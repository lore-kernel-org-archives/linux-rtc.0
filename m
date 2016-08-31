Return-Path: <rtc-linux+bncBCL4FNGB7UHBBPOCTW7AKGQEN3QY64Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com. [2a00:1450:400c:c09::244])
        by gmr-mx.google.com with ESMTPS id r74si2640764wme.3.2016.08.31.15.59.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 15:59:08 -0700 (PDT)
Received: by mail-wm0-x244.google.com with SMTP id w207so5700151wmw.0
        for <rtc-linux@googlegroups.com>; Wed, 31 Aug 2016 15:59:08 -0700 (PDT)
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	matthew.garrett@nebula.com,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [rtc-linux] [PATCH v2 1/2] rtc-cmos: Ensure no expired alarm is left
 enabled after resume
Date: Thu,  1 Sep 2016 00:58:59 +0200
Message-Id: <20160831225900.20122-1-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Some BIOSes, such as the one of the Dell XPS13 9333, wake the system
when an alarm goes off without informing the OS. If any of the
RTC_IRQMASK bits is set when this happens and hpet is enabled,
the alarm is not automatically cleared at resume. As consequence,
the user must manually clear the alarm writing 0 to wakealarm
before being able to set a new alarm. Ensure this never happens.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/rtc/rtc-cmos.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 1dec52f..62d5b33 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -900,10 +900,32 @@ static inline int cmos_poweroff(struct device *dev)
 
 #ifdef	CONFIG_PM_SLEEP
 
+static bool cmos_is_wkalrm_expired(struct device *dev)
+{
+	struct cmos_rtc *cmos = dev_get_drvdata(dev);
+	struct rtc_wkalrm alarm;
+	struct rtc_time now;
+	time64_t t_now;
+	time64_t t_expires;
+	int ret;
+
+	ret = rtc_read_alarm(cmos->rtc, &alarm);
+	if (ret) {
+		dev_err(dev, "Could not read alarm: err=%d\n", ret);
+		return false;
+	}
+	t_expires = rtc_tm_to_time64(&alarm.time);
+	cmos_read_time(dev, &now);
+	t_now = rtc_tm_to_time64(&now);
+
+	return t_expires <= t_now;
+}
+
 static int cmos_resume(struct device *dev)
 {
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	unsigned char tmp;
+	bool is_wkalrm_expired;
 
 	if (cmos->enabled_wake) {
 		if (cmos->wake_off)
@@ -913,6 +935,8 @@ static int cmos_resume(struct device *dev)
 		cmos->enabled_wake = 0;
 	}
 
+	is_wkalrm_expired = cmos_is_wkalrm_expired(dev);
+
 	spin_lock_irq(&rtc_lock);
 	tmp = cmos->suspend_ctrl;
 	cmos->suspend_ctrl = 0;
@@ -939,6 +963,17 @@ static int cmos_resume(struct device *dev)
 			tmp &= ~RTC_AIE;
 			hpet_mask_rtc_irq_bit(RTC_AIE);
 		} while (mask & RTC_AIE);
+
+		/*
+		 * If RTC_AIE is set and we have an alarm set to go off in the
+		 * past, then the BIOS woke the system when the alarm went off
+		 * and we now have to clear it.
+		 */
+		if ((tmp & RTC_AIE) && is_wkalrm_expired) {
+			rtc_update_irq(cmos->rtc, 1, mask);
+			tmp &= ~RTC_AIE;
+			CMOS_WRITE(tmp, RTC_CONTROL);
+		}
 	}
 	spin_unlock_irq(&rtc_lock);
 
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
