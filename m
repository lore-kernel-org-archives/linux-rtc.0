Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:47053 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbeIJB3w (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 9 Sep 2018 21:29:52 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: pl030: fix possible race condition
Date: Sun,  9 Sep 2018 22:38:47 +0200
Message-Id: <20180909203848.3470-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
References: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before requesting the IRQ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pl030.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index f85a1a93e669..343bb6ed1783 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -112,6 +112,13 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 		goto err_rtc;
 	}
 
+	rtc->rtc = devm_rtc_allocate_device(&dev->dev);
+	if (IS_ERR(rtc->rtc)) {
+		ret = PTR_ERR(rtc->rtc);
+		goto err_rtc;
+	}
+
+	rtc->rtc->ops = &pl030_ops;
 	rtc->base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!rtc->base) {
 		ret = -ENOMEM;
@@ -128,12 +135,9 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 	if (ret)
 		goto err_irq;
 
-	rtc->rtc = rtc_device_register("pl030", &dev->dev, &pl030_ops,
-				       THIS_MODULE);
-	if (IS_ERR(rtc->rtc)) {
-		ret = PTR_ERR(rtc->rtc);
+	ret = rtc_register_device(rtc->rtc);
+	if (ret)
 		goto err_reg;
-	}
 
 	return 0;
 
@@ -154,7 +158,6 @@ static int pl030_remove(struct amba_device *dev)
 	writel(0, rtc->base + RTC_CR);
 
 	free_irq(dev->irq[0], rtc);
-	rtc_device_unregister(rtc->rtc);
 	iounmap(rtc->base);
 	amba_release_regions(dev);
 
-- 
2.19.0.rc2
