Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E052B1F6
	for <linux-rtc@vger.kernel.org>; Mon,  7 Sep 2026 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813250; cv=none; b=qXzu47ZEVh5Inq0bpD9k7/czwKdMHG+bDUdfK4ku49BWUveCW+At2WR+qk40IYxC2pAUFBvXQSwMO19ocSM0HyFSSjK40ndrDe4DhArVVTavhRtG2oEKteBzvCHaeEGkckHnyknK6EH05QSt8VY9ev+ckCOlmOIz7TqD5YLU0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813250; c=relaxed/simple;
	bh=mIOAFf4/mkVnKyy9Pr2ub9EN7il/hC4uxGNZV5cUVr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFBz/JbrI0EattB9GV38IW2BXcmnkiO5oPiPxZjcZEOieW/UE3yrNrvgZQZ8tzDs5HgsnFEAXf2vOpt2GOAvgzHiH/rxrK185iG2WbNs0BR7R7yUJFik66eKU/kkd7vuQqYdQ7Sdf3mP0HSW5q1bgbZUZ45BVNQrRRMExBo0lEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qs7iy5lw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qs7iy5lw"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4843f205a5bso2311705f8f.1
        for <linux-rtc@vger.kernel.org>; Mon, 07 Sep 2026 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788813247; x=1789418047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dxoel9GdpZ6JK+POFcZ8n3vlkVi/jnVPwLg6Nkmyd+g=;
        b=qs7iy5lwGkF553T4Xbt2ymedf/ASwK1aHXyGXzIlBYh9YaRob6pV75J9sahPPn4bFb
         bOqT7R5GPbf77N3ejFVdjU5smcR+edDcaxcYvkVXmjmbNWMVsmiCO/G0Bw7bEYqP+LKA
         Yrx/jB88PRmDhZAJ7xMBJpYPN7B4zF4BO0n2AxoeTr3+xDHuvEFCS/27SZYd3nZu6DXd
         DnGMTgvH7SjHbi8D9cXxQKLGRk1XIHssGumr5K+KU5i+8p8UTp4EuTnMzL9kJW0TUsGa
         +KcEI6oC6hmSuoVWYP+CMl13DfZnCRwU7zBkdKrJySl5nJ6/aTGk+B1cXMFzP1gt3kfU
         CtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813247; x=1789418047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dxoel9GdpZ6JK+POFcZ8n3vlkVi/jnVPwLg6Nkmyd+g=;
        b=Qkl0OEAs7aQaVRHPytvLyDZqD3+hWdYyBbsJxOulxa2UZgf+X0KvuNJpR8Y5StjYKD
         z7cF7x9d1/y/P+/9+mbbOUHn9LVrlYzrpHAqwQI2xfZjCpmwczlENtmx/A3pdYIvCTyO
         XFWbga/Q9Pcae0lIVTR+bRP4EA+oLSTh4e+iRjL4fGQZRmRZ/L5eaQ60tFZiHmyIv5Vd
         718rWrZjv/VKiwNOgXYSNUkrhkhMn3lH2G17doudK/CtvIF4gX05wWOthb2zjpmUD5uP
         goUhEfGKo6AVq3Z37qJUFg8+PB1+UbXCaTc1JTzfX8eQB0KpCxg9WVR0BGLGkTKB6hlD
         8YaQ==
X-Gm-Message-State: AFuF++ntNPxszNNbhUsBDOPTdUKJcUAW+MQktDdVt6RuXm3M6IYho1DA
	5s2VSTpsDcc/N1kZmDolLfLzSL9CJ3S9gSHRrAFFfk4hegk+Ac/CIXk/
X-Gm-Gg: AYBFou26DLqaPml45VBb/5zDRrupKhbqLynfqgaYNEdHft9tBtmJGjU0NsEW2uSkfsh
	6/i+vX0/OEySgBgB65Btlq3bHpRLQX+qSexccWzjbWhnZ41vOuuveVbx1cjysNFJphGMs8ylkvU
	A7bJdC1yJu7FWZWRzbiZ+arKtnNNtV0xhextf93kjLD4oA45xcKQqbt+RkbHUHwGQqEarRTYJ6L
	C1npWS3I8I7wpTUxhF31cb0DbcSKjQnRx+KzyHhWdXCl3NDlxwTVZv6B9vxhRYu4xzR0Yat4QqF
	Iz3WFTokKKxhRudBKR7ncqIatRUWkbHNdg1pKSMevTcihXEMzfew2zrjEIEgj6ru5fo22F51tsM
	waikw7yyv5VQM98grXAHSuDVHAdeQAjOhYVmXDPnnRamwFvUMsuvxztziP2Xaslja/NYiS02uJG
	HkkIpF/k/2MTRMsM+IRaXBIyXhVZWIoyZn1EvMUEoYbdv/jwJKPLmYKiMgyDI4PQ==
