Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3AB442FDF
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390820; cv=none; b=KdQxK/7f7yWosXahswOJFh2kDRvCoGhIkA0b/1lj2ZkhsVZooKuyxAKlYl0QmEv+vX5JBMP8zZ3T+N0tqro3tjGCAAzhIoBfDmMcKbz0Wsk2qKBsajmlRou7a6a/GwOYAdmg7N4eThAnjrALRKstV0rSWA+5AWlD0wFwfzC/gns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390820; c=relaxed/simple;
	bh=SG9a3O8kgbbhIUPGdJffq+qyBcl8R53EBTAnTVe65o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSg6wWyVjGo9OumjGq1bgK3TBGlsySfa7+OzBke3VeMBMKDP255K1JixaT/KrAoaiCQjaYJtz5xUk4l9Inqt6gDH9vSGU9TeVCFCggYlHdjjHQZHZqkc7BY6y32yqe4k+SGNrzBcsT5DNysz3noIeHbvTLX4xGQhAzHEyUKl9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7Izp6HY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7Izp6HY"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso1841935e9.0
        for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390814; x=1786995614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EuP0o+o2y3kz5Ka/bLCibsf9qoUzv8ZsKgTXDkaX/fc=;
        b=b7Izp6HY2zEoxar/NlfwIJ2QDThBiaUm5tdPoivtEJ68Hoi20iXboJPvetbgNY8VUT
         VmltFvdkKK5ttnheaYvJDT+/LJGw2scmOwUja+Q1gCLd3qRQYI8lOn0OQ40d/J51V10B
         5q1N1IcYph6+M1G6VOUXkv9op3NYJP1YEEK/P/FMlNfAYKjugIaxiyVMMNy2TfD63Dod
         tRD5RLIacaxoUNWckw6Xv+gqeZcUaev1YBHB0jSLCKfjYm/3ZA14EE+nbr4jIrvRnm6W
         Klyj8wyzgEoFXyFHP4JT+lwx4jdcNjCPGeln3SdRwqVkI59NN1v63d+84GRJWpmmO4Ou
         ECtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390814; x=1786995614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EuP0o+o2y3kz5Ka/bLCibsf9qoUzv8ZsKgTXDkaX/fc=;
        b=ISUw90QDPEeaBSojCgpxKKqoNac21SLKFWQgtsUHgBS/Eo8dFx1BpIA8aYED24mhQU
         b0op0bMUSXddk2nGsP7bhlgFAX3Ar0ihAuprPelnnMOBKLTtfcfMI5i2psBn1fWDDBdG
         qOcPTvR/YsMbJ2gkM+96cNcj6EB7QkGdtOiZWy+p/Hvss0shKCLFD/UmqpV5KMfefcQX
         zOGil1BBPg9UY564215wPWFBX44fVHZkC/m7mxm0UUlUzBNpPGjgo5P7y4vkWChenZ48
         oB6YVYIESj9p52IiGNZgGADIgsnYM+OX66IhatuN7z0yi4b0z7ZuQ2h5vszbs9ta3xgp
         2H8Q==
X-Gm-Message-State: AOJu0YzrbNHHa+tXNjMd0khW5a18B8ghs37W7y7WduK9qFuxt3kfAr7r
	g8Dz9rvTgixOIPprtmDVzwpp/eTU6PaUpgvgTRMdPcn3GwbVPC9IH8Ap
X-Gm-Gg: AR+sD11h7T5hGoCt0HTwNhQ19Q0RrW9FwzD6F7Hb9X9Coc9yq4p43zRdYB/mcnJXjN1
	TCRXBvSTRuTcFRaMzEEPMWkdazdjl62haybT2GcntnyGFIm/ExsrdIjiwq/f9h2/ACrdUVJSMVa
	5KkBrufydOqAoTdIOxjP5o8RL4fOTZsI4WuiNpefcqcbftDV1EHkF0KHLUmSvz/vBixAGexfncU
	YLRj7gBWvQ6e4iry6LIaYnOYo6iEaMq1cTqbKd9QPad4VH5Bx8FA83udvAL9S++Nf0GfyyO2iiH
	r4gAa+pF2P9LcGq3X9GWncrptNdq1NyU8TYE/nbjMQIqScXCH+0+H6nLMObz2joUa6TIPCJAF1V
	O2uI4DygyI+CKFicvm0ImDfWQummK2RvEmE3TEA07o4AetWXhgBdpYF4x3tzVc4JaFUmFa9XBYq
	dClQ0FWQBWOYCfFuO5T+S+mvor0WM+jxbH6yW3EyObheJFOwRuIKZJxV0eFyAYoCk=
