Return-Path: <rtc-linux+bncBDKZNNNLXAHBBV6J4OUQKGQEJ3L57YY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x232.google.com (mail-pd0-x232.google.com. [2607:f8b0:400e:c02::232])
        by gmr-mx.google.com with ESMTPS id xv6si1042857pab.2.2015.04.23.05.25.58
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2015 05:25:58 -0700 (PDT)
Received: by mail-pd0-x232.google.com with SMTP id a3so17172201pde.3
        for <rtc-linux@googlegroups.com>; Thu, 23 Apr 2015 05:25:58 -0700 (PDT)
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [rtc-linux] [PATCH 1/2] rtc: interface: Fix coding style violations
Date: Thu, 23 Apr 2015 21:25:39 +0900
Message-Id: <1429791940-22169-1-git-send-email-k.kozlowski.k@gmail.com>
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

Fix issues reported by checkpatch:
  ERROR: open brace '{' following struct go on the same line
  ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 include/linux/rtc.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index c8b68741994e..85b48b29a143 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -101,8 +101,7 @@ struct rtc_timer {
 /* flags */
 #define RTC_DEV_BUSY 0
 
-struct rtc_device
-{
+struct rtc_device {
 	struct device dev;
 	struct module *owner;
 
@@ -202,10 +201,10 @@ int rtc_register(rtc_task_t *task);
 int rtc_unregister(rtc_task_t *task);
 int rtc_control(rtc_task_t *t, unsigned int cmd, unsigned long arg);
 
-void rtc_timer_init(struct rtc_timer *timer, void (*f)(void* p), void* data);
-int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer* timer,
+void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data);
+int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
 			ktime_t expires, ktime_t period);
-int rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer* timer);
+int rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer);
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
