Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB0F322B8F
	for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991550; cv=none; b=hhkpiHCKFOskozZwUqRQWerUHISIVwlDFjo8KjSphuNakKOY+54GdQgS4MaEw9fp34poEmqYOR687y1tNE1RLmuCeikawsY5+CidJrJy/kJorX2/uvmMOuqR4vfL18lGHEL1RNKhsy66qeV7jQNLN9JvY/p7a4Myw5NEf8/hUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991550; c=relaxed/simple;
	bh=vimKlP/CL30w9EjmCSmTBhfknSF6cYoa+TZYoAo0NUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjSMgQs6Pl/+nra1jAOvJ3OUavWHL1u79F0ldF0BKFd/NEXzYwINObRJFVLFf+8uJH5paGXstQ9EP8JspTBUQ6aEWC5ZEpbnHAyHV16zOQnul5TC+OtCj/AGJK6i/7L/f2OeEnvcEJu7IX/5weVWvvcxlBvpMvfO4kodIhB1cP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU/UHW+V; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU/UHW+V"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49550ec592cso15273605e9.0
        for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784991547; x=1785596347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zgluu7s47pCA4HHB8dPtmgKpF/NpEMyDi5754/51Ew=;
        b=EU/UHW+Vuz6pUhKo1mVoaIkwlZCq1o8LV5D7mRa8aV+oC3Jm35nxJ0YrLrzXg4YXrv
         FH5CRj1MmEYtb2bSfyn6kAcR5r5Mur3JWOtE8X1mqjxe5ORBA1wG6tQAsSxTlbn5TRQb
         2HyUv8r0xKxn9jruM8PT66BAq1eJBH7dycUXhNjwQVQQBnlDAkVgn7Iq5/5ISHnd+/Px
         HmVWcqXhKtHGUAcE9xYeKyU1N0AqdIBLnzPF3pfzjhmyUghUDqf102XZ/8xSNZsqyjzh
         91qqoinn9o1xFw6h1zV/UUV+q6lBlYRDj4vVoUhc0UErNiAOurst8BAe0nZxFswkusEf
         RwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991547; x=1785596347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0zgluu7s47pCA4HHB8dPtmgKpF/NpEMyDi5754/51Ew=;
        b=BDaFfBdqcrS6S18ngaV8u77qa9GIDcmq75wOcJL31fROcAx0GNOxgdIe5kAzjs5cHK
         gb2fWLXAbUyJ956eEV/kmg0GHr+yjjnnEib9uaEpNiN5VjMqfYpEEPHcI18wCziKAEWn
         qQJqHkoW7/yGvwnwmiv5dqBw2GtTytvvqBBbvrE3dlzDeroKogt82rB6Bkgt+E9zjy1z
         bSYtNm6vTdgHogeHMT37DgAWTWgQq2ZYT27/FvAKyzIJQRQnbOjZ7Kxcj/bvHSk/IlTW
         HSIaCI7ZPf388d4aVOsYOX0l0sCljscqbgaf88k+5VkjOhSWEaqwfOvLSheaEdEs4YGv
         +v4g==
X-Forwarded-Encrypted: i=1; AHgh+RrEYlBYtXzYzN/njoyCPjUWjk0i1X/7ifdkNGTNMKwecWAchRpC67s0YyMtVHgv89jtArBsIIyNIDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAYJLuMfVtibSxJw4bcRUsm2ES445rWnuS8E9mOo0UED57MtH
	0C3xY52zxl32UpbkX9g8TVLKAeyRfG17hk/34HgQckzlW4dXXLJre04V
