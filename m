Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24179408623
	for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750454; cv=none; b=IyzKKrSWkdDcLjOD8BO/ABbmEE3C7ncnI/YR6Nbzq0Q4eLmTrNl1kPMpZNml4enEHGWxhKjWRFcWet1HuR+Gr4xcdZG0cZFRg2F7Ro97sZ+5zbzL4p64yCo9BNDZpg9ZvPQpDvWOXeDXkTUTGl0WovK+9xHftxq+ZCjFHOovRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750454; c=relaxed/simple;
	bh=uqLZ39OkwB45W/YyWSWTM5AhH2hdJM1vW9c3aJ7RhcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5aYnCgLdEbC9dK4rKXzAutHUnOc6V0bbFJlD85iKDuS59o/rf+8i+5cwf1q5heaXijm6TyJdpSMdSNb6DfEcK/0jfPdS3Ki8XC4/y1Pv4yTiREoXdZVVzryJSynSRPFwrw1c2hsMbZVljb5O5nxSNC/OoyEWYYmTFsPXq/FfmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3ARL3op; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3ARL3op"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495590dde14so40018035e9.0
        for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784750448; x=1785355248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wHVKRdW29ID/cUyKddOMZzMqmcNtiHSeTpp8Hs63yoY=;
        b=p3ARL3opuVaj0mI0jEK7CdpOXHhmvW/8DTZrp3Z6tL2CZ3G5Rz0KnYBYm0/IA9H1KM
         lfL2WOYCh7WS6Qo2nWqFv8Yx6Yd73uC7W7zGIuNIsugwvcoi1SuSQkos1J7jSWq8dgas
         rLyqczWweoO0bgv8xiktFXvL+7MPy/ko34gDqyq25O0Zdl6WCUbfH28p6koaJi8Isaxv
         MiW/g4UayjWKYQ/hXyf1g0Yf94kIYNoBpY4ImRNWIUC/fWPNg+45X654Qjv05cUj2yGl
         Ftw+mMK83xNDZL6UFVwQ3i5y6s+g75Z9jYfzYPSRMLA4x3xQj6O2mMD4Zuys8gOi6gOv
         AL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750448; x=1785355248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wHVKRdW29ID/cUyKddOMZzMqmcNtiHSeTpp8Hs63yoY=;
        b=YW0rCcaMW9yN0L7SPiLJaxWtOFL0j/zMJKUPnQi1dwR5nD1dXZz/grSLqgIKNQQg6q
         QpCpcAtx7MVVuegphhNA+A5OArmxDBC4ZFxK8MI9sC6yVzBuD3f3Ji1F22/H1Gi9Xi9Y
         ywemmQstMhX8R1SbYsse1463FYG29AoI6aMKtOiA0PZjBGN/NEogWEYBaVsjVZkz6IcC
         wZ80113bF2cm1Fo9w0FUTPOvQVNU4lmotWmb9yZJos5HDvRCQ5QL7tiHEZcjflr43gUj
         s6a7Eg0Mx8muqccPgjuf3YCrmAMFnYcudY3AKLvpxaBPZsI1apn540itjYar8JG1utN3
         UqWg==
X-Gm-Message-State: AOJu0YwWog3Pn9AOBnmd+8sHewhY1yRuRCbAAeO0kQuYaaI8Ruc2cmZ0
	u5NrBZMkQ2FYp966bDTN/4MUBEnSoKXQRrU748NKKKU/wdn0cugO1bUr
X-Gm-Gg: AR+sD108xALc2fkupsd1HLufDrGSAIvtOOBrLsTo5CbSSk20owVU4Q6pS6Z3VqylZSC
	E0Jx/0McimU8uDUf8a5D6N45ScD07fVHGj3UzEkX7yl+3tebgiuFXhBpGmwoXvGjoQFIvmPNhhU
	7wa6UObULmXLqJpC1L60hEnFXC43mV3MBBrCC18aJI0A2obmGx/fW2TsMYLfBf6P9QcJUUmzVaH
	5HADb/CICvvOEHc4kf21ObrSUQ/grcKfZcbLBcMuvyJ92TnmGPgn/f2nGCe2wgFAYuuk3IjVZGd
	aYEmNMIOL/GlEh9nMbSLDzcoc7O3N3N+G6KdW1tRf4NbwOafWXnO0bhwNMIffoxTtvxrHnU3puY
	k+idjB08taRPQOgZBD7/MngUpzfTKQ/0d9TkeCK161bbNlr+YrKqloU3ec+nZ0hhjvquAibcYpU
	sd9wdnGg==
