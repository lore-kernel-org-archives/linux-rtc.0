Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33698 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdGLFuD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 12 Jul 2017 01:50:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id x23so3216412wrb.0
        for <linux-rtc@vger.kernel.org>; Tue, 11 Jul 2017 22:50:02 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/9] rtc: ds1307: remove member irq from struct ds1307
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Message-ID: <8784802b-3efa-8d2c-fc54-fce7af6bcbf0@gmail.com>
Date: Wed, 12 Jul 2017 07:49:14 +0200
MIME-Version: 1.0
In-Reply-To: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The irq number is used in the probe function only, so we don't have
to store it in struct ds1307.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 1cedb21b..adc90f18 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -126,7 +126,6 @@ struct ds1307 {
 	struct device		*dev;
 	struct regmap		*regmap;
 	const char		*name;
-	int			irq;
 	struct rtc_device	*rtc;
 #ifdef CONFIG_COMMON_CLK
 	struct clk_hw		clks[2];
@@ -1334,7 +1333,6 @@ static int ds1307_probe(struct i2c_client *client,
 	dev_set_drvdata(&client->dev, ds1307);
 	ds1307->dev = &client->dev;
 	ds1307->name = client->name;
-	ds1307->irq = client->irq;
 
 	ds1307->regmap = devm_regmap_init_i2c(client, &regmap_config);
 	if (IS_ERR(ds1307->regmap)) {
@@ -1414,7 +1412,7 @@ static int ds1307_probe(struct i2c_client *client,
 		 * For some variants, be sure alarms can trigger when we're
 		 * running on Vbackup (BBSQI/BBSQW)
 		 */
-		if (chip->alarm && (ds1307->irq > 0 ||
+		if (chip->alarm && (client->irq > 0 ||
 				    ds1307_can_wakeup_device)) {
 			ds1307->regs[0] |= DS1337_BIT_INTCN
 					| bbsqi_bitpos[ds1307->type];
@@ -1499,7 +1497,7 @@ static int ds1307_probe(struct i2c_client *client,
 	case rx_8130:
 		ds1307->offset = 0x10; /* Seconds starts at 0x10 */
 		rtc_ops = &rx8130_rtc_ops;
-		if (chip->alarm && ds1307->irq > 0) {
+		if (chip->alarm && client->irq > 0) {
 			irq_handler = rx8130_irq;
 			want_irq = true;
 		}
@@ -1509,7 +1507,7 @@ static int ds1307_probe(struct i2c_client *client,
 		break;
 	case mcp794xx:
 		rtc_ops = &mcp794xx_rtc_ops;
-		if (chip->alarm && (ds1307->irq > 0 ||
+		if (chip->alarm && (client->irq > 0 ||
 				    ds1307_can_wakeup_device)) {
 			irq_handler = mcp794xx_irq;
 			want_irq = true;
@@ -1655,7 +1653,7 @@ static int ds1307_probe(struct i2c_client *client,
 		return PTR_ERR(ds1307->rtc);
 	}
 
-	if (ds1307_can_wakeup_device && ds1307->irq <= 0) {
+	if (ds1307_can_wakeup_device && client->irq <= 0) {
 		/* Disable request for an IRQ */
 		want_irq = false;
 		dev_info(ds1307->dev,
@@ -1666,7 +1664,7 @@ static int ds1307_probe(struct i2c_client *client,
 
 	if (want_irq) {
 		err = devm_request_threaded_irq(ds1307->dev,
-						ds1307->irq, NULL, irq_handler,
+						client->irq, NULL, irq_handler,
 						IRQF_SHARED | IRQF_ONESHOT,
 						ds1307->name, ds1307);
 		if (err) {
-- 
2.13.2
