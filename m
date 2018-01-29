Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:58588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751032AbeA2CtO (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 28 Jan 2018 21:49:14 -0500
From: Zhang Rui <rui.zhang@intel.com>
To: alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org
Cc: gabriele.mzt@gmail.com, rui.zhang@intel.com
Subject: [PATCH 3/4] rtc: cmos: acknowledge ACPI driven wake alarms upon resume
Date: Mon, 29 Jan 2018 10:48:47 +0800
Message-Id: <1517194128-5326-3-git-send-email-rui.zhang@intel.com>
In-Reply-To: <1517194128-5326-1-git-send-email-rui.zhang@intel.com>
References: <1517194128-5326-1-git-send-email-rui.zhang@intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Previously, the RTC alarm is acknowledged either by the cmos rtc irq
handler, or by the hpet rtc irq handler.

When using ACPI RTC Fixed event as the RTC alarm, the RTC alarm is
acknowledged by the ACPI RTC event handler, as addressed in the previous
patch.
But, when resume from suspend-to-ram (ACPI S3), the ACPI SCI is cleared
right after resume, thus the ACPI RTC event handler is not invoked at all,
results in the RTC Alarm unacknowledged.

Handle this by comparing the current time and the RTC Alarm time in the
rtc_cmos driver .resume() callback
1. Assume the wakeup event has already been fired if the RTC Alarm time
   is earlier than/equal to the current time, and ACK the RTC Alarm.
2. Assume the wakeup event has not been fired if the RTC Alarm time
   is later than current time, and re-arm it if needed.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/rtc/rtc-cmos.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 9665a72..bcf86e1 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1022,8 +1022,26 @@ static void cmos_check_wkalrm(struct device *dev)
 {
 	struct cmos_rtc *cmos = dev_get_drvdata(dev);
 	struct rtc_wkalrm current_alarm;
+	time64_t t_now;
 	time64_t t_current_expires;
 	time64_t t_saved_expires;
+	struct rtc_time now;
+
+	/* Check if we have RTC Alarm armed */
+	if (!(cmos->suspend_ctrl & RTC_AIE))
+		return;
+
+	cmos_read_time(dev, &now);
+	t_now = rtc_tm_to_time64(&now);
+
+	/*
+	 * ACPI RTC wake event is cleared after resume from STR,
+	 * ACK the rtc irq here
+	 */
+	if (t_now >= cmos->alarm_expires && use_acpi_alarm) {
+		cmos_interrupt(0, (void *)cmos->rtc);
+		return;
+	}
 
 	cmos_read_alarm(dev, &current_alarm);
 	t_current_expires = rtc_tm_to_time64(&current_alarm.time);
-- 
2.7.4
