Return-Path: <rtc-linux+bncBCAJFDXE4QGBBN753KVQKGQENTK5CGQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x22e.google.com (mail-pd0-x22e.google.com. [2607:f8b0:400e:c02::22e])
        by gmr-mx.google.com with ESMTPS id 5si611262pdt.0.2015.06.09.03.23.51
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 03:23:51 -0700 (PDT)
Received: by mail-pd0-x22e.google.com with SMTP id ki1so11983999pdb.1
        for <rtc-linux@googlegroups.com>; Tue, 09 Jun 2015 03:23:51 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Cc: Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>,
	Diego Ercolani <diego.ercolani@gmail.com>,
	Egbert Eich <eich@suse.com>,
	Max Asbock <amax@lenovo.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>,
	Adrian Huang <adrianhuang0701@gmail.com>
Subject: [rtc-linux] [RFC PATCH v2 2/2] rtc-cmos: Revert "rtc-cmos: Add an
 alarm disable quirk"
Date: Tue,  9 Jun 2015 18:23:33 +0800
Message-Id: <1433845413-13960-3-git-send-email-adrianhuang0701@gmail.com>
In-Reply-To: <1433845413-13960-1-git-send-email-adrianhuang0701@gmail.com>
References: <1433845413-13960-1-git-send-email-adrianhuang0701@gmail.com>
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
added a special quirk is not needed because [PATCH 1/2] of this
patchset makes the kernel more robust:
rtc-cmos: Clear interrupt flag if alarm time is less equal to
now+1 seconds.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/rtc/rtc-cmos.c | 50 --------------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 4e60ac8..6064f29 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -41,7 +41,6 @@
 #include <linux/pm.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/dmi.h>
 
 /* this is for "generic access to PC-style RTC" using CMOS_READ/CMOS_WRITE */
 #include <asm-generic/rtc.h>
@@ -383,50 +382,6 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
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
@@ -435,9 +390,6 @@ static int cmos_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	if (!is_valid_irq(cmos->irq))
 		return -EINVAL;
 
-	if (alarm_disable_quirk)
-		return 0;
-
 	spin_lock_irqsave(&rtc_lock, flags);
 
 	if (enabled)
@@ -1298,8 +1250,6 @@ static int __init cmos_init(void)
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
