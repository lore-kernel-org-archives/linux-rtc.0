Return-Path: <rtc-linux+bncBDKZNNNLXAHBBAXCS6VAKGQE2XYSL3Q@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x22e.google.com (mail-pd0-x22e.google.com. [2607:f8b0:400e:c02::22e])
        by gmr-mx.google.com with ESMTPS id dv5si1289307pbb.0.2015.05.03.02.57.22
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2015 02:57:22 -0700 (PDT)
Received: by pdbqd1 with SMTP id qd1so136978596pdb.2
        for <rtc-linux@googlegroups.com>; Sun, 03 May 2015 02:57:22 -0700 (PDT)
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [rtc-linux] [PATCH v2 1/2] rtc: interface: Fix coding style violations
Date: Sun,  3 May 2015 18:57:10 +0900
Message-Id: <1430647031-13584-1-git-send-email-k.kozlowski.k@gmail.com>
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
Additionally adjust alignment of wrapper function arguments.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

---

Changes since v1:
1. Adjust alignment (suggested by Alexandre Belloni).
---
 include/linux/rtc.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index c8b68741994e..4a5e2bda4358 100644
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
-			ktime_t expires, ktime_t period);
-int rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer* timer);
+void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data);
+int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
+		    ktime_t expires, ktime_t period);
+int rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer);
 void rtc_timer_do_work(struct work_struct *work);
 
 static inline bool is_leap_year(unsigned int year)
-- 
2.1.4

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
