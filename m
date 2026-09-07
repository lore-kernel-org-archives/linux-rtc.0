Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998A52D2CC
	for <linux-rtc@vger.kernel.org>; Mon,  7 Sep 2026 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813257; cv=none; b=ghwXuezgirbWwh0DIhxARdHcy+867ALlCUP6s0ok1oPBGr54FYxEiWmmf4BSQWW5X7IuWv/TvoOSoUKKM6GMiKO5TrxyilAOXQqWW6vjKl4F/O9Si5ZiA7O+RyCcbQLmY0qOK5BNyVkK2N8pue63vE7M5JTSqSV9VhHcmoItH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813257; c=relaxed/simple;
	bh=MnJEj0B8CcYBACLAw3JsCqugpkGMobiamsNHgKngBxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuaK68hBNmstjR312lcaZkFdNkKjOmVHaBQ0JHKV2VtahnzKvHKwAZWZuaL8gMwxDtwTrGUTInLvjYHXjnWZxvaimmtvnmpqn5v6s0Prbp1Ugqzt3LRXSy8RCjZ58twCWIBPUWQ7jrnF9nXEYIPGBiY+rVgHgqVrnGFUwhGYbYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtyStryj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtyStryj"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-484362f5c4aso4919055f8f.3
        for <linux-rtc@vger.kernel.org>; Mon, 07 Sep 2026 13:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788813251; x=1789418051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mWk40ktaGFYc0a5WN0YPWh/YYHzjM0DGHQ579TPtQxI=;
        b=KtyStryjRXlIXpAUMfjwHjPp6sO9faozSCVYX96SmGPRfRyCkqWsnv+xe+V0I27F6q
         o0TG3SyBb8YrBZjpZBEmIWQjL4USJoAFCmQVMipfmdTo1tjOsdPmFBTDHhmGt4c+4RXn
         1V8Ya5Hr/euVgiaqXre7Yyf6Wbcmye1gz8HiC5+iyFMVSRmCNsjAeB95GXSMgZ8bEVAc
         Gf0AaBMwOE8dvQKsmwHX7IF9bj4w1VOrUewl+6Qp0qohU3siMsZmmV5WflWjuRrXx4Pu
         TBnL3y31Iptc68JJcr4kEaQ+DBKCvydWxWCC2vqSGHjJq8xH95uzTxIpr+D4z0waSNGK
         t+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813251; x=1789418051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mWk40ktaGFYc0a5WN0YPWh/YYHzjM0DGHQ579TPtQxI=;
        b=nR7cDOO/SmixfkYbIqWnTfAkyCCTLWaFBjwyUzpK+eHBa/PDfkXwtNAPiMmGL7YDap
         2zkRusGqO36nsz4sQYi2GJuw7uXIWWNuz6Zlm8kbewfk6LdxwML/sojSYC371Q+bi0S9
         OGzHyVTmHtA5drsVx31mEnBVamqrMvm/sCVMsOz3szfqNvVdddmLcTvHeOTNJxIwyXtE
         7Uq+NUajASLYcIFx+hcgOEokbp0xRggIz1A9Fx9T9vO6IlEdIQ2MQirPom9A6fc4fD49
         H9Kcy2IrO/MIMcxEtoi+LcJAy6/BEtGxODJMld9d84hHIe9lPzjUvVq5Nh2AI91e8sqk
         Lckg==
X-Gm-Message-State: AFuF++l3ZdNXJtHqmx/Pfg+57S+oYlASXDlF9dPreFzg9X2+Rio0eai0
	mHaR1fPoIksCItr3/b4DToqzXr2NJYwQCmbd4nokOhF9wK6dWXhnkF2+
