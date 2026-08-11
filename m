Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4B4779BE
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477348; cv=none; b=jAbPaZrfgbaxpKn6wbt4P75D/2Y7QGAImnh+EQvpB9SUn35b1CBhhmOuxgGVJ3vqBFQdw5Q+JS+PdW9rV3jvhnTZewWbGajD6wvnVv4kFtPvM7fUVC7aHdSuD6nSb2CN/WRMJETJMO1eDY7NwhWcZqocFSbnovOMthuXruwFd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477348; c=relaxed/simple;
	bh=s1E975qyDx/aoC3utss4boTjVjGr6XZHFUjkKJJOiyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzmPJ6aFpND7Cy3J9mEFtvzZliOenhubrBhvzTtuOAYFyaZ3385NkZ7X1G4nScBiQEKqxychNmunPaCIEn5MPuC7XN6WQs1RWHCr+krHgXyYti3jPth1zjGdSfO8xUqmLApEaQvLVF9owCKvm9+WcqHpInfa1d9SEM2TMY0ioSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dab1Ym6E; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dab1Ym6E"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b966dd74so1015825e9.3
        for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786477343; x=1787082143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VJQY9PyWbhU7AG4wbSarfgz43hrJhg7RLYse0peNSa4=;
        b=Dab1Ym6E+uHZ9YI1Pxfh4O21qdAHDcDGEWKeFTPWMgiJ972sEPJ31KRlG8T885C3Di
         uP6RKrazVgBPY8b4xCd2Eays9PCmM63suzArUvPJxziiHqpYG+JGmTePMdX9a1SXsTDC
         ejop90ke3VoDUvqwcH0Nr2DFOFDSXO7JAjqt3iqzEjnW6lAG4HacdI8bP2Yl56OM3LDi
         0pokgPdX9770LgqVTPmI4CkcXyXNzKFg0i8di9BjvqSMBefssqE4zQrVkE33RxDzbii+
         0mZylETU7lu+Lnu9Rwyo4+iWc5uMKFcY9Xee4lUcx0skf1u8586rCRkfqfkoTGOK7DQn
         /YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786477343; x=1787082143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VJQY9PyWbhU7AG4wbSarfgz43hrJhg7RLYse0peNSa4=;
        b=ItGCuuJlwlidr29t4ccTy7uej+IH7m/ZxHP47ZNeLJteiw3yDON/NW2MuPPQeqB7jH
         92WqRHtSP9z+Vz4aYKZsYzT1NziW51gF463ZfkRvJbAYBnUAHsZzVGCGDW+laScUWW1o
         LbGjtEyWC2LsRRhk+xTtvjDY6qvMTZcHWnDBXktD1ERLmY5A1M8fpPdVn+lf5NbK7/b2
         aLQ0gBWG/ChpNrfpC6zqke6XCPTVs5OG6KqSlhJm/455/C+T9CEQ3qMnSyyAgBHV837F
         ZnF1blLq25HC9/9zCRmTNKn42TgGhxBcwcLkVmgwvxPB9R6lMlmvjkgrIby8JDrWvsez
         KkhA==
X-Gm-Message-State: AOJu0Yxs6Dh97BRauJdMic0+1pSrGCwCt07pvMd1o+I46bXL+0tDGrVi
	cLg1GXhw7bnC7sdsSVemTYxyQidC4OTVGqHzz0/VPz1bx1FdjmJ06DJ0
X-Gm-Gg: AR+sD10j+/DKMYEddwpHY65Km3YNxp0TNTQfzaviCOU63lNccCZXJqBBMEiOE9ocmzj
	EkT4MRpLQ5epv2UxsbBPOTfpCxmKZXCc5zUTOVBPY9ZNUGxfmCsK8ePxOCWxDfUzjfFfhXmE84O
	KNzD07Ho1Q4OXab3syiWqxLBtt6jcgZ4yARaVSHiPR/xtx0FpQeaHT4GVpahoUvOc9eKCJzrgF2
	gnHsaEnRNmxilupITagn2BTfjp2EambHuC1pEBoPArE6Y5AsNfKJilz11N5tkcPTsdQCxPedmCQ
	b8Tb7gwhpOzrBPRKTj5W2j8cSh+jWWxU+vf2yezG6fHfJJa1BjEpzcPK1Wf5jqbo1YymA0YAKgu
	Ye0mCmZ4/js9lbGQ9A8020MtuMT8O6PumdGDnlvOIG7da+FIY3npAMME337EZJnOgBUSxrCRdfW
	aOg+6el18e8UKbTkC+Rc0wQSToWp9GG6h2PGNnY8JdEmITMC6LAvPR/PiKE6mUY2G0