X-Received: by 2002:a05:6000:2387:b0:475:f0f0:9ef8 with SMTP id ffacd0b85a97d-47f8d76ee54mr329403f8f.61.1784750447423;
        Wed, 22 Jul 2026 13:00:47 -0700 (PDT)
Received: from antoniarch ([78.210.252.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fa9sm9532851f8f.20.2026.07.22.13.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:00:47 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 3/6] rtc: abx80x: use regmap instead of I2C specific API
Date: Wed, 22 Jul 2026 21:58:11 +0200
Message-ID: <20260722195814.298552-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722195814.298552-1-apokusinski01@gmail.com>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework the driver so that it uses regmap_* functions for communication
with the device instead of the i2c_smbus_* API. This way the support for
ABX81X RTCs which use SPI can be added later.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/Kconfig      |   1 +
 drivers/rtc/rtc-abx80x.c | 331 +++++++++++++++++++++------------------
 2 files changed, 180 insertions(+), 152 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 01def8231873..4d14bcba616e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -215,6 +215,7 @@ config RTC_DRV_ABEOZ9
 config RTC_DRV_ABX80X
 	tristate "Abracon ABx80x"
 	select WATCHDOG_CORE if WATCHDOG
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Abracon AB080X and AB180X
 	  families of ultra-low-power  battery- and capacitor-backed real-time
diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 9b0e1d48d9ba..e5ba821a6768 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -16,6 +16,7 @@
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/watchdog.h>
 
@@ -125,52 +126,53 @@ static struct abx80x_cap abx80x_caps[] = {
 
 struct abx80x_priv {
 	struct rtc_device *rtc;
-	struct i2c_client *client;
+	struct regmap *regmap;
 	struct watchdog_device wdog;
 	int irq;
 };
 
-static int abx80x_write_config_key(struct i2c_client *client, u8 key)
+static int abx80x_write_config_key(struct device *dev, u8 key)
 {
-	if (i2c_smbus_write_byte_data(client, ABX8XX_REG_CFG_KEY, key) < 0) {
-		dev_err(&client->dev, "Unable to write configuration key\n");
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
+
+	if (regmap_write(priv->regmap, ABX8XX_REG_CFG_KEY, key) < 0) {
+		dev_err(dev, "Unable to write configuration key\n");
 		return -EIO;
 	}
 
 	return 0;
 }
 
-static int abx80x_is_rc_mode(struct i2c_client *client)
+static int abx80x_is_rc_mode(struct device *dev)
 {
-	int flags = 0;
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
+	int err, flags = 0;
 
-	flags =  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSS);
-	if (flags < 0) {
-		dev_err(&client->dev,
-			"Failed to read autocalibration attribute\n");
-		return flags;
+	err = regmap_read(priv->regmap, ABX8XX_REG_OSS, &flags);
+	if (err < 0) {
+		dev_err(dev, "Failed to read autocalibration attribute\n");
+		return err;
 	}
 
 	return (flags & ABX8XX_OSS_OMODE) ? 1 : 0;
 }
 
-static int abx80x_enable_trickle_charger(struct i2c_client *client,
-					 u8 trickle_cfg)
+static int abx80x_enable_trickle_charger(struct device *dev, u8 trickle_cfg)
 {
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	int err;
 
 	/*
 	 * Write the configuration key register to enable access to the Trickle
 	 * register
 	 */
-	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_MISC) < 0)
+	if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_MISC) < 0)
 		return -EIO;
 
-	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_TRICKLE,
-					ABX8XX_TRICKLE_CHARGE_ENABLE |
-					trickle_cfg);
+	err = regmap_write(priv->regmap, ABX8XX_REG_TRICKLE,
+			   ABX8XX_TRICKLE_CHARGE_ENABLE | trickle_cfg);
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to write trickle register\n");
+		dev_err(dev, "Unable to write trickle register\n");
 		return -EIO;
 	}
 
@@ -179,19 +181,19 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
 
 static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned char buf[8];
 	int err, flags, rc_mode = 0;
 
 	/* Read the Oscillator Failure only in XT mode */
