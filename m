Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43185 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdE3IWC (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 30 May 2017 04:22:02 -0400
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id C7F7120EC6
        for <linux-rtc@vger.kernel.org>; Tue, 30 May 2017 10:21:28 +0200 (CEST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3 v2] rtc: gemini: Add optional clock handling
Date: Tue, 30 May 2017 09:53:30 +0200
Message-Id: <20170530075332.3740-1-linus.walleij@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>
Message-ID: <20170530075330.kaM62XNx8nCH8dKfxLkLr3WV8kBUU_I2Tmz1_bATRv4@z>

This makes the Gemini optionally take two clock references to
the PCLK and EXTCLK. As we are adding a clock framework to the
Gemini platform we need to make sure that we get the right
references.

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use devm_clk_get() so we do not leave dangling clocks
  behind.
- Add Hans' ACK.
---
 drivers/rtc/rtc-gemini.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index 5279390bb42d..cf766e01832a 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/clk.h>
 
 #define DRV_NAME        "rtc-gemini"
 
@@ -38,6 +39,8 @@ struct gemini_rtc {
 	struct rtc_device	*rtc_dev;
 	void __iomem		*rtc_base;
 	int			rtc_irq;
+	struct clk		*pclk;
+	struct clk		*extclk;
 };
 
 enum gemini_rtc_offsets {
@@ -127,6 +130,27 @@ static int gemini_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, rtc);
 
+	rtc->pclk = devm_clk_get(dev, "PCLK");
+	if (IS_ERR(rtc->pclk)) {
+		dev_err(dev, "could not get PCLK\n");
+	} else {
+		ret = clk_prepare_enable(rtc->pclk);
+		if (ret) {
+			dev_err(dev, "failed to enable PCLK\n");
+			return ret;
+		}
+	}
+	rtc->extclk = devm_clk_get(dev, "EXTCLK");
+	if (IS_ERR(rtc->extclk)) {
+		dev_err(dev, "could not get EXTCLK\n");
+	} else {
+		ret = clk_prepare_enable(rtc->extclk);
+		if (ret) {
+			dev_err(dev, "failed to enable EXTCLK\n");
+			return ret;
+		}
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res)
 		return -ENODEV;
@@ -156,6 +180,10 @@ static int gemini_rtc_remove(struct platform_device *pdev)
 {
 	struct gemini_rtc *rtc = platform_get_drvdata(pdev);
 
+	if (!IS_ERR(rtc->extclk))
+		clk_disable_unprepare(rtc->extclk);
+	if (!IS_ERR(rtc->pclk))
+		clk_disable_unprepare(rtc->pclk);
 	rtc_device_unregister(rtc->rtc_dev);
 
 	return 0;
-- 
2.9.4
