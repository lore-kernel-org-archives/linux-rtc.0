Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47525 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbdHVXyM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 22 Aug 2017 19:54:12 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: sa1100: make alarms useful
Date: Wed, 23 Aug 2017 01:53:54 +0200
Message-Id: <20170822235354.15533-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Currently, the driver unregisters the IRQs when the rtc character device is
closed. This means that the device needs to stay open to get alarms while
the usual use case will open the device, set the alarm and close the
device.

Move the IRQ requests to sa1100_rtc_probe() and use the devm managed
versions so we don't need to free them.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-sa1100.c | 61 ++++++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index fe8ebf47bbe5..8e6cf4323267 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -95,44 +95,6 @@ static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int sa1100_rtc_open(struct device *dev)
-{
-	struct sa1100_rtc *info = dev_get_drvdata(dev);
-	struct rtc_device *rtc = info->rtc;
-	int ret;
-
-	ret = request_irq(info->irq_1hz, sa1100_rtc_interrupt, 0, "rtc 1Hz", dev);
-	if (ret) {
-		dev_err(dev, "IRQ %d already in use.\n", info->irq_1hz);
-		return ret;
-	}
-	ret = request_irq(info->irq_alarm, sa1100_rtc_interrupt, 0, "rtc Alrm", dev);
-	if (ret) {
-		dev_err(dev, "IRQ %d already in use.\n", info->irq_alarm);
-		goto fail_ai;
-	}
-	rtc->max_user_freq = RTC_FREQ;
-	rtc_irq_set_freq(rtc, NULL, RTC_FREQ);
-
-	return 0;
-
- fail_ai:
-	free_irq(info->irq_1hz, dev);
-	return ret;
-}
-
-static void sa1100_rtc_release(struct device *dev)
-{
-	struct sa1100_rtc *info = dev_get_drvdata(dev);
-
-	spin_lock_irq(&info->lock);
-	writel_relaxed(0, info->rtsr);
-	spin_unlock_irq(&info->lock);
-
-	free_irq(info->irq_alarm, dev);
-	free_irq(info->irq_1hz, dev);
-}
-
 static int sa1100_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	u32 rtsr;
@@ -214,8 +176,6 @@ static int sa1100_rtc_proc(struct device *dev, struct seq_file *seq)
 }
 
 static const struct rtc_class_ops sa1100_rtc_ops = {
-	.open = sa1100_rtc_open,
-	.release = sa1100_rtc_release,
 	.read_time = sa1100_rtc_read_time,
 	.set_time = sa1100_rtc_set_time,
 	.read_alarm = sa1100_rtc_read_alarm,
@@ -309,6 +269,21 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	info->irq_1hz = irq_1hz;
 	info->irq_alarm = irq_alarm;
 
+	ret = devm_request_irq(&pdev->dev, irq_1hz, sa1100_rtc_interrupt, 0,
+			       "rtc 1Hz", dev);
+	if (ret) {
+		dev_err(&pdev->dev, "IRQ %d already in use.\n", irq_1hz);
+		return ret;
+	}
+	ret = devm_request_irq(&pdev->dev, irq_alarm, sa1100_rtc_interrupt, 0,
+			       "rtc Alrm", dev);
+	if (ret) {
+		dev_err(&pdev->dev, dev, "IRQ %d already in use.\n", irq_alarm);
+		return ret;
+	}
+
+	rtc->max_user_freq = RTC_FREQ;
+	rtc_irq_set_freq(rtc, NULL, RTC_FREQ);
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, iores);
 	if (IS_ERR(base))
@@ -337,8 +312,12 @@ static int sa1100_rtc_remove(struct platform_device *pdev)
 {
 	struct sa1100_rtc *info = platform_get_drvdata(pdev);
 
-	if (info)
+	if (info) {
+		spin_lock_irq(&info->lock);
+		writel_relaxed(0, info->rtsr);
+		spin_unlock_irq(&info->lock);
 		clk_disable_unprepare(info->clk);
+	}
 
 	return 0;
 }
-- 
2.14.1
