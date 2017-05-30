Return-Path: <rtc-linux+bncBDE6RCFOWIARBC6KWTEQKGQE73Z4JIQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-lf0-x229.google.com (mail-lf0-x229.google.com. [2a00:1450:4010:c07::229])
        by gmr-mx.google.com with ESMTPS id g11si523717wme.2.2017.05.30.00.53.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 May 2017 00:53:46 -0700 (PDT)
Received: by mail-lf0-x229.google.com with SMTP id a5so44433342lfh.2
        for <rtc-linux@googlegroups.com>; Tue, 30 May 2017 00:53:46 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [rtc-linux] [PATCH 1/3 v2] rtc: gemini: Add optional clock handling
Date: Tue, 30 May 2017 09:53:30 +0200
Message-Id: <20170530075332.3740-1-linus.walleij@linaro.org>
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

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
