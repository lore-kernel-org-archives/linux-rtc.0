Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35487 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdEaVdi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 31 May 2017 17:33:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id g15so6648270wmc.2
        for <linux-rtc@vger.kernel.org>; Wed, 31 May 2017 14:33:38 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 3/4] rtc: ds1307: factor out century bit handling
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <85789383-af9c-fdbb-ff58-121d9fd432f5@gmail.com>
Message-ID: <0eb6b8ca-20fe-ea3b-2e2b-a53d2fb82692@gmail.com>
Date: Wed, 31 May 2017 23:32:57 +0200
MIME-Version: 1.0
In-Reply-To: <85789383-af9c-fdbb-ff58-121d9fd432f5@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The driver has lots of places with chip-specific code what doesn't
necessarily facilitate maintenance.

Let's describe chip-specific differences in century bit handling
in struct chip_desc to improve this.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 70 ++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 44 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index bf906e9f..79160027 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -135,6 +135,9 @@ struct chip_desc {
 	unsigned		alarm:1;
 	u16			nvram_offset;
 	u16			nvram_size;
+	u8			century_reg;
+	u8			century_enable_bit;
+	u8			century_bit;
 	u16			trickle_charger_reg;
 	u8			trickle_charger_setup;
 	u8			(*do_trickle_setup)(struct ds1307 *, uint32_t,
@@ -150,6 +153,8 @@ static struct chip_desc chips[last_ds_type] = {
 	},
 	[ds_1337] = {
 		.alarm		= 1,
+		.century_reg	= DS1307_REG_MONTH,
+		.century_bit	= DS1337_BIT_CENTURY,
 	},
 	[ds_1338] = {
 		.nvram_offset	= 8,
@@ -157,10 +162,15 @@ static struct chip_desc chips[last_ds_type] = {
 	},
 	[ds_1339] = {
 		.alarm		= 1,
+		.century_reg	= DS1307_REG_MONTH,
+		.century_bit	= DS1337_BIT_CENTURY,
 		.trickle_charger_reg = 0x10,
 		.do_trickle_setup = &do_trickle_setup_ds1339,
 	},
 	[ds_1340] = {
+		.century_reg	= DS1307_REG_HOUR,
+		.century_enable_bit = DS1340_BIT_CENTURY_EN,
+		.century_bit	= DS1340_BIT_CENTURY,
 		.trickle_charger_reg = 0x08,
 	},
 	[ds_1388] = {
@@ -168,6 +178,8 @@ static struct chip_desc chips[last_ds_type] = {
 	},
 	[ds_3231] = {
 		.alarm		= 1,
+		.century_reg	= DS1307_REG_MONTH,
+		.century_bit	= DS1337_BIT_CENTURY,
 	},
 	[mcp794xx] = {
 		.alarm		= 1,
@@ -277,6 +289,7 @@ static irqreturn_t ds1307_irq(int irq, void *dev_id)
 static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 {
 	struct ds1307	*ds1307 = dev_get_drvdata(dev);
+	const struct chip_desc *chip = &chips[ds1307->type];
 	int		tmp, ret;
 
 	/* read the RTC date and time registers all at once */
@@ -306,20 +319,8 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 	t->tm_year = bcd2bin(ds1307->regs[DS1307_REG_YEAR]) + 100;
 
 #ifdef CONFIG_RTC_DRV_DS1307_CENTURY
-	switch (ds1307->type) {
-	case ds_1337:
-	case ds_1339:
-	case ds_3231:
-		if (ds1307->regs[DS1307_REG_MONTH] & DS1337_BIT_CENTURY)
-			t->tm_year += 100;
-		break;
-	case ds_1340:
-		if (ds1307->regs[DS1307_REG_HOUR] & DS1340_BIT_CENTURY)
-			t->tm_year += 100;
-		break;
-	default:
-		break;
-	}
+	if (ds1307->regs[chip->century_reg] & chip->century_bit)
+		t->tm_year += 100;
 #endif
 
 	dev_dbg(dev, "%s secs=%d, mins=%d, "
@@ -335,6 +336,7 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 {
 	struct ds1307	*ds1307 = dev_get_drvdata(dev);
+	const struct chip_desc *chip = &chips[ds1307->type];
 	int		result;
 	int		tmp;
 	u8		*buf = ds1307->regs;
@@ -345,24 +347,14 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		t->tm_hour, t->tm_mday,
 		t->tm_mon, t->tm_year, t->tm_wday);
 
-#ifdef CONFIG_RTC_DRV_DS1307_CENTURY
 	if (t->tm_year < 100)
 		return -EINVAL;
 
-	switch (ds1307->type) {
-	case ds_1337:
-	case ds_1339:
-	case ds_3231:
-	case ds_1340:
-		if (t->tm_year > 299)
-			return -EINVAL;
-	default:
-		if (t->tm_year > 199)
-			return -EINVAL;
-		break;
-	}
+#ifdef CONFIG_RTC_DRV_DS1307_CENTURY
+	if (t->tm_year > (chip->century_bit ? 299 : 199))
+		return -EINVAL;
 #else
-	if (t->tm_year < 100 || t->tm_year > 199)
+	if (t->tm_year > 199)
 		return -EINVAL;
 #endif
 
@@ -377,19 +369,12 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 	tmp = t->tm_year - 100;
 	buf[DS1307_REG_YEAR] = bin2bcd(tmp);
 
-	switch (ds1307->type) {
-	case ds_1337:
-	case ds_1339:
-	case ds_3231:
-		if (t->tm_year > 199)
-			buf[DS1307_REG_MONTH] |= DS1337_BIT_CENTURY;
-		break;
-	case ds_1340:
-		buf[DS1307_REG_HOUR] |= DS1340_BIT_CENTURY_EN;
-		if (t->tm_year > 199)
-			buf[DS1307_REG_HOUR] |= DS1340_BIT_CENTURY;
-		break;
-	case mcp794xx:
+	if (chip->century_enable_bit)
+		buf[chip->century_reg] |= chip->century_enable_bit;
+	if (t->tm_year > 199 && chip->century_bit)
+		buf[chip->century_reg] |= chip->century_bit;
+
+	if (ds1307->type == mcp794xx) {
 		/*
 		 * these bits were cleared when preparing the date/time
 		 * values and need to be set again before writing the
@@ -397,9 +382,6 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		 */
 		buf[DS1307_REG_SECS] |= MCP794XX_BIT_ST;
 		buf[DS1307_REG_WDAY] |= MCP794XX_BIT_VBATEN;
-		break;
-	default:
-		break;
 	}
 
 	dev_dbg(dev, "%s: %7ph\n", "write", buf);
-- 
2.13.0
