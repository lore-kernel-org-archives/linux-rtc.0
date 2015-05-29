Return-Path: <rtc-linux+bncBCN6JTVP2IEBBEHYUGVQKGQETX3TK7I@googlegroups.com>
MIME-Version: 1.0
Received: from m50-111.126.com (m50-111.126.com. [123.125.50.111])
        by gmr-mx.google.com with ESMTP id qr9si232910igb.0.2015.05.29.07.47.42
        for <rtc-linux@googlegroups.com>;
        Fri, 29 May 2015 07:47:44 -0700 (PDT)
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	linux-cris-kernel@axis.com,
	Mikael Starvik <starvik@axis.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Xunlei Pang <pang.xunlei@linaro.org>
Subject: [rtc-linux] [PATCH v2 3/4] drivers/rtc/interface.c: Remove rtc_set_mmss()
Date: Fri, 29 May 2015 22:46:17 +0800
Message-Id: <1432910778-314-3-git-send-email-xlpang@126.com>
In-Reply-To: <1432910778-314-1-git-send-email-xlpang@126.com>
References: <1432910778-314-1-git-send-email-xlpang@126.com>
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

From: Xunlei Pang <pang.xunlei@linaro.org>

Now rtc_set_mmss() has no users, just remove it.

We still have rtc_set_time() doing similar things.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/interface.c | 45 ---------------------------------------------
 include/linux/rtc.h     |  1 -
 2 files changed, 46 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 166fc60..b511aa1 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -91,51 +91,6 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 }
 EXPORT_SYMBOL_GPL(rtc_set_time);
 
-int rtc_set_mmss(struct rtc_device *rtc, unsigned long secs)
-{
-	int err;
-
-	err = mutex_lock_interruptible(&rtc->ops_lock);
-	if (err)
-		return err;
-
-	if (!rtc->ops)
-		err = -ENODEV;
-	else if (rtc->ops->set_mmss64)
-		err = rtc->ops->set_mmss64(rtc->dev.parent, secs);
-	else if (rtc->ops->set_mmss)
-		err = rtc->ops->set_mmss(rtc->dev.parent, secs);
-	else if (rtc->ops->read_time && rtc->ops->set_time) {
-		struct rtc_time new, old;
-
-		err = rtc->ops->read_time(rtc->dev.parent, &old);
-		if (err == 0) {
-			rtc_time64_to_tm(secs, &new);
-
-			/*
-			 * avoid writing when we're going to change the day of
-			 * the month. We will retry in the next minute. This
-			 * basically means that if the RTC must not drift
-			 * by more than 1 minute in 11 minutes.
-			 */
-			if (!((old.tm_hour == 23 && old.tm_min == 59) ||
-				(new.tm_hour == 23 && new.tm_min == 59)))
-				err = rtc->ops->set_time(rtc->dev.parent,
-						&new);
-		}
-	} else {
-		err = -EINVAL;
-	}
-
-	pm_stay_awake(rtc->dev.parent);
-	mutex_unlock(&rtc->ops_lock);
-	/* A timer might have just expired */
-	schedule_work(&rtc->irqwork);
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(rtc_set_mmss);
-
 static int rtc_read_alarm_internal(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 {
 	int err;
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 8dcf682..e8f2c3c 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -161,7 +161,6 @@ extern void devm_rtc_device_unregister(struct device *dev,
 
 extern int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm);
 extern int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm);
-extern int rtc_set_mmss(struct rtc_device *rtc, unsigned long secs);
 extern int rtc_set_ntp_time(struct timespec64 now);
 int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm);
 extern int rtc_read_alarm(struct rtc_device *rtc,
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
