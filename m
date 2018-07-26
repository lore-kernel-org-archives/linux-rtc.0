Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:59280 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730184AbeGZO6S (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:18 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/8] rtc: sh: remove dead code
Date: Thu, 26 Jul 2018 15:40:50 +0200
Message-Id: <20180726134056.18273-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Since commit 80d4bb515b78 ("RTC: Cleanup rtc_class_ops->irq_set_state") and
commit 696160fec162 ("RTC: Cleanup rtc_class_ops->irq_set_freq()"),
sh_rtc_irq_set_state and sh_rtc_irq_set_freq are never called. Remove them
along with task handling.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sh.c | 89 +-------------------------------------------
 1 file changed, 1 insertion(+), 88 deletions(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 4f98543d1ea5..abbce362f4df 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -143,7 +143,6 @@ static int __sh_rtc_alarm(struct sh_rtc *rtc)
 static int __sh_rtc_periodic(struct sh_rtc *rtc)
 {
 	struct rtc_device *rtc_dev = rtc->rtc_dev;
-	struct rtc_task *irq_task;
 	unsigned int tmp, pending;
 
 	tmp = readb(rtc->regbase + RCR2);
@@ -160,14 +159,7 @@ static int __sh_rtc_periodic(struct sh_rtc *rtc)
 	else {
 		if (rtc->periodic_freq & PF_HP)
 			rtc->periodic_freq |= PF_COUNT;
-		if (rtc->periodic_freq & PF_KOU) {
-			spin_lock(&rtc_dev->irq_task_lock);
-			irq_task = rtc_dev->irq_task;
-			if (irq_task)
-				irq_task->func(irq_task->private_data);
-			spin_unlock(&rtc_dev->irq_task_lock);
-		} else
-			rtc_update_irq(rtc->rtc_dev, 1, RTC_PF | RTC_IRQF);
+		rtc_update_irq(rtc->rtc_dev, 1, RTC_PF | RTC_IRQF);
 	}
 
 	return pending;
@@ -223,81 +215,6 @@ static irqreturn_t sh_rtc_shared(int irq, void *dev_id)
 	return IRQ_RETVAL(ret);
 }
 
-static int sh_rtc_irq_set_state(struct device *dev, int enable)
-{
-	struct sh_rtc *rtc = dev_get_drvdata(dev);
-	unsigned int tmp;
-
-	spin_lock_irq(&rtc->lock);
-
-	tmp = readb(rtc->regbase + RCR2);
-
-	if (enable) {
-		rtc->periodic_freq |= PF_KOU;
-		tmp &= ~RCR2_PEF;	/* Clear PES bit */
-		tmp |= (rtc->periodic_freq & ~PF_HP);	/* Set PES2-0 */
-	} else {
-		rtc->periodic_freq &= ~PF_KOU;
-		tmp &= ~(RCR2_PESMASK | RCR2_PEF);
-	}
-
-	writeb(tmp, rtc->regbase + RCR2);
-
-	spin_unlock_irq(&rtc->lock);
-
-	return 0;
-}
-
-static int sh_rtc_irq_set_freq(struct device *dev, int freq)
-{
-	struct sh_rtc *rtc = dev_get_drvdata(dev);
-	int tmp, ret = 0;
-
-	spin_lock_irq(&rtc->lock);
-	tmp = rtc->periodic_freq & PF_MASK;
-
-	switch (freq) {
-	case 0:
-		rtc->periodic_freq = 0x00;
-		break;
-	case 1:
-		rtc->periodic_freq = 0x60;
-		break;
-	case 2:
-		rtc->periodic_freq = 0x50;
-		break;
-	case 4:
-		rtc->periodic_freq = 0x40;
-		break;
-	case 8:
-		rtc->periodic_freq = 0x30 | PF_HP;
-		break;
-	case 16:
-		rtc->periodic_freq = 0x30;
-		break;
-	case 32:
-		rtc->periodic_freq = 0x20 | PF_HP;
-		break;
-	case 64:
-		rtc->periodic_freq = 0x20;
-		break;
-	case 128:
-		rtc->periodic_freq = 0x10 | PF_HP;
-		break;
-	case 256:
-		rtc->periodic_freq = 0x10;
-		break;
-	default:
-		ret = -ENOTSUPP;
-	}
-
-	if (ret == 0)
-		rtc->periodic_freq |= tmp;
-
-	spin_unlock_irq(&rtc->lock);
-	return ret;
-}
-
 static inline void sh_rtc_setaie(struct device *dev, unsigned int enable)
 {
 	struct sh_rtc *rtc = dev_get_drvdata(dev);
@@ -674,8 +591,6 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtc);
 
 	/* everything disabled by default */
-	sh_rtc_irq_set_freq(&pdev->dev, 0);
-	sh_rtc_irq_set_state(&pdev->dev, 0);
 	sh_rtc_setaie(&pdev->dev, 0);
 	sh_rtc_setcie(&pdev->dev, 0);
 
@@ -707,8 +622,6 @@ static int __exit sh_rtc_remove(struct platform_device *pdev)
 {
 	struct sh_rtc *rtc = platform_get_drvdata(pdev);
 
-	sh_rtc_irq_set_state(&pdev->dev, 0);
-
 	sh_rtc_setaie(&pdev->dev, 0);
 	sh_rtc_setcie(&pdev->dev, 0);
 
-- 
2.18.0
