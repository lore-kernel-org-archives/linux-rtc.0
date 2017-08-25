Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33675 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932711AbdHYUGf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Aug 2017 16:06:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id e67so844209wmd.0
        for <linux-rtc@vger.kernel.org>; Fri, 25 Aug 2017 13:06:35 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/5] rtc: ds1307: factor out trickle charger initialization
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
Message-ID: <80e5bf1f-d078-f1c3-8396-92864eb58128@gmail.com>
Date: Fri, 25 Aug 2017 22:06:11 +0200
MIME-Version: 1.0
In-Reply-To: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Rename the existing function ds1307_trickle_init to ds1307_trickle_setup
and factor out trickle charger initialization from ds1307_probe into a
new function ds1307_trickle_init.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 2b5c6d60..ea88e4b3 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -970,8 +970,8 @@ static u8 do_trickle_setup_ds1339(struct ds1307 *ds1307,
 	return setup;
 }
 
-static u8 ds1307_trickle_init(struct ds1307 *ds1307,
-			      const struct chip_desc *chip)
+static u8 ds1307_trickle_setup(struct ds1307 *ds1307,
+			       const struct chip_desc *chip)
 {
 	uint32_t ohms;
 	bool diode = true;
@@ -1344,6 +1344,30 @@ static enum ds_type ds1307_get_type(struct device *dev,
 	return acpi_id ? acpi_id->driver_data : -ENODEV;
 }
 
+static void ds1307_trickle_init(struct ds1307 *ds1307)
+{
+	struct ds1307_platform_data *pdata = dev_get_platdata(ds1307->dev);
+	const struct chip_desc *chip = &chips[ds1307->type];
+	u8 trickle_charger_setup;
+
+	if (!chip->trickle_charger_reg)
+		return;
+
+	if (pdata)
+		trickle_charger_setup = pdata->trickle_charger_setup;
+	else
+		trickle_charger_setup = ds1307_trickle_setup(ds1307, chip);
+
+	if (trickle_charger_setup) {
+		trickle_charger_setup |= DS13XX_TRICKLE_CHARGER_MAGIC;
+		dev_dbg(ds1307->dev,
+			"writing trickle charger info 0x%x to 0x%x\n",
+			trickle_charger_setup, chip->trickle_charger_reg);
+		regmap_write(ds1307->regmap, chip->trickle_charger_reg,
+			     trickle_charger_setup);
+	}
+}
+
 static const struct regmap_config regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -1359,10 +1383,8 @@ static int ds1307_probe(struct i2c_client *client,
 	bool			want_irq;
 	bool			ds1307_can_wakeup_device = false;
 	unsigned char		*buf;
-	struct ds1307_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct rtc_time		tm;
 	unsigned long		timestamp;
-	u8			trickle_charger_setup = 0;
 
 	ds1307 = devm_kzalloc(&client->dev, sizeof(struct ds1307), GFP_KERNEL);
 	if (!ds1307)
@@ -1385,25 +1407,11 @@ static int ds1307_probe(struct i2c_client *client,
 		return ds1307->type;
 
 	chip = &chips[ds1307->type];
-
 	want_irq = client->irq > 0 && chip->alarm;
-
-	if (!pdata)
-		trickle_charger_setup = ds1307_trickle_init(ds1307, chip);
-	else if (pdata->trickle_charger_setup)
-		trickle_charger_setup = pdata->trickle_charger_setup;
-
-	if (trickle_charger_setup && chip->trickle_charger_reg) {
-		trickle_charger_setup |= DS13XX_TRICKLE_CHARGER_MAGIC;
-		dev_dbg(ds1307->dev,
-			"writing trickle charger info 0x%x to 0x%x\n",
-			trickle_charger_setup, chip->trickle_charger_reg);
-		regmap_write(ds1307->regmap, chip->trickle_charger_reg,
-			     trickle_charger_setup);
-	}
-
 	buf = ds1307->regs;
 
+	ds1307_trickle_init(ds1307);
+
 #ifdef CONFIG_OF
 /*
  * For devices with no IRQ directly connected to the SoC, the RTC chip
-- 
2.14.1
