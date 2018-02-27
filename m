Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.139]:34555 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbeB0CoN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 26 Feb 2018 21:44:13 -0500
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: zyw@rock-chips.com, briannorris@google.com, dianders@google.com,
        jwerner@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: [PATCH v2] rtc: cros-ec: return -ETIME when refused to set alarms in the past
Date: Tue, 27 Feb 2018 10:43:57 +0800
Message-Id: <20180227024357.4897-1-jeffy.chen@rock-chips.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Since accessing a Chrome OS EC based rtc is a slow operation, there is a
race window where if the alarm is set for the next second and the second
ticks over right before calculating the alarm offset.

In this case the current driver is setting a 0-second alarm, which would
be considered as disabling alarms by the EC(EC_RTC_ALARM_CLEAR).

This breaks, e.g., hwclock which relies on RTC_UIE_ON ->
rtc_update_irq_enable(), which sets a 1-second alarm and expects it to
fire an interrupt.

So return -ETIME when the alarm is in the past, follow __rtc_set_alarm().

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2:
Rewrite commit message as Brian suggested.
Check alarm time only when that alarm is enabled.

 drivers/rtc/rtc-cros-ec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index f0ea6899c731..ae7e8554679f 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -196,11 +196,11 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		alarm_offset = EC_RTC_ALARM_CLEAR;
 		cros_ec_rtc->saved_alarm = (u32)alarm_time;
 	} else {
+		alarm_offset = (u32)alarm_time - current_time;
+
 		/* Don't set an alarm in the past. */
-		if ((u32)alarm_time < current_time)
-			alarm_offset = EC_RTC_ALARM_CLEAR;
-		else
-			alarm_offset = (u32)alarm_time - current_time;
+		if (alarm_offset <= 0)
+			return -ETIME;
 	}
 
 	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, alarm_offset);
-- 
2.11.0
