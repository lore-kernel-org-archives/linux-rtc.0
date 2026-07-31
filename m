Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1D4519BD
	for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523816; cv=none; b=pV30bywhs4ix/3HPZTqnsLwwDxXDdDRb8EpvHWqA7EV5Fp2UF9UmY1Vgk9NwH9WPHkISSv2COVC+Bnre/WQYfVRhm4MAzgB05eSrx6ngnZ4YJpVddTsrLKcPFyo3uJoebNSuotnM2ZnDXGCKXeA1wnjpYyrlT6OWEAzNWLTPhiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523816; c=relaxed/simple;
	bh=6/IzwT02kJfSEiuFFlTE5fnSrsWq8IxfPOmF4n6K7/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATQ7R25o8zojr9W1yvX3SWZ50gDy9If4QLNEHk5na5ZuexaQR0iBEkVXR4HizLGRTfoaAnvod7NIvJYgEkKVhWX5OFlCHGRbJrrQPgyzcwK2YVBd+R/ew2uNI+GBSnyErQd54UeRWFirfGTh7KfB3L1bHahfXrW9sT8cJ06ukuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoweBVQA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoweBVQA"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f752b3423so1217514f8f.3
        for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785523813; x=1786128613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hr6pvt5J2uDbgwi+hPwwnpYHI398ulN1a5Y4JjOVnmo=;
        b=XoweBVQAnAaHtGXc89Rc9VZrY7KNZ4sqviklJvuEY9pB1s9nsJgJxJZR3HpLyljXEH
         XNVQ29yILGxOGazHCUqWou1BGPekZC+MRRN/BkBnDCPL0WvlNRyqeSxw6E1ngeZnlWWY
         ROuxweDtJcsS8iW+Xtsya0OCzSwon6+DiIS0gqW5x8Mh4Ez2nF6lnvuO8KuRZKde5WwF
         ANFcOBTUEIat4jhQ3Lippvy1v8511nc7DwpnO/wy3gj6TA3R3zmogMGOj8hjTXpR//u2
         1bOQr4Ndi18n/odMBu6NPrhIOoAapoUW/UPRbXNchv/yG28vKt9vY37vREl9baumrLnj
         0DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523813; x=1786128613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hr6pvt5J2uDbgwi+hPwwnpYHI398ulN1a5Y4JjOVnmo=;
        b=nRI55aNmL/lbR4uyLdpou6OyBtiPnSVZob4lL0xyfQZyqRajduBrukZEcwkM9nKyX0
         CC1vkZGVgFze9GB5ilTA1E+K+pCpjZS9MKL+JQ3REqh/b6NwHZBr+umVHEmlCrf6svU6
         7NOLt8ksx3CkOA3nFGlSR0zSQd/jBFXivzffFKjoK449G3kNZCMb2enRlfN78gwtkhtT
         fzDOFFQUv98B6qlWNjxb2qYYuxs+EKqoDGZIbLbkxeW8tvK2sTch3gXkpK7Hsr0eKgyL
         0hhL0EWMdx0CJHHnjQw4aioX39khUw2CtwBeH784MQVajECmDqhrfyGhvTikCwxbkQsO
         bTXQ==
X-Gm-Message-State: AOJu0YxAL4qHvWYaYM3N9gWe1nDyseX8AqSSMT/mzWmZG2xQ+dZNc3ab
	1EcmtB8HIBvgsijQhDwFQvl9cV4h2inGgSIghPQaY8rrEFqsj04OpZuY3RDkBA==
