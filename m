Received: from mail-wr2-f24.google.com (mail-wr2-f24.google.com [74.125.225.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB154E1C9C
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592039; cv=none; b=dcrhhlEJv2P72fBizZsJssQavcRk1SRkHg91R1U8HfxgRdgqO0Qf3ZGrskCpaNENLuxf7AMw9xGP7IxE/hFXcCRDRa2y50B1fm0QoWgoglOLSa9fNBYo479HKQC6yMpsIQUEeLb6AsXp4rdpcUPjazhg3ic4Yr553Tkm5bFvMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592039; c=relaxed/simple;
	bh=+fuIrmtzR6ldoVb6Om5t2rG3lzQj67cX476aa8hApRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cs0u08g70Nu0R6vD8/0IDzSMb11h7pL1sl/9Ev2D4kiPjqS1VL+GCc7cHj7lRrP/zaKiqPIk6pmv6dHjiGSkdQIqOsT5dLdojjYAtyGQK+M/Yh0wv0eIg1n7Vhf1Vx5SbKg6gJTbQVf7t9QyYCZEB9w9rDuG9ELzTLllU9aGVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRJFK68V; arc=none smtp.client-ip=74.125.225.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRJFK68V"
Received: by mail-wr2-f24.google.com with SMTP id ffacd0b85a97d-482f63546c3so119643f8f.1
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789592015; x=1790196815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AAunmvXAHLcWGYzBYZe3R5JhEjHYwRPNQssUB8ElOec=;
        b=RRJFK68Vp8klJ2CEhgJrtL07qPCAYF9YreqpUN+pBri0kSI+s5uY1HB9MBSFsUvvMW
         oYjMupJNZnoh+FVCrBnhZw8GRCzxr6Qf94BZ/PF998CHOKPYJOH/D1S16YYfst8S4cl+
         IT72tbW9OwMcZ9Fmy9y/LZGHpOOOm+EP1yhmZgI5haI2Wbqj+SD+fI99i5+r1ZNhrZ5C
         ycAHw4AiSoI6I9Xx4fzQzpaj7yobMrNk2ViUZqN31azBpKYhrYa/JLmZRNoIipvDO3BS
         fo90WN6Jw0yNXb6E8JqxKjdi3wkC6g+9nw/syiOOEv1UsZ31+iIoXq4LLh+5Uc5k79Yk
         9ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789592015; x=1790196815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AAunmvXAHLcWGYzBYZe3R5JhEjHYwRPNQssUB8ElOec=;
        b=R6CtaHQ5y7YhoXrG4KynboGPHY1cUhA7gmk+PoIcFqiCsg5xjaplqgxA3vq1lTytsq
         YQdOYYW8sV+xOKMRlbDaAR+2If8xz5WakuF6EjjLKQi1VgLBCeiuO8n9oWeoIa7MF439
         vQPrGBKJwAbfw2X/I9Adbr0XpWjxvFNWYGklemOTfoIJQ6YK+El0fm1yMgQxNLGPE4G3
         sBI/mWGVyzF7ZEzLfy2Ms+hUMATx2PyH0gLzdQy2qlfzHHjBNW7As1UG+x+nh0TJ45Ei
         vZkk03H5EOwZs8wbAhx7ZW9erLU1FSaI/p8BbOIdAXQQtEwScUGFbLda5/Kf5zsathD3
         efHg==
X-Gm-Message-State: AFuF++liQG3JXHwki2uQz/Nroyrbf59y6g2rxDUBJTN4fAEcGzAFhdVA
	EUjEnk3PuHtx4rUWrny/L6NrQwDlvEHrte0HzXnbXHUwuQeyjLBDxx+WAJGpK9JS
X-Gm-Gg: AYBFou3QEu5BS4sSoTS4Tg5llUs9fe7M3vpP/FBPKtIyoa2HOgVG5Sog7yzoA4zAfVg
	1V8+8NPBC51dEy0PHfW7rkfeF7OQxYH42iAPpzUpepCFf4/5stoFFDr0eyLiNCHhlEJ7fQZW4Gw
	0my9Lip3htWCZiOWEnxSC0CJKRFE58cjdP0KWHo+Sq8xdt8zPZgXT/UH77sYgteP3rc7WRKSaOz
	NiIAhqkrJlLwvc3/5TkBqoqH9IwawYUNxQP0PEWD7SL3VvDCY954501w1z9spy3ikF67egHAk6w
	4uP8CGWA8ZO8tgNpQjH4poYIvJBOHMDDMssBONtWoLteeX3MyNc3yNyTAALqe7Z44cI/Z9BoGH5
	8YCSI+71eisLlZwyJwQCz1+ZUKZExvoHEASPfN/tMM+OpnW5JcPvu5ZhI4Vkoqr+V8sTLtIAPgL
	b/Qg/BnhPWGBC1hkkOyO1zlZhCoDKLQqX6IlhKBppdyTwhhD7r/fG3bmST7AtjKsl/Uo2k9w==
X-Received: by 2002:a05:6000:41cc:b0:487:b4a:3f54 with SMTP id ffacd0b85a97d-4870d16b4fbmr5439006f8f.29.1789592014822;
        Wed, 16 Sep 2026 13:53:34 -0700 (PDT)
Received: from antoniarch ([78.210.41.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7678sm11086166f8f.2.2026.09.16.13.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 13:53:34 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v7 5/9] rtc: abx80x: add irq to struct abx80x_priv
Date: Wed, 16 Sep 2026 22:51:34 +0200
Message-ID: <20260916205138.16771-6-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916205138.16771-1-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
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
 drivers/rtc/rtc-abx80x.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 2fd0079b7c51..91844c0d9063 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -135,6 +135,7 @@ struct abx80x_priv {
 	struct i2c_client *client;
 	struct watchdog_device wdog;
 	struct mutex lock;
+	int irq;
 };
 
 static int abx80x_write_config_key(struct i2c_client *client, u8 key)
@@ -305,11 +306,12 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
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
@@ -343,7 +345,7 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	u8 alarm[6];
 	int err;
 
-	if (client->irq <= 0)
+	if (priv->irq <= 0)
 		return -EINVAL;
 
 	alarm[0] = 0x0;
@@ -949,6 +951,7 @@ static int abx80x_probe(struct i2c_client *client)
 
 	priv->rtc->ops = &abx80x_rtc_ops;
 	priv->client = client;
+	priv->irq = client->irq;
 	err = devm_mutex_init(&client->dev, &priv->lock);
 	if (err)
 		return err;
@@ -1000,19 +1003,19 @@ static int abx80x_probe(struct i2c_client *client)
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