-	rc_mode = abx80x_is_rc_mode(client);
+	rc_mode = abx80x_is_rc_mode(dev);
 	if (rc_mode < 0)
 		return rc_mode;
 
 	if (!rc_mode) {
-		flags = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSS);
-		if (flags < 0)
-			return flags;
+		err = regmap_read(priv->regmap, ABX8XX_REG_OSS, &flags);
+		if (err < 0)
+			return err;
 
 		if (flags & ABX8XX_OSS_OF) {
 			dev_err(dev, "Oscillator failure, data is invalid.\n");
@@ -199,10 +201,9 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		}
 	}
 
-	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_HTH,
-					    sizeof(buf), buf);
+	err = regmap_bulk_read(priv->regmap, ABX8XX_REG_HTH, buf, sizeof(buf));
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to read date\n");
+		dev_err(dev, "Unable to read date\n");
 		return -EIO;
 	}
 
@@ -219,7 +220,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned char buf[8];
 	int err, flags;
 
@@ -235,22 +236,22 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	buf[ABX8XX_REG_YR] = bin2bcd(tm->tm_year - 100);
 	buf[ABX8XX_REG_WD] = tm->tm_wday;
 
-	err = i2c_smbus_write_i2c_block_data(client, ABX8XX_REG_HTH,
-					     sizeof(buf), buf);
+	err = regmap_bulk_write(priv->regmap, ABX8XX_REG_HTH, buf,
+				sizeof(buf));
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to write to date registers\n");
+		dev_err(dev, "Unable to write to date registers\n");
 		return -EIO;
 	}
 
 	/* Clear the OF bit of Oscillator Status Register */
-	flags = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSS);
-	if (flags < 0)
-		return flags;
+	err = regmap_read(priv->regmap, ABX8XX_REG_OSS, &flags);
+	if (err < 0)
+		return err;
 
-	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_OSS,
-					flags & ~ABX8XX_OSS_OF);
+	err = regmap_write(priv->regmap, ABX8XX_REG_OSS,
+			   flags & ~ABX8XX_OSS_OF);
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to write oscillator status register\n");
+		dev_err(dev, "Unable to write oscillator status register\n");
 		return err;
 	}
 
@@ -259,13 +260,13 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 {
-	struct i2c_client *client = dev_id;
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct device *dev = dev_id;
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	struct rtc_device *rtc = priv->rtc;
-	int status;
+	int err, status;
 
-	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
-	if (status < 0)
+	err = regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
+	if (err < 0)
 		return IRQ_NONE;
 
 	if (status & ABX8XX_STATUS_AF)
@@ -276,17 +277,16 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 	 * reset kicks in.
 	 */
 	if (status & ABX8XX_STATUS_WDT)
-		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
+		dev_alert(dev, "watchdog timeout interrupt.\n");
 
-	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
+	regmap_write(priv->regmap, ABX8XX_REG_STATUS, 0);
 
 	return IRQ_HANDLED;
 }
 
 static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned char buf[7];
 
 	int irq_mask, err;
@@ -294,14 +294,13 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	if (priv->irq <= 0)
 		return -EINVAL;
 
-	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
-					    sizeof(buf), buf);
+	err = regmap_bulk_read(priv->regmap, ABX8XX_REG_ASC, buf, sizeof(buf));
 	if (err)
 		return err;
 
-	irq_mask = i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);
-	if (irq_mask < 0)
-		return irq_mask;
+	err = regmap_read(priv->regmap, ABX8XX_REG_IRQ, &irq_mask);
+	if (err < 0)
+		return err;
 
 	t->time.tm_sec = bcd2bin(buf[0] & 0x7F);
 	t->time.tm_min = bcd2bin(buf[1] & 0x7F);
@@ -318,8 +317,7 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	u8 alarm[6];
 	int err;
 
@@ -333,17 +331,16 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	alarm[4] = bin2bcd(t->time.tm_mday);
 	alarm[5] = bin2bcd(t->time.tm_mon + 1);
 
