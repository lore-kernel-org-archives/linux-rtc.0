Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36254 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbdGLFuF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 12 Jul 2017 01:50:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id 77so3188631wrb.3
        for <linux-rtc@vger.kernel.org>; Tue, 11 Jul 2017 22:50:05 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 3/9] rtc: ds1307: improve trickle charger initialization
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Message-ID: <050da9b3-5b21-2eb4-91b9-3cbb2887446a@gmail.com>
Date: Wed, 12 Jul 2017 07:49:28 +0200
MIME-Version: 1.0
In-Reply-To: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Instead of storing the trickle_charger_setup value in struct chip_desc
we can let function ds1307_trickle_init return it because it's used
in the probe function only.
This allows us to constify struct chip_desc variables in a next step.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index eecf6b27..d7158c9d 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -141,7 +141,6 @@ struct chip_desc {
 	u8			century_bit;
 	u8			bbsqi_bit;
 	u16			trickle_charger_reg;
-	u8			trickle_charger_setup;
 	u8			(*do_trickle_setup)(struct ds1307 *, uint32_t,
 						    bool);
 };
@@ -941,23 +940,23 @@ static u8 do_trickle_setup_ds1339(struct ds1307 *ds1307,
 	return setup;
 }
 
-static void ds1307_trickle_init(struct ds1307 *ds1307,
-				struct chip_desc *chip)
+static u8 ds1307_trickle_init(struct ds1307 *ds1307,
+			      struct chip_desc *chip)
 {
-	uint32_t ohms = 0;
+	uint32_t ohms;
 	bool diode = true;
 
 	if (!chip->do_trickle_setup)
-		goto out;
+		return 0;
+
 	if (device_property_read_u32(ds1307->dev, "trickle-resistor-ohms",
 				     &ohms))
-		goto out;
+		return 0;
+
 	if (device_property_read_bool(ds1307->dev, "trickle-diode-disable"))
 		diode = false;
-	chip->trickle_charger_setup = chip->do_trickle_setup(ds1307,
-							     ohms, diode);
-out:
-	return;
+
+	return chip->do_trickle_setup(ds1307, ohms, diode);
 }
 
 /*----------------------------------------------------------------------*/
@@ -1319,6 +1318,7 @@ static int ds1307_probe(struct i2c_client *client,
 	struct ds1307_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct rtc_time		tm;
 	unsigned long		timestamp;
+	u8 			trickle_charger_setup = 0;
 
 	irq_handler_t	irq_handler = ds1307_irq;
 
@@ -1359,18 +1359,17 @@ static int ds1307_probe(struct i2c_client *client,
 	}
 
 	if (!pdata)
-		ds1307_trickle_init(ds1307, chip);
+		trickle_charger_setup = ds1307_trickle_init(ds1307, chip);
 	else if (pdata->trickle_charger_setup)
-		chip->trickle_charger_setup = pdata->trickle_charger_setup;
+		trickle_charger_setup = pdata->trickle_charger_setup;
 
-	if (chip->trickle_charger_setup && chip->trickle_charger_reg) {
+	if (trickle_charger_setup && chip->trickle_charger_reg) {
+		trickle_charger_setup |= DS13XX_TRICKLE_CHARGER_MAGIC;
 		dev_dbg(ds1307->dev,
 			"writing trickle charger info 0x%x to 0x%x\n",
-		    DS13XX_TRICKLE_CHARGER_MAGIC | chip->trickle_charger_setup,
-		    chip->trickle_charger_reg);
+			trickle_charger_setup, chip->trickle_charger_reg);
 		regmap_write(ds1307->regmap, chip->trickle_charger_reg,
-		    DS13XX_TRICKLE_CHARGER_MAGIC |
-		    chip->trickle_charger_setup);
+			     trickle_charger_setup);
 	}
 
 	buf = ds1307->regs;
-- 
2.13.2
