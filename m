Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36245 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756688AbdGLFuE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 12 Jul 2017 01:50:04 -0400
Received: by mail-wr0-f194.google.com with SMTP id 77so3188554wrb.3
        for <linux-rtc@vger.kernel.org>; Tue, 11 Jul 2017 22:50:04 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/9] rtc: ds1307: factor out bbsqi bit to struct chip_desc
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Message-ID: <6db8da4c-8611-02c1-1d79-1f4015528250@gmail.com>
Date: Wed, 12 Jul 2017 07:49:22 +0200
MIME-Version: 1.0
In-Reply-To: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Factor out the bbsqi bit to struct chip_desc.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index adc90f18..eecf6b27 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -139,6 +139,7 @@ struct chip_desc {
 	u8			century_reg;
 	u8			century_enable_bit;
 	u8			century_bit;
+	u8			bbsqi_bit;
 	u16			trickle_charger_reg;
 	u8			trickle_charger_setup;
 	u8			(*do_trickle_setup)(struct ds1307 *, uint32_t,
@@ -169,6 +170,7 @@ static struct chip_desc chips[last_ds_type] = {
 		.alarm		= 1,
 		.century_reg	= DS1307_REG_MONTH,
 		.century_bit	= DS1337_BIT_CENTURY,
+		.bbsqi_bit	= DS1339_BIT_BBSQI,
 		.trickle_charger_reg = 0x10,
 		.do_trickle_setup = &do_trickle_setup_ds1339,
 	},
@@ -185,6 +187,7 @@ static struct chip_desc chips[last_ds_type] = {
 		.alarm		= 1,
 		.century_reg	= DS1307_REG_MONTH,
 		.century_bit	= DS1337_BIT_CENTURY,
+		.bbsqi_bit	= DS3231_BIT_BBSQW,
 	},
 	[rx_8130] = {
 		.alarm		= 1,
@@ -1319,11 +1322,6 @@ static int ds1307_probe(struct i2c_client *client,
 
 	irq_handler_t	irq_handler = ds1307_irq;
 
-	static const int	bbsqi_bitpos[] = {
-		[ds_1337] = 0,
-		[ds_1339] = DS1339_BIT_BBSQI,
-		[ds_3231] = DS3231_BIT_BBSQW,
-	};
 	const struct rtc_class_ops *rtc_ops = &ds13xx_rtc_ops;
 
 	ds1307 = devm_kzalloc(&client->dev, sizeof(struct ds1307), GFP_KERNEL);
@@ -1414,8 +1412,7 @@ static int ds1307_probe(struct i2c_client *client,
 		 */
 		if (chip->alarm && (client->irq > 0 ||
 				    ds1307_can_wakeup_device)) {
-			ds1307->regs[0] |= DS1337_BIT_INTCN
-					| bbsqi_bitpos[ds1307->type];
+			ds1307->regs[0] |= DS1337_BIT_INTCN | chip->bbsqi_bit;
 			ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
 
 			want_irq = true;
-- 
2.13.2
