Return-Path: <rtc-linux+bncBCAJFDXE4QGBBM753KVQKGQEZUKLXDA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x22e.google.com (mail-pd0-x22e.google.com. [2607:f8b0:400e:c02::22e])
        by gmr-mx.google.com with ESMTPS id 5si611262pdt.0.2015.06.09.03.23.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 03:23:47 -0700 (PDT)
Received: by pdbki1 with SMTP id ki1so11983999pdb.1
        for <rtc-linux@googlegroups.com>; Tue, 09 Jun 2015 03:23:47 -0700 (PDT)
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
Subject: [rtc-linux] [RFC PATCH v2 1/2] rtc-cmos: Clear interrupt flag if
 alarm time is
Date: Tue,  9 Jun 2015 18:23:32 +0800
Message-Id: <1433845413-13960-2-git-send-email-adrianhuang0701@gmail.com>
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

This patch makes sure cmos_do_shutdown() is invoked if the configured
alarm time is less equal to current_time + 1 seconds. Therefore,
the interrupt flag can be cleared before powering off the system.

The member 'alarm_expires' is introduced in struct cmos_rtc because
of the following reasons:
	1) The configured alarm time can be retrieved from
	   cmos_read_alarm(), but we need to take the 'wrapped
	   timestamp' and 'time rollover' into consideration. The
	   function __rtc_read_alarm() eliminates the concerns. To
	   avoid the duplicated code in the lower level RTC driver,
	   invoking __rtc_read_alarm from the lower level RTC driver
	   is not encouraged. Moreover, the compilation error 'the
	   undefined __rtc_read_alarm" is observed if the lower level
	   RTC driver is compiled as a kernel module.
	2) The uie_rtctimer.node.expires and aie_timer.node.expires can
	   be retrieved for the configured alarm time. But, the problem
	   is that either of them might configure the CMOS alarm time.
	   We cannot make sure who configured the CMOS alarm time
	   before (uie_rtctimer or aie_timer is enabled and then is
	   disabled).
	3) The patch introduces the member 'alarm_expires' to keep the
	   newly configured alarm time, so the above-mentioned concerns
	   can be eliminated.

The issue goes away after 20-time shutdown tests.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Reviewed-by: Max Asbock <amax@lenovo.com>
---
 drivers/rtc/rtc-cmos.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index a82556a..4e60ac8 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -51,6 +51,7 @@ struct cmos_rtc {
 	struct device		*dev;
 	int			irq;
 	struct resource		*iomem;
+	time64_t		alarm_expires;
 
 	void			(*wake_on)(struct device *);
 	void			(*wake_off)(struct device *);
@@ -377,6 +378,8 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	spin_unlock_irq(&rtc_lock);
 
+	cmos->alarm_expires = rtc_tm_to_time64(&t->time);
+
 	return 0;
 }
 
@@ -588,7 +591,7 @@ static struct bin_attribute nvram = {
 
 /*----------------------------------------------------------------*/
 
-static struct cmos_rtc	cmos_rtc;
+static struct cmos_rtc	cmos_rtc = { .alarm_expires = 0 };
 
 static irqreturn_t cmos_interrupt(int irq, void *p)
 {
@@ -860,6 +863,52 @@ static void __exit cmos_do_remove(struct device *dev)
 	cmos->dev = NULL;
 }
 
+static int cmos_aie_poweroff(struct device *dev)
+{
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+	struct rtc_time now;
+	int err;
+	time64_t t_now;
+	unsigned char rtc_control;
+
+	if (!cmos->alarm_expires)
+		return -EINVAL;
+
+	spin_lock_irq(&rtc_lock);
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	spin_unlock_irq(&rtc_lock);
+
+	/* We only care about the situation where AIE is disabled. */
+	if (rtc_control & RTC_AIE)
+		return -EBUSY;
+
+	err = cmos_read_time(dev, &now);
+	if (err < 0)
+		return err;
+	t_now = rtc_tm_to_time64(&now);
+
+	/*
+	 * When enabling "RTC wake-up" in BIOS setup, the machine reboots
+	 * automatically right after shutdown on some buggy boxes.
+	 * This automatic rebooting issue won't happen when the alarm
+	 * time is larger than now+1 seconds.
+	 *
+	 * If the alarm time is equal to now+1 seconds, we need to wait
+	 * for 1 second so that AF is set by CMOS hardware. Therefore, we
+	 * can get a chance to clear AF in cmos_do_shutdown().
+	 *
+	 * If the alarm time is less equal to 'now', the function simply
+	 * returns '0' so that we can get a chance to clear AF in
+	 * cmos_do_shutdown().
+	 */
+	if (cmos->alarm_expires > (t_now + 1))
+		return -EBUSY;
+	else if (cmos->alarm_expires == (t_now + 1))
+		msleep(1000);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 
 static int cmos_suspend(struct device *dev)
@@ -1094,8 +1143,11 @@ static void cmos_pnp_shutdown(struct pnp_dev *pnp)
 	struct device *dev = &pnp->dev;
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 
-	if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
-		return;
+	if (system_state == SYSTEM_POWER_OFF) {
+		cmos_poweroff(dev);
+		if (cmos_aie_poweroff(dev) < 0)
+			return;
+	}
 
 	cmos_do_shutdown(cmos->irq);
 }
@@ -1200,8 +1252,11 @@ static void cmos_platform_shutdown(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 
-	if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
-		return;
+	if (system_state == SYSTEM_POWER_OFF) {
+		cmos_poweroff(dev);
+		if (cmos_aie_poweroff(dev) < 0)
+			return;
+	}
 
 	cmos_do_shutdown(cmos->irq);
 }
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
