Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D1442396
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390818; cv=none; b=jTbvDjlmhnQKHSbHQI5Bh+mQbkyKh1ZXfEuiMLxnwgg1JZFFsVtDkyDX8+jCTbp82Xli9P0gqz6yhOzTors258nm/dAYip1zGtA/JdefcXixJhABWZDSExUY4bN00OtXMG9DZeieTjKLoz8fEKK8jPSj0TZAkzTOv7Co45mrkuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390818; c=relaxed/simple;
	bh=s1E975qyDx/aoC3utss4boTjVjGr6XZHFUjkKJJOiyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZ4buDWrbiSV9P6mFTsKHFuo9dDIRysdfg3FCLQlDXBp53wzOacbjHRV33GldYQdHOUNfNEr4ALbE7G298ZG1s8jtP0Elz5FF4J7PXVCo3o631r5R6WXEmqQ3+eIceiyD5gl7tZCddnLbSZoKFf2OynyV29Z3uxCbUAtPbvjTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kui1bmqn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kui1bmqn"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f904e80eeso1832806f8f.1
        for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 12:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390808; x=1786995608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VJQY9PyWbhU7AG4wbSarfgz43hrJhg7RLYse0peNSa4=;
        b=kui1bmqnakamcvL9PFKLr8RaSFGDUAQ7jCMW2QEg2iCMhVRjT0MQZfby+h5Qb6DuMx
         b/bqVnO9mM0IbqjqZUzLUKSTVlUzX+EPKgE0AraPO+bn9YGmQfcUnp5iR1Ogs6m5PjlW
         zi6+iOYqCRAHMz7cQrREgyPUysu+BFrC5XapKqXSppp2SQMwyo0BSP4dMS0ksUWxOjyq
         7NTAEeLiyAP/hUM4txggbAVIGzhhMhyMlbDuvPhFY66AxHl7HDUIH6qRwK927RyLEIgB
         k1nC9IlJxyyXMnO39wkc5bXFtEFkk8ddQzhjYwAbcli1Fcy+akppeNAVn53sF1rfjo92
         cpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390808; x=1786995608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VJQY9PyWbhU7AG4wbSarfgz43hrJhg7RLYse0peNSa4=;
        b=Eo379CRD5RcQH0UFsffjn8I1DbLvvTR/6/pFbaY5sZDY0N1h3XQWtwoE6jerqeCMNg
         RUcqymVo/QXu50yL+/DLf5d/ei79I75puESeIJ5dRgncnJ6BhUBZaVOv44hdxsIrAY2L
         qQRq4VJioA6WdFZBXD00zpQqJXb3JBCM/xSB+tiAaY8QW2IwrynbdRXhNB/P8vP8EvMS
         aZZVLNr3ljaco12Gbmr+P6JFDa4MZyoKax6xhE1bCnyZ+61HhBatO+Kxd7U8bxHcGEGL
         y99Bfe6vl+SzLoSe0xZOZH/Rz2oKVkut4Zqm1eqmeQ7MAq/H1EagqQESNoLfppGb8kwU
         ZNnw==
X-Gm-Message-State: AOJu0YxJTLr7mzyWBHh5TFVaZLuH5vWT6XfMXRMdF3GFlm8mc2X0aA7f
	kkxkUzx+eM7LymDJczE43YzXp8ETxecChEVy7WkQuurs30ZevY6791Cr
X-Gm-Gg: AR+sD131RgLMHHRIBNd9OxRZTgqB6IE+u0lKN+clBrm36m/vM0typwDdwOnqMNl2Tmp
	oS6HDiGk+hiQxBmIGNeckJO14RBGeyVSl3gykiyMwS6V8/63N/FDe8bi1VlbnbYOFtCZv1i4blP
	Bo5ot9OY7rIEW8x3kcPij7jkoXFI/RXcBqdU7xQ8dT07jkmKmhNgbaYhZYfzAis+yobu/yBQllh
	wQHDOfQ2MEvb/LuJRafF0lBLTpPcU6OqvM75/tRRGbfWRL8k9typIyxH/AHtUcNopuXWa3FpEM8
	HOWwxZjWiChvLi14S46qy13GkZekeKGwFOrYQkJlfASW1dNAL4AVMTWZ4McJlC4xypWM4pdDifm
	MDVJTww/uGn+5BhLCubvUEB59kHxRO/9NtDIPE9K4fCKxkzLmj2hRjuB+JIprCuOuVqInjKpVme
	h7NJdSxq1IHcYjSYAePW3mOwVR7iihZT0KpyYx5vtpjVf6uVKLWNvKbf/cV8YEii/6LEK5gwhO2
	Q==
X-Received: by 2002:a5d:588c:0:b0:47f:eca7:ad1a with SMTP id ffacd0b85a97d-47feca7ad3fmr71195460f8f.1.1786390807559;
        Mon, 10 Aug 2026 12:40:07 -0700 (PDT)
Received: from antoniarch ([78.213.94.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506cbsm39291689f8f.14.2026.08.10.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:07 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 4/9] rtc: abx80x: properly handle shared IRQs
Date: Mon, 10 Aug 2026 21:38:21 +0200
Message-ID: <20260810193826.210683-5-apokusinski01@gmail.com>
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

