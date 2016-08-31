Return-Path: <rtc-linux+bncBCL4FNGB7UHBBP6CTW7AKGQEMJOIYMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com. [2a00:1450:400c:c09::243])
        by gmr-mx.google.com with ESMTPS id y7si3077420wmd.0.2016.08.31.15.59.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 15:59:11 -0700 (PDT)
Received: by mail-wm0-x243.google.com with SMTP id c133so1055767wmd.2
        for <rtc-linux@googlegroups.com>; Wed, 31 Aug 2016 15:59:11 -0700 (PDT)
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	matthew.garrett@nebula.com,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [rtc-linux] [PATCH v2 2/2] rtc-cmos: Restore alarm after resume
Date: Thu,  1 Sep 2016 00:59:00 +0200
Message-Id: <20160831225900.20122-2-gabriele.mzt@gmail.com>
In-Reply-To: <20160831225900.20122-1-gabriele.mzt@gmail.com>
References: <20160831225900.20122-1-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Some platform firmware may interfere with the RTC alarm over suspend,
resulting in the kernel and hardware having different ideas about system
state but also potentially causing problems with firmware that assumes the
OS will clean this case up.  This patch restores the RTC alarm on resume
to ensure that kernel and hardware are in sync.

The case we've seen is Intel Rapid Start, which is a firmware-mediated
feature that automatically transitions systems from suspend-to-RAM to
suspend-to-disk without OS involvement.  It does this by setting the RTC
alarm and a flag that indicates that on wake it should perform the
transition rather than re-starting the OS.  However, if the OS has set a
wakeup alarm that would wake the machine earlier, it refuses to overwrite
it and allows the system to wake instead.

This fails in the following situation:

1) User configures Intel Rapid Start to transition after (say) 15
minutes
2) User suspends to RAM. Firmware sets the wakeup alarm for 15 minutes
in the future
3) User resumes after 5 minutes. Firmware does not reset the alarm, and
as such it is still set for 10 minutes in the future
4) User suspends after 5 minutes. Firmware notices that the alarm is set
for 5 minutes in the future, which is less than the 15 minute transition
threshold. It therefore assumes that the user wants the machine to wake
in 5 minutes
5) System resumes after 5 minutes

The worst case scenario here is that the user may have put the system in a
bag between (4) and (5), resulting in it running in a confined space and
potentially overheating.  This seems reasonably important.  The Rapid
Start support code got added in 3.11, but it can be configured in the
firmware regardless of kernel support.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/rtc/rtc-cmos.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 62d5b33..4cdb335 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -62,6 +62,8 @@ struct cmos_rtc {
 	u8			day_alrm;
 	u8			mon_alrm;
 	u8			century;
+
+	struct rtc_wkalrm	saved_wkalrm;
 };
 
 /* both platform and pnp busses use negative numbers for invalid irqs */
@@ -880,6 +882,8 @@ static int cmos_suspend(struct device *dev)
 			enable_irq_wake(cmos->irq);
 	}
 
+	cmos_read_alarm(dev, &cmos->saved_wkalrm);
+
 	dev_dbg(dev, "suspend%s, ctrl %02x\n",
 			(tmp & RTC_AIE) ? ", alarm may wake" : "",
 			tmp);
@@ -900,6 +904,22 @@ static inline int cmos_poweroff(struct device *dev)
 
 #ifdef	CONFIG_PM_SLEEP
 
+static void cmos_check_wkalrm(struct device *dev)
+{
+	struct cmos_rtc *cmos = dev_get_drvdata(dev);
+	struct rtc_wkalrm current_alarm;
+	time64_t t_current_expires;
+	time64_t t_saved_expires;
+
+	cmos_read_alarm(dev, &current_alarm);
+	t_current_expires = rtc_tm_to_time64(&current_alarm.time);
+	t_saved_expires = rtc_tm_to_time64(&cmos->saved_wkalrm.time);
+	if (t_current_expires != t_saved_expires ||
+	    cmos->saved_wkalrm.enabled != current_alarm.enabled) {
+		cmos_set_alarm(dev, &cmos->saved_wkalrm);
+	}
+}
+
 static bool cmos_is_wkalrm_expired(struct device *dev)
 {
 	struct cmos_rtc *cmos = dev_get_drvdata(dev);
@@ -935,6 +955,9 @@ static int cmos_resume(struct device *dev)
 		cmos->enabled_wake = 0;
 	}
 
+	/* The BIOS might have changed the alarm, restore it */
+	cmos_check_wkalrm(dev);
+
 	is_wkalrm_expired = cmos_is_wkalrm_expired(dev);
 
 	spin_lock_irq(&rtc_lock);
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
