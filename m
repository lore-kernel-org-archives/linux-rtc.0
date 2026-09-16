Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330374E2F0B
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592078; cv=none; b=IFKxkOqdw05ajd87x9DI3YzKP9lyXIgpqT+u4nohTEXV4W6yy5/+6V2KDTOVc7tL9XrGmlYUogYfYExowMH6t1hc1RUtqz/eGSH3w0cEUbyYCY2xJ+FdG0DzXHZ98WyGMgVMNgvxG3o1EMHFn+a3wo1dkIdMDv0VhEdzjYMxC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592078; c=relaxed/simple;
	bh=WUkEehPfF2jpZwug+w5ko9fR06pm4zUBXZPmUw/p31w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASULiqvosVeZzD2yjciEXG8ihBjO5OjKybSeHTV9EcTrNG0d2T3RfHEIhuqVvaSbr8e3xLM2ic21oh6BUSVUr8xGM/1I6f7nrvQ9IfYYJQtu2E1a75oQVsd/+A5/qLxBQ+W+gXEuk4ly1n/eYxjWzSzLfrPCTBvfYVdH4UYxR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwJ2iJFs; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwJ2iJFs"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350faaso102004f8f.0
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789592019; x=1790196819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPjnpaPjtKc/aLzxIuaEfCFqOlX9GGn5Y8DyBKtmH/Y=;
        b=qwJ2iJFsKGIHYGen29fMlKHgrKRg1cObBVoSzI4hhbBtDW9FeISnD02xb72xQU8qj4
         k3wAfoEymeT8AdStSBbGCbMHPeCJgPIWcBL/MNVAVTtcbHiisRX+OnL6iWrPDma3fxES
         VAYLQbD4kaqt0obSoPpoxw8Kp8+7OJPKgfNVMQMowA1kWtrc17LPEOL6tr9B+FmS44Id
         UI6UuOsDu9RFJsPWOvoTIBgXhYzh87Q/08W3ZoP8PrVdTJAR4OzBUNjwkpURM+VJVg5Q
         DDpxQ4E+2j3jHPeWbSvdRLnIC5M+/3hjOIy2IbKMQwdO6VFWCLjgrBqUPbtAGhNpoRyw
         KRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789592019; x=1790196819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPjnpaPjtKc/aLzxIuaEfCFqOlX9GGn5Y8DyBKtmH/Y=;
        b=ylzbFI5o6bJ4ewdYbqH8icvEAKPqUh72OXh1Lg7BbxmyJLETuUBFbcyfItf6T6f08H
         9jWeSBpr2b3593ql0Se2St0dyDqYa3Dd89f5khDIMkIGV+H5R5mD/EozESQQ549VvDfC
         5unAJey1gFWsZH+ybWySMsnDVuCyPXLRs/jKBQKEbO+gMHpgcZYbe65dZbzS1EXZ9RTh
         3bBhAw8poEd2Qi1E8fsZryy4f39ib0DlFU/ia9fxgFKMcc7hnrkgNteaBTAltyoTmRAg
         tXm7lZ1ar4/bWO9hNkEKP4gpijor2OfnEvqBBFCdpBRN0mtCpMCU+xw7vU6YFu/N/pEx
         Dquw==
X-Gm-Message-State: AFuF++mvCmH47Q9b1yH1SVsU7zwReubfuPgnILjyqRWGcsrmRLTL7LPC
	FhyK/t3S615592wzUwVYVXkDCPaV7wQk860Awtt9gCOs/sNlTFrrDLuE
X-Gm-Gg: AYBFou3rWWXjqJmK4kfc0hhhnAqPvomufm5nf1aRMF204OiaF/TobrOSjz7ESpZAQnU
	UACDbJ5BghUdRq0OkGoAfnZDZ5sj5geL6CoFxP9asEx2krSxVG/eVBmDa7I3UeZRMTedqXM4Fka
	jWAadIGHzDiP7N3vkSob2Pjmat4gmPIr1cgZo+0XmKXxZftzM4oXVzM3zWsHTTn/n3tBUOJc1wN
	Kf6WXtTOI+ApNQ83fgFqSJ3c2qbfn/79E9PDpRR1NP2/nz7Az8BzIs4XFfCFZ0bj9nmPnjT+CN8
	F5c6YPHlFYfLCMt7Xkpb0ay2D0GdRRkrdq8mcP1KycpDF/9d3rV2ih0Ag35kwjoR47sOie+o3Vz
	Iy80bAH3MXoFPSdob1wiYVHIPnM9xjNicJSuYsE7Hf4fofzaxB0mo7zcGcXfVSMMr99nttKzU+5
	q5EgzLF21LAzh1xykQsTl5Uy75hV8mE6fUxQEJyAvzsVbLLIux0zSnc5UV9FdTSJ7Tea4+uz4=
