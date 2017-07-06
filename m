Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49151 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdGFJmO (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 05:42:14 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 01/11] rtc: class separate device allocation from registration
Date: Thu,  6 Jul 2017 11:41:58 +0200
Message-Id: <20170706094208.16240-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
References: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Create rtc_allocate_device to allocate memory for a struct rtc_device and
initialize it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/class.c | 63 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 543c64cd3df0..fb39c1334d7b 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -150,6 +150,41 @@ static SIMPLE_DEV_PM_OPS(rtc_class_dev_pm_ops, rtc_suspend, rtc_resume);
 #define RTC_CLASS_DEV_PM_OPS	NULL
 #endif
 
+static struct rtc_device *rtc_allocate_device(void)
+{
+	struct rtc_device *rtc;
+
+	rtc = kzalloc(sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return NULL;
+
+	device_initialize(&rtc->dev);
+
+	rtc->irq_freq = 1;
+	rtc->max_user_freq = 64;
+	rtc->dev.class = rtc_class;
+	rtc->dev.groups = rtc_get_dev_attribute_groups();
+	rtc->dev.release = rtc_device_release;
+
+	mutex_init(&rtc->ops_lock);
+	spin_lock_init(&rtc->irq_lock);
+	spin_lock_init(&rtc->irq_task_lock);
+	init_waitqueue_head(&rtc->irq_queue);
+
+	/* Init timerqueue */
+	timerqueue_init_head(&rtc->timerqueue);
+	INIT_WORK(&rtc->irqwork, rtc_timer_do_work);
+	/* Init aie timer */
+	rtc_timer_init(&rtc->aie_timer, rtc_aie_update_irq, (void *)rtc);
+	/* Init uie timer */
+	rtc_timer_init(&rtc->uie_rtctimer, rtc_uie_update_irq, (void *)rtc);
+	/* Init pie timer */
+	hrtimer_init(&rtc->pie_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	rtc->pie_timer.function = rtc_pie_update_irq;
+	rtc->pie_enabled = 0;
+
+	return rtc;
+}
 
 /**
  * rtc_device_register - register w/ RTC class
@@ -189,40 +224,16 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 		}
 	}
 
-	rtc = kzalloc(sizeof(struct rtc_device), GFP_KERNEL);
-	if (rtc == NULL) {
+	rtc = rtc_allocate_device();
+	if (!rtc) {
 		err = -ENOMEM;
 		goto exit_ida;
 	}
 
-	device_initialize(&rtc->dev);
-
 	rtc->id = id;
 	rtc->ops = ops;
 	rtc->owner = owner;
-	rtc->irq_freq = 1;
-	rtc->max_user_freq = 64;
 	rtc->dev.parent = dev;
-	rtc->dev.class = rtc_class;
-	rtc->dev.groups = rtc_get_dev_attribute_groups();
-	rtc->dev.release = rtc_device_release;
-
-	mutex_init(&rtc->ops_lock);
-	spin_lock_init(&rtc->irq_lock);
-	spin_lock_init(&rtc->irq_task_lock);
-	init_waitqueue_head(&rtc->irq_queue);
-
-	/* Init timerqueue */
-	timerqueue_init_head(&rtc->timerqueue);
-	INIT_WORK(&rtc->irqwork, rtc_timer_do_work);
-	/* Init aie timer */
-	rtc_timer_init(&rtc->aie_timer, rtc_aie_update_irq, (void *)rtc);
-	/* Init uie timer */
-	rtc_timer_init(&rtc->uie_rtctimer, rtc_uie_update_irq, (void *)rtc);
-	/* Init pie timer */
-	hrtimer_init(&rtc->pie_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	rtc->pie_timer.function = rtc_pie_update_irq;
-	rtc->pie_enabled = 0;
 
 	dev_set_name(&rtc->dev, "rtc%d", id);
 
-- 
2.11.0