X-Gm-Gg: AYBFou2+L8Bn6BcSFHEB7cKwJjYgaCo/+TZN5ZA0JXHOrj+yGmRmd3gbkJhvdkC/UA3
	wmcR1tDJNeUmYlg0DuKvw7fFdZqBIpuMFM2Lje/lUKpAsmoBq1f/tI43b3UDuTI0I82/dTum55Y
	5VZ02qL5Odql5NveIxQga4nu8V6ec+qro2SFhWwMMWEJHL+xAbYgTnBFdSaWpoD2OQ7SAuH8aIE
	gw13Z5HykrFuJphgovVHyNc7x5fiGj1yuSbXBJdUuKRSKz1UYdK2hvRwxV9a+K5Zy5ZuJdZuMx8
	VI3UvDcgsUYcZ1RsLH1UDHtzlSsuGA9plWGYRzHwqe0bOGuYky6ncY7dp69j4MsC8tTMAc3FZaE
	FJk0Mw6lzdD2X/S7zW4UPBR90MxO5MAEKZMjG64DXyFWILnMBqPHRxN1xP3jOwhqgHi36rQzKUK
	J7dfP8FL9uvuIF8ekfwR2Pa8GDrX9w56y9OQYynqmUDb6II654LrIAjlElpSKIIYcLZHgxieHu
X-Received: by 2002:a05:6000:4b11:b0:485:8313:9f47 with SMTP id ffacd0b85a97d-48587055d09mr53237162f8f.10.1788813251455;
        Mon, 07 Sep 2026 13:34:11 -0700 (PDT)
Received: from antoniarch ([78.212.37.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858e239862sm25959116f8f.9.2026.09.07.13.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:34:10 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v6 6/9] rtc: abx80x: use regmap instead of I2C specific API
Date: Mon,  7 Sep 2026 22:32:13 +0200
Message-ID: <20260907203216.53192-7-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907203216.53192-1-apokusinski01@gmail.com>
References: <20260907203216.53192-1-apokusinski01@gmail.com>
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
 drivers/rtc/rtc-abx80x.c | 393 +++++++++++++++++++++------------------
 2 files changed, 213 insertions(+), 181 deletions(-)

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
index 529f63e024f8..7b8e6546ccff 100644
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
 
@@ -227,10 +230,10 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	unsigned char buf[8];
-	int err, flags;
+	unsigned int flags;
+	int err;
 
 	if (tm->tm_year < 100)
 		return -EINVAL;
@@ -246,22 +249,22 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
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
 
@@ -270,16 +273,16 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 {
-	struct i2c_client *client = dev_id;
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct device *dev = dev_id;
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	struct rtc_device *rtc = priv->rtc;
-	unsigned int status_flags_clear;
-	int status;
+	unsigned int status, status_flags_clear;
+	int err;
 
 	guard(mutex)(&priv->lock);
 
-	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
-	if (status < 0)
+	err = regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
+	if (err < 0)
 		return IRQ_NONE;
 
 	if (status & ABX8XX_STATUS_AF)
@@ -290,13 +293,13 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 	 * reset kicks in.
 	 */
 	if (status & ABX8XX_STATUS_WDT)
-		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
+		dev_alert(dev, "watchdog timeout interrupt.\n");
 
 	status_flags_clear = status & (ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT);
 
 	if (status_flags_clear) {
-		i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
-					  ~status_flags_clear);
+		regmap_write(priv->regmap, ABX8XX_REG_STATUS,
+			     ~status_flags_clear);
 		return IRQ_HANDLED;
 	}
 
@@ -305,25 +308,24 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 
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
 	if (err < ARRAY_SIZE(buf))
 		return -EIO;
 
-	irq_mask = i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);
-	if (irq_mask < 0)
-		return irq_mask;
+	err = regmap_read(priv->regmap, ABX8XX_REG_IRQ, &irq_mask);
+	if (err < 0)
+		return err;
 
 	t->time.tm_sec = bcd2bin(buf[0] & 0x7F);
 	t->time.tm_min = bcd2bin(buf[1] & 0x7F);
@@ -340,8 +342,7 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = dev_get_drvdata(dev);
 	u8 alarm[6];
 	int err;
 
@@ -357,17 +358,16 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 
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
@@ -378,9 +378,9 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
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
@@ -390,9 +390,9 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 
 	guard(mutex)(&priv->lock);
 
