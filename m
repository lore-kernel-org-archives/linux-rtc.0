Return-Path: <rtc-linux+bncBCAJFDXE4QGBBZEGWKVAKGQEUEBYNWQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com. [2607:f8b0:400e:c02::235])
        by gmr-mx.google.com with ESMTPS id k3si564668pdm.0.2015.05.08.02.35.32
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 02:35:32 -0700 (PDT)
Received: by mail-pd0-x235.google.com with SMTP id qa5so73145234pdb.1
        for <rtc-linux@googlegroups.com>; Fri, 08 May 2015 02:35:32 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Brecht Machiels <brecht@mos6581.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>,
	Rabin Vincent <rabin.vincent@stericsson.com>,
	Borislav Petkov <bp@suse.de>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>,
	Adrian Huang <adrianhuang0701@gmail.com>
Subject: [rtc-linux] [RFC PATCH 1/2] Revert "rtc-cmos: Add an alarm disable quirk"
Date: Fri,  8 May 2015 17:34:25 +0800
Message-Id: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Commit d5a1c7e3fc38 ("rtc-cmos: Add an alarm disable quirk") that
added a special quirk is not needed because PATCH [2/2] of this
patchset makes the kernel more robust:
rtc: restore the RTC alarm time to the configured alarm time in BIOS
Setup

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/rtc/rtc-cmos.c | 52 --------------------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index a82556a..9754564 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -29,8 +29,6 @@
  * other drivers and utilities on correctly configured systems.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -41,7 +39,6 @@
 #include <linux/pm.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/dmi.h>
 
 /* this is for "generic access to PC-style RTC" using CMOS_READ/CMOS_WRITE */
 #include <asm-generic/rtc.h>
@@ -380,50 +377,6 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	return 0;
 }
 
-/*
- * Do not disable RTC alarm on shutdown - workaround for b0rked BIOSes.
- */
-static bool alarm_disable_quirk;
-
-static int __init set_alarm_disable_quirk(const struct dmi_system_id *id)
-{
-	alarm_disable_quirk = true;
-	pr_info("BIOS has alarm-disable quirk - RTC alarms disabled\n");
-	return 0;
-}
-
-static const struct dmi_system_id rtc_quirks[] __initconst = {
-	/* https://bugzilla.novell.com/show_bug.cgi?id=805740 */
-	{
-		.callback = set_alarm_disable_quirk,
-		.ident    = "IBM Truman",
-		.matches  = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "4852570"),
-		},
-	},
-	/* https://bugzilla.novell.com/show_bug.cgi?id=812592 */
-	{
-		.callback = set_alarm_disable_quirk,
-		.ident    = "Gigabyte GA-990XA-UD3",
-		.matches  = {
-			DMI_MATCH(DMI_SYS_VENDOR,
-					"Gigabyte Technology Co., Ltd."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "GA-990XA-UD3"),
-		},
-	},
-	/* http://permalink.gmane.org/gmane.linux.kernel/1604474 */
-	{
-		.callback = set_alarm_disable_quirk,
-		.ident    = "Toshiba Satellite L300",
-		.matches  = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L300"),
-		},
-	},
-	{}
-};
-
 static int cmos_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
@@ -432,9 +385,6 @@ static int cmos_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	if (!is_valid_irq(cmos->irq))
 		return -EINVAL;
 
-	if (alarm_disable_quirk)
-		return 0;
-
 	spin_lock_irqsave(&rtc_lock, flags);
 
 	if (enabled)
@@ -1243,8 +1193,6 @@ static int __init cmos_init(void)
 			platform_driver_registered = true;
 	}
 
-	dmi_check_system(rtc_quirks);
-
 	if (retval == 0)
 		return 0;
 
-- 
1.9.1

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
