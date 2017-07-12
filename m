Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35559 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756693AbdGLFuK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 12 Jul 2017 01:50:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id z45so3219690wrb.2
        for <linux-rtc@vger.kernel.org>; Tue, 11 Jul 2017 22:50:09 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 7/9] rtc: ds1307: factor out rtc_ops to struct chip_desc
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Message-ID: <172c3b18-b16c-bcd0-a877-c6f2d797ff43@gmail.com>
Date: Wed, 12 Jul 2017 07:49:44 +0200
MIME-Version: 1.0
In-Reply-To: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Factor out rtc_ops to struct chip_desc and use ds13xx_rtc_ops as default.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 51 ++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index e64ea250..4083464f 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -141,14 +141,39 @@ struct chip_desc {
 	u8			century_bit;
 	u8			bbsqi_bit;
 	irq_handler_t		irq_handler;
+	const struct rtc_class_ops *rtc_ops;
 	u16			trickle_charger_reg;
 	u8			(*do_trickle_setup)(struct ds1307 *, uint32_t,
 						    bool);
 };
 
+static int ds1307_get_time(struct device *dev, struct rtc_time *t);
+static int ds1307_set_time(struct device *dev, struct rtc_time *t);
 static u8 do_trickle_setup_ds1339(struct ds1307 *, uint32_t ohms, bool diode);
 static irqreturn_t rx8130_irq(int irq, void *dev_id);
+static int rx8130_read_alarm(struct device *dev, struct rtc_wkalrm *t);
+static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t);
+static int rx8130_alarm_irq_enable(struct device *dev, unsigned int enabled);
 static irqreturn_t mcp794xx_irq(int irq, void *dev_id);
+static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t);
+static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t);
+static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled);
+
+static const struct rtc_class_ops rx8130_rtc_ops = {
+        .read_time      = ds1307_get_time,
+        .set_time       = ds1307_set_time,
+        .read_alarm     = rx8130_read_alarm,
+        .set_alarm      = rx8130_set_alarm,
+        .alarm_irq_enable = rx8130_alarm_irq_enable,
+};
+
+static const struct rtc_class_ops mcp794xx_rtc_ops = {
+        .read_time      = ds1307_get_time,
+        .set_time       = ds1307_set_time,
+        .read_alarm     = mcp794xx_read_alarm,
+        .set_alarm      = mcp794xx_set_alarm,
+        .alarm_irq_enable = mcp794xx_alarm_irq_enable,
+};
 
 static const struct chip_desc chips[last_ds_type] = {
 	[ds_1307] = {
@@ -197,6 +222,7 @@ static const struct chip_desc chips[last_ds_type] = {
 		.nvram_offset	= 0x20,
 		.nvram_size	= 4,	/* 32bit (4 word x 8 bit) */
 		.irq_handler = rx8130_irq,
+		.rtc_ops = &rx8130_rtc_ops,
 	},
 	[mcp794xx] = {
 		.alarm		= 1,
@@ -204,6 +230,7 @@ static const struct chip_desc chips[last_ds_type] = {
 		.nvram_offset	= 0x20,
 		.nvram_size	= 0x40,
 		.irq_handler = mcp794xx_irq,
+		.rtc_ops = &mcp794xx_rtc_ops,
 	},
 };
 
@@ -731,14 +758,6 @@ static int rx8130_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	return regmap_write(ds1307->regmap, RX8130_REG_CONTROL0, reg);
 }
 
-static const struct rtc_class_ops rx8130_rtc_ops = {
-	.read_time	= ds1307_get_time,
-	.set_time	= ds1307_set_time,
-	.read_alarm	= rx8130_read_alarm,
-	.set_alarm	= rx8130_set_alarm,
-	.alarm_irq_enable = rx8130_alarm_irq_enable,
-};
-
 /*----------------------------------------------------------------------*/
 
 /*
@@ -891,14 +910,6 @@ static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 				  enabled ? MCP794XX_BIT_ALM0_EN : 0);
 }
 
-static const struct rtc_class_ops mcp794xx_rtc_ops = {
-	.read_time	= ds1307_get_time,
-	.set_time	= ds1307_set_time,
-	.read_alarm	= mcp794xx_read_alarm,
-	.set_alarm	= mcp794xx_set_alarm,
-	.alarm_irq_enable = mcp794xx_alarm_irq_enable,
-};
-
 /*----------------------------------------------------------------------*/
 
 static int ds1307_nvram_read(void *priv, unsigned int offset, void *val,
@@ -1325,8 +1336,6 @@ static int ds1307_probe(struct i2c_client *client,
 	unsigned long		timestamp;
 	u8 			trickle_charger_setup = 0;
 
-	const struct rtc_class_ops *rtc_ops = &ds13xx_rtc_ops;
-
 	ds1307 = devm_kzalloc(&client->dev, sizeof(struct ds1307), GFP_KERNEL);
 	if (!ds1307)
 		return -ENOMEM;
@@ -1495,14 +1504,10 @@ static int ds1307_probe(struct i2c_client *client,
 		break;
 	case rx_8130:
 		ds1307->offset = 0x10; /* Seconds starts at 0x10 */
-		rtc_ops = &rx8130_rtc_ops;
 		break;
 	case ds_1388:
 		ds1307->offset = 1; /* Seconds starts at 1 */
 		break;
-	case mcp794xx:
-		rtc_ops = &mcp794xx_rtc_ops;
-		break;
 	default:
 		break;
 	}
@@ -1678,7 +1683,7 @@ static int ds1307_probe(struct i2c_client *client,
 		ds1307->rtc->nvram_old_abi = true;
 	}
 
-	ds1307->rtc->ops = rtc_ops;
+	ds1307->rtc->ops = chip->rtc_ops ?: &ds13xx_rtc_ops;
 	err = rtc_register_device(ds1307->rtc);
 	if (err)
 		return err;
-- 
2.13.2
