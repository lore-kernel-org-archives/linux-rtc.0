Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:44414 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750823AbdJYOCW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 25 Oct 2017 10:02:22 -0400
From: Chen Zhong <chen.zhong@mediatek.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linus Walleij <linus.walleij@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-rtc@vger.kernel.org>
Subject: [PATCH v6 1/6] mfd: mt6397: create irq mappings in mfd core driver
Date: Wed, 25 Oct 2017 21:15:59 +0800
Message-ID: <1508937364-30054-2-git-send-email-chen.zhong@mediatek.com>
In-Reply-To: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The core driver should create and manage irq mappings instead of
leaf drivers. This patch change to pass irq domain to
devm_mfd_add_devices() and it will create mapping for irq resources
automatically. And remove irq mapping in rtc driver since this has
been done in core driver.

Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 drivers/mfd/mt6397-core.c |    4 ++--
 drivers/rtc/rtc-mt6397.c  |    7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 04a601f..6546d7f 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -289,7 +289,7 @@ static int mt6397_probe(struct platform_device *pdev)
 
 		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
 					   ARRAY_SIZE(mt6323_devs), NULL,
-					   0, NULL);
+					   0, pmic->irq_domain);
 		break;
 
 	case MT6397_CID_CODE:
@@ -304,7 +304,7 @@ static int mt6397_probe(struct platform_device *pdev)
 
 		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
 					   ARRAY_SIZE(mt6397_devs), NULL,
-					   0, NULL);
+					   0, pmic->irq_domain);
 		break;
 
 	default:
diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 1a61fa5..385f830 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -322,10 +322,9 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rtc->addr_base = res->start;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);
-	if (rtc->irq <= 0)
-		return -EINVAL;
+	rtc->irq = platform_get_irq(pdev, 0);
+	if (rtc->irq < 0)
+		return rtc->irq;
 
 	rtc->regmap = mt6397_chip->regmap;
 	rtc->dev = &pdev->dev;
-- 
1.7.9.5
