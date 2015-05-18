Return-Path: <rtc-linux+bncBAABBTXY42VAKGQEFI753TA@googlegroups.com>
Received: from mx2.suse.de (cantor2.suse.de. [195.135.220.15])
        by gmr-mx.google.com with ESMTPS id gt9si335746wib.2.2015.05.18.03.17.49
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 May 2015 03:17:49 -0700 (PDT)
Date: Mon, 18 May 2015 12:17:44 +0200
From: Borislav Petkov <bp@suse.de>
To: Adrian Huang <adrianhuang0701@gmail.com>,
	Brecht Machiels <brecht@mos6581.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>,
	Rabin Vincent <rabin.vincent@stericsson.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [rtc-linux] Re: [RFC PATCH 1/2] Revert "rtc-cmos: Add an alarm
 disable quirk"
Message-ID: <20150518101744.GF23662@pd.tnic>
References: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
In-Reply-To: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, May 08, 2015 at 05:34:25PM +0800, Adrian Huang wrote:
> Commit d5a1c7e3fc38 ("rtc-cmos: Add an alarm disable quirk") that
> added a special quirk is not needed because PATCH [2/2] of this
> patchset makes the kernel more robust:
> rtc: restore the RTC alarm time to the configured alarm time in BIOS
> Setup
> 
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  drivers/rtc/rtc-cmos.c | 52 --------------------------------------------------
>  1 file changed, 52 deletions(-)

...

> -	/* http://permalink.gmane.org/gmane.linux.kernel/1604474 */
> -	{
> -		.callback = set_alarm_disable_quirk,
> -		.ident    = "Toshiba Satellite L300",
> -		.matches  = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L300"),
> -		},
> -	},

Looking at the link, this must be Brecht's box.

Brecht, is there any way you could test those patches? I'm attaching
them here.

If you need help applying them and building a kernel or so, let me know.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

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

--y0ulUmNC+osPPQO6
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-revert_rtc-cmos-add_an_alarm_disable_quirk.patch"

>From adrianhuang0701@gmail.com Fri May  8 11:35:33 2015
From: Adrian Huang <adrianhuang0701@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com
Cc: Brecht Machiels <brecht@mos6581.org>, Thomas Gleixner
 <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Rabin Vincent
 <rabin.vincent@stericsson.com>, Borislav Petkov <bp@suse.de>, Nagananda
 Chumbalkar <nchumbalkar@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>,
 Adrian Huang <adrianhuang0701@gmail.com>
Subject: [RFC PATCH 1/2] Revert "rtc-cmos: Add an alarm disable quirk"
Date: Fri,  8 May 2015 17:34:25 +0800
Message-Id: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Status: RO
X-Status: A

Commit d5a1c7e3fc38 ("rtc-cmos: Add an alarm disable quirk") that
added a special quirk is not needed because PATCH [2/2] of this
patchset makes the kernel more robust:
rtc: restore the RTC alarm time to the configured alarm time in BIOS
Setup

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Cc: Brecht Machiels <brecht@mos6581.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Nagananda Chumbalkar <nchumbalkar@lenovo.com>
Cc: Adrian Huang <ahuang12@lenovo.com>
Cc: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Link: http://lkml.kernel.org/r/1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com
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



--y0ulUmNC+osPPQO6
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0002-rtc-restore_the_rtc_alarm_time_to_the_configured_alarm_time_in_bios_setup.patch"

>From adrianhuang0701@gmail.com Fri May  8 11:36:12 2015
From: Adrian Huang <adrianhuang0701@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com
Cc: Brecht Machiels <brecht@mos6581.org>, Thomas Gleixner
 <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Rabin Vincent
 <rabin.vincent@stericsson.com>, Borislav Petkov <bp@suse.de>, Nagananda
 Chumbalkar <nchumbalkar@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>,
 Adrian Huang <adrianhuang0701@gmail.com>
Subject: [RFC PATCH 2/2] rtc: Restore the RTC alarm time to the configured
 alarm time in BIOS Setup
Date: Fri,  8 May 2015 17:35:06 +0800
Message-Id: <1431077706-3560-1-git-send-email-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Status: RO

