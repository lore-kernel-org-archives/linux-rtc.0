Return-Path: <rtc-linux+bncBCAJFDXE4QGBBDUHWKVAKGQEKDKXUAA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com. [2607:f8b0:400e:c02::22b])
        by gmr-mx.google.com with ESMTPS id x3si530746pdh.2.2015.05.08.02.36.14
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 02:36:14 -0700 (PDT)
Received: by mail-pd0-x22b.google.com with SMTP id nk13so74070720pdb.0
        for <rtc-linux@googlegroups.com>; Fri, 08 May 2015 02:36:14 -0700 (PDT)
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
Subject: [rtc-linux] [RFC PATCH 2/2] rtc: Restore the RTC alarm time to the
 configured alarm time in BIOS Setup
Date: Fri,  8 May 2015 17:35:06 +0800
Message-Id: <1431077706-3560-1-git-send-email-adrianhuang0701@gmail.com>
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

This patch restores the configured alarm time (user configures the
time in BIOS Setup) to rtc alarm registers. In some circumstances,
the time of the rtc alarm registers is the past time because
user-space programs (for example: hwclock) may invoke ioctl() with
RTC_UIE_ON. In any case, this patch prevents the AF bit from getting
set to 1. Note, AF=1 will cause the system to reboot after shut down.
Therefore, this patch fixes the issue from occurring.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
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
