Return-Path: <rtc-linux+bncBCL4FNGB7UHBB4UDXS5AKGQEKVLRO2I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com. [2a00:1450:400c:c09::244])
        by gmr-mx.google.com with ESMTPS id d193si458053wmd.2.2016.06.01.08.40.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2016 08:40:33 -0700 (PDT)
Received: by mail-wm0-x244.google.com with SMTP id q62so7919646wmg.3
        for <rtc-linux@googlegroups.com>; Wed, 01 Jun 2016 08:40:33 -0700 (PDT)
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	matthew.garrett@nebula.com,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [rtc-linux] [PATCH 1/2] rtc-cmos: Clear expired alarm after resume
Date: Wed,  1 Jun 2016 17:40:14 +0200
Message-Id: <1464795615-7748-1-git-send-email-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

If the system wakes up because of a wake alarm, the internal state
of the alarm is not updated. As consequence, the state no longer
reflects the actual state of the hardware and setting a new alarm
is not possible until the expired alarm is cleared.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/rtc/rtc-cmos.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fbe9c72..fd121e3 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -900,11 +900,33 @@ static inline int cmos_poweroff(struct device *dev)
 
 #ifdef	CONFIG_PM_SLEEP
 
+static void cmos_check_alarm(struct device *dev)
+{
+	struct cmos_rtc *cmos = dev_get_drvdata(dev);
+	struct rtc_wkalrm alarm;
+	struct rtc_time now;
+	time64_t t_now;
+	time64_t t_expires;
+
+	cmos_read_time(dev, &now);
+	rtc_read_alarm(cmos->rtc, &alarm);
+	t_now = rtc_tm_to_time64(&now);
+	t_expires = rtc_tm_to_time64(&alarm.time);
+
+	if (t_expires <= t_now && alarm.enabled) {
+		alarm.enabled = 0;
+		cmos->suspend_ctrl &= ~RTC_AIE;
+		rtc_set_alarm(cmos->rtc, &alarm);
+	}
+}
+
 static int cmos_resume(struct device *dev)
 {
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	unsigned char tmp;
 
+	cmos_check_alarm(dev);
+
 	if (cmos->enabled_wake) {
 		if (cmos->wake_off)
 			cmos->wake_off(dev);
-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
