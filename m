Return-Path: <rtc-linux+bncBDKZNNNLXAHBBWOJ4OUQKGQEVC242PQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com. [2607:f8b0:400e:c02::236])
        by gmr-mx.google.com with ESMTPS id pc4si1053591pac.0.2015.04.23.05.26.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2015 05:26:01 -0700 (PDT)
Received: by mail-pd0-x236.google.com with SMTP id nk13so17221511pdb.0
        for <rtc-linux@googlegroups.com>; Thu, 23 Apr 2015 05:26:01 -0700 (PDT)
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [rtc-linux] [PATCH 2/2] rtc: interface: Remove unused return value
 from rtc_timer_cancel()
Date: Thu, 23 Apr 2015 21:25:40 +0900
Message-Id: <1429791940-22169-2-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1429791940-22169-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1429791940-22169-1-git-send-email-k.kozlowski.k@gmail.com>
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

The rtc_timer_cancel() always returns 0 and cannot fail (calls only
other void-returning functions).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/rtc/interface.c | 4 +---
 include/linux/rtc.h     | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 96268fc11337..31f11ab214a0 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -983,14 +983,12 @@ int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
  *
  * Kernel interface to cancel an rtc_timer
  */
-int rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer)
+void rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer)
 {
-	int ret = 0;
 	mutex_lock(&rtc->ops_lock);
 	if (timer->enabled)
 		rtc_timer_remove(rtc, timer);
 	mutex_unlock(&rtc->ops_lock);
-	return ret;
 }
 
 
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 85b48b29a143..381d12086ab3 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -204,7 +204,7 @@ int rtc_control(rtc_task_t *t, unsigned int cmd, unsigned long arg);
 void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data);
 int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
 			ktime_t expires, ktime_t period);
-int rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer);
+void rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer);
 void rtc_timer_do_work(struct work_struct *work);
 
 static inline bool is_leap_year(unsigned int year)
-- 
2.1.0

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
