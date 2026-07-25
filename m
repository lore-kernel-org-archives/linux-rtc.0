Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4081D3128A3
	for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991547; cv=none; b=T+HypyVqJCD7tXcRVCDB10JIAK9T7IL2wLwhRG2x1AaYPGePEkN1T8arTmsf0pRfXazUjJzj5487sQafQzVcmTdYjqdZ/Qjm16eoLTpHSXuYUglC3jblZyhdEZ0DsznxEnzblLTCHiXgWDaXJj58Y+uTcnsBe0BIe1s+V4b4u7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991547; c=relaxed/simple;
	bh=LyzLuowTE4prJ6Qfhg9ntGE5hRTmAYLWWwjc9OT9w1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFKMx29CvG9nhDQQxD2gKrVO8tXRdhtOw/wD/M/+tPdwNlrJSn86tYZiriRxr77IjSdaTT9IkPkq+Vo7sYd9grolhuWMscgFt+zf/LWXSgmQi9aYpZq2U33+GHlKbT9s8fWr01M3jL1vaJITS3ueEjMoCwt+YJnVXGTMl5Xahik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BusiSaMD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BusiSaMD"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4955158f26aso8841725e9.3
        for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784991544; x=1785596344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o3uCLNcwLCDLjMIlGid7kDRJH5CJ1Czd6gqweJK2Ges=;
        b=BusiSaMDYwC9F5Y0XAlhRDo7zLqL4EAEosQs/uJpdhUTJaVOHhmW6hc+9IjajdO0qF
         UtFD5Jxc5ZVK5/PD1iODrnUUh7kuOy3u2ajRTrZqkJuLK1r8Oxi3EIt/nt5WhN5bYlPL
         YBK8Yenmqv54J4K1JVT5CZ02MgAAj//AdcBGbJtjVSwbzYI96Kb5hTID13Ly4wK9YBPa
         dCx0rXzh0JLlADTJWG9sZGJqfELUqJ4iBCCEGM65WIgUvfvygynQjz9SQ8BoMEGED3Gg
         YSo4GiavDlriIqjui3GwsXDGNd+4WwRuOCwsSO+NHlFCst2HgG7HugDr8K49ISEELL3o
         y8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991544; x=1785596344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o3uCLNcwLCDLjMIlGid7kDRJH5CJ1Czd6gqweJK2Ges=;
        b=CQVNcUrG1XKaKAqri9gOUUTeRsEiqFWBhdpCQxJv68gKxqfpj5k8KN5q3vQeJRB/zW
         +c1osEsvxtJc2mgHL47y0zwM5sGZds8hkkzPAI4y899Yp12oP6nmJNP0H/izX1aTXDUd
         ZUAmjiTYKKqhnICCwABK2kgBkbvfgHsvYMrlrWpEYFb5DuBgWx0B0XdZIsQ2qAkIWIqs
         QtcT4JxYOD02L4f56mlJqFba8hW2r/wq/kJ/5uXguLLZLy9kFI0Vn4ry9SjAAbEyl2Qw
         4SqlZOLZHNFYFEZh8dYYlIhG0iShU6YtIli4IQH4e8I4WW+Ie54d6MZgfA8dSOfNCtLI
         4kMw==
X-Forwarded-Encrypted: i=1; AHgh+RpiTTEF7x+KD5zCai56QxhdJG4wQCX7j+LRmK+8jTiczPPAUVKDVjTUHc0pBWfoPyZha6LZTm3tZII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKBtOG6IuX0PYT4/5VTY4IvFdae2ugPcd61GMjx0/QgdQeHSb1
	LqOu9DtfkgSIgIztKoivqW1locr77prLqBLIDkbttvmEFoal+Vvz/r2a
X-Gm-Gg: AR+sD12iebfJsk2kNmdWKMyYLjkn8Yes80ClV6bznwIPsQ1HYzduR3yi/jEsZ9ZqCT8
	7XxP6ARKEfUZvV1ojWYbkKOJVpd5M35vuiYXfZaw4BX89u4zCE34km4f+qLyhQh7gyB3OmntxQ7
	+Upt/VBYEVJ4aeUeMr9fxiDWycVagjH+ml0epk2foAzmbBXEIqGIRIw5IcItKCOi7aismK8slbh
	042x8vSzgQvdj09x9VWh//3UnY77q9O71oX3EK0gbw9oTVMfbAbGhcr/VsM32SrEucMNBE3/FW2
	ryJbr17gXl8bUZT5wG9+bQ3KsBj1vTjKh7vkxRUVqkoXi5cwwCZsEE41Sj0dtttXUR9v7J4P5Nr
	wkUPBcc/sUtUJDIm5yUiSvdpw1/HhTGk0GLPDL5y0bIXix1bjlfVRTl3Fglypl1BDJBlRRq0WC7
	oFPQG4u1pTba4+
X-Received: by 2002:a05:600c:3b10:b0:495:3f26:97fb with SMTP id 5b1f17b1804b1-496b56bbd08mr29400865e9.3.1784991544347;
        Sat, 25 Jul 2026 07:59:04 -0700 (PDT)
Received: from antoniarch ([78.212.96.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f24a93sm79704435e9.11.2026.07.25.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:59:04 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: marex@denx.de,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 4/8] rtc: abx80x: add irq to struct abx80x_priv
Date: Sat, 25 Jul 2026 16:57:14 +0200
Message-ID: <20260725145718.14733-5-apokusinski01@gmail.com>
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

This way the irq number is not tied to the i2c_client and can be
easily accessed also in the case of ABX81X SPI clocks.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index fd9e887bb9c5..b83c789e213d 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -127,6 +127,7 @@ struct abx80x_priv {
 	struct rtc_device *rtc;
 	struct i2c_client *client;
 	struct watchdog_device wdog;
+	int irq;
 };
 
 static int abx80x_write_config_key(struct i2c_client *client, u8 key)
@@ -292,11 +293,12 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	unsigned char buf[7];
 
 	int irq_mask, err;
 
-	if (client->irq <= 0)
+	if (priv->irq <= 0)
 		return -EINVAL;
 
 	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
@@ -324,10 +326,11 @@ static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	u8 alarm[6];
 	int err;
 
-	if (client->irq <= 0)
+	if (priv->irq <= 0)
 		return -EINVAL;
 
 	alarm[0] = 0x0;
@@ -915,6 +918,7 @@ static int abx80x_probe(struct i2c_client *client)
 
 	priv->rtc->ops = &abx80x_rtc_ops;
 	priv->client = client;
+	priv->irq = client->irq;
 
 	i2c_set_clientdata(client, priv);
 
@@ -928,19 +932,19 @@ static int abx80x_probe(struct i2c_client *client)
 	if (err)
 		return err;
 
-	if (client->irq > 0) {
-		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
-		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+	if (priv->irq > 0) {
+		dev_info(&client->dev, "IRQ %d supplied\n", priv->irq);
+		err = devm_request_threaded_irq(&client->dev, priv->irq, NULL,
 						abx80x_handle_irq,
 						IRQF_SHARED | IRQF_ONESHOT,
 						"abx8xx",
 						client);
 		if (err) {
 			dev_err(&client->dev, "unable to request IRQ, alarms disabled\n");
-			client->irq = 0;
+			priv->irq = 0;
 		}
 	}
-	if (client->irq <= 0)
+	if (priv->irq <= 0)
 		clear_bit(RTC_FEATURE_ALARM, priv->rtc->features);
 
 	err = rtc_add_group(priv->rtc, &rtc_calib_attr_group);
-- 
2.55.0

