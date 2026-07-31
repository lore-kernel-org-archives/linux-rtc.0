Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C494519BD
	for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523811; cv=none; b=Di3QKZDE+/gAqg7/WMo+4BZ83Boqq3lychmooY8zgjW1lE4es8HihK9yLb3eW5JxH8qfAkBox5Bwl5VizASDHj+Ek3XLiqVkpqgv++kPHD2N47BANm/mJvrKMi2jZvyMHVx1KgfxF1Z0C+wU8HgpNXrj1y5L197yIxShzlPtjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523811; c=relaxed/simple;
	bh=sViFzWJhXIbtkeyCwXiwWrDna0ysqKKTQtJUPl/9D3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXlGrx/Pf+/kwQP+6N8oPL0NKUHG3F6QtdoGdPaABxTcsj+Qa02Yuf79lFeJb/gUxetNYMaob3qXwWHK6N2N5OG3SMoKfSfyLuy7LW3/KJM1vQr3u22z9Rpq95bJP94IacBl2jd/OlyHl9Wtj5N+AORBWSPNg5Xmb/hRAGJ75XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIoMW777; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIoMW777"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f81a3ccf9so1263691f8f.0
        for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 11:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785523808; x=1786128608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IbHCFTYG93Y1dCLgcimL0oosJgOI0iKbHqRlXM74gC4=;
        b=SIoMW777UvOv5VvH1kR+PwbRJwDG1ZhnqkD+ca82sZ5/s5PwhWFvpbnvQvA3M9RXGm
         Z9dbAfDtuEjdDDLxIECeVEJKKnJ+xOpUcSqjjSgctVO6VDgNd0lb16IKs4aZmS3EZqA1
         Sz3ev/Ydxizu6vKkyPPtvxIf5zItDsWtTjzlmeDXvSMY9hYlzewL4RmmzhdcWD5ocUJ4
         sLkwu4J7js6p9mTuzsUuWSDqRv+ydd2XC0wKCeRVhlQ/AtkuqhiyQPwujLXZlsc7o+y3
         kQglrcG2f2SXHlOHxykc4nfadXzAVJfc4jmOK5UCiMVtvVam+1zTSweIGTqP58fPUiPx
         4ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523808; x=1786128608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbHCFTYG93Y1dCLgcimL0oosJgOI0iKbHqRlXM74gC4=;
        b=ZCFA/cjnZ5mvB7q5FyoZRoQWWQ4huago8aXVGF76zFqpaJ4xhSwp6ZQMZU8xft8Iws
         T/9gUZ0cfvc3zjQ4+u8bbXYRYbtHMWeL8V5nIyC/y2P3LM0Up/GcQv7VMIaP0WY1DYKO
         dv8eXxqrZmDW3XJ7x1HRVzBunjkW1vO2PXlw+3v6EL+bOb3v+U2qDivDY26qbZvJ3LQQ
         tWUpvIJFHbsd0a5AwsCygat9nmHvMPT1uuUW7uIKjCUEcBlEYHXdkP2ETnW6h0HD2HNa
         pkLDzqG5N5Bxu3HFlqIdyXJGhw3EMRJIKu0lRhrJQyJydn48VYOIfFYwJUW/9czzCk3e
         D7og==
X-Gm-Message-State: AOJu0YyqysUTmlN2B+wcFKoyZW1Nr4EXtct0/yTNT0/u3+o4zocT6A58
	Wo7FGwZYwcoXVjomxnpiodeZu7JBaBbvu7kQMWBiTywBthNCVlvDlPe4
X-Gm-Gg: AR+sD12AYdXI/E0ilgRQLEtDKrazj2L+a92rZACqF7uCDBTeFva3b+JHX726GfZD/w/
	J9vk5F8l8wkyqcCGQ2gi7IU/6QyYs9NveCwY5u0YdR4PumiKtEUtFNegDghUKHZJ2Fdsg/qFj0t
	R9YdJ3Vp0UzdHjygdC1u6MjL8AySxuXVApHMTHO/qNVF/oXMWWw9pQMTP1ksHbZHgIUyAqC1uSu
	3cJEiPBjYnzG9rI/wtkpxFmA/Tc6KyJxrRlVFfOO2B7t2TFP1+eaAukRjcFW9+RUFfM8OZneeks
	quWijs/SRwowfmSoiZLYOAEjvRE8dijcA7ef9IhWeO2vemk2wZ/FY1fy+KwYfrcqlyTx7hfCbNb
	uGd8Q1AbO2wE1ileWqnjOOheGSnKXxze3ecM3h6scYTeDpTOU+fJm/7FCoIJCHxCb3T2DlNCTCM
	15uQTinQ7HFRB6FzqoC63SbR9rLXXAyEY9WHq400kM1HrHgkXUed1HVNNn14+nW5Nn
X-Received: by 2002:a05:6000:470f:b0:47d:f445:9490 with SMTP id ffacd0b85a97d-47fd7335076mr1541099f8f.60.1785523808054;
        Fri, 31 Jul 2026 11:50:08 -0700 (PDT)
Received: from antoniarch ([78.211.133.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91b3sm8741488f8f.14.2026.07.31.11.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:50:07 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 3/8] rtc: abx80x: properly handle shared IRQs
Date: Fri, 31 Jul 2026 20:48:26 +0200
Message-ID: <20260731184831.44037-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731184831.44037-1-apokusinski01@gmail.com>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
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
 drivers/rtc/rtc-abx80x.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 8d791b9ec7d2..b84fce0ef294 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -266,27 +266,34 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
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
-- 
2.55.0