X-Gm-Gg: AR+sD138DRoU+0wUPDG6RJlUw5dAfMHJ5wOOQRTAOcDAOxn8uMV99sDTkjGTDVgTG5z
	708kYIW0fR1rihEyXaUMG6peIE13nOdUMyg6dq0yMDM+S6P/hRXpESMxJukGAYruCrQ++GeuaZG
	/h7CfP83IaLDhyuIz4qbrZaqLZF003GhpGEyO5wCo0V2phqengg4dVa30XsfbYnRynm75OY4Gkd
	4QNIN+mwvgYNDB7mVd9eKlKVMzXHpGGGW4nQU6siJgyogtHGJ6794ucemB679amPH9hoMwUOvns
	Gie8SXsNyc7VPqJ3COQ0/Ex3g5Nff3r4nH+LcTivPRjHywWcMAtyLU8ws2W5qvtnrIM85/7G6N4
	fwBJ0427jzKNGsIMGyQv/BteUiCNhTAXmECwnI0IKlhHjCqqYwwEw2DEJgiQYi/hU+y8PfoqMbM
	7H1w==
X-Received: by 2002:a05:600c:1d0c:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-496b5b3b22cmr31596335e9.3.1784991546751;
        Sat, 25 Jul 2026 07:59:06 -0700 (PDT)
Received: from antoniarch ([78.212.96.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f24a93sm79704435e9.11.2026.07.25.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:59:06 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: marex@denx.de,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 6/8] rtc: abx80x: replace read-modify-write pattern with regmap helpers
Date: Sat, 25 Jul 2026 16:57:16 +0200
Message-ID: <20260725145718.14733-7-apokusinski01@gmail.com>
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

Before introducing the regmap usage in the driver, updating specific
bits of a register was performed using the read-modify-write pattern.
Now, the functions regmap_update_bits() and regmap_write_bits() can
be used to simplify the code.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 105 +++++++++++----------------------------
 1 file changed, 28 insertions(+), 77 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 3c5ab0ffbea8..a7686206eb92 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -224,7 +224,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned char buf[8];
-	int err, flags;
+	int err;
 
 	if (tm->tm_year < 100)
 		return -EINVAL;
@@ -246,18 +246,11 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
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
@@ -363,7 +356,7 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 					  int autocalibration)
 {
 	struct abx80x_priv *priv = dev_get_drvdata(dev);
-	int retval, flags = 0;
+	int flags = 0;
 
 	if ((autocalibration != 0) && (autocalibration != 1024) &&
 	    (autocalibration != 512)) {
@@ -371,10 +364,6 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 		return -EINVAL;
 	}
 
-	retval = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
-	if (retval < 0)
-		return retval;
-
 	if (autocalibration == 0) {
 		flags &= ~(ABX8XX_OSC_ACAL_512 | ABX8XX_OSC_ACAL_1024);
 	} else if (autocalibration == 1024) {
@@ -390,9 +379,9 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
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
@@ -455,7 +444,7 @@ static ssize_t oscillator_store(struct device *dev,
 				const char *buf, size_t count)
 {
 	struct abx80x_priv *priv = dev_get_drvdata(dev->parent);
-	int retval, flags, rc_mode = 0;
+	int retval, rc_mode = 0;
 
 	if (strncmp(buf, "rc", 2) == 0) {
 		rc_mode = 1;
@@ -466,24 +455,14 @@ static ssize_t oscillator_store(struct device *dev,
 		return -EINVAL;
 	}
 
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
@@ -550,17 +529,8 @@ static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 		return put_user(tmp, (unsigned int __user *)arg);
 
 	case RTC_VL_CLR:
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
@@ -812,7 +782,7 @@ static int abx80x_probe(struct i2c_client *client)
 	struct regmap *regmap;
 	struct device_node *np = client->dev.of_node;
 	struct abx80x_priv *priv;
-	int i, data, err, trickle_cfg = -EINVAL;
+	int i, err, trickle_cfg = -EINVAL;
 	char buf[7];
 	unsigned int part = (uintptr_t)i2c_get_match_data(client);
 	unsigned int partnumber;
@@ -859,14 +829,9 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -899,30 +864,10 @@ static int abx80x_probe(struct i2c_client *client)
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
 
@@ -933,8 +878,14 @@ static int abx80x_probe(struct i2c_client *client)
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

