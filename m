Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41A2E739A
	for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991549; cv=none; b=hOjLBWCnbplYjFVyN7Tk3gT1i8wYdjAvC6KJ+q2sa9CNvRjRn8Kd1YkfI7m1LNzz9DTy6Eyl0hdSXFFR3nwtMh0UlVWylFWH6wFgn3pzSpZrqdU/KL2a05CDof5HOdchboPdB2XL99ip0QWu3nCyXxwjqDucN50mNL/N5j1TKdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991549; c=relaxed/simple;
	bh=o2f8XCYNCN1OMTejQn4weA6tmkrvhaix9d2uZ2VnlGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOdI2LlaA8QYdv75QZrBD5Cw23zBgt2+hghgUmfWHkf9LV2hGIikvwf1n31G5hBZS6AOUpxoM3ZDhqoOYw9ZA9SLSqTFZq7PFw3NzPnGGWARWYAEPG9UEujKFMsb+aEbeoP92bZXesLfMssrtvjmknJD+dPpj40w7mKOn9T8zoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1xwyBvj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1xwyBvj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so10133445e9.3
        for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784991546; x=1785596346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+qOU3AJRHxPByY4n2MJ/8afo8STW5D+pRGCXsF+kFw=;
        b=I1xwyBvj2XJj35WOayxghcVEVDMw3nRboCHtZ4YmRG3X4XruY8aYe026JPePiBn05V
         iUpxzAMYTuI1Tl20nV1jocygI3KlnOyZgsYvwN33qy9amd/ha6x+kxNZn7zOlIQhHBFm
         263eskiWq6j1Sn0CxXF2yiVD5LPwnCTNodQooh42Ww/j1u7SC0zmiHA5pL7SNNsDqYr9
         FZbtRwH8SSC/dAvIvJtZ3dg0cg253L+Kh9PIoNbYs/kAhj/Nhws03BpdX6PfmmaiCFPc
         j5badkBdBf0ftQFB4r1ZtaySUgANSSArJgpYJU2rZ5MaJEauq7RSCTA1wQLOWjmty3yj
         qmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991546; x=1785596346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+qOU3AJRHxPByY4n2MJ/8afo8STW5D+pRGCXsF+kFw=;
        b=FvAN2zeDJOv6HCssYvrLaY4NnBq3zCysoZLNX18DI++pMRdSXssLCELPJwnI6AsmvG
         /xp7h5i6f4XMaDDao8ClFRVaul6clMAb3TKbj7WU9OCDZyLgZbs953bly7nlyHVj6WtQ
         4R8w9KmSaAbCj4h0Me50WMT4mgjQy177CTKWnFErxNkTqtA5Nb+LMr1nkSFXkxvqEXGW
         eeIaKUOxahkX4focsgAsGz1ZZJXdA3CkCAwed9hA4xOXLjOCeGSrr+W0esYiBh4Gpuur
         yRpp2v72HhNmbKOz161y/SJVw6Ozt+7M2fT2R3nSJGOvhLFk1fbX8D49hIEbE0h1y0Uq
         +43Q==
X-Forwarded-Encrypted: i=1; AHgh+RqJ3Hu2BwHvnyJQu8JVh29eevEEfDAJ7gzwZ+ZV5qUbPThw4GqKHcHh0D21bCSkLJUGPCy+ASn1xPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YybknVi1no7hPM+rs8jVWLziweQW6cXaGPjh68HgHyJ7vRETAfU
	3nsHyODEPdYTwVpnJi1HuKqDLCfjGq3nhh8yI1FzZ5iPM81eXvCv2VSg
X-Gm-Gg: AR+sD10H9Gt+KJ4tTsNyQkggMIaQs32TfO0I/gr1hEoRkjQkn3+v9WmxN8MI3wBe0KN
	Vztmnk1z/l81ksj5Ej2zewp/KQAgkjVUmwuPRaGy53KuT0Y2Kbh3rIQI3bWaoeCc7HZGaD3SX74
	4LquqtBLP1ORFoRKxSsawUhrv/PiXzS8VzPVX3soA4SMe3lgta2nGB6d3rD8TDL8OP6fhMSGA/C
	0RdKsFjY6nORuTN/+CvIr8eX+cb7EzuqKxLot/fxXGNkSIKj2glGDxfPtaLOYNqO/0hufNuzLmZ
	HMk+tTiHNgabdS3Nlef5/o9PM99iMCzAsqRCUQlPnmVn6BIGVOXejTpFY1yGzcZpng51GWQD1Jk
	Fwt7ZHPWdpRFmxxlu9n3rfTuWfuap5n1ma8jBHJZW4YdHJAw/r/qKCVg/2ulLuN3nSTXWChDyzQ
	dV7w==
X-Received: by 2002:a05:600c:6986:b0:495:4e1d:82e6 with SMTP id 5b1f17b1804b1-496b572e6fdmr35721895e9.36.1784991545596;
        Sat, 25 Jul 2026 07:59:05 -0700 (PDT)