X-Received: by 2002:a05:6000:4383:b0:487:8ec:1fc with SMTP id ffacd0b85a97d-4870cf09c40mr5052451f8f.12.1789592019334;
        Wed, 16 Sep 2026 13:53:39 -0700 (PDT)
Received: from antoniarch ([78.210.41.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7678sm11086166f8f.2.2026.09.16.13.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 13:53:39 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v7 8/9] rtc: abx80x: create abx80x_i2c_probe()
Date: Wed, 16 Sep 2026 22:51:37 +0200
Message-ID: <20260916205138.16771-9-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916205138.16771-1-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the I2C-specific code from abx80x_probe() to the newly created
function. This is a preparation for introducing the support for
ABX81X RTCs which use SPI interface.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 173 ++++++++++++++++++++++++---------------
 1 file changed, 106 insertions(+), 67 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 53fc788cbf96..3f0f8d7f8761 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -780,73 +780,38 @@ static const struct regmap_access_table abx80x_write_table = {
 	.n_no_ranges = ARRAY_SIZE(abx80x_no_write_ranges),
 };
 
-static const struct regmap_config abx80x_regmap_config_i2c = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = ABX8XX_SRAM_BASE + ABX8XX_SRAM_WIN_SIZE - 1,
-
-	.rd_table = &abx80x_read_table,
-	.wr_table = &abx80x_write_table,
-};
-
-static const struct i2c_device_id abx80x_id[] = {
-	{ .name = "abx80x", .driver_data = ABX80X },
-	{ .name = "ab0801", .driver_data = AB0801 },
-	{ .name = "ab0803", .driver_data = AB0803 },
-	{ .name = "ab0804", .driver_data = AB0804 },
-	{ .name = "ab0805", .driver_data = AB0805 },
-	{ .name = "ab1801", .driver_data = AB1801 },
-	{ .name = "ab1803", .driver_data = AB1803 },
-	{ .name = "ab1804", .driver_data = AB1804 },
-	{ .name = "ab1805", .driver_data = AB1805 },
-	{ .name = "rv1805", .driver_data = RV1805 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, abx80x_id);
-
-static int abx80x_probe(struct i2c_client *client)
+static int abx80x_probe(struct device *dev, struct regmap *regmap, int irq,
+			struct device_node *np, unsigned int part)
 {
-	struct regmap *regmap;
-	struct device_node *np = client->dev.of_node;
 	struct abx80x_priv *priv;
 	int i, err, trickle_cfg = -EINVAL;
 	char buf[7];
-	unsigned int part = (uintptr_t)i2c_get_match_data(client);
 	unsigned int partnumber;
 	unsigned int majrev, minrev;
 	unsigned int lot;
 	unsigned int wafer;
 	unsigned int uid;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
-		return -ENODEV;
-
-	regmap = devm_regmap_init_i2c(client, &abx80x_regmap_config_i2c);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Unable to allocate regmap\n");
-		return PTR_ERR(regmap);
-	}
-
-	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
 
-	priv->rtc = devm_rtc_allocate_device(&client->dev);
+	priv->rtc = devm_rtc_allocate_device(dev);
 	if (IS_ERR(priv->rtc))
 		return PTR_ERR(priv->rtc);
 
 	priv->rtc->ops = &abx80x_rtc_ops;
-	priv->irq = client->irq;
+	priv->irq = irq;
 	priv->regmap = regmap;
-	err = devm_mutex_init(&client->dev, &priv->lock);
+	err = devm_mutex_init(dev, &priv->lock);
 	if (err)
 		return err;
 
-	dev_set_drvdata(&client->dev, priv);
+	dev_set_drvdata(dev, priv);
 
 	err = regmap_bulk_read(regmap, ABX8XX_REG_ID0, buf, sizeof(buf));
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to read partnumber\n");
+		dev_err(dev, "Unable to read partnumber\n");
 		return -EIO;
 	}
 
@@ -856,14 +821,14 @@ static int abx80x_probe(struct i2c_client *client)
 	lot = ((buf[4] & 0x80) << 2) | ((buf[6] & 0x80) << 1) | buf[3];
 	uid = ((buf[4] & 0x7f) << 8) | buf[5];
 	wafer = (buf[6] & 0x7c) >> 2;