X-Received: by 2002:a05:600c:34c3:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-49978465fbcmr99538485e9.13.1786477343119;
        Tue, 11 Aug 2026 12:42:23 -0700 (PDT)
Received: from antoniarch ([78.213.143.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b22784fsm2606535e9.2.2026.08.11.12.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:42:22 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v5 4/9] rtc: abx80x: properly handle shared IRQs
Date: Tue, 11 Aug 2026 21:40:29 +0200
Message-ID: <20260811194034.28937-5-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811194034.28937-1-apokusinski01@gmail.com>
References: <20260811194034.28937-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The abx80x RTC driver registers its interrupt handler with IRQF_SHARED,
but the handler always returned IRQ_HANDLED and cleared the status
register even when no interrupt source from the RTC was active.

This could cause the driver to claim interrupts belonging to other
devices sharing the same IRQ line and could also clear unrelated status
bits in the RTC status register.

Only handle the interrupt when the alarm or watchdog flags are set, and
clear only those interrupt status bits that were handled. Return
IRQ_NONE when the interrupt was not generated by the RTC.

Fixes: 718a820a303c ("rtc: abx80x: add alarm support")
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/rtc-abx80x.c | 54 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 0c8d3416fd5a..485d1ea08030 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -51,12 +51,18 @@
 #define ABX8XX_CTRL2_RSVD	BIT(5)
 
 #define ABX8XX_REG_IRQ		0x12
+#define ABX8XX_IRQ_EX1E		BIT(0)
+#define ABX8XX_IRQ_EX2E		BIT(1)
 #define ABX8XX_IRQ_AIE		BIT(2)
+#define ABX8XX_IRQ_TIE		BIT(3)
+#define ABX8XX_IRQ_BLIE		BIT(4)
 #define ABX8XX_IRQ_IM_1_4	(0x3 << 5)
 
 #define ABX8XX_REG_CD_TIMER_CTL	0x18
 
 #define ABX8XX_REG_OSC		0x1c
+#define ABX8XX_OSC_ACIE		BIT(0)
+#define ABX8XX_OSC_OFIE		BIT(1)
 #define ABX8XX_OSC_FOS		BIT(3)
 #define ABX8XX_OSC_BOS		BIT(4)
 #define ABX8XX_OSC_ACAL_512	BIT(5)
@@ -266,27 +272,34 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 	struct i2c_client *client = dev_id;
 	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	struct rtc_device *rtc = priv->rtc;
+	irqreturn_t handled = IRQ_NONE;
 	int status;
 
 	guard(mutex)(&priv->lock);
 
 	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
 	if (status < 0)
-		return IRQ_NONE;
+		return handled;
 
-	if (status & ABX8XX_STATUS_AF)
+	if (status & ABX8XX_STATUS_AF) {
 		rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
+		handled = IRQ_HANDLED;
+	}
 
 	/*
 	 * It is unclear if we'll get an interrupt before the external
 	 * reset kicks in.
 	 */
-	if (status & ABX8XX_STATUS_WDT)
+	if (status & ABX8XX_STATUS_WDT) {
 		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
+		handled = IRQ_HANDLED;
+	}
 
-	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
+	if (handled == IRQ_HANDLED)
+		i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
+					  status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));
 
-	return IRQ_HANDLED;
+	return handled;
 }
 
 static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
@@ -950,6 +963,37 @@ static int abx80x_probe(struct i2c_client *client)
 	if (err)
 		return err;
 
+	/* Disable unused interrupts */
+	data = i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);
+	if (data < 0) {
+		dev_err(&client->dev, "Unable to read irq register\n");
+		return -EIO;
+	}
+
+	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_IRQ,
+					data & ~(ABX8XX_IRQ_EX1E |
+						 ABX8XX_IRQ_EX2E |
+						 ABX8XX_IRQ_TIE |
+						 ABX8XX_IRQ_BLIE));
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write irq register\n");
+		return -EIO;
+	}
+
+	data = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
+	if (data < 0) {
+		dev_err(&client->dev, "Unable to read Oscillator Control register\n");
+		return -EIO;
+	}
+
+	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC,
+					data & ~(ABX8XX_OSC_ACIE |
+						 ABX8XX_OSC_OFIE));
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write Oscillator Control register\n");
+		return -EIO;
+	}
+
 	if (client->irq > 0) {
 		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
 		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-- 
2.55.0