X-Received: by 2002:adf:e19b:0:b0:485:a410:63fd with SMTP id ffacd0b85a97d-485a410656cmr1433024f8f.35.1788813246552;
        Mon, 07 Sep 2026 13:34:06 -0700 (PDT)
Received: from antoniarch ([78.212.37.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858e239862sm25959116f8f.9.2026.09.07.13.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:34:05 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v6 3/9] rtc: abx80x: add mutex protection for register writes
Date: Mon,  7 Sep 2026 22:32:10 +0200
Message-ID: <20260907203216.53192-4-apokusinski01@gmail.com>
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

The ABX80X RTC driver performs multi-step register operations such as
NVMEM transfers or register writes preceded by a configuration key
write. Add a mutex to serialize all the register writes to protect
these sequences against race conditions.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 45 +++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index e4fd7b5d4b11..44de234efecf 100644
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
@@ -319,6 +326,7 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	u8 alarm[6];
 	int err;
 
@@ -332,6 +340,8 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	alarm[4] = bin2bcd(t->time.tm_mday);
 	alarm[5] = bin2bcd(t->time.tm_mon + 1);
 
+	guard(mutex)(&priv->lock);
+
 	err = i2c_smbus_write_i2c_block_data(client, ABX8XX_REG_AHTH,
 					     sizeof(alarm), alarm);
 	if (err < 0) {
@@ -354,6 +364,7 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 					  int autocalibration)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	int retval, flags = 0;
 
 	if ((autocalibration != 0) && (autocalibration != 1024) &&
@@ -362,6 +373,8 @@ static int abx80x_rtc_set_autocalibration(struct device *dev,
 		return -EINVAL;
 	}
 
+	guard(mutex)(&priv->lock);
+
 	flags = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
 	if (flags < 0)
 		return flags;
@@ -445,6 +458,7 @@ static ssize_t oscillator_store(struct device *dev,
 				const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	int retval, flags, rc_mode = 0;
 
 	if (strncmp(buf, "rc", 2) == 0) {
@@ -456,6 +470,8 @@ static ssize_t oscillator_store(struct device *dev,
 		return -EINVAL;
 	}
 
+	guard(mutex)(&priv->lock);
+
 	flags =  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
 	if (flags < 0)
 		return flags;
@@ -513,8 +529,11 @@ static const struct attribute_group rtc_calib_attr_group = {
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
@@ -528,6 +547,7 @@ static int abx80x_alarm_irq_enable(struct device *dev, unsigned int enabled)
 static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	int status, tmp;
 
 	switch (cmd) {
@@ -541,16 +561,18 @@ static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
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
 
@@ -619,6 +641,8 @@ static int __abx80x_wdog_set_timeout(struct watchdog_device *wdog,
 	struct abx80x_priv *priv = watchdog_get_drvdata(wdog);
 	u8 val = ABX8XX_WDT_WDS | timeout_bits(timeout);
 
+	guard(mutex)(&priv->lock);
+
 	/*
 	 * Writing any timeout to the WDT register resets the watchdog timer.
 	 * Writing 0 disables it.
@@ -703,6 +727,8 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
 		len = min(lower + bytes, (size_t)ABX8XX_SRAM_WIN_SIZE) - lower;
 		len = min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
 
+		guard(mutex)(&priv->lock);
+
 		ret = i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
 						extram);
 		if (ret)
@@ -910,6 +936,9 @@ static int abx80x_probe(struct i2c_client *client)
 
 	priv->rtc->ops = &abx80x_rtc_ops;
 	priv->client = client;
+	err = devm_mutex_init(&client->dev, &priv->lock);
+	if (err)
+		return err;
 
 	i2c_set_clientdata(client, priv);
 
-- 
2.55.0

