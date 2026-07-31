Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9047D449
	for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523817; cv=none; b=fTMzk2quoIsVe7tCd45ZrylG3EAaFz9pSkk7a2hwL4l7MvXQvirn425NCiKwee4uVXddxGDp0Mo3fmtlxYiLziHLqXTINmK1s1cs8fr60ARjPD/mnwYXps8tdpFVov9smnk5s0cV6PNPMFGBABCBdayKaO/8jJh0xNLl4kjo0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523817; c=relaxed/simple;
	bh=SOmEnp6pfII2o6j9zw5e/e8nP0AC+vDaMLCtBMnrToc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MX7hApP7Ubn3jydgBgJrcuP1TIULjRsyIk/kUT/VeDDJrPe+ZEICfTN415lBmZ4z+bYN4M/ulsUYXAxWR0P+5LOrU2R7chl2tCSn442iPnJCS6p5AvTYTJmJt6R/9CiZ+mkLLWu2aWHg6HBdC7XsfgRCsP6kxQt8XFi6DZONZ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2i52AqP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2i52AqP"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso732996f8f.0
        for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785523814; x=1786128614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NKr5A5/ii5kP6rNYEAJZsRAcGmJBesXhE1ggd65HDrA=;
        b=N2i52AqPtIw1m/PpXSCmImqJaPP6iRsnIDD5ZfCX+yGNUEyFmMbbeDZmHlopkP1UYR
         uP91JEaE/aNMyWqH6ISAfqN7Ty3lhF/DJdaBfqphxAH/JgDhU7sl6u5xxdIRcwgL3vLn
         OJIGtyHRFlH0R92R9JOvuitq4wQ5iZ8kTSbDnZIpsVHjMtIucW5lTk8vjOPv/GDU8J2T
         24Z7502v261ktbGv32TSA5tXRDG1IcdFZeu5VujIdLhx9aufffe6bBDqq97kHwCITV2m
         +xzuTFv2XZiUXAw4rzoE9NDEFgTcW6Eudrh2cQoc+PHfcaI5mMOzZfc9WVRrzKv4CUae
         ggrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523814; x=1786128614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NKr5A5/ii5kP6rNYEAJZsRAcGmJBesXhE1ggd65HDrA=;
        b=imVeMLMlQCyBQ3CBr4pXfWQjI/Lyvvao57Twykus3tvY8KsJSQKnn+JFq2rtepBtI7
         PZ58ppcHNmnrH6xbnCKKLMqAe62gIcsanu5rQvTuCvISRes8ivaKaLVeldISeB0nkZo7
         J9C+DcnAq0vboae7b3khDZjpTjowzAH97mvdsbThtJbPbluWAbkCnud9gvQmOEPaH2R+
         W/sp5UIyk3qXXSRuTjqpA9grA7Kev2UWlRt387EYCn88p0HyE1q6fSHt+RIoalWJXxPP
         7pyd93qyVbJzcbF+0Tq97oXIbJNGsHkIIWS1PogbTODcJmuuEw/QG818ZGs3jTWO+s3j
         C9IQ==
X-Gm-Message-State: AOJu0Ywa4vM4QOwzO8fWOhfWvhkbPySu4uo6C5C1zHHA7asWzRkOsYFN
	Z12ipDSLpEMUm74hNTymM0QtjwUHaFtn4HIzxqUsUhH0bMbBsogaHjhe
X-Gm-Gg: AR+sD10uF3DlfxTWrOoa63EccYXLRidrjWeEWD3JwmK4yBVSNZF0YbJ3h1yB96MXMni
	sPp0tB7mwYIo/T6/TFOm3hvRJlChYi3Ga61I6eYtK1b51EwMCXsdd1vHoW+JUaZdCOlTNirxlrP
	zndWqTY4Nz+dzcURnKEx7sAWLJOQaQNZXsGu9pGblq82FmkoE6W1oUTQzKr7yhWhcm0vgl+j1e5
	uAGjFqEXnnjBCB/LF+04BRkCQb++6K8J5+9fhoDHp2hAB8wFbJ2M27V4wrYkqdwf9Yvbzs+3U1p
	x3uXEhqbUiDANWsnPgZ+xYmhcULHnil78wmK6aa3LdxHFPXqwVDQdfGdyzoSv6lMlBKWUkIyayf
	m+zbDTNpUmqMvqzuzIwtnyR88rPrajzqOR8sgN3HfsvK6zQPMJ/wYcj98BpCveZ2ks7YiyXdqjN
	nbul+ByBaj3Q/ocHYU81f/ussDXRA53ytwsyaloZMjJhcb1LJZ5RdZy8qJSHOgG5RJ
X-Received: by 2002:a5d:4992:0:b0:47f:81fe:12fb with SMTP id ffacd0b85a97d-47fd7307a2amr1069138f8f.47.1785523814019;
        Fri, 31 Jul 2026 11:50:14 -0700 (PDT)
Received: from antoniarch ([78.211.133.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91b3sm8741488f8f.14.2026.07.31.11.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:50:13 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 7/8] rtc: abx80x: create abx80x_i2c_probe()
Date: Fri, 31 Jul 2026 20:48:30 +0200
Message-ID: <20260731184831.44037-8-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731184831.44037-1-apokusinski01@gmail.com>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
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
 drivers/rtc/rtc-abx80x.c | 167 ++++++++++++++++++++++++---------------
 1 file changed, 103 insertions(+), 64 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 52f958e2aecd..6583e097af68 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -773,73 +773,38 @@ static const struct regmap_access_table abx80x_write_table = {
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
 
@@ -849,14 +814,14 @@ static int abx80x_probe(struct i2c_client *client)
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
 
@@ -871,7 +836,7 @@ static int abx80x_probe(struct i2c_client *client)
 		err = regmap_update_bits(regmap, ABX8XX_REG_CTRL2,
 					 ABX8XX_CTRL2_RSVD, 0);
 		if (err < 0) {
-			dev_err(&client->dev, "Unable to write control2 register\n");
+			dev_err(dev, "Unable to write control2 register\n");
 			return -EIO;
 		}
 
@@ -879,7 +844,7 @@ static int abx80x_probe(struct i2c_client *client)
 		 * Write the configuration key register to enable access to
 		 * the config2 register
 		 */
-		if (abx80x_write_config_key(&client->dev, ABX8XX_CFG_KEY_MISC) < 0)
+		if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_MISC) < 0)
 			return -EIO;
 
 		/*
@@ -891,7 +856,7 @@ static int abx80x_probe(struct i2c_client *client)
 					ABX8XX_OUT_CTRL_EXDS,
 					ABX8XX_OUT_CTRL_EXDS);
 		if (err < 0) {
-			dev_err(&client->dev,
+			dev_err(dev,
 				"Unable to write output control register\n");
 			return -EIO;
 		}
@@ -903,26 +868,24 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -930,7 +893,7 @@ static int abx80x_probe(struct i2c_client *client)
 		return err;
 
 	if (abx80x_caps[part].has_wdog) {
-		err = abx80x_setup_watchdog(&client->dev);
+		err = abx80x_setup_watchdog(dev);
 		if (err)
 			return err;
 	}
@@ -940,14 +903,14 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -956,14 +919,39 @@ static int abx80x_probe(struct i2c_client *client)
 
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
@@ -1011,16 +999,67 @@ static const struct of_device_id abx80x_of_match[] = {
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

