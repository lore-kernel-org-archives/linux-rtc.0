Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53393 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932306AbdHVKG6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 22 Aug 2017 06:06:58 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/2] rtc: puv3: make alarms useful
Date: Tue, 22 Aug 2017 12:06:51 +0200
Message-Id: <20170822100651.26590-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170822100651.26590-1-alexandre.belloni@free-electrons.com>
References: <20170822100651.26590-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Currently, the driver unregisters the IRQs when the rtc character device is
closed. This means that the device needs to stay open to get alarms while
the usual use case will open the device, set the alarm and close the
device.

Move the IRQ requests to puv3_rtc_probe() and use the devm managed versions
so we don't need to free them.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-puv3.c | 56 +++++++++++++-------------------------------------
 1 file changed, 14 insertions(+), 42 deletions(-)

diff --git a/drivers/rtc/rtc-puv3.c b/drivers/rtc/rtc-puv3.c
index 4f495dee2f48..9e83be32ff43 100644
--- a/drivers/rtc/rtc-puv3.c
+++ b/drivers/rtc/rtc-puv3.c
@@ -157,49 +157,7 @@ static int puv3_rtc_proc(struct device *dev, struct seq_file *seq)
 	return 0;
 }
 
-static int puv3_rtc_open(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_device *rtc_dev = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = request_irq(puv3_rtc_alarmno, puv3_rtc_alarmirq,
-			0, "pkunity-rtc alarm", rtc_dev);
-
-	if (ret) {
-		dev_err(dev, "IRQ%d error %d\n", puv3_rtc_alarmno, ret);
-		return ret;
-	}
-
-	ret = request_irq(puv3_rtc_tickno, puv3_rtc_tickirq,
-			0, "pkunity-rtc tick", rtc_dev);
-
-	if (ret) {
-		dev_err(dev, "IRQ%d error %d\n", puv3_rtc_tickno, ret);
-		goto tick_err;
-	}
-
-	return ret;
-
- tick_err:
-	free_irq(puv3_rtc_alarmno, rtc_dev);
-	return ret;
-}
-
-static void puv3_rtc_release(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_device *rtc_dev = platform_get_drvdata(pdev);
-
-	/* do not clear AIE here, it may be needed for wake */
-	puv3_rtc_setpie(dev, 0);
-	free_irq(puv3_rtc_alarmno, rtc_dev);
-	free_irq(puv3_rtc_tickno, rtc_dev);
-}
-
 static const struct rtc_class_ops puv3_rtcops = {
-	.open		= puv3_rtc_open,
-	.release	= puv3_rtc_release,
 	.read_time	= puv3_rtc_gettime,
 	.set_time	= puv3_rtc_settime,
 	.read_alarm	= puv3_rtc_getalarm,
@@ -259,6 +217,20 @@ static int puv3_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	ret = devm_request_irq(&pdev->dev, puv3_rtc_alarmno, puv3_rtc_alarmirq,
+			       0, "pkunity-rtc alarm", rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "IRQ%d error %d\n", puv3_rtc_alarmno, ret);
+		return ret;
+	}
+
+	ret = devm_request_irq(&pdev->dev, puv3_rtc_tickno, puv3_rtc_tickirq,
+			       0, "pkunity-rtc tick", rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "IRQ%d error %d\n", puv3_rtc_tickno, ret);
+		return ret;
+	}
+
 	/* get the memory region */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
-- 
2.14.1
