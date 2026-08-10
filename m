Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E77442FBC
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390818; cv=none; b=ca45ASLX5f8YWmztBxVb35W5sR4wWoOetiEsXzhQsMycqft9SQMKvTE7ifxzYDxRaiACu15nSPVkJlKZEyXOCMTeURs82XdcIhZ1cgopLX5GoyosUFCWrp+6CKJeFaauOzUB+TW7drYLpPH5HP6BYK+L5UxZyDiybbWl+Nwcbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390818; c=relaxed/simple;
	bh=4U5s2L+JK6pt5bn+oqBO8mnGY3oOxGJXMUlIyoAUykY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcpVWEXtpJG5OUW1UJ6ktGH4SIL3HvNOpxD9BeVsTwozOzede6YGws7/WLiDwhH6mtojJ84UrBdHUSpxw920Y22mwcc2kmGvVax9rWSpq7OmFgLaPe+I4Z2FJdeRvTZzVx7SbCpIdA+dkm5ehKAT0oF6lExEb6NrjPXS8CULDuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmxCT183; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmxCT183"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so20098485e9.2
        for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390811; x=1786995611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/mH2/MSL/UFAT3IsfTBYmLtSq62dX7+BB1fHUUx/EhE=;
        b=WmxCT1830xyTx/4vUIGqiHbJrtBQF5K6litXJCW6iy5nntZQTKLbxYB2eGzSdPRcIm
         oDuvLvlbBBFOa3cDkIl7bACJNmlCjKyTiq0W48gWUcYQqtTG129GJ7C4sUJWgAuqkOiz
         4eGrYnw8YJHLaCj/BPclGo8DLHAuwaYbgwmhbIUuL5qHfyB6NQ2y9hideeWmHLUvvt48
         2oVVEqTy0qeYcP5AfkJd9SIUgqwJq5Pec9SxE2uvdRtMJ7yxpQz36dALjOT8WUkFtcZo
         obqnlwcBk09rXRFAfWB5+qG2rcVe+oG+Dj8lAyp/j5VKDdRik4il6oKUHOFDemtzCDQq
         HEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390811; x=1786995611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/mH2/MSL/UFAT3IsfTBYmLtSq62dX7+BB1fHUUx/EhE=;
        b=XSxcKsz83oWF0RqtW/N7p7U3c5bv4m7ML4BIJtLLX2gegp6O6XidrvGPN6a1agMLMB
         BI1WVD9+beGcT+Qo/irWB02xhnWuomEngCpvajETu7omMEMH3WO3bnAo1VktbMotJzbB
         PrdLQ9y9+1XDwTKIq8LatTw/Pg/VAeCN6ee4ABGKuFX10mV2ArH952Y3LiISrUQz1jcK
         UP+yK4jB5hkJjtE7Ry7UwZlSeHWXryJ7Jj6yLOHFgMuPLI2bGGBNycfeEBhtMre74Oj2
         g0b4PMW7vA3bc9jKrCmp3R2CVzMI881oTCAjBZMyGv4dqIDtYP7qH8BQDXbt6pYzWs3M
         FSnQ==
X-Gm-Message-State: AOJu0YzJpJzc/+xlD7BBvG1AXW7bqw7/Pyc7juoAyzaiJyMbEnIOP+W8
	qY0Vd/HIxFg0oey0Yjzo8rqzDFejY49ifceTkaos+PmfnC7fsP7XDRvZ
X-Gm-Gg: AR+sD102nYzpB/oW72EsiLnPEWadh6hP9xnCvd0DaWcyBUD34qFsQgRnDKKULCKeHva
	gB1iwPz0Zh8re1UReXr7wx6a7q+uxwLt/gH+MknaV7hSulYRrbR5iYgg5nLO1Zct15+3IdLjksF
	8SB4HCpyA9b2sN8yQGZ+T+airnetz856i6EccXcccNKdY/2er1xDqN2KEPoBiBIGQVnPH0neAis
	p/PcdoaYLguCD9tsEh2DcV08nnHy0hEwdocI2hg8Av+euWXTDY8J2/s3WK5UehxjfzbfWup2klt
	YkSdw8IreYwH223BB0eIRXZURoZKRH7TkwPY6r1NKEpe4DMhRdl+zZG+l65iSiDDztq5PlBJupM
	cyu+tScgNLSSZGWU+bFd1q8YOswBVUp3bin9U3uN7wSA6OEFrZn39saUEoKbc2YkMv7X9TIr0Y6
	ynD+BeFkJmYbk3vJ8YNqmhJUOtPwYYPo9tP++JT8i+zJiNF3HrjslvxkO+0wtAWssX11FgR91QS
	Q==
