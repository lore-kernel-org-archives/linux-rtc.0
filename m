Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:59315 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbeGZO61 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:27 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 8/8] rtc: remove struct rtc_task
Date: Thu, 26 Jul 2018 15:40:56 +0200
Message-Id: <20180726134056.18273-9-alexandre.belloni@bootlin.com>
In-Reply-To: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Include rtc_task members directly in rtc_timer member.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 8 ++++----
 include/linux/rtc.h     | 9 ++-------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index d0983ed6c842..a962540faf2e 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -912,8 +912,8 @@ void rtc_timer_do_work(struct work_struct *work)
 		timerqueue_del(&rtc->timerqueue, &timer->node);
 		trace_rtc_timer_dequeue(timer);
 		timer->enabled = 0;
-		if (timer->task.func)
-			timer->task.func(timer->task.private_data);
+		if (timer->func)
+			timer->func(timer->private_data);
 
 		trace_rtc_timer_fired(timer);
 		/* Re-add/fwd periodic timers */
@@ -968,8 +968,8 @@ void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data)
 {
 	timerqueue_init(&timer->node);
 	timer->enabled = 0;
-	timer->task.func = f;
-	timer->task.private_data = data;
+	timer->func = f;
+	timer->private_data = data;
 }
 
 /* rtc_timer_start - Sets an rtc_timer to fire in the future
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index bf4d375025d1..6aedc30003e7 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -87,16 +87,11 @@ struct rtc_class_ops {
 	int (*set_offset)(struct device *, long offset);
 };
 
-typedef struct rtc_task {
-	void (*func)(void *private_data);
-	void *private_data;
-} rtc_task_t;
-
-
 struct rtc_timer {
-	struct rtc_task	task;
 	struct timerqueue_node node;
 	ktime_t period;
+	void (*func)(void *private_data);
+	void *private_data;
 	int enabled;
 };
 
-- 
2.18.0
