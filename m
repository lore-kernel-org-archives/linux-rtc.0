Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:58588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751032AbeA2CtQ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 28 Jan 2018 21:49:16 -0500
From: Zhang Rui <rui.zhang@intel.com>
To: alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org
Cc: gabriele.mzt@gmail.com, rui.zhang@intel.com
Subject: [PATCH 4/4] rtc: cmos: introduce quirks to enable use_acpi_alarm mode
Date: Mon, 29 Jan 2018 10:48:48 +0800
Message-Id: <1517194128-5326-4-git-send-email-rui.zhang@intel.com>
In-Reply-To: <1517194128-5326-1-git-send-email-rui.zhang@intel.com>
References: <1517194128-5326-1-git-send-email-rui.zhang@intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use ACPI for RTC Alarm only for Intel platforms
1. with Low Power S0 support
2. with HPET RTC emulation enabled
3. no earlier than 2015

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/rtc/rtc-cmos.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index bcf86e1..414b450 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -43,6 +43,8 @@
 #include <linux/of_platform.h>
 #ifdef CONFIG_X86
 #include <asm/i8259.h>
+#include <asm/cpu_device_id.h>
+#include <linux/dmi.h>
 #endif
 
 /* this is for "generic access to PC-style RTC" using CMOS_READ/CMOS_WRITE */
@@ -1183,6 +1185,33 @@ static void rtc_wake_off(struct device *dev)
 	acpi_disable_event(ACPI_EVENT_RTC, 0);
 }
 
+#ifdef CONFIG_X86
+static const struct x86_cpu_id use_acpi_alarm_ids[] = {
+	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_ANY },
+	{}
+};
+
+/* Enable use_acpi_alarm mode for Intel platforms no earlier than 2015 */
+static void use_acpi_alarm_quirks(void)
+{
+	int year;
+
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+		return;
+
+	if (!is_hpet_enabled())
+		return;
+
+	if (!x86_match_cpu(use_acpi_alarm_ids))
+		return;
+
+	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year >= 2015)
+		use_acpi_alarm = true;
+}
+#else
+static inline void use_acpi_alarm_quirks(void) { }
+#endif
+
 /* Every ACPI platform has a mc146818 compatible "cmos rtc".  Here we find
  * its device node and pass extra config data.  This helps its driver use
  * capabilities that the now-obsolete mc146818 didn't have, and informs it
@@ -1195,6 +1224,8 @@ static void cmos_wake_setup(struct device *dev)
 	if (acpi_disabled)
 		return;
 
+	use_acpi_alarm_quirks();
+
 	rtc_wake_setup(dev);
 	acpi_rtc_info.wake_on = rtc_wake_on;
 	acpi_rtc_info.wake_off = rtc_wake_off;
-- 
2.7.4