X-Received: by 2002:a05:6000:43d6:10b0:47f:ff13:105e with SMTP id ffacd0b85a97d-47fff13109emr35491709f8f.28.1786390810802;
        Mon, 10 Aug 2026 12:40:10 -0700 (PDT)
Received: from antoniarch ([78.213.94.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506cbsm39291689f8f.14.2026.08.10.12.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:10 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 6/9] rtc: abx80x: use regmap instead of I2C specific API
Date: Mon, 10 Aug 2026 21:38:23 +0200
Message-ID: <20260810193826.210683-7-apokusinski01@gmail.com>
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

Rework the driver so that it uses regmap_* functions for communication
with the device instead of the i2c_smbus_* API. This way the support for
ABX81X RTCs which use SPI can be added later.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/Kconfig      |   1 +
 drivers/rtc/rtc-abx80x.c | 389 +++++++++++++++++++++------------------
 2 files changed, 211 insertions(+), 179 deletions(-)

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
index 12a4dbfec639..5d41882f3c70 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/watchdog.h>
 
@@ -132,53 +133,55 @@ static struct abx80x_cap abx80x_caps[] = {
 
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
 
@@ -187,19 +190,20 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
 
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
@@ -207,10 +211,9 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
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
 
@@ -227,8 +230,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned char buf[8];
 	int err, flags;
 
@@ -246,22 +248,22 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
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
 
@@ -270,16 +272,17 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
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
@@ -292,36 +295,35 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
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
-	if (err < 0)
+	err = regmap_bulk_read(priv->regmap, ABX8XX_REG_ASC, buf, sizeof(buf));
+	if (err)
 		return err;
 
-	irq_mask = i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);
-	if (irq_mask < 0)
-		return irq_mask;
+	err = regmap_read(priv->regmap, ABX8XX_REG_IRQ, &irq_mask);
+	if (err < 0)
+		return err;
 
 	t->time.tm_sec = bcd2bin(buf[0] & 0x7F);
 	t->time.tm_min = bcd2bin(buf[1] & 0x7F);
@@ -338,8 +340,7 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	u8 alarm[6];
 	int err;
 
@@ -355,17 +356,16 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 
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
@@ -376,9 +376,9 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int abx80x_rtc_set_autocalibration(struct device *dev,
 					  int autocalibration)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
-	int retval, flags = 0;
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
+	unsigned int flags = 0;
+	int retval;
 
 	if ((autocalibration != 0) && (autocalibration != 1024) &&
 	    (autocalibration != 512)) {
@@ -388,9 +388,9 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 
 	guard(mutex)(&priv->lock);
 
-	flags = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
-	if (flags < 0)
-		return flags;
+	retval = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
+	if (retval < 0)
+		return retval;
 
 	if (autocalibration == 0) {
 		flags &= ~(ABX8XX_OSC_ACAL_512 | ABX8XX_OSC_ACAL_1024);
@@ -404,22 +404,23 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
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
@@ -470,9 +471,9 @@ static ssize_t oscillator_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev->parent);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
-	int retval, flags, rc_mode = 0;
+	struct abx80x_priv *priv = dev_get_drvdata(dev->parent);
+	int retval, rc_mode = 0;
+	unsigned int flags;
 
 	if (strncmp(buf, "rc", 2) == 0) {
 		rc_mode = 1;
@@ -485,9 +486,9 @@ static ssize_t oscillator_store(struct device *dev,
 
 	guard(mutex)(&priv->lock);
 
-	flags =  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
-	if (flags < 0)
-		return flags;
+	retval = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
+	if (retval < 0)
+		return retval;
 
 	if (rc_mode == 0)
 		flags &= ~(ABX8XX_OSC_OSEL);
@@ -495,10 +496,10 @@ static ssize_t oscillator_store(struct device *dev,
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
@@ -511,9 +512,8 @@ static ssize_t oscillator_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	int rc_mode = 0;
-	struct i2c_client *client = to_i2c_client(dev->parent);
 
-	rc_mode = abx80x_is_rc_mode(client);
+	rc_mode = abx80x_is_rc_mode(dev->parent);
 
 	if (rc_mode < 0) {
 		dev_err(dev, "Failed to read RTC oscillator selection\n");
@@ -541,33 +541,31 @@ static const struct attribute_group rtc_calib_attr_group = {
 
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
 
@@ -575,16 +573,15 @@ static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 
 	case RTC_VL_CLR:
 		scoped_guard(mutex, &priv->lock) {
-			status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
-			if (status < 0)
-				return status;
+			err = regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
+			if (err < 0)
+				return err;
 
 			status &= ~ABX8XX_STATUS_BLF;
 
-			tmp = i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
-							status);
-			if (tmp < 0)
-				return tmp;
+			err = regmap_write(priv->regmap, ABX8XX_REG_STATUS, status);
+			if (err < 0)
+				return err;
 		}
 
 		return 0;
@@ -603,9 +600,9 @@ static const struct rtc_class_ops abx80x_rtc_ops = {
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
@@ -620,7 +617,7 @@ static int abx80x_dt_trickle_cfg(struct i2c_client *client)
 	} else if (!strcmp(diode, "schottky")) {
 		trickle_cfg |= ABX8XX_TRICKLE_SCHOTTKY_DIODE;
 	} else {
-		dev_dbg(&client->dev, "Invalid tc-diode value: %s\n", diode);
+		dev_dbg(dev, "Invalid tc-diode value: %s\n", diode);
 		return -EINVAL;
 	}
 
@@ -633,7 +630,7 @@ static int abx80x_dt_trickle_cfg(struct i2c_client *client)
 			break;
 
 	if (i == sizeof(trickle_resistors)) {
-		dev_dbg(&client->dev, "Invalid tc-resistor value: %u\n", tmp);
+		dev_dbg(dev, "Invalid tc-resistor value: %u\n", tmp);
 		return -EINVAL;
 	}
 
@@ -660,7 +657,7 @@ static int __abx80x_wdog_set_timeout(struct watchdog_device *wdog,
 	 * Writing any timeout to the WDT register resets the watchdog timer.
 	 * Writing 0 disables it.
 	 */
-	return i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_WDT, val);
+	return regmap_write(priv->regmap, ABX8XX_REG_WDT, val);
 }
 
 static int abx80x_wdog_set_timeout(struct watchdog_device *wdog,
@@ -705,9 +702,11 @@ static const struct watchdog_ops abx80x_wdog_ops = {
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
@@ -716,10 +715,10 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
 
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
@@ -731,33 +730,29 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
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
@@ -793,6 +788,38 @@ static int abx80x_setup_nvmem(struct abx80x_priv *priv)
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
@@ -810,9 +837,11 @@ MODULE_DEVICE_TABLE(i2c, abx80x_id);
 
 static int abx80x_probe(struct i2c_client *client)
 {
+	struct regmap *regmap;
 	struct device_node *np = client->dev.of_node;
 	struct abx80x_priv *priv;
-	int i, data, err, trickle_cfg = -EINVAL;
+	int i, err, trickle_cfg = -EINVAL;
+	unsigned int data;
 	char buf[7];
 	unsigned int part = (uintptr_t)i2c_get_match_data(client);
 	unsigned int partnumber;
@@ -824,8 +853,30 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -840,16 +891,14 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -863,15 +912,15 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -883,8 +932,8 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -894,11 +943,11 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -926,38 +975,20 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -967,31 +998,31 @@ static int abx80x_probe(struct i2c_client *client)
 		return err;
 
 	/* Disable unused interrupts */
-	data = i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);
-	if (data < 0) {
+	err = regmap_read(regmap, ABX8XX_REG_IRQ, &data);
+	if (err < 0) {
 		dev_err(&client->dev, "Unable to read irq register\n");
 		return -EIO;
 	}
 
-	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_IRQ,
-					data & ~(ABX8XX_IRQ_EX1E |
-						 ABX8XX_IRQ_EX2E |
-						 ABX8XX_IRQ_TIE |
-						 ABX8XX_IRQ_BLIE));
+	err = regmap_write(regmap, ABX8XX_REG_IRQ,
+			   data & ~(ABX8XX_IRQ_EX1E |
+				    ABX8XX_IRQ_EX2E |
+				    ABX8XX_IRQ_TIE |
+				    ABX8XX_IRQ_BLIE));
 	if (err < 0) {
 		dev_err(&client->dev, "Unable to write irq register\n");
 		return -EIO;
 	}
 
-	data = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
-	if (data < 0) {
+	err = regmap_read(regmap, ABX8XX_REG_OSC, &data);
+	if (err < 0) {
 		dev_err(&client->dev, "Unable to read Oscillator Control register\n");
 		return -EIO;
 	}
 
-	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC,
-					data & ~(ABX8XX_OSC_ACIE |
-						 ABX8XX_OSC_OFIE));
+	err = regmap_write(regmap, ABX8XX_REG_OSC,
+			   data & ~(ABX8XX_OSC_ACIE |
+				    ABX8XX_OSC_OFIE));
 	if (err < 0) {
 		dev_err(&client->dev, "Unable to write Oscillator Control register\n");
 		return -EIO;
@@ -1003,7 +1034,7 @@ static int abx80x_probe(struct i2c_client *client)
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