X-Gm-Gg: AR+sD12tqH9qmwHfLIYBqSf0Hugon2sloL9TqbrsW/hxqFxaqh9mVB8R/2FdjPLvqyE
	eDos0qT0jii/MCgmwZiQ6gCDKVf4Q3ZBqGc3B9N2JSVONhQslkjIJ78159UZz4+empX5IFuODYN
	aSVPxmCCroNwVxaGWAVu/m9XBU5xOL9y7dA8Lg+kpkaBzwQ7V8qtolhJf7Sn7m/mZreD4XE00lK
	Fm7WImoBTcDUJ7pPT+apNeNARdDLBXs9fzT+OI9GJpWmaHimXLBgMPRPXnk7HNpwQCV8cW0A/Sg
	YdoWRblfIlhEksUgg10enoFnXh+NJ9m8bS6NVXfA66ir+Oz3iKrY6+78+VfX4K93utoaC6tUhO8
	BzQkpVNTl18S0N+TzYFkD7JbITl5uVVJ8SIhMF1pz2izCxZRCK5L6agiKMIaH8tu7Pm4D2DgYO7
	+BfEfdf9TsQOz0Jj3nGgq0f7ZxiYxQE2zCiyuPFTO3s5O9MaoKWK9JNnr+DGfHo+E2
X-Received: by 2002:a05:6000:3111:b0:47f:45d1:7b74 with SMTP id ffacd0b85a97d-47fd7327d88mr1578876f8f.58.1785523812762;
        Fri, 31 Jul 2026 11:50:12 -0700 (PDT)
Received: from antoniarch ([78.211.133.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91b3sm8741488f8f.14.2026.07.31.11.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:50:12 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 6/8] rtc: abx80x: replace read-modify-write pattern with regmap helpers
Date: Fri, 31 Jul 2026 20:48:29 +0200
Message-ID: <20260731184831.44037-7-apokusinski01@gmail.com>
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

Before introducing the regmap usage in the driver, updating specific
bits of a register was performed using the read-modify-write pattern.
Now, the functions regmap_update_bits() and regmap_write_bits() can
be used to simplify the code.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 109 +++++++++++----------------------------
 1 file changed, 30 insertions(+), 79 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 23823fc2f545..52f958e2aecd 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -226,7 +226,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned char buf[8];
-	int err, flags;
+	int err;
 
 	if (tm->tm_year < 100)
 		return -EINVAL;
@@ -250,18 +250,11 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
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
@@ -371,7 +364,7 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 					  int autocalibration)
 {
 	struct abx80x_priv *priv = dev_get_drvdata(dev);
-	int retval, flags = 0;
+	int flags = 0;
 
 	if ((autocalibration != 0) && (autocalibration != 1024) &&
 	    (autocalibration != 512)) {
@@ -379,12 +372,6 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
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
@@ -396,13 +383,15 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
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
@@ -465,7 +454,7 @@ static ssize_t oscillator_store(struct device *dev,
 				const char *buf, size_t count)
 {
 	struct abx80x_priv *priv = dev_get_drvdata(dev->parent);
-	int retval, flags, rc_mode = 0;
+	int retval, rc_mode = 0;
 
 	if (strncmp(buf, "rc", 2) == 0) {
 		rc_mode = 1;
@@ -478,24 +467,14 @@ static ssize_t oscillator_store(struct device *dev,
 
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
@@ -566,17 +545,8 @@ static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 	case RTC_VL_CLR:
 		guard(mutex)(&priv->lock);
 
-		err = regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
-		if (err < 0)
-			return err;
-
-		status &= ~ABX8XX_STATUS_BLF;
-
-		err = regmap_write(priv->regmap, ABX8XX_REG_STATUS, status);
-		if (err < 0)
-			return err;
-
-		return 0;
+		return regmap_update_bits(priv->regmap, ABX8XX_REG_STATUS,
+					  ABX8XX_STATUS_BLF, 0);
 
 	default:
 		return -ENOIOCTLCMD;
@@ -832,7 +802,7 @@ static int abx80x_probe(struct i2c_client *client)
 	struct regmap *regmap;
 	struct device_node *np = client->dev.of_node;
 	struct abx80x_priv *priv;
-	int i, data, err, trickle_cfg = -EINVAL;
+	int i, err, trickle_cfg = -EINVAL;
 	char buf[7];
 	unsigned int part = (uintptr_t)i2c_get_match_data(client);
 	unsigned int partnumber;
@@ -882,14 +852,9 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -903,30 +868,10 @@ static int abx80x_probe(struct i2c_client *client)
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
 
@@ -937,8 +882,14 @@ static int abx80x_probe(struct i2c_client *client)
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
-- 
2.55.0

