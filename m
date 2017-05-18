Return-Path: <rtc-linux+bncBDE6RCFOWIARB66Y7DEAKGQEFNZWSSA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id n5si510372wmg.0.2017.05.18.16.21.30
        for <rtc-linux@googlegroups.com>;
        Thu, 18 May 2017 16:21:30 -0700 (PDT)
Received: from localhost (unknown [88.191.26.124])
	by mail.free-electrons.com (Postfix) with ESMTPSA id 6B69820D80
	for <rtc-linux@googlegroups.com>; Fri, 19 May 2017 01:21:28 +0200 (CEST)
Resent-Message-ID: <20170518232128.2txnis2n2djp3kdr@piout.net>
From: Linus Walleij <linus.walleij@linaro.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-rtc@vger.kernel.org
Cc: Janos Laube <janos.dev@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [rtc-linux] [PATCH 1/3] rtc: gemini: Add optional clock handling
Date: Thu, 18 May 2017 23:56:33 +0200
Message-Id: <20170518215635.13505-1-linus.walleij@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This makes the Gemini optionally take two clock references to
the PCLK and EXTCLK. As we are adding a clock framework to the
Gemini platform we need to make sure that we get the right
references.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/rtc/rtc-gemini.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index 5279390bb42d..d69a35aa80e7 100644
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
 
+	rtc->pclk = clk_get(dev, "PCLK");
+	if (IS_ERR(rtc->pclk)) {
+		dev_err(dev, "could not get PCLK\n");
+	} else {
+		ret = clk_prepare_enable(rtc->pclk);
+		if (ret) {
+			dev_err(dev, "failed to enable PCLK\n");
+			return ret;
+		}
+	}
+	rtc->extclk = clk_get(dev, "EXTCLK");
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
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
