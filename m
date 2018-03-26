Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:12948 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeCZN6U (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 26 Mar 2018 09:58:20 -0400
From: Zhang Rui <rui.zhang@intel.com>
To: linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Cc: rjw@rjwysocki.net, alexandre.belloni@free-electrons.com,
        gabriele.mzt@gmail.com, rui.zhang@intel.com
Subject: [PATCH 3/3] rtc: cmos: introduce quirks to enable use_acpi_alarm mode
Date: Mon, 26 Mar 2018 21:58:03 +0800
Message-Id: <1522072683-3968-3-git-send-email-rui.zhang@intel.com>
In-Reply-To: <1522072683-3968-1-git-send-email-rui.zhang@intel.com>
References: <1522072683-3968-1-git-send-email-rui.zhang@intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use ACPI for RTC Alarm only for Intel platforms
1. with Low Power S0 support
2. with HPET RTC emulation enabled
3. no earlier than 2015

Note that, during the test, it is found that this patch
1. works in 4.15-rc kernel
2. hangs the platform after suspend-to-idle for 2 or 3 times, in 4.15.0
3. works again in 4.16-rc3 kernel.
4. works in the latest 4.15.12 stable kernel.

Thus although this patch breaks 4.15.0 kernel for some unknown reason,
still, it is safe for both upstream and backport.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/rtc/rtc-cmos.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index bcf86e1..75c4bdc 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -43,6 +43,8 @@
 #include <linux/of_platform.h>
 #ifdef CONFIG_X86
 #include <asm/i8259.h>
+#include <asm/processor.h>
+#include <linux/dmi.h>
 #endif
 
 /* this is for "generic access to PC-style RTC" using CMOS_READ/CMOS_WRITE */
@@ -1183,6 +1185,28 @@ static void rtc_wake_off(struct device *dev)
 	acpi_disable_event(ACPI_EVENT_RTC, 0);
 }
 
+#ifdef CONFIG_X86
+/* Enable use_acpi_alarm mode for Intel platforms no earlier than 2015 */
+static void use_acpi_alarm_quirks(void)
+{
+	int year;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return;
+
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+		return;
+
+	if (!is_hpet_enabled())
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
@@ -1195,6 +1219,8 @@ static void cmos_wake_setup(struct device *dev)
 	if (acpi_disabled)
 		return;
 
+	use_acpi_alarm_quirks();
+
 	rtc_wake_setup(dev);
 	acpi_rtc_info.wake_on = rtc_wake_on;
 	acpi_rtc_info.wake_off = rtc_wake_off;
-- 
2.7.4
