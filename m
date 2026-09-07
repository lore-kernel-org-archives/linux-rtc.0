Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAED403123
	for <linux-rtc@vger.kernel.org>; Mon,  7 Sep 2026 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813252; cv=none; b=sE1YRM0DLkVXB0F9Y7OusUWjKFN9VBXh8RqYsLiJE/o5QGunMTLnWysII3CHhsBaTYXSoICC5aFH05j8Ve2GEOscs1RbXLeKQrLgkkJAHrNreegJlgiLq7/BypKxGesIM1Y9P/zZwIzE9cf+3Wcryyrzkyk/8qwG9ThX5p5CxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813252; c=relaxed/simple;
	bh=Pc8AByMjSEUPU4qRRamFAyp8fdzecA/x0gsS3IoUfSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwR6BEomXYzlp5VwfUJzh780j09Q3oPRjKfR55eg1WJrnEXvz0IARBXGj8bxpEQiLmH/coUqd8mEUb9B4n5FZs78xzb7W1yarBl2aY1YdAOTwAT2ECKVXerQs/ZGj6ZPnmauNU499AjvFd0K0NJty2YrSmXPqPbJcORnOCTKglw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tL+WdLvl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL+WdLvl"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-484374f54d0so2445421f8f.3
        for <linux-rtc@vger.kernel.org>; Mon, 07 Sep 2026 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788813248; x=1789418048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOxWsNxGR4Xn24fPORPxPNrQIFRGPR6rV/CUVrW8Whs=;
        b=tL+WdLvlVHeacyG7pNXCz+LBbWgzuCMfI8IL4/84KgpQPEZHpQTQW+JOwfObuzGhPE
         hD6HIBHNLfEfZgbpIRnaO2uhmred33RkG53ZoL0rZGqWdjvftK5xFclH3mFHO3W4P4hS
         XT7SJE8rLR5atiMNhuyy6kcfoc9TculGzrHFxGAn3HouzczRTU/m/IkP1LwsRV6dhokz
         YBuaxCy+R+A5MizNJKXmro0ag2xEyKzDhqDywe8d+oez72Cl+hzR2P1apSVhFahS2jXL
         cu4TBJZDNFG1Qk7z8i3gzKMEzEOzfvq0auL4n3IJqK7D0GLgRZbsGn9MR9bPiCXvek/0
         tQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813248; x=1789418048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AOxWsNxGR4Xn24fPORPxPNrQIFRGPR6rV/CUVrW8Whs=;
        b=G8aRTs0t+8uSyVWD8dZQv+CUgSMLQj/49mYJMJ5NmUJhhyD+pelBzMkMexS2BU0a0R
         g4n6Z8OcYdu1zqB6zqrXLabA9aatfaP4mZ/7tks/I6tXl1QHhL6gQtSJxgY018mcPiWU
         MQTpYSjPN1N1d6uuqJSYrESNGCCiirgviZ2rxjohltix3d38AcfB9jny/IDiaxf6XbHT
         2r0J4zNgiZnyJoiJWg/fqL6A43MPdGMdT23tFktTOM/qARspPGcuY8Bj5xxStzlhOd3i
         yrnZ6vGGRfALw6B/34S/95tWPbPFRS6DMHAtre4/hx4DPba6J/JejW4+xyhEVEimrF02
         lPmw==
X-Gm-Message-State: AFuF++lx4deVSsnKtRoWO6j5LteLsPNvn6Jrvvm23vgjT8pFgNN4JfGO
	4oK+CFozAiQJFS/z/22o8VEpJrPLlq+CZdbyP0NpIdlhtFjCWwdiB/Z0
X-Gm-Gg: AYBFou3ECAzchEoi7B+Iq7vzlOjyWcUEXe74d6S0LZ1nabY7auy1Z3q5zD/3eeXgspL
	KJlATY1QV4VNcke03OrInmE//s7vPYeFbREZhxYzLcLFitDlx8jfOp1KW7I+alwpueeCi9fIoG/
	FAh/JJrvYE8hd0kTODiuwofxWaoHr7nUT0DlUdLINmQcMj4VJxymm/EwuPbmVrT4ZrLal+HDltZ
	pfPDK96HCRwtyCtZHm2cPcuyNZei/as9ZfHOLLNf6sVbLDVkTYAqJEVKpwDAduVxv9TZhdHDVVX
	Uhn94uunybRcwLM+KSZgZv+qcMXo/XpKT0NyBYpXlFvGS6ZL9hjdrZO1uc9O6SA0Z3EAHwo0fP9
	r5fospvGBrDmkVd12XoSxTE6ETHZ3QqsJt0Dbpaw4VhEwvoW5eN2FaxgFAw46tdVtxtdmMF0jVj
	cn/ZEpNmmYEAvN64IvFZ0tQTPvnMWMMen/JSg+umyhR6toZzTglvydph7sKDdpFA==
X-Received: by 2002:a05:6000:420d:b0:485:8ebb:be1a with SMTP id ffacd0b85a97d-4858ebbbee4mr40491144f8f.4.1788813248126;
        Mon, 07 Sep 2026 13:34:08 -0700 (PDT)
Received: from antoniarch ([78.212.37.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858e239862sm25959116f8f.9.2026.09.07.13.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:34:07 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v6 4/9] rtc: abx80x: properly handle shared IRQs
Date: Mon,  7 Sep 2026 22:32:11 +0200
Message-ID: <20260907203216.53192-5-apokusinski01@gmail.com>
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
 drivers/rtc/rtc-abx80x.c | 52 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 44de234efecf..8f9211bfb7e2 100644
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
@@ -266,6 +272,7 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 	struct i2c_client *client = dev_id;
 	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	struct rtc_device *rtc = priv->rtc;
+	unsigned int status_flags_clear;
 	int status;
 
 	guard(mutex)(&priv->lock);
@@ -284,9 +291,15 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 	if (status & ABX8XX_STATUS_WDT)
 		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
 
-	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
+	status_flags_clear = status & (ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT);
 
-	return IRQ_HANDLED;
+	if (status_flags_clear) {
+		i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
+					  ~status_flags_clear);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
 }
 
 static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
@@ -952,6 +965,41 @@ static int abx80x_probe(struct i2c_client *client)
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
+	/* Unlock write access to Oscillator Control Register */
+	if (abx80x_write_config_key(client, ABX8XX_CFG_KEY_OSC) < 0)
+		return -EIO;
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