Steps to reproduce the problem:
	1) Enable RTC wake-up option in BIOS Setup
	2) Issue one of these commands in the OS: "poweroff" 
	   or "shutdown -h now"
	3) System will shut down and then reboot automatically

Root-cause of the issue:
	1) During the shutdown process, the hwclock utility is used
	   to save the system clock to hardware clock (RTC).
	2) The hwclock utility invokes ioctl() with RTC_UIE_ON. The
	   kernel configures the RTC alarm for the periodic interrupt
	   (every 1 second).
	3) The hwclock uitlity closes the /dev/rtc0 device, and the
	   kernel disables the RTC alarm irq (AIE bit of Register B)
	   via ioctl() with RTC_UIE_OFF. But, the configured alarm
	   time is the current_time + 1.
	4) After the next 1 second is elapsed, the AF (alarm
	   interrupt flag) of Register C is set.
	5) The S5 handler in BIOS is invoked to configure alarm
	   registers (enable AIE bit and configure alarm date/time).
	   But, BIOS does not clear the previous interrupt status
	   during alarm configuration. Therefore, "AF=AIE=1" causes 
	   the rtc device to trigger an interrupt.  
	6) So, the machine reboots automatically right after shutdown.

This patch restores the configured alarm time (user configures the
time in BIOS Setup) to rtc alarm registers. In some circumstances,
the time of the rtc alarm registers is the past time because
user-space programs (for example: hwclock) may invoke ioctl() with
RTC_UIE_ON. In any case, this patch prevents the AF bit from getting
set to 1. Note, AF=1 will cause the system to reboot after shut down.
Therefore, this patch fixes the issue from occurring.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Cc: Brecht Machiels <brecht@mos6581.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Nagananda Chumbalkar <nchumbalkar@lenovo.com>
Cc: Adrian Huang <ahuang12@lenovo.com>
Cc: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Link: http://lkml.kernel.org/r/1431077706-3560-1-git-send-email-adrianhuang0701@gmail.com
Reviewed-by: Nagananda Chumbalkar <nchumbalkar@lenovo.com>
---
 drivers/rtc/interface.c | 21 +++++++++++++++++++++
 drivers/rtc/rtc-dev.c   |  1 +
 include/linux/rtc.h     |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 166fc60..2fe17da 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -986,4 +986,25 @@ int rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer)
 	return ret;
 }
 
+/* rtc_alarm_restore - Restores the alarm time
+ * @ rtc: rtc device to be used
+ *
+ * Kernel interface to restore the alarm time
+ */
+int rtc_alarm_restore(struct rtc_device *rtc)
+{
+	struct rtc_wkalrm aie_alarm;
+	int err;
 
+	/* If someone has configured the AIE timer, do nothing. */
+	if (rtc->aie_timer.enabled)
+		return 0;
+
+	/* Read the alarm date/time from aie_timer. */
+	err = rtc_read_alarm(rtc, &aie_alarm);
+	if (err < 0)
+		return err;
+
+	return __rtc_set_alarm(rtc, &aie_alarm);
+}
+EXPORT_SYMBOL_GPL(rtc_alarm_restore);
diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index 799c34b..a5ea279 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -437,6 +437,7 @@ static int rtc_dev_release(struct inode *inode, struct file *file)
 	rtc_dev_ioctl(file, RTC_UIE_OFF, 0);
 	rtc_update_irq_enable(rtc, 0);
 	rtc_irq_set_state(rtc, NULL, 0);
+	rtc_alarm_restore(rtc);
 
 	if (rtc->ops->release)
 		rtc->ops->release(rtc->dev.parent);
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 8dcf682..bf945cb 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -188,6 +188,7 @@ extern int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled);
 extern int rtc_alarm_irq_enable(struct rtc_device *rtc, unsigned int enabled);
 extern int rtc_dev_update_irq_enable_emul(struct rtc_device *rtc,
 						unsigned int enabled);
+extern int rtc_alarm_restore(struct rtc_device *rtc);
 
 void rtc_handle_legacy_irq(struct rtc_device *rtc, int num, int mode);
 void rtc_aie_update_irq(void *private);
-- 
1.9.1



--y0ulUmNC+osPPQO6--
