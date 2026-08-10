Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89EE442FBF
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390818; cv=none; b=H2ChOSq4yZxx5YWWwcQdZlSnKTg8WUXtbNI2Jw4FBmHegm8IxlQ/8d3Svur6o72VIWtvJeIO+YGEAQCy/Ive2k1nk/e/gsWoaaKKjBFSoFmQV1nwT7ZjhgsLe0EWkvNHOcGwc5JG9Ei1hnUK8X0nM+5BeC2raA3FbQwjrDG7gow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390818; c=relaxed/simple;
	bh=7zftsifT1TeOCwtPU5cqKvqhs764DJUWLd8kYg26RIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/JXzvR8/+xEI1Z/fJoU/JuJeYQ91eeutiBvGwtk/3J1+3qXJ03NIdq9Q8vi3elzAea32tLICU6aS3Dyluo4At9cYjTqQL/8xi6Y5kde+m9muSy7OZbHmfFmjrV4ZfbVKmu1M6jv5rhsxgFgXbmYQx3cUyENo1W4mhCNZWaS4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3+SV9JA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3+SV9JA"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47fd66a094eso10032f8f.3
        for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390812; x=1786995612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Km3JbJM3tHI5y78m8g9L0NcliILGFksyyeAC4KOBDJY=;
        b=Y3+SV9JAcjKaN0JGHPK/bPP0KMTQpx2EA6W+O1xTFxxPXKcHvpuccSCiOvPPJH6mq5
         KRFZ34k6cc5rpLrwGWMgsbVaz0i1H+uqZ2c4PPZKhAzli1TE+HAP/ARCnZwmKZ5C/L8n
         hqUClVsczyQUbrAHKRNGMqCqS+yAPxKQcnFNNMkxHMS4I5PIjZRnrv6fLEWaSmQIBK9D
         ZPPlD4FTH9T1XURa/ckfsJJTgq3XfEhBS8DrrBjGRP9k2gofM8+cmMgaFdYTfPovcUNZ
         J42MQVimFH1ad6Kjo8wmK+o95NfC5B0xAFmxkZ9UI+1/5t/lY0rSxwVX4rAtPsW5Jl/S
         w/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390812; x=1786995612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Km3JbJM3tHI5y78m8g9L0NcliILGFksyyeAC4KOBDJY=;
        b=Z6aMRKUcDKQMxM2dzeWe7V7CpJlSfmL41MmfQqo5fMnFpKWHIR4IFW/N1N4MKj5lv/
         kYoCZr3DTd3MtBh413p1O/WwqU6JtK1fAJO3/kHT5BeZsqAzVC2HVrLXfvcN/p26lejN
         jKtk0TV7RJI4XtaOGgDT8E6yl2sDEylQC/CPHCXflrz+zLA/6LliaSg/ZSD4MjnZKMYA
         DT8Wj6Hd7HbPLE9IQezcUUMwjypcMShe8AeIvvkZvaYY3BxBsfbt8+X2fHxmXn3K9BiI
         j0APXeG1LIIGme66uHRsEhCTEDeNF/rns0FLDhB7Fld1WmcaGChNMA3rz8gBbF3msZeC
         V/1A==
X-Gm-Message-State: AOJu0YxDZKHtEoLl1wT4eDfcPVxKrZJMHJQQ84EZ53SFtLzOTel2zaP9
	EO5jryg0Xnw86TOZrV9eUmmQn1sImDKe7I5sGCz63r8xzR/SDzB6mLb+
