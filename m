Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33F47D449
	for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523815; cv=none; b=ZIyqW0ZGOToexX3d5JCUzQEL9/I/IA/UjIQjeaIIyT9C/O0FmtRsqFf+Y500FM+b2dm5FJgHEKC8b+9YX+FBhf3itFHdbSO0lsHIcnh7g/X0riW5jGwFj/YZD4F/5JBmSGLD+i9OLARNO8tEOggvxRVDN0jqzsKa6Eprj3nKqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523815; c=relaxed/simple;
	bh=smW58NOjjH8RU+MjbhcZ5V2ocVLnA797K6y8dncfWn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lf3BikC2gL9hKHM7Me15uJ0Inh/2XPQJsBQ9huZTOVY8eEQzEONgUmx6ROR6MDZFiZ4Qty+jL1CcatltXVWjlmhsJZosdsgSPgfExvqv7QhXzodk8FxW8Rc8St6AsTfF4RgUFXE8UklFpdzzTZ6MC28hAx+XsDvHfJBpoUyZ0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7C/YOoz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7C/YOoz"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1416329f8f.0
        for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785523811; x=1786128611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nz+tahWHahXvPUM7eZ2dr1GOta+1JNuTb+dkAqH/T7E=;
        b=Y7C/YOozUI6vhYzxN6GLkOFsIQ5I5BxJy+HUxYQr7nzRl8+cK0xTmW3PltMYayf+xD
         5BZAyCKLxzJN1Vilk41W5wqH8wPGNcw0ZNNkRN9grnuPghj80Y29flmyhGo0E3Uiilj+
         /GKh4yFpNx8czHVwllyvwsTGIFiwciYkjWYDwEdWsflHw4U0jsO20WPvtjvZ0sZI0Ejb
         kEdBN8GwnyJqqxq9ywQ+BtmamFwa2SH0+kf8ZcBoNcz3qLi3sze+NbO1YqL6q5DcHLUe
         9em4zgUUnWLEgE24ULR/BjlSOlTcBQcaSYmUpGoI7gRV0uP7bESvErrTULyo8/3uh0Oy
         JuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523811; x=1786128611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nz+tahWHahXvPUM7eZ2dr1GOta+1JNuTb+dkAqH/T7E=;
        b=IFELpBorXWZ3LP0Stu6Wxd3yCb4h6XcHkrodNtO+OoHUe4jdrXg55zw3cnue9U0wUu
         i2bwG3JGl/9wUYHDdaaVeEUtvMsEfLY5c0b9dDlvASRzsdjaXQKW73vtvcAJnMOOXIEf
         OG9aAxfwn7o19bdtdAquJAHoQfJLJ9cwbL0Nn2vqiJ08Q5zitNE2Cv552UeB2UnGLX8O
         qJVn/JjFUwvqFm2Raad63XTdpNrzA+BEfoKm/hyRxl4MBVU74XayiD69RLp5I0GOrkce
         fQZnj6wgdAtqCJ8O0CWcfXycqX3sB0slLY25M6fQwicI4FNe57QPlH2tC3RTpcvqfv5v
         iLsQ==
X-Gm-Message-State: AOJu0YzqFeFbrDK/1QYectmstT8O2B8Ng3lEO131wU0LFhasJJNVEa01
	c+e/NdnGhDBtT2XsR31zN2G4zQcfnMupjl5sZyN0oXfbsn55RyiIxDSO
X-Gm-Gg: AR+sD11+Uq+YqsKzz06GToU49HUC+h7HjWAbPmsk6C5l6UIruk/T2B1pfU/BOL550O7
	dTnuobEcqURplpxVBTgU7vswjW4a1XhNaY1/LXRk85VG/KZkojzaT56ISCZbn886MPd7T1Soorq
	6PuF/6tuM88kOl+/N/xF7b8lE58wwc0+xOmMLx0WpUX9Kcw2QfEfzaQT5njIB/sp8hhv1hNOB09
	pKg02jwAN14+Sz7THUQ8J4J4ICec4LCkWcr5fDLfhevbgmp8IIsw9h5Kjtyevucu4DzNTwpHLRi
	ONQQiIXu8hIEAk6GWcB5NLzjL9GlPDxTxqW9f1hvWqZLpEHH/mQ3ydA4mnPf4Eq28AdjY/J58KC
	lKGfxYNY2V/u35z/71OoY4CTbHaHBrqnJIlbCfCn2XbIWCmf+dlyA9HlqXuugPpQ61Jo5ZwWYnw
	Pp2F1jSS+4aIj6n2e6VscxGGps094+Rs0dR6gJGyuk+btbFZJoQotsQnljtyRXOclJOwNXXuczR
	UM=