-	err = i2c_smbus_write_i2c_block_data(client, ABX8XX_REG_AHTH,
-					     sizeof(alarm), alarm);
+	err = regmap_bulk_write(priv->regmap, ABX8XX_REG_AHTH,
+				alarm, sizeof(alarm));
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to write alarm registers\n");
+		dev_err(dev, "Unable to write alarm registers\n");
 		return -EIO;
 	}
 
 	if (t->enabled) {
-		err = i2c_smbus_write_byte_data(client, ABX8XX_REG_IRQ,
-						(ABX8XX_IRQ_IM_1_4 |
-						 ABX8XX_IRQ_AIE));
+		err = regmap_write(priv->regmap, ABX8XX_REG_IRQ,
+				   ABX8XX_IRQ_IM_1_4 | ABX8XX_IRQ_AIE);
 		if (err)
 			return err;
 	}
@@ -354,7 +351,7 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int abx80x_rtc_set_autocalibration(struct device *dev,
 					  int autocalibration)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	int retval, flags = 0;
 
 	if ((autocalibration != 0) && (autocalibration != 1024) &&
@@ -363,9 +360,9 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 		return -EINVAL;
 	}
 
-	flags = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
-	if (flags < 0)
-		return flags;
+	retval = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
+	if (retval < 0)
+		return retval;
 
 	if (autocalibration == 0) {
 		flags &= ~(ABX8XX_OSC_ACAL_512 | ABX8XX_OSC_ACAL_1024);
@@ -379,22 +376,22 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 	}
 
 	/* Unlock write access to Oscillator Control Register */
-	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_OSC) < 0)
+	if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_OSC) < 0)
 		return -EIO;
 
