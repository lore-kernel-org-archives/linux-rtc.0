Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:59285 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730441AbeGZO6T (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:19 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/8] rtc: remove rtc_irq_register/rtc_irq_unregister
Date: Thu, 26 Jul 2018 15:40:51 +0200
Message-Id: <20180726134056.18273-4-alexandre.belloni@bootlin.com>
In-Reply-To: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The rtc_irq_* interface is not used from outside the RTC subsytem since
2016.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 33 ---------------------------------
 include/linux/rtc.h     |  4 ----
 2 files changed, 37 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 6d4012dd6922..2b1b9a0b9f8a 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -719,39 +719,6 @@ void rtc_class_close(struct rtc_device *rtc)
 }
 EXPORT_SYMBOL_GPL(rtc_class_close);
 
-int rtc_irq_register(struct rtc_device *rtc, struct rtc_task *task)
-{
-	int retval = -EBUSY;
-
-	if (task == NULL || task->func == NULL)
-		return -EINVAL;
-
-	/* Cannot register while the char dev is in use */
-	if (test_and_set_bit_lock(RTC_DEV_BUSY, &rtc->flags))
-		return -EBUSY;
-
-	spin_lock_irq(&rtc->irq_task_lock);
-	if (rtc->irq_task == NULL) {
-		rtc->irq_task = task;
-		retval = 0;
-	}
-	spin_unlock_irq(&rtc->irq_task_lock);
-
-	clear_bit_unlock(RTC_DEV_BUSY, &rtc->flags);
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(rtc_irq_register);
-
-void rtc_irq_unregister(struct rtc_device *rtc, struct rtc_task *task)
-{
-	spin_lock_irq(&rtc->irq_task_lock);
-	if (rtc->irq_task == task)
-		rtc->irq_task = NULL;
-	spin_unlock_irq(&rtc->irq_task_lock);
-}
-EXPORT_SYMBOL_GPL(rtc_irq_unregister);
-
 static int rtc_update_hrtimer(struct rtc_device *rtc, int enabled)
 {
 	/*
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 6268208760e9..f868d6b619ab 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -204,10 +204,6 @@ extern void rtc_update_irq(struct rtc_device *rtc,
 extern struct rtc_device *rtc_class_open(const char *name);
 extern void rtc_class_close(struct rtc_device *rtc);
 
-extern int rtc_irq_register(struct rtc_device *rtc,
-				struct rtc_task *task);
-extern void rtc_irq_unregister(struct rtc_device *rtc,
-				struct rtc_task *task);
 extern int rtc_irq_set_state(struct rtc_device *rtc,
 				struct rtc_task *task, int enabled);
 extern int rtc_irq_set_freq(struct rtc_device *rtc,
-- 
2.18.0