X-Received: by 2002:a05:6000:1846:b0:47f:6e8b:699c with SMTP id ffacd0b85a97d-47fd729208fmr1583057f8f.14.1785523811326;
        Fri, 31 Jul 2026 11:50:11 -0700 (PDT)
Received: from antoniarch ([78.211.133.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91b3sm8741488f8f.14.2026.07.31.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:50:10 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 5/8] rtc: abx80x: use regmap instead of I2C specific API
Date: Fri, 31 Jul 2026 20:48:28 +0200
Message-ID: <20260731184831.44037-6-apokusinski01@gmail.com>
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

Rework the driver so that it uses regmap_* functions for communication
with the device instead of the i2c_smbus_* API. This way the support for
ABX81X RTCs which use SPI can be added later.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/Kconfig      |   1 +
 drivers/rtc/rtc-abx80x.c | 354 +++++++++++++++++++++------------------
 2 files changed, 192 insertions(+), 163 deletions(-)

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
index 4ac3ace687a1..23823fc2f545 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/watchdog.h>
 
@@ -126,53 +127,55 @@ static struct abx80x_cap abx80x_caps[] = {
 
 struct abx80x_priv {
 	struct rtc_device *rtc;
-	struct i2c_client *client;
+	struct regmap *regmap;
 	struct watchdog_device wdog;
 	struct mutex lock;
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
+	unsigned int flags = 0;
+	int err;
 
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
 
@@ -181,19 +184,20 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
 
 static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned char buf[8];
-	int err, flags, rc_mode = 0;
+	unsigned int flags;
+	int err, rc_mode = 0;
 
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
@@ -201,10 +205,9 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
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
 
@@ -221,8 +224,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned char buf[8];
 	int err, flags;
 
@@ -240,22 +242,22 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	guard(mutex)(&priv->lock);
 
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
 
@@ -264,16 +266,17 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 {
-	struct i2c_client *client = dev_id;
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct device *dev = dev_id;
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	struct rtc_device *rtc = priv->rtc;
 	irqreturn_t handled = IRQ_NONE;
-	int status;
+	unsigned int status;
+	int err;
 
 	guard(mutex)(&priv->lock);
 
-	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
-	if (status < 0)
+	err = regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
+	if (err < 0)
 		return handled;
 
 	if (status & ABX8XX_STATUS_AF) {
@@ -286,36 +289,35 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 	 * reset kicks in.
 	 */
 	if (status & ABX8XX_STATUS_WDT) {
-		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
+		dev_alert(dev, "watchdog timeout interrupt.\n");
 		handled = IRQ_HANDLED;
 	}
 
 	if (handled == IRQ_HANDLED)
-		i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
-					  status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));
+		regmap_write(priv->regmap, ABX8XX_REG_STATUS,
+			     status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));
 
 	return handled;
 }
 
 static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned char buf[7];
 
-	int irq_mask, err;
+	unsigned int irq_mask;
+	int err;
 
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
@@ -332,8 +334,7 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	u8 alarm[6];
 	int err;
 
@@ -349,17 +350,16 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	guard(mutex)(&priv->lock);
 
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
@@ -370,8 +370,7 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int abx80x_rtc_set_autocalibration(struct device *dev,
 					  int autocalibration)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	int retval, flags = 0;
 
 	if ((autocalibration != 0) && (autocalibration != 1024) &&
@@ -382,9 +381,9 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 
 	guard(mutex)(&priv->lock);
 
-	flags = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
-	if (flags < 0)
-		return flags;
+	retval = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
+	if (retval < 0)
+		return retval;
 
 	if (autocalibration == 0) {
 		flags &= ~(ABX8XX_OSC_ACAL_512 | ABX8XX_OSC_ACAL_1024);
@@ -398,22 +397,23 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
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
+	unsigned int flags = 0;
+	int autocalibration, err;
 
-	flags =  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
-	if (flags < 0)
-		return flags;
+	err = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
+	if (err < 0)
+		return err;
 
 	if (flags & ABX8XX_OSC_ACAL_512)
 		autocalibration = 512;
@@ -464,8 +464,7 @@ static ssize_t oscillator_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev->parent);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev->parent);
 	int retval, flags, rc_mode = 0;
 
 	if (strncmp(buf, "rc", 2) == 0) {
@@ -479,9 +478,9 @@ static ssize_t oscillator_store(struct device *dev,
 
 	guard(mutex)(&priv->lock);
 
-	flags =  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
-	if (flags < 0)
-		return flags;
+	retval = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
+	if (retval < 0)
+		return retval;
 
 	if (rc_mode == 0)
 		flags &= ~(ABX8XX_OSC_OSEL);
@@ -489,10 +488,10 @@ static ssize_t oscillator_store(struct device *dev,
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
@@ -505,9 +504,8 @@ static ssize_t oscillator_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	int rc_mode = 0;
-	struct i2c_client *client = to_i2c_client(dev->parent);
 
-	rc_mode = abx80x_is_rc_mode(client);
+	rc_mode = abx80x_is_rc_mode(dev->parent);
 
 	if (rc_mode < 0) {
 		dev_err(dev, "Failed to read RTC oscillator selection\n");
@@ -535,33 +533,31 @@ static const struct attribute_group rtc_calib_attr_group = {
 
 static int abx80x_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	int err;
 
 	guard(mutex)(&priv->lock);
 
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
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
-	int status, tmp;
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
+	unsigned int status;
+	int err, tmp;
 
 	switch (cmd) {
 	case RTC_VL_READ:
-		status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
-		if (status < 0)
-			return status;
+		err = regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
+		if (err < 0)
+			return err;
 
 		tmp = status & ABX8XX_STATUS_BLF ? RTC_VL_BACKUP_LOW : 0;
 
@@ -570,16 +566,15 @@ static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 	case RTC_VL_CLR:
 		guard(mutex)(&priv->lock);
 
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
 
@@ -597,9 +592,9 @@ static const struct rtc_class_ops abx80x_rtc_ops = {
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
@@ -614,7 +609,7 @@ static int abx80x_dt_trickle_cfg(struct i2c_client *client)
 	} else if (!strcmp(diode, "schottky")) {
 		trickle_cfg |= ABX8XX_TRICKLE_SCHOTTKY_DIODE;
 	} else {
-		dev_dbg(&client->dev, "Invalid tc-diode value: %s\n", diode);
+		dev_dbg(dev, "Invalid tc-diode value: %s\n", diode);
 		return -EINVAL;
 	}
 
@@ -627,7 +622,7 @@ static int abx80x_dt_trickle_cfg(struct i2c_client *client)
 			break;
 
 	if (i == sizeof(trickle_resistors)) {
-		dev_dbg(&client->dev, "Invalid tc-resistor value: %u\n", tmp);
+		dev_dbg(dev, "Invalid tc-resistor value: %u\n", tmp);
 		return -EINVAL;
 	}
 
@@ -654,7 +649,7 @@ static int __abx80x_wdog_set_timeout(struct watchdog_device *wdog,
 	 * Writing any timeout to the WDT register resets the watchdog timer.
 	 * Writing 0 disables it.
 	 */
-	return i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_WDT, val);
+	return regmap_write(priv->regmap, ABX8XX_REG_WDT, val);
 }
 
 static int abx80x_wdog_set_timeout(struct watchdog_device *wdog,
@@ -699,9 +694,11 @@ static const struct watchdog_ops abx80x_wdog_ops = {
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
@@ -710,10 +707,10 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
 
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
@@ -725,33 +722,29 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
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
 
 		guard(mutex)(&priv->lock);
 
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
@@ -787,6 +780,38 @@ static int abx80x_setup_nvmem(struct abx80x_priv *priv)
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
@@ -804,6 +829,7 @@ MODULE_DEVICE_TABLE(i2c, abx80x_id);
 
 static int abx80x_probe(struct i2c_client *client)
 {
+	struct regmap *regmap;
 	struct device_node *np = client->dev.of_node;
 	struct abx80x_priv *priv;
 	int i, data, err, trickle_cfg = -EINVAL;
@@ -818,8 +844,30 @@ static int abx80x_probe(struct i2c_client *client)
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ID0,
-					    sizeof(buf), buf);
+	regmap = devm_regmap_init_i2c(client, &abx80x_regmap_config_i2c);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Unable to allocate regmap\n");
+		return PTR_ERR(regmap);
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
+	err = devm_mutex_init(&client->dev, &priv->lock);
+	if (err)
+		return err;
+
+	dev_set_drvdata(&client->dev, priv);
+
+	err = regmap_bulk_read(regmap, ABX8XX_REG_ID0, buf, sizeof(buf));
 	if (err < 0) {
 		dev_err(&client->dev, "Unable to read partnumber\n");
 		return -EIO;
@@ -834,16 +882,14 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -857,15 +903,15 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -877,8 +923,8 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -888,11 +934,11 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -920,38 +966,20 @@ static int abx80x_probe(struct i2c_client *client)
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
-	if (err)
-		return err;
-
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
-	err = devm_mutex_init(&client->dev, &priv->lock);
+	err = regmap_write(regmap, ABX8XX_REG_CD_TIMER_CTL, BIT(2));
 	if (err)
 		return err;
 
-	i2c_set_clientdata(client, priv);
-
 	if (abx80x_caps[part].has_wdog) {
-		err = abx80x_setup_watchdog(priv);
+		err = abx80x_setup_watchdog(&client->dev);
 		if (err)
 			return err;
 	}
@@ -966,7 +994,7 @@ static int abx80x_probe(struct i2c_client *client)
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