-	retval = i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC, flags);
+	retval = regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);
 
 	return retval;
 }
 
 static int abx80x_rtc_get_autocalibration(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	int flags = 0, autocalibration;
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
+	int flags = 0, autocalibration, err;
 
-	flags =  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
-	if (flags < 0)
-		return flags;
+	err = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
+	if (err < 0)
+		return err;
 
 	if (flags & ABX8XX_OSC_ACAL_512)
 		autocalibration = 512;
@@ -445,7 +442,7 @@ static ssize_t oscillator_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct abx80x_priv *priv = dev_get_drvdata(dev->parent);
 	int retval, flags, rc_mode = 0;
 
 	if (strncmp(buf, "rc", 2) == 0) {
@@ -457,9 +454,9 @@ static ssize_t oscillator_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	flags =  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
-	if (flags < 0)
-		return flags;
+	retval = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
+	if (retval < 0)
+		return retval;
 
 	if (rc_mode == 0)
 		flags &= ~(ABX8XX_OSC_OSEL);
@@ -467,10 +464,10 @@ static ssize_t oscillator_store(struct device *dev,
 		flags |= (ABX8XX_OSC_OSEL);
 
 	/* Unlock write access on Oscillator Control register */
-	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_OSC) < 0)
+	if (abx80x_write_config_key(dev->parent, ABX8XX_CFG_KEY_OSC) < 0)
 		return -EIO;
 
-	retval = i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC, flags);
+	retval = regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);
 	if (retval < 0) {
 		dev_err(dev, "Failed to write Oscillator Control register\n");
 		return retval;
@@ -483,9 +480,8 @@ static ssize_t oscillator_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	int rc_mode = 0;
-	struct i2c_client *client = to_i2c_client(dev->parent);
 
-	rc_mode = abx80x_is_rc_mode(client);
+	rc_mode = abx80x_is_rc_mode(dev->parent);
 
 	if (rc_mode < 0) {
 		dev_err(dev, "Failed to read RTC oscillator selection\n");
@@ -513,45 +509,43 @@ static const struct attribute_group rtc_calib_attr_group = {
 
 static int abx80x_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	int err;
 
 	if (enabled)
-		err = i2c_smbus_write_byte_data(client, ABX8XX_REG_IRQ,
-						(ABX8XX_IRQ_IM_1_4 |
-						 ABX8XX_IRQ_AIE));
+		err = regmap_write(priv->regmap, ABX8XX_REG_IRQ,
+				   ABX8XX_IRQ_IM_1_4 | ABX8XX_IRQ_AIE);
 	else
-		err = i2c_smbus_write_byte_data(client, ABX8XX_REG_IRQ,
-						ABX8XX_IRQ_IM_1_4);
+		err = regmap_write(priv->regmap, ABX8XX_REG_IRQ,
+				   ABX8XX_IRQ_IM_1_4);
 	return err;
 }
 
 static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	int status, tmp;
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
+	int err, status, tmp;
 
 	switch (cmd) {
 	case RTC_VL_READ:
-		status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
-		if (status < 0)
-			return status;
+		err = regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
+		if (err < 0)
+			return err;
 
 		tmp = status & ABX8XX_STATUS_BLF ? RTC_VL_BACKUP_LOW : 0;
 
 		return put_user(tmp, (unsigned int __user *)arg);
 
 	case RTC_VL_CLR:
-		status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
-		if (status < 0)
-			return status;
+		err = regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
+		if (err < 0)
+			return err;
 
 		status &= ~ABX8XX_STATUS_BLF;
 
-		tmp = i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
-						status);
-		if (tmp < 0)
-			return tmp;
+		err = regmap_write(priv->regmap, ABX8XX_REG_STATUS, status);
+		if (err < 0)
+			return err;
 
 		return 0;
 
@@ -569,9 +563,9 @@ static const struct rtc_class_ops abx80x_rtc_ops = {
 	.ioctl		= abx80x_ioctl,
 };
 
-static int abx80x_dt_trickle_cfg(struct i2c_client *client)
+static int abx80x_dt_trickle_cfg(struct device *dev)
 {
-	struct device_node *np = client->dev.of_node;
+	struct device_node *np = dev->of_node;
 	const char *diode;
 	int trickle_cfg = 0;
 	int i, ret;
@@ -586,7 +580,7 @@ static int abx80x_dt_trickle_cfg(struct i2c_client *client)
 	} else if (!strcmp(diode, "schottky")) {
 		trickle_cfg |= ABX8XX_TRICKLE_SCHOTTKY_DIODE;
 	} else {
-		dev_dbg(&client->dev, "Invalid tc-diode value: %s\n", diode);
+		dev_dbg(dev, "Invalid tc-diode value: %s\n", diode);
 		return -EINVAL;
 	}
 
@@ -599,7 +593,7 @@ static int abx80x_dt_trickle_cfg(struct i2c_client *client)
 			break;
 
 	if (i == sizeof(trickle_resistors)) {
-		dev_dbg(&client->dev, "Invalid tc-resistor value: %u\n", tmp);
+		dev_dbg(dev, "Invalid tc-resistor value: %u\n", tmp);
 		return -EINVAL;
 	}
 
@@ -624,7 +618,7 @@ static int __abx80x_wdog_set_timeout(struct watchdog_device *wdog,
 	 * Writing any timeout to the WDT register resets the watchdog timer.
 	 * Writing 0 disables it.
 	 */
-	return i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_WDT, val);
+	return regmap_write(priv->regmap, ABX8XX_REG_WDT, val);
 }
 
 static int abx80x_wdog_set_timeout(struct watchdog_device *wdog,
@@ -669,9 +663,11 @@ static const struct watchdog_ops abx80x_wdog_ops = {
 	.set_timeout = abx80x_wdog_set_timeout,
 };
 
-static int abx80x_setup_watchdog(struct abx80x_priv *priv)
+static int abx80x_setup_watchdog(struct device *dev)
 {
-	priv->wdog.parent = &priv->client->dev;
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
+
+	priv->wdog.parent = dev;
 	priv->wdog.ops = &abx80x_wdog_ops;
 	priv->wdog.info = &abx80x_wdog_info;
 	priv->wdog.min_timeout = 1;
@@ -680,10 +676,10 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
 
 	watchdog_set_drvdata(&priv->wdog, priv);
 
-	return devm_watchdog_register_device(&priv->client->dev, &priv->wdog);
+	return devm_watchdog_register_device(dev, &priv->wdog);
 }
 #else
-static int abx80x_setup_watchdog(struct abx80x_priv *priv)
+static int abx80x_setup_watchdog(struct device *dev)
 {
 	return 0;
 }
@@ -695,31 +691,27 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
 	int ret;
 
 	while (bytes) {
-		u8 extram, reg, len, lower, upper;
+		u8 reg, len, lower, upper;
 
 		lower = FIELD_GET(NVMEM_ADDR_LOWER, offset);
 		upper = FIELD_GET(NVMEM_ADDR_UPPER, offset);
-		extram = FIELD_PREP(ABX8XX_EXTRAM_XADS, upper);
 		reg = ABX8XX_SRAM_BASE + lower;
 		len = min(lower + bytes, (size_t)ABX8XX_SRAM_WIN_SIZE) - lower;
 		len = min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
 
-		ret = i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
-						extram);
+		ret = regmap_update_bits(priv->regmap, ABX8XX_REG_EXTRAM,
+					 ABX8XX_EXTRAM_XADS, upper);
 		if (ret)
 			return ret;
 
 		if (write) {
-			ret = i2c_smbus_write_i2c_block_data(priv->client, reg,
-							     len, val);
+			ret = regmap_bulk_write(priv->regmap, reg, val, len);
 			if (ret)
 				return ret;
 		} else {
-			ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
-							    len, val);
-			if (ret <= 0)
-				return ret ? ret : -EIO;
-			len = ret;
+			ret = regmap_bulk_read(priv->regmap, reg, val, len);
+			if (ret)
+				return ret;
 		}
 
 		offset += len;
@@ -755,6 +747,38 @@ static int abx80x_setup_nvmem(struct abx80x_priv *priv)
 	return devm_rtc_nvmem_register(priv->rtc, &config);
 }
 
