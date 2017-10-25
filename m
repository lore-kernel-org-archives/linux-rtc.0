Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:39542 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750949AbdJYNwM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 25 Oct 2017 09:52:12 -0400
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
Subject: [PATCH v6 6/6] mfd: mt6397: Add PMIC keys support to MT6397 driver
Date: Wed, 25 Oct 2017 21:16:04 +0800
Message-ID: <1508937364-30054-7-git-send-email-chen.zhong@mediatek.com>
In-Reply-To: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This patch adds compatible strings and interrupts for pmic keys
which serves as child device of MFD.

Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 drivers/mfd/mt6397-core.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 6546d7f..77b64bd 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -43,6 +43,16 @@
 	},
 };
 
+static const struct resource mt6323_keys_resources[] = {
+	DEFINE_RES_IRQ(MT6323_IRQ_STATUS_PWRKEY),
+	DEFINE_RES_IRQ(MT6323_IRQ_STATUS_FCHRKEY),
+};
+
+static const struct resource mt6397_keys_resources[] = {
+	DEFINE_RES_IRQ(MT6397_IRQ_PWRKEY),
+	DEFINE_RES_IRQ(MT6397_IRQ_HOMEKEY),
+};
+
 static const struct mfd_cell mt6323_devs[] = {
 	{
 		.name = "mt6323-regulator",
@@ -50,6 +60,11 @@
 	}, {
 		.name = "mt6323-led",
 		.of_compatible = "mediatek,mt6323-led"
+	}, {
+		.name = "mtk-pmic-keys",
+		.num_resources = ARRAY_SIZE(mt6323_keys_resources),
+		.resources = mt6323_keys_resources,
+		.of_compatible = "mediatek,mt6323-keys"
 	},
 };
 
@@ -71,7 +86,12 @@
 	}, {
 		.name = "mt6397-pinctrl",
 		.of_compatible = "mediatek,mt6397-pinctrl",
-	},
+	}, {
+		.name = "mtk-pmic-keys",
+		.num_resources = ARRAY_SIZE(mt6397_keys_resources),
+		.resources = mt6397_keys_resources,
+		.of_compatible = "mediatek,mt6397-keys"
+	}
 };
 
 static void mt6397_irq_lock(struct irq_data *data)
-- 
1.7.9.5