-	dev_info(&client->dev, "model %04x, revision %u.%u, lot %x, wafer %x, uid %x\n",
+	dev_info(dev, "model %04x, revision %u.%u, lot %x, wafer %x, uid %x\n",
 		 partnumber, majrev, minrev, lot, wafer, uid);
 
 	err = regmap_update_bits(regmap, ABX8XX_REG_CTRL1,
 				 ABX8XX_CTRL_12_24 | ABX8XX_CTRL_ARST | ABX8XX_CTRL_WRITE,
 				 ABX8XX_CTRL_WRITE);
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to write control register\n");
+		dev_err(dev, "Unable to write control register\n");
 		return -EIO;
 	}
 
@@ -878,7 +843,7 @@ static int abx80x_probe(struct i2c_client *client)
 		err = regmap_update_bits(regmap, ABX8XX_REG_CTRL2,
 					 ABX8XX_CTRL2_RSVD, 0);
 		if (err < 0) {
-			dev_err(&client->dev, "Unable to write control2 register\n");
+			dev_err(dev, "Unable to write control2 register\n");
 			return -EIO;
 		}
 
@@ -886,7 +851,7 @@ static int abx80x_probe(struct i2c_client *client)
 		 * Write the configuration key register to enable access to
 		 * the config2 register
 		 */
-		if (abx80x_write_config_key(&client->dev, ABX8XX_CFG_KEY_MISC) < 0)
+		if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_MISC) < 0)
 			return -EIO;
 
 		/*
@@ -898,7 +863,7 @@ static int abx80x_probe(struct i2c_client *client)
 					ABX8XX_OUT_CTRL_EXDS,
 					ABX8XX_OUT_CTRL_EXDS);
 		if (err < 0) {
-			dev_err(&client->dev,
+			dev_err(dev,
 				"Unable to write output control register\n");
 			return -EIO;
 		}
@@ -910,26 +875,24 @@ static int abx80x_probe(struct i2c_client *client)
 			if (partnumber == abx80x_caps[i].pn)
 				break;
 		if (abx80x_caps[i].pn == 0) {
-			dev_err(&client->dev, "Unknown part: %04x\n",
-				partnumber);
+			dev_err(dev, "Unknown part: %04x\n", partnumber);
 			return -EINVAL;
 		}
 		part = i;
 	}
 
 	if (partnumber != abx80x_caps[part].pn) {
-		dev_err(&client->dev, "partnumber mismatch %04x != %04x\n",
+		dev_err(dev, "partnumber mismatch %04x != %04x\n",
 			partnumber, abx80x_caps[part].pn);
 		return -EINVAL;
 	}
 
 	if (np && abx80x_caps[part].has_tc)
-		trickle_cfg = abx80x_dt_trickle_cfg(&client->dev);
+		trickle_cfg = abx80x_dt_trickle_cfg(dev);
 
 	if (trickle_cfg > 0) {
-		dev_info(&client->dev, "Enabling trickle charger: %02x\n",
-			 trickle_cfg);
-		abx80x_enable_trickle_charger(&client->dev, trickle_cfg);
+		dev_info(dev, "Enabling trickle charger: %02x\n", trickle_cfg);
+		abx80x_enable_trickle_charger(dev, trickle_cfg);
 	}
 
 	err = regmap_write(regmap, ABX8XX_REG_CD_TIMER_CTL, BIT(2));
@@ -941,23 +904,23 @@ static int abx80x_probe(struct i2c_client *client)
 				 ABX8XX_IRQ_EX1E | ABX8XX_IRQ_EX2E |
 				 ABX8XX_IRQ_TIE | ABX8XX_IRQ_BLIE, 0);
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to update irq register\n");
+		dev_err(dev, "Unable to update irq register\n");
 		return -EIO;
 	}
 
 	/* Unlock write access to Oscillator Control Register */
-	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_OSC) < 0)
+	if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_OSC) < 0)
 		return -EIO;
 
 	err = regmap_write_bits(regmap, ABX8XX_REG_OSC,
 				ABX8XX_OSC_ACIE | ABX8XX_OSC_OFIE, 0);
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to update Oscillator Control register\n");
+		dev_err(dev, "Unable to update Oscillator Control register\n");
 		return -EIO;
 	}
 
 	if (abx80x_caps[part].has_wdog) {
-		err = abx80x_setup_watchdog(&client->dev);
+		err = abx80x_setup_watchdog(dev);
 		if (err)
 			return err;
 	}