+static const struct regmap_range abx80x_no_read_ranges[] = {
+	regmap_reg_range(0x1e, 0x1e),
+	regmap_reg_range(0x22, 0x25),
+	regmap_reg_range(0x31, 0x3e),
+};
+
+static const struct regmap_range abx80x_no_write_ranges[] = {
+	regmap_reg_range(0x1e, 0x1e),
+	regmap_reg_range(0x22, 0x25),
+	regmap_reg_range(ABX8XX_REG_ID0, ABX8XX_REG_ID0 + 6),
+	regmap_reg_range(0x31, 0x3e),
+};
+
+static const struct regmap_access_table abx80x_read_table = {
+	.no_ranges = abx80x_no_read_ranges,
+	.n_no_ranges = ARRAY_SIZE(abx80x_no_read_ranges),
+};
+
+static const struct regmap_access_table abx80x_write_table = {
+	.no_ranges = abx80x_no_write_ranges,
+	.n_no_ranges = ARRAY_SIZE(abx80x_no_write_ranges),
+};
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
 static const struct i2c_device_id abx80x_id[] = {
 	{ .name = "abx80x", .driver_data = ABX80X },
 	{ .name = "ab0801", .driver_data = AB0801 },
@@ -772,6 +796,7 @@ MODULE_DEVICE_TABLE(i2c, abx80x_id);
 
 static int abx80x_probe(struct i2c_client *client)
 {
+	struct regmap *regmap;
 	struct device_node *np = client->dev.of_node;
 	struct abx80x_priv *priv;
 	int i, data, err, trickle_cfg = -EINVAL;
@@ -786,8 +811,27 @@ static int abx80x_probe(struct i2c_client *client)
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ID0,
-					    sizeof(buf), buf);
+	regmap = devm_regmap_init_i2c(client, &abx80x_regmap_config_i2c);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Unable to allocate regmap\n");
+		return -EIO;
+	}
+
+	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
+	priv->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(priv->rtc))
+		return PTR_ERR(priv->rtc);
+
+	priv->rtc->ops = &abx80x_rtc_ops;
+	priv->irq = client->irq;
+	priv->regmap = regmap;
+
+	dev_set_drvdata(&client->dev, priv);
+
+	err = regmap_bulk_read(regmap, ABX8XX_REG_ID0, buf, sizeof(buf));
 	if (err < 0) {
 		dev_err(&client->dev, "Unable to read partnumber\n");
 		return -EIO;
@@ -802,16 +846,14 @@ static int abx80x_probe(struct i2c_client *client)
 	dev_info(&client->dev, "model %04x, revision %u.%u, lot %x, wafer %x, uid %x\n",
 		 partnumber, majrev, minrev, lot, wafer, uid);
 
-	data = i2c_smbus_read_byte_data(client, ABX8XX_REG_CTRL1);
-	if (data < 0) {
+	err = regmap_read(regmap, ABX8XX_REG_CTRL1, &data);
+	if (err < 0) {
 		dev_err(&client->dev, "Unable to read control register\n");
 		return -EIO;
 	}
 
-	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_CTRL1,
-					((data & ~(ABX8XX_CTRL_12_24 |
-						   ABX8XX_CTRL_ARST)) |
-					 ABX8XX_CTRL_WRITE));
+	err = regmap_write(regmap, ABX8XX_REG_CTRL1,
+			   (data & ~(ABX8XX_CTRL_12_24 | ABX8XX_CTRL_ARST)) | ABX8XX_CTRL_WRITE);
 	if (err < 0) {
 		dev_err(&client->dev, "Unable to write control register\n");
 		return -EIO;
@@ -825,15 +867,15 @@ static int abx80x_probe(struct i2c_client *client)
 		 * register is set. RV-1805-C3 datasheet indicates that
 		 * the bit should be cleared in section 11h - Control2.
 		 */
-		data = i2c_smbus_read_byte_data(client, ABX8XX_REG_CTRL2);
-		if (data < 0) {
+		err = regmap_read(regmap, ABX8XX_REG_CTRL2, &data);
+		if (err < 0) {
 			dev_err(&client->dev,
 				"Unable to read control2 register\n");
 			return -EIO;
 		}
 
-		err = i2c_smbus_write_byte_data(client, ABX8XX_REG_CTRL2,
-						data & ~ABX8XX_CTRL2_RSVD);
+		err = regmap_write(regmap, ABX8XX_REG_CTRL2,
+				   data & ~ABX8XX_CTRL2_RSVD);
 		if (err < 0) {
 			dev_err(&client->dev,
 				"Unable to write control2 register\n");
@@ -845,8 +887,8 @@ static int abx80x_probe(struct i2c_client *client)
 		 * 10pin package and the EXTI input is not present.
 		 * Disable it to avoid leakage.
 		 */
-		data = i2c_smbus_read_byte_data(client, ABX8XX_REG_OUT_CTRL);
-		if (data < 0) {
+		err = regmap_read(regmap, ABX8XX_REG_OUT_CTRL, &data);
+		if (err < 0) {
 			dev_err(&client->dev,
 				"Unable to read output control register\n");
 			return -EIO;
@@ -856,11 +898,11 @@ static int abx80x_probe(struct i2c_client *client)
 		 * Write the configuration key register to enable access to
 		 * the config2 register
 		 */
-		if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_MISC) < 0)
+		if (abx80x_write_config_key(&client->dev, ABX8XX_CFG_KEY_MISC) < 0)
 			return -EIO;
 
-		err = i2c_smbus_write_byte_data(client, ABX8XX_REG_OUT_CTRL,
-						data | ABX8XX_OUT_CTRL_EXDS);
+		err = regmap_write(regmap, ABX8XX_REG_OUT_CTRL,
+				   data | ABX8XX_OUT_CTRL_EXDS);
 		if (err < 0) {
 			dev_err(&client->dev,
 				"Unable to write output control register\n");
@@ -888,35 +930,20 @@ static int abx80x_probe(struct i2c_client *client)
 	}
 
 	if (np && abx80x_caps[part].has_tc)
-		trickle_cfg = abx80x_dt_trickle_cfg(client);
+		trickle_cfg = abx80x_dt_trickle_cfg(&client->dev);
 
 	if (trickle_cfg > 0) {
 		dev_info(&client->dev, "Enabling trickle charger: %02x\n",
 			 trickle_cfg);
-		abx80x_enable_trickle_charger(client, trickle_cfg);
+		abx80x_enable_trickle_charger(&client->dev, trickle_cfg);
 	}
 
-	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_CD_TIMER_CTL,
-					BIT(2));
+	err = regmap_write(regmap, ABX8XX_REG_CD_TIMER_CTL, BIT(2));
 	if (err)
 		return err;
 
-	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
-	if (priv == NULL)
-		return -ENOMEM;
-
-	priv->rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(priv->rtc))
-		return PTR_ERR(priv->rtc);
-
-	priv->rtc->ops = &abx80x_rtc_ops;
-	priv->client = client;
-	priv->irq = client->irq;
-
-	i2c_set_clientdata(client, priv);
-
 	if (abx80x_caps[part].has_wdog) {
-		err = abx80x_setup_watchdog(priv);
+		err = abx80x_setup_watchdog(&client->dev);
 		if (err)
 			return err;
 	}
@@ -931,7 +958,7 @@ static int abx80x_probe(struct i2c_client *client)
 						abx80x_handle_irq,
 						IRQF_SHARED | IRQF_ONESHOT,
 						"abx8xx",
-						client);
+						&client->dev);
 		if (err) {
 			dev_err(&client->dev, "unable to request IRQ, alarms disabled\n");
 			priv->irq = 0;
-- 
2.55.0

