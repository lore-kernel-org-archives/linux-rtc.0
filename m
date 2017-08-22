Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53391 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932464AbdHVKG6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 22 Aug 2017 06:06:58 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/2] rtc: puv3: switch to devm_rtc_allocate_device()/rtc_register_device()
Date: Tue, 22 Aug 2017 12:06:50 +0200
Message-Id: <20170822100651.26590-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use managed RTC device allocation as this allows for further cleanup.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-puv3.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-puv3.c b/drivers/rtc/rtc-puv3.c
index c0a6e638c672..4f495dee2f48 100644
--- a/drivers/rtc/rtc-puv3.c
+++ b/drivers/rtc/rtc-puv3.c
@@ -222,10 +222,6 @@ static void puv3_rtc_enable(struct device *dev, int en)
 
 static int puv3_rtc_remove(struct platform_device *dev)
 {
-	struct rtc_device *rtc = platform_get_drvdata(dev);
-
-	rtc_device_unregister(rtc);
-
 	puv3_rtc_setpie(&dev->dev, 0);
 	puv3_rtc_setaie(&dev->dev, 0);
 
@@ -259,6 +255,10 @@ static int puv3_rtc_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "PKUnity_rtc: tick irq %d, alarm irq %d\n",
 		 puv3_rtc_tickno, puv3_rtc_alarmno);
 
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
 	/* get the memory region */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
@@ -278,12 +278,10 @@ static int puv3_rtc_probe(struct platform_device *pdev)
 	puv3_rtc_enable(&pdev->dev, 1);
 
 	/* register RTC and exit */
-	rtc = rtc_device_register("pkunity", &pdev->dev, &puv3_rtcops,
-				  THIS_MODULE);
-
-	if (IS_ERR(rtc)) {
+	rtc->ops = &puv3_rtcops;
+	ret = rtc_register_device(rtc);
+	if (ret) {
 		dev_err(&pdev->dev, "cannot attach rtc\n");
-		ret = PTR_ERR(rtc);
 		goto err_nortc;
 	}
 
-- 
2.14.1
