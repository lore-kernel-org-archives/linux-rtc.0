Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B2437450
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390814; cv=none; b=o+DbE+Z5ywtfW+BvWiZQX0eqI5lfTDPCx+tuuk4dZXKvqW/w81949KI98Px9Vu9P+fIc0wDNmNrJ7TzuhhilcQnjTTkgW2RY2B0Qa/It1G7fi8fcV6HLa1nDPwJwlnw/eIxfzSzAOmprOSpwqL2lio/7FQiAfcu9je7M/bAqS68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390814; c=relaxed/simple;
	bh=p25ogiM2Sa8dkypvVtSH6kxWkficJn5eIY7C0S2Bxg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLqFgyugaCAnzRFIHIlROZ/JkIsbvkPekpVuXQ6TnTtP0x8xjfZpAxDHOdupxRkGyv/M5tl4j2inNL8l4I3jRw+8hly6p0XeMLQrXe93gAi2k0imzMgXiSuAjXXIQ+KQP+mkDZg2dBTwfCyRS4xu0XBeJZ7xXCggk7BvvCfOCOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaAbUBiJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaAbUBiJ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48000c5d6d3so1011345f8f.1
        for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390806; x=1786995606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cJn7ePOsurTlt5ccE+gZ6P4uZZ4odFFp/lRiM7gv8dM=;
        b=YaAbUBiJ2QwKZR0xUqPtjo9HB3fSEIgI6VIU6yCbjFNGnx5Z056rB3Jdvnil8eZayN
         0yhqTfxhw51P5iescM/68oaDgrEE9YT9dN/GySm9mstKBRxkoQzeSsj+5Xfyy6zicPLG
         J1MbYcGn+sIP9veBhQVFlOznjkjqPu7qyRaju9C7ReDNzbdidAWoXPZQogy/OoksCpPb
         JRsy8LtdtPSOfvrEgKvbYK8kd2vxFLx1Bgf+ix2dbhwsK81dKKGGzPRrIjrnZ/KFmRRW
         ZLYz8WtFI9VwKO81tBLYRUoRbKD33XttOHnUCPI6145WUjr4AeLay4sr3R6F+dDoE7mB
         UEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390806; x=1786995606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cJn7ePOsurTlt5ccE+gZ6P4uZZ4odFFp/lRiM7gv8dM=;
        b=CG1FGxSxBw+uj3n5zQLP5cJwgPrdGKIUT1aiOFe0SHyLoqFycyRNZFVlam2MAIfbsS
         2F8JLGd2QBZKJ0D9FItqxPU3DrQp1qhPVGWBtFktaq9p70JuFadEgTM2IbDNIKg8s9HG
         efoU3NvGAdtGQC8Ji6ri54+D7wMWetPCatKF+MFxC3n2tkcssPyOfgJXm/PYTdMppNRF
         rFyZ9BUb4Y7mpu66pKXhllDKjHAV2MeNtEBOwJRCIk5ShZcIbpTpvSr2bYX0RFw9IIwY
         9YiBA4WivSsqfNjDAl4OZWOrbIfeVME2ZpeO2Q/urIxdwFLcLfWvNsdh9kS+ScxU/rcS
         BCIw==
X-Gm-Message-State: AOJu0YzRHnAnfftpsiRIpuY4LqBSSptbIaZrQ4Paq1dXXpySYzKahXvE
	mrHoTquA/iOtvIN7tQv8pJMLW8CfH1aNxUSuuyCUiGYZCYephQtZ0uLr
X-Gm-Gg: AR+sD12WcTaZrufO3ra+x/apQGDB1IL8DB5q5hd8q/ju9FupLF+wqwAw9tsaGtluki+
	dDtToIEp4hW+wvkBJrUiMhFJ8eeya1coEqHVTPAyAOZv2/Wv7eP8WaQKtDRC+Fp1c9GCItUqKd0
	UMVRloXKMrP/oGRB/ztsPKNNDqIDu+ShYAQArluAhtCYTKuoy79QQE1u/wNk6hlQ67QRZ0h7byC
	8TiMdxeqDI5OYmVRw1/Ko0y3xlpYmZ+IxsDNEZjBYGzWWYwLFIX8KCEEUGsWbqgktfMJ/PyDlQF
	qmsrMia/j6LrcM2lPEbQoi5K6VgZx6gIM750lsq8cbBztqOd8IWh8O/M/gWZge8EKA39eczAOns
	+ytbI+XBj3G0Qz31iHDDSbiAeacP7bYvbGNMCQB+646xPrYNi5/xLMwacVv/jxgsHJsh6o8m+dy
	IU3RTzUhnOF+Q/XQ5mvTkovX6b+dFqbnZM+crLQ4ktk7wi/faKonDo1Q1NUli3ixM=
X-Received: by 2002:a05:6000:608:b0:47f:9662:85fe with SMTP id ffacd0b85a97d-480026c8757mr35222263f8f.16.1786390806060;
        Mon, 10 Aug 2026 12:40:06 -0700 (PDT)
