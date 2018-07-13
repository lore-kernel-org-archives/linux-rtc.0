Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:53962 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729670AbeGMPgm (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 13 Jul 2018 11:36:42 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] rtc: jz4740: Add support for the JZ4725B, JZ4760, JZ4770
Date: Fri, 13 Jul 2018 17:14:24 +0200
Message-Id: <20180713151424.13000-1-paul@crapouillou.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The RTC in the JZ4725B works just like the one in the JZ4740.

The RTC in the JZ4760 and JZ4770 work just like the one in the JZ4780.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt |  3 +++
 drivers/rtc/rtc-jz4740.c                                     | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
index 41c7ae18fd7b..a9e821de84f2 100644
--- a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
@@ -4,6 +4,9 @@ Required properties:
 
 - compatible: One of:
   - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
+  - "ingenic,jz4725b-rtc" - for use with the JZ4725B SoC
+  - "ingenic,jz4760-rtc" - for use with the JZ4760 SoC
+  - "ingenic,jz4770-rtc" - for use with the JZ4770 SoC
   - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
 - reg: Address range of rtc register set
 - interrupts: IRQ number for the alarm interrupt
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index d0a891777f44..1c867e3a0ea5 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -54,6 +54,9 @@
 
 enum jz4740_rtc_type {
 	ID_JZ4740,
+	ID_JZ4725B,
+	ID_JZ4760,
+	ID_JZ4770,
 	ID_JZ4780,
 };
 
@@ -114,7 +117,7 @@ static inline int jz4740_rtc_reg_write(struct jz4740_rtc *rtc, size_t reg,
 {
 	int ret = 0;
 
-	if (rtc->type >= ID_JZ4780)
+	if (rtc->type >= ID_JZ4760)
 		ret = jz4780_rtc_enable_write(rtc);
 	if (ret == 0)
 		ret = jz4740_rtc_wait_write_ready(rtc);
@@ -300,6 +303,9 @@ static void jz4740_rtc_power_off(void)
 
 static const struct of_device_id jz4740_rtc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-rtc", .data = (void *)ID_JZ4740 },
+	{ .compatible = "ingenic,jz4725b-rtc", .data = (void *)ID_JZ4725B },
+	{ .compatible = "ingenic,jz4760-rtc", .data = (void *)ID_JZ4760 },
+	{ .compatible = "ingenic,jz4770-rtc", .data = (void *)ID_JZ4770 },
 	{ .compatible = "ingenic,jz4780-rtc", .data = (void *)ID_JZ4780 },
 	{},
 };
@@ -428,6 +434,9 @@ static const struct dev_pm_ops jz4740_pm_ops = {
 
 static const struct platform_device_id jz4740_rtc_ids[] = {
 	{ "jz4740-rtc", ID_JZ4740 },
+	{ "jz4725b-rtc", ID_JZ4725B },
+	{ "jz4760-rtc", ID_JZ4760 },
+	{ "jz4770-rtc", ID_JZ4770 },
 	{ "jz4780-rtc", ID_JZ4780 },
 	{}
 };
-- 
2.11.0