X-Received: by 2002:a05:600c:4652:b0:495:648c:a1 with SMTP id 5b1f17b1804b1-49974600c74mr6786225e9.3.1786390813895;
        Mon, 10 Aug 2026 12:40:13 -0700 (PDT)
Received: from antoniarch ([78.213.94.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506cbsm39291689f8f.14.2026.08.10.12.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:13 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 8/9] rtc: abx80x: create abx80x_i2c_probe()
Date: Mon, 10 Aug 2026 21:38:25 +0200
Message-ID: <20260810193826.210683-9-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810193826.210683-1-apokusinski01@gmail.com>
References: <20260810193826.210683-1-apokusinski01@gmail.com>
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
 drivers/rtc/rtc-abx80x.c | 171 ++++++++++++++++++++++++---------------
 1 file changed, 105 insertions(+), 66 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index ab88af43b4fa..08b22c067699 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -781,73 +781,38 @@ static const struct regmap_access_table abx80x_write_table = {
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
 
@@ -857,14 +822,14 @@ static int abx80x_probe(struct i2c_client *client)
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
 
@@ -879,7 +844,7 @@ static int abx80x_probe(struct i2c_client *client)
 		err = regmap_update_bits(regmap, ABX8XX_REG_CTRL2,
 					 ABX8XX_CTRL2_RSVD, 0);
 		if (err < 0) {
-			dev_err(&client->dev, "Unable to write control2 register\n");
+			dev_err(dev, "Unable to write control2 register\n");
 			return -EIO;
 		}
 
@@ -887,7 +852,7 @@ static int abx80x_probe(struct i2c_client *client)
 		 * Write the configuration key register to enable access to
 		 * the config2 register
 		 */
-		if (abx80x_write_config_key(&client->dev, ABX8XX_CFG_KEY_MISC) < 0)
+		if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_MISC) < 0)
 			return -EIO;
 
 		/*
@@ -899,7 +864,7 @@ static int abx80x_probe(struct i2c_client *client)
 					ABX8XX_OUT_CTRL_EXDS,
 					ABX8XX_OUT_CTRL_EXDS);
 		if (err < 0) {
-			dev_err(&client->dev,
+			dev_err(dev,
 				"Unable to write output control register\n");
 			return -EIO;
 		}
@@ -911,26 +876,24 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -938,7 +901,7 @@ static int abx80x_probe(struct i2c_client *client)
 		return err;
 
 	if (abx80x_caps[part].has_wdog) {
-		err = abx80x_setup_watchdog(&client->dev);
+		err = abx80x_setup_watchdog(dev);
 		if (err)
 			return err;
 	}
@@ -952,26 +915,26 @@ static int abx80x_probe(struct i2c_client *client)
 				 ABX8XX_IRQ_EX1E | ABX8XX_IRQ_EX2E |
 				 ABX8XX_IRQ_TIE | ABX8XX_IRQ_BLIE, 0);
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to update irq register\n");
+		dev_err(dev, "Unable to update irq register\n");
 		return -EIO;
 	}
 
 	err = regmap_update_bits(regmap, ABX8XX_REG_OSC,
 				 ABX8XX_OSC_ACIE | ABX8XX_OSC_OFIE, 0);
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to update Oscillator Control register\n");
+		dev_err(dev, "Unable to update Oscillator Control register\n");
 		return -EIO;
 	}
 
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
@@ -980,14 +943,39 @@ static int abx80x_probe(struct i2c_client *client)
 
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
@@ -1035,16 +1023,67 @@ static const struct of_device_id abx80x_of_match[] = {
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