Received: from antoniarch ([78.213.94.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506cbsm39291689f8f.14.2026.08.10.12.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:05 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 3/9] rtc: abx80x: add mutex protection for register writes
Date: Mon, 10 Aug 2026 21:38:20 +0200
Message-ID: <20260810193826.210683-4-apokusinski01@gmail.com>
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

The ABX80X RTC driver performs multi-step register operations such as
NVMEM transfers or register writes preceded by a configuration key
write. Add a mutex to serialize all the register writes to protect
these sequences against race conditions.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 45 +++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index fdf9664ebb6f..0c8d3416fd5a 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -15,6 +15,7 @@
 #include <linux/i2c.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/rtc.h>
 #include <linux/watchdog.h>
@@ -127,6 +128,7 @@ struct abx80x_priv {
 	struct rtc_device *rtc;
 	struct i2c_client *client;
 	struct watchdog_device wdog;
+	struct mutex lock;
 };
 
 static int abx80x_write_config_key(struct i2c_client *client, u8 key)
@@ -219,6 +221,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags;
 
@@ -234,6 +237,8 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	buf[ABX8XX_REG_YR] = bin2bcd(tm->tm_year - 100);
 	buf[ABX8XX_REG_WD] = tm->tm_wday;
 
+	guard(mutex)(&priv->lock);
+
 	err = i2c_smbus_write_i2c_block_data(client, ABX8XX_REG_HTH,
 					     sizeof(buf), buf);
 	if (err < 0) {
@@ -263,6 +268,8 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 	struct rtc_device *rtc = priv->rtc;
 	int status;
 
+	guard(mutex)(&priv->lock);
+
 	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
 	if (status < 0)
 		return IRQ_NONE;
@@ -317,6 +324,7 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	u8 alarm[6];
 	int err;
 
@@ -330,6 +338,8 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	alarm[4] = bin2bcd(t->time.tm_mday);
 	alarm[5] = bin2bcd(t->time.tm_mon + 1);
 
+	guard(mutex)(&priv->lock);
+
 	err = i2c_smbus_write_i2c_block_data(client, ABX8XX_REG_AHTH,
 					     sizeof(alarm), alarm);
 	if (err < 0) {
@@ -352,6 +362,7 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 					  int autocalibration)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	int retval, flags = 0;
 
 	if ((autocalibration != 0) && (autocalibration != 1024) &&
@@ -360,6 +371,8 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 		return -EINVAL;
 	}
 
+	guard(mutex)(&priv->lock);
+
 	flags = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
 	if (flags < 0)
 		return flags;
@@ -443,6 +456,7 @@ static ssize_t oscillator_store(struct device *dev,
 				const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	int retval, flags, rc_mode = 0;
 
 	if (strncmp(buf, "rc", 2) == 0) {
@@ -454,6 +468,8 @@ static ssize_t oscillator_store(struct device *dev,
 		return -EINVAL;
 	}
 
+	guard(mutex)(&priv->lock);
+
 	flags =  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
 	if (flags < 0)
 		return flags;
@@ -511,8 +527,11 @@ static const struct attribute_group rtc_calib_attr_group = {
 static int abx80x_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	int err;
 
+	guard(mutex)(&priv->lock);
+
 	if (enabled)
 		err = i2c_smbus_write_byte_data(client, ABX8XX_REG_IRQ,
 						(ABX8XX_IRQ_IM_1_4 |
@@ -526,6 +545,7 @@ static int abx80x_alarm_irq_enable(struct device *dev, unsigned int enabled)
 static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	int status, tmp;
 
 	switch (cmd) {
@@ -539,16 +559,18 @@ static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 		return put_user(tmp, (unsigned int __user *)arg);
 
 	case RTC_VL_CLR:
-		status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
-		if (status < 0)
-			return status;
+		scoped_guard(mutex, &priv->lock) {
+			status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
+			if (status < 0)
+				return status;
 
-		status &= ~ABX8XX_STATUS_BLF;
+			status &= ~ABX8XX_STATUS_BLF;
 
-		tmp = i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
-						status);
-		if (tmp < 0)
-			return tmp;
+			tmp = i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
+							status);
+			if (tmp < 0)
+				return tmp;
+		}
 
 		return 0;
 
@@ -617,6 +639,8 @@ static int __abx80x_wdog_set_timeout(struct watchdog_device *wdog,
 	struct abx80x_priv *priv = watchdog_get_drvdata(wdog);
 	u8 val = ABX8XX_WDT_WDS | timeout_bits(timeout);
 
+	guard(mutex)(&priv->lock);
+
 	/*
 	 * Writing any timeout to the WDT register resets the watchdog timer.
 	 * Writing 0 disables it.
@@ -701,6 +725,8 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
 		len = min(lower + bytes, (size_t)ABX8XX_SRAM_WIN_SIZE) - lower;
 		len = min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
 
+		guard(mutex)(&priv->lock);
+
 		ret = i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
 						extram);
 		if (ret)
@@ -908,6 +934,9 @@ static int abx80x_probe(struct i2c_client *client)
 
 	priv->rtc->ops = &abx80x_rtc_ops;
 	priv->client = client;
+	err = devm_mutex_init(&client->dev, &priv->lock);
+	if (err)
+		return err;
 
 	i2c_set_clientdata(client, priv);
 
-- 
2.55.0

