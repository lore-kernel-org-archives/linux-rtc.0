Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEEE43F4C7
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390817; cv=none; b=YGzZZvw5mX9Es7BcPVW7L58WgyFQrPPjWjIBk+2Fzdw/mzx7TS9O6HEgYm+0LC6wz0c4dkrCi8CzAUkIeP1l9mZG1vruNasyqTLPR1Sn4YC+QolJUnH+e2Y+FvbvBeUyohN7Zgn/+kW560aE59Xainxb9c0d2HrMBTLPDin94Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390817; c=relaxed/simple;
	bh=08UtlehfK03KUSQwevWJqiUxLKsv8IURriGU2uZB4o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oak64pnLu5aWeOmWZxa/NuAoZOhnIb9l5APbHtbJXPSZyYdKAgwtH/UyxbKrI0/QHiLtjb8o2XeMmiUKgAkedjrIKRK8701LM4qo1dafGTQC0cqHFJpQWLWQu6sng7y4V6i1LZVuGyketepbFkBZPAwZrgkPg5q70QX8eg7wKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQK58+xt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQK58+xt"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-480001972b8so894529f8f.2
        for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390809; x=1786995609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yFhi9f2vBNbbKbsB00RQsZsEKX9ezsH2FMVXNlaSZW0=;
        b=pQK58+xtN8eLJbFkYRVM3lKUfL+OHC5eLpP9fLBoYWpTfQUXbZ7Kgv8RUGPSYNPQJM
         EP/EMryHMrIrLoo6bQSNmi4StUMVyD3rTml80e3x9iyiWs/1/uqr4xwbEEQsRfnyGWbC
         NGB+CDC8L69OH/tqtDWSnfUo8Vk7VgOJAxWmU1Yn5685/wYue/MfFjbaL7Sfa+LQK8n0
         sqL1yMNPxTQ08QBHZ8m+WJDurdeK4R6uYNC11daVlrRSTKsrTv8pExjuypxPm32OIlWU
         SG3P6Me7YIFRBRzDxwNaeJyQ4JzFndUws6EfPjP1W+oF9fvv1XCnIXLeId4I3Ujf3mAl
         7JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390809; x=1786995609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yFhi9f2vBNbbKbsB00RQsZsEKX9ezsH2FMVXNlaSZW0=;
        b=UEeGY7xlmin1gKWhIcEviKqgd+gpAWES8Gr2Tk2dtOOK+VMWX4KJKZsye1iWKs3WEE
         bwJtQEbRQ26sOlBcV+ZiprYJxQYstNT5IwxQmRwsRxd0DhS5fHbzWhI/Hqz23FO/fOiD
         wsULWUuBYHSTO7ufep5aS95jK0ugrULNWvl+wCuCEEEr1ET7rFZXrXpEfvOK9U4hlbRL
         m1sJSXtUNPZkMfWX+CzLgOA0vQgoIw4U38AY2ix+Z3NGAcVaMPahFERJSL0vfdFgPvAk
         ehLzr9r2Igz/pUHAqf836z5Kcn0zd6JK4hMwGPAEwsAAWGus3ONaMiZ4z9TrJI2fU/RF
         6C8Q==
X-Gm-Message-State: AOJu0YzHOLvs2cXFjSI8On0VS2jMRM/bHDFMqAF0kFgCgrWLEyDrliXZ
	0CHAOcSib1ptzocUJncOOQEmWOg4TEioILfYWDQ7B4bmTSrmVyikvsTG
X-Gm-Gg: AR+sD12RVW9saLL/uP31TgR5ns2W5VlGt9TpvoDEq6saXJRVXOLQSGVjQmblHXNUcOZ
	3zTrUDTuS8uGAEdvxky7SoqztSkMgY5DjoPGUOmMfH8L9IjijJPv0zpyfy0U7aBGUAwng3JrmtN
	pFc9t2R2Ad0Z41uS3JO7F2glm5kurJDQzK8Ox+FzV0AwkDFURuMbmz1To7PlrNRLJeyJYhItFkX
	E0UEPULn4XdJTBqnzKvI3aVzVLIZchSg8TA4S4WFRn0ZCj4HXS9M/cIgkgyjXdm0R62XbH0tHxK
	MNRp/eJ5/PiVtLoSMImC17+vojSAl3GKedtjRqiQ/LrLGWdXLYeyzT/phbNeK+4vQRfJKWAb1rE
	+yVIRcuOqcV+qD/x9ikJdTs41i757ZIIhjbpdpwcBV0ft8JSn/wgbltyHL+x7iJQhEIxXkfhiXf
	RTurAElMyiwLpkJtdryVAy3/p3xcLIkQvR881bQtShzmUopHKBzAe7TcU4R1yYklk=
X-Received: by 2002:a05:6000:41f7:b0:47f:95ce:6f48 with SMTP id ffacd0b85a97d-481455df5afmr6870669f8f.11.1786390809120;
        Mon, 10 Aug 2026 12:40:09 -0700 (PDT)
Received: from antoniarch ([78.213.94.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506cbsm39291689f8f.14.2026.08.10.12.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:08 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 5/9] rtc: abx80x: add irq to struct abx80x_priv
Date: Mon, 10 Aug 2026 21:38:22 +0200
Message-ID: <20260810193826.210683-6-apokusinski01@gmail.com>
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

This way the irq number is not tied to the i2c_client and can be
easily accessed also in the case of ABX81X SPI clocks.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 485d1ea08030..12a4dbfec639 100644
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
@@ -341,7 +343,7 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	u8 alarm[6];
 	int err;
 
-	if (client->irq <= 0)
+	if (priv->irq <= 0)
 		return -EINVAL;
 
 	alarm[0] = 0x0;
@@ -947,6 +949,7 @@ static int abx80x_probe(struct i2c_client *client)
 
 	priv->rtc->ops = &abx80x_rtc_ops;
 	priv->client = client;
+	priv->irq = client->irq;
 	err = devm_mutex_init(&client->dev, &priv->lock);
 	if (err)
 		return err;
@@ -994,19 +997,19 @@ static int abx80x_probe(struct i2c_client *client)
 		return -EIO;
 	}
 
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