-	flags = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
-	if (flags < 0)
-		return flags;
+	retval = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
+	if (retval < 0)
+		return retval;
 
 	if (autocalibration == 0) {
 		flags &= ~(ABX8XX_OSC_ACAL_512 | ABX8XX_OSC_ACAL_1024);
@@ -406,22 +406,23 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
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
@@ -472,9 +473,9 @@ static ssize_t oscillator_store(struct device *dev,
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
@@ -487,9 +488,9 @@ static ssize_t oscillator_store(struct device *dev,
 
 	guard(mutex)(&priv->lock);
 
-	flags =  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
-	if (flags < 0)
-		return flags;
+	retval = regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
+	if (retval < 0)
+		return retval;
 
 	if (rc_mode == 0)
 		flags &= ~(ABX8XX_OSC_OSEL);
@@ -497,10 +498,10 @@ static ssize_t oscillator_store(struct device *dev,
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
@@ -513,9 +514,8 @@ static ssize_t oscillator_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	int rc_mode = 0;
-	struct i2c_client *client = to_i2c_client(dev->parent);
 
-	rc_mode = abx80x_is_rc_mode(client);
+	rc_mode = abx80x_is_rc_mode(dev->parent);
 
 	if (rc_mode < 0) {
 		dev_err(dev, "Failed to read RTC oscillator selection\n");
@@ -543,33 +543,31 @@ static const struct attribute_group rtc_calib_attr_group = {
 
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
 
@@ -577,16 +575,15 @@ static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 
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
@@ -605,9 +602,9 @@ static const struct rtc_class_ops abx80x_rtc_ops = {
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
@@ -622,7 +619,7 @@ static int abx80x_dt_trickle_cfg(struct i2c_client *client)
 	} else if (!strcmp(diode, "schottky")) {
 		trickle_cfg |= ABX8XX_TRICKLE_SCHOTTKY_DIODE;
 	} else {
-		dev_dbg(&client->dev, "Invalid tc-diode value: %s\n", diode);
+		dev_dbg(dev, "Invalid tc-diode value: %s\n", diode);
 		return -EINVAL;
 	}
 
@@ -635,7 +632,7 @@ static int abx80x_dt_trickle_cfg(struct i2c_client *client)
 			break;
 
 	if (i == sizeof(trickle_resistors)) {
-		dev_dbg(&client->dev, "Invalid tc-resistor value: %u\n", tmp);
+		dev_dbg(dev, "Invalid tc-resistor value: %u\n", tmp);
 		return -EINVAL;
 	}
 
@@ -662,7 +659,7 @@ static int __abx80x_wdog_set_timeout(struct watchdog_device *wdog,
 	 * Writing any timeout to the WDT register resets the watchdog timer.
 	 * Writing 0 disables it.
 	 */
-	return i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_WDT, val);
+	return regmap_write(priv->regmap, ABX8XX_REG_WDT, val);
 }
 
 static int abx80x_wdog_set_timeout(struct watchdog_device *wdog,
@@ -707,9 +704,11 @@ static const struct watchdog_ops abx80x_wdog_ops = {
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
@@ -718,10 +717,10 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
 
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
@@ -733,33 +732,29 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
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
@@ -795,6 +790,38 @@ static int abx80x_setup_nvmem(struct abx80x_priv *priv)
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
@@ -812,9 +839,11 @@ MODULE_DEVICE_TABLE(i2c, abx80x_id);
 
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
@@ -826,8 +855,30 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -842,16 +893,14 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -865,15 +914,15 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -885,8 +934,8 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -896,11 +945,11 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -928,38 +977,20 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -969,24 +1000,24 @@ static int abx80x_probe(struct i2c_client *client)
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
@@ -995,9 +1026,9 @@ static int abx80x_probe(struct i2c_client *client)
 	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_OSC) < 0)
 		return -EIO;
 
-	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC,
-					data & ~(ABX8XX_OSC_ACIE |
-						 ABX8XX_OSC_OFIE));
+	err = regmap_write(regmap, ABX8XX_REG_OSC,
+			   data & ~(ABX8XX_OSC_ACIE |
+				    ABX8XX_OSC_OFIE));
 	if (err < 0) {
 		dev_err(&client->dev, "Unable to write Oscillator Control register\n");
 		return -EIO;
@@ -1009,7 +1040,7 @@ static int abx80x_probe(struct i2c_client *client)
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