Received: from antoniarch ([78.212.96.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f24a93sm79704435e9.11.2026.07.25.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:59:05 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: marex@denx.de,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 5/8] rtc: abx80x: use regmap instead of I2C specific API
Date: Sat, 25 Jul 2026 16:57:15 +0200
Message-ID: <20260725145718.14733-6-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725145718.14733-1-apokusinski01@gmail.com>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
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
 drivers/rtc/rtc-abx80x.c | 343 +++++++++++++++++++++------------------
 2 files changed, 189 insertions(+), 155 deletions(-)

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
index b83c789e213d..3c5ab0ffbea8 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -16,6 +16,7 @@
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/watchdog.h>
 
@@ -125,52 +126,54 @@ static struct abx80x_cap abx80x_caps[] = {
 
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
 
@@ -179,19 +182,20 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
 
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
@@ -199,10 +203,9 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
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
 
@@ -219,7 +222,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned char buf[8];
 	int err, flags;
 
@@ -235,22 +238,22 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
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
 
@@ -259,14 +262,15 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
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
 
-	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
-	if (status < 0)
+	err = regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
+	if (err < 0)
 		return handled;
 
 	if (status & ABX8XX_STATUS_AF) {
@@ -279,36 +283,35 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
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
@@ -325,8 +328,7 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	u8 alarm[6];
 	int err;
 
@@ -340,17 +342,16 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
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
@@ -361,7 +362,7 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int abx80x_rtc_set_autocalibration(struct device *dev,
 					  int autocalibration)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	int retval, flags = 0;
 
 	if ((autocalibration != 0) && (autocalibration != 1024) &&
@@ -370,9 +371,9 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
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
@@ -386,22 +387,23 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
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
@@ -452,7 +454,7 @@ static ssize_t oscillator_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct abx80x_priv *priv = dev_get_drvdata(dev->parent);
 	int retval, flags, rc_mode = 0;
 
 	if (strncmp(buf, "rc", 2) == 0) {
@@ -464,9 +466,9 @@ static ssize_t oscillator_store(struct device *dev,
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
@@ -474,10 +476,10 @@ static ssize_t oscillator_store(struct device *dev,
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
@@ -490,9 +492,8 @@ static ssize_t oscillator_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	int rc_mode = 0;
-	struct i2c_client *client = to_i2c_client(dev->parent);
 
-	rc_mode = abx80x_is_rc_mode(client);
+	rc_mode = abx80x_is_rc_mode(dev->parent);
 
 	if (rc_mode < 0) {
 		dev_err(dev, "Failed to read RTC oscillator selection\n");
@@ -520,45 +521,44 @@ static const struct attribute_group rtc_calib_attr_group = {
 
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
 
@@ -576,9 +576,9 @@ static const struct rtc_class_ops abx80x_rtc_ops = {
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
@@ -593,7 +593,7 @@ static int abx80x_dt_trickle_cfg(struct i2c_client *client)
 	} else if (!strcmp(diode, "schottky")) {
 		trickle_cfg |= ABX8XX_TRICKLE_SCHOTTKY_DIODE;
 	} else {
-		dev_dbg(&client->dev, "Invalid tc-diode value: %s\n", diode);
+		dev_dbg(dev, "Invalid tc-diode value: %s\n", diode);
 		return -EINVAL;
 	}
 
@@ -606,7 +606,7 @@ static int abx80x_dt_trickle_cfg(struct i2c_client *client)
 			break;
 
 	if (i == sizeof(trickle_resistors)) {
-		dev_dbg(&client->dev, "Invalid tc-resistor value: %u\n", tmp);
+		dev_dbg(dev, "Invalid tc-resistor value: %u\n", tmp);
 		return -EINVAL;
 	}
 
@@ -631,7 +631,7 @@ static int __abx80x_wdog_set_timeout(struct watchdog_device *wdog,
 	 * Writing any timeout to the WDT register resets the watchdog timer.
 	 * Writing 0 disables it.
 	 */
-	return i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_WDT, val);
+	return regmap_write(priv->regmap, ABX8XX_REG_WDT, val);
 }
 
 static int abx80x_wdog_set_timeout(struct watchdog_device *wdog,
@@ -676,9 +676,11 @@ static const struct watchdog_ops abx80x_wdog_ops = {
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
@@ -687,10 +689,10 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
 
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
@@ -702,31 +704,27 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
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
@@ -762,6 +760,38 @@ static int abx80x_setup_nvmem(struct abx80x_priv *priv)
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
@@ -779,6 +809,7 @@ MODULE_DEVICE_TABLE(i2c, abx80x_id);
 
 static int abx80x_probe(struct i2c_client *client)
 {
+	struct regmap *regmap;
 	struct device_node *np = client->dev.of_node;
 	struct abx80x_priv *priv;
 	int i, data, err, trickle_cfg = -EINVAL;
@@ -793,8 +824,27 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -809,16 +859,14 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -851,15 +899,15 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -871,8 +919,8 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -882,11 +930,11 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -895,35 +943,20 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -938,7 +971,7 @@ static int abx80x_probe(struct i2c_client *client)
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