@@ -967,14 +930,14 @@ static int abx80x_probe(struct i2c_client *client)
 		return err;
 
 	if (priv->irq > 0) {
-		dev_info(&client->dev, "IRQ %d supplied\n", priv->irq);
-		err = devm_request_threaded_irq(&client->dev, priv->irq, NULL,
+		dev_info(dev, "IRQ %d supplied\n", priv->irq);
+		err = devm_request_threaded_irq(dev, priv->irq, NULL,
 						abx80x_handle_irq,
 						IRQF_SHARED | IRQF_ONESHOT,
 						"abx8xx",
-						&client->dev);
+						dev);
 		if (err) {
-			dev_err(&client->dev, "unable to request IRQ, alarms disabled\n");
+			dev_err(dev, "unable to request IRQ, alarms disabled\n");
 			priv->irq = 0;
 		}
 	}
@@ -983,14 +946,39 @@ static int abx80x_probe(struct i2c_client *client)
 
 	err = rtc_add_group(priv->rtc, &rtc_calib_attr_group);
 	if (err) {
-		dev_err(&client->dev, "Failed to create sysfs group: %d\n",
-			err);
+		dev_err(dev, "Failed to create sysfs group: %d\n", err);
 		return err;
 	}
 
 	return devm_rtc_register_device(priv->rtc);
 }
 
+#if IS_ENABLED(CONFIG_I2C)
+
+static const struct regmap_config abx80x_regmap_config_i2c = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ABX8XX_SRAM_BASE + ABX8XX_SRAM_WIN_SIZE - 1,
+
+	.rd_table = &abx80x_read_table,
+	.wr_table = &abx80x_write_table,
+};
+
+static const struct i2c_device_id abx80x_id[] = {
+	{ .name = "abx80x", .driver_data = ABX80X },
+	{ .name = "ab0801", .driver_data = AB0801 },
+	{ .name = "ab0803", .driver_data = AB0803 },
+	{ .name = "ab0804", .driver_data = AB0804 },
+	{ .name = "ab0805", .driver_data = AB0805 },
+	{ .name = "ab1801", .driver_data = AB1801 },
+	{ .name = "ab1803", .driver_data = AB1803 },
+	{ .name = "ab1804", .driver_data = AB1804 },
+	{ .name = "ab1805", .driver_data = AB1805 },
+	{ .name = "rv1805", .driver_data = RV1805 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, abx80x_id);
+
 #ifdef CONFIG_OF
 static const struct of_device_id abx80x_of_match[] = {
 	{
@@ -1038,16 +1026,67 @@ static const struct of_device_id abx80x_of_match[] = {
 MODULE_DEVICE_TABLE(of, abx80x_of_match);
 #endif
 
+static int abx80x_i2c_probe(struct i2c_client *client)
+{
+	unsigned int part = (uintptr_t)i2c_get_match_data(client);
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	regmap = devm_regmap_init_i2c(client, &abx80x_regmap_config_i2c);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Unable to allocate regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	return abx80x_probe(&client->dev, regmap, client->irq,
+			    client->dev.of_node, part);
+}
+
 static struct i2c_driver abx80x_driver = {
 	.driver		= {
 		.name	= "rtc-abx80x",
 		.of_match_table = of_match_ptr(abx80x_of_match),
 	},
-	.probe		= abx80x_probe,
+	.probe		= abx80x_i2c_probe,
 	.id_table	= abx80x_id,
 };
 
-module_i2c_driver(abx80x_driver);
+static int abx80x_register_driver(void)
+{
+	return i2c_add_driver(&abx80x_driver);
+}
+
+static void abx80x_unregister_driver(void)
+{
+	i2c_del_driver(&abx80x_driver);
+}
+
+#else
+
+static int abx80x_register_driver(void)
+{
+	return 0;
+}
+
+static void abx80x_unregister_driver(void)
+{
+}
+
+#endif /* IS_ENABLED(CONFIG_I2C) */
+
+static int __init abx80x_init(void)
+{
+	return abx80x_register_driver();
+}
+module_init(abx80x_init);
+
+static void __exit abx80x_exit(void)
+{
+	abx80x_unregister_driver();
+}
+module_exit(abx80x_exit);
 
 MODULE_AUTHOR("Philippe De Muyter <phdm@macqel.be>");
 MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@bootlin.com>");
-- 
2.55.0