X-Gm-Gg: AR+sD13x/+C2TMfrqQYob0s/sXiosia0koAwP1dWOGjzUcmq2TC4I4lN+dozH5Zx/LC
	3TL/s3Ebz39PSxTvpFSEmcgcOiJ1F4UABKd4vXEGLES5jJeMDixW+ThDicuXyvTYkirTCSzmXhZ
	oDhLXuvcbyrxgLwVrZkdx21Qgm0IztSw4zDl6jYIPzGVFYmtEFfrJFMR/C6APSZ32XOwZppOJhy
	3oy8BQO2Dh7fn8j2dUyU0MSVLyM0oxKNVpFFmXq3MvXlyYcX5u9SILpspTvo3bsFmzsJ7FdKhHd
	qlQmxIu7+hb82o4TFZIBncm3iLGXbSTfY5Lp4Ozwh59JuvtQ2/KZE4XuUqRD7e08F2lTjwsd9b9
	1ykYYzEYPsLLvrw5bX5UhKp7V4wGdkHLtdIYL9HJ53MEjqeFgiPTdaEnymUM99+tV66ClKj/IwM
	9FpHvt/pWJcL2hvtLeXKEZSZE4mXdSXtOEga9T6UDoyhdwTyPBAQ+boh7N5zTB3YUqvgaMP1VQ3
	3V0uU8WX4hskw==
X-Received: by 2002:a5d:6f0c:0:b0:47e:9f16:c0bf with SMTP id ffacd0b85a97d-47fec63e205mr73032320f8f.30.1786390812379;
        Mon, 10 Aug 2026 12:40:12 -0700 (PDT)
Received: from antoniarch ([78.213.94.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506cbsm39291689f8f.14.2026.08.10.12.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:12 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 7/9] rtc: abx80x: replace read-modify-write pattern with regmap helpers
Date: Mon, 10 Aug 2026 21:38:24 +0200
Message-ID: <20260810193826.210683-8-apokusinski01@gmail.com>
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

Before introducing the regmap usage in the driver, updating specific
bits of a register was performed using the read-modify-write pattern.
Now, the functions regmap_update_bits() and regmap_write_bits() can
be used to simplify the code.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 135 ++++++++++-----------------------------
 1 file changed, 35 insertions(+), 100 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 5d41882f3c70..ab88af43b4fa 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -232,7 +232,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned char buf[8];
-	int err, flags;
+	int err;
 
 	if (tm->tm_year < 100)
 		return -EINVAL;
@@ -256,18 +256,11 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	}
 
 	/* Clear the OF bit of Oscillator Status Register */
-	err = regmap_read(priv->regmap, ABX8XX_REG_OSS, &flags);
+	err = regmap_update_bits(priv->regmap, ABX8XX_REG_OSS, ABX8XX_OSS_OF, 0);
 	if (err < 0)
-		return err;
-
-	err = regmap_write(priv->regmap, ABX8XX_REG_OSS,
-			   flags & ~ABX8XX_OSS_OF);
-	if (err < 0) {
 		dev_err(dev, "Unable to write oscillator status register\n");
-		return err;
-	}
 
-	return 0;
+	return err;
 }
 
 static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
@@ -378,7 +371,6 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 {
 	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned int flags = 0;
-	int retval;
 
 	if ((autocalibration != 0) && (autocalibration != 1024) &&
 	    (autocalibration != 512)) {
@@ -386,12 +378,6 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 		return -EINVAL;
 	}
 
-	guard(mutex)(&priv->lock);
-
-	retval = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
-	if (retval < 0)
-		return retval;
-
 	if (autocalibration == 0) {
 		flags &= ~(ABX8XX_OSC_ACAL_512 | ABX8XX_OSC_ACAL_1024);
 	} else if (autocalibration == 1024) {
@@ -403,13 +389,15 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 		flags |= (ABX8XX_OSC_ACAL_1024 | ABX8XX_OSC_ACAL_512);
 	}
 
+	guard(mutex)(&priv->lock);
+
 	/* Unlock write access to Oscillator Control Register */
 	if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_OSC) < 0)
 		return -EIO;
 
-	retval = regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);
-
-	return retval;
+	return regmap_write_bits(priv->regmap, ABX8XX_REG_OSC,
+				 ABX8XX_OSC_ACAL_1024 | ABX8XX_OSC_ACAL_512,
+				 flags);
 }
 
 static int abx80x_rtc_get_autocalibration(struct device *dev)
@@ -473,7 +461,6 @@ static ssize_t oscillator_store(struct device *dev,
 {
 	struct abx80x_priv *priv = dev_get_drvdata(dev->parent);
 	int retval, rc_mode = 0;
-	unsigned int flags;
 
 	if (strncmp(buf, "rc", 2) == 0) {
 		rc_mode = 1;
@@ -486,24 +473,14 @@ static ssize_t oscillator_store(struct device *dev,
 
 	guard(mutex)(&priv->lock);
 
-	retval = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
-	if (retval < 0)
-		return retval;
-
-	if (rc_mode == 0)
-		flags &= ~(ABX8XX_OSC_OSEL);
-	else
-		flags |= (ABX8XX_OSC_OSEL);
-
 	/* Unlock write access on Oscillator Control register */
 	if (abx80x_write_config_key(dev->parent, ABX8XX_CFG_KEY_OSC) < 0)
 		return -EIO;
 
-	retval = regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);
-	if (retval < 0) {
+	retval = regmap_write_bits(priv->regmap, ABX8XX_REG_OSC, ABX8XX_OSC_OSEL,
+				   rc_mode == 0 ? 0 : (ABX8XX_OSC_OSEL));
+	if (retval < 0)
 		dev_err(dev, "Failed to write Oscillator Control register\n");
-		return retval;
-	}
 
 	return retval ? retval : count;
 }
@@ -573,18 +550,11 @@ static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 
 	case RTC_VL_CLR:
 		scoped_guard(mutex, &priv->lock) {
-			err = regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
-			if (err < 0)
-				return err;
-
-			status &= ~ABX8XX_STATUS_BLF;
-
-			err = regmap_write(priv->regmap, ABX8XX_REG_STATUS, status);
-			if (err < 0)
-				return err;
+			err = regmap_update_bits(priv->regmap, ABX8XX_REG_STATUS,
+						 ABX8XX_STATUS_BLF, 0);
 		}
 
-		return 0;
+		return err;
 
 	default:
 		return -ENOIOCTLCMD;
@@ -841,7 +811,6 @@ static int abx80x_probe(struct i2c_client *client)
 	struct device_node *np = client->dev.of_node;
 	struct abx80x_priv *priv;
 	int i, err, trickle_cfg = -EINVAL;
-	unsigned int data;
 	char buf[7];
 	unsigned int part = (uintptr_t)i2c_get_match_data(client);
 	unsigned int partnumber;
@@ -891,14 +860,9 @@ static int abx80x_probe(struct i2c_client *client)
 	dev_info(&client->dev, "model %04x, revision %u.%u, lot %x, wafer %x, uid %x\n",
 		 partnumber, majrev, minrev, lot, wafer, uid);
 
-	err = regmap_read(regmap, ABX8XX_REG_CTRL1, &data);
-	if (err < 0) {
-		dev_err(&client->dev, "Unable to read control register\n");
-		return -EIO;
-	}
-
-	err = regmap_write(regmap, ABX8XX_REG_CTRL1,
-			   (data & ~(ABX8XX_CTRL_12_24 | ABX8XX_CTRL_ARST)) | ABX8XX_CTRL_WRITE);
+	err = regmap_update_bits(regmap, ABX8XX_REG_CTRL1,
+				 ABX8XX_CTRL_12_24 | ABX8XX_CTRL_ARST | ABX8XX_CTRL_WRITE,
+				 ABX8XX_CTRL_WRITE);
 	if (err < 0) {
 		dev_err(&client->dev, "Unable to write control register\n");
 		return -EIO;
@@ -912,30 +876,10 @@ static int abx80x_probe(struct i2c_client *client)
 		 * register is set. RV-1805-C3 datasheet indicates that
 		 * the bit should be cleared in section 11h - Control2.
 		 */
-		err = regmap_read(regmap, ABX8XX_REG_CTRL2, &data);
-		if (err < 0) {
-			dev_err(&client->dev,
-				"Unable to read control2 register\n");
-			return -EIO;
-		}
-
-		err = regmap_write(regmap, ABX8XX_REG_CTRL2,
-				   data & ~ABX8XX_CTRL2_RSVD);
-		if (err < 0) {
-			dev_err(&client->dev,
-				"Unable to write control2 register\n");
-			return -EIO;
-		}
-
-		/*
-		 * Avoid extra power leakage. The RV1805 uses smaller
-		 * 10pin package and the EXTI input is not present.
-		 * Disable it to avoid leakage.
-		 */
-		err = regmap_read(regmap, ABX8XX_REG_OUT_CTRL, &data);
+		err = regmap_update_bits(regmap, ABX8XX_REG_CTRL2,
+					 ABX8XX_CTRL2_RSVD, 0);
 		if (err < 0) {
-			dev_err(&client->dev,
-				"Unable to read output control register\n");
+			dev_err(&client->dev, "Unable to write control2 register\n");
 			return -EIO;
 		}
 
@@ -946,8 +890,14 @@ static int abx80x_probe(struct i2c_client *client)
 		if (abx80x_write_config_key(&client->dev, ABX8XX_CFG_KEY_MISC) < 0)
 			return -EIO;
 
-		err = regmap_write(regmap, ABX8XX_REG_OUT_CTRL,
-				   data | ABX8XX_OUT_CTRL_EXDS);
+		/*
+		 * Avoid extra power leakage. The RV1805 uses smaller
+		 * 10pin package and the EXTI input is not present.
+		 * Disable it to avoid leakage.
+		 */
+		err = regmap_write_bits(regmap, ABX8XX_REG_OUT_CTRL,
+					ABX8XX_OUT_CTRL_EXDS,
+					ABX8XX_OUT_CTRL_EXDS);
 		if (err < 0) {
 			dev_err(&client->dev,
 				"Unable to write output control register\n");
@@ -998,33 +948,18 @@ static int abx80x_probe(struct i2c_client *client)
 		return err;
 
 	/* Disable unused interrupts */
-	err = regmap_read(regmap, ABX8XX_REG_IRQ, &data);
-	if (err < 0) {
-		dev_err(&client->dev, "Unable to read irq register\n");
-		return -EIO;
-	}
-
-	err = regmap_write(regmap, ABX8XX_REG_IRQ,
-			   data & ~(ABX8XX_IRQ_EX1E |
-				    ABX8XX_IRQ_EX2E |
-				    ABX8XX_IRQ_TIE |
-				    ABX8XX_IRQ_BLIE));
-	if (err < 0) {
-		dev_err(&client->dev, "Unable to write irq register\n");
-		return -EIO;
-	}
-
-	err = regmap_read(regmap, ABX8XX_REG_OSC, &data);
+	err = regmap_update_bits(regmap, ABX8XX_REG_IRQ,
+				 ABX8XX_IRQ_EX1E | ABX8XX_IRQ_EX2E |
+				 ABX8XX_IRQ_TIE | ABX8XX_IRQ_BLIE, 0);
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to read Oscillator Control register\n");
+		dev_err(&client->dev, "Unable to update irq register\n");
 		return -EIO;
 	}
 
-	err = regmap_write(regmap, ABX8XX_REG_OSC,
-			   data & ~(ABX8XX_OSC_ACIE |
-				    ABX8XX_OSC_OFIE));
+	err = regmap_update_bits(regmap, ABX8XX_REG_OSC,
+				 ABX8XX_OSC_ACIE | ABX8XX_OSC_OFIE, 0);
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to write Oscillator Control register\n");
+		dev_err(&client->dev, "Unable to update Oscillator Control register\n");
 		return -EIO;
 	}
 
-- 
2.55.0

