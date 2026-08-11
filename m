Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395D47ACD8
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477355; cv=none; b=p63GZWYnpuuDYGHntkZITvQLPVfQMcOn7wlzhH4bfqhc/D6FEMGlWERlDOveOcOWb4/ScEIv80QG9afCoHORGhpRpEcm862s1kVvKx6d9C2v5yYs+k59xKeNdgavUZ7rUQXYdQxsDjoS3RWq5pDSTZA0qfV2k49upK/zlF3P6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477355; c=relaxed/simple;
	bh=L/Xi+O03EBynElRL7L0vL8qcfN7hIjPo8s3prz4BfVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOZXUCUNHC6lbvAoZcYWftRaYNynDuNVQhykGnVz27AId/Vv4uyLv0Rhs0wgbUBxCBOFAkfW/jP3x3XTFJYBUHGQJd5vpLQ/Bfb/fjL6dIEDL+aoVbc6ErEJSzwXK1V3BsH2Lw7y04XBnLEHczjfXodXJWmxuzMqXn4/XOanPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L60GtcNg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L60GtcNg"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso678805e9.3
        for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786477351; x=1787082151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yR/4hjRVD3BKmEkJnBlwxN5TsqF/X+OQ8T6Cq6656R0=;
        b=L60GtcNgZUmTWJ+0RL3+vwsaBH7mBvzq5mS5YyRC3jXXpsh7eQ0CkPdBJxrRW4BKMD
         uUQBxdqHzCPdTJCsJ8fBkPkDwyQvTUiBYJFPY2aNT2kx+saj3GOxGVTU/Y9QHkohEaEY
         nArO5kitsvPpEdZgdAGyP2SmmNBIgfj1YAzuyV4XGWVm1DkJmN6Uou3hqHpSfK97NX5j
         JU5ZoVMlmZs4If943Fw/H111nLro9sI09OVEdMiYdyL+KlyzjwyuqpB1SRtR/cbZRhu4
         aiabdtYiARRqB6VvQFRNzyqRKmTxJbpJe18rtpq5k/9cBrOgIxfQMf45aGiiW/YX7i0I
         4P/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786477351; x=1787082151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yR/4hjRVD3BKmEkJnBlwxN5TsqF/X+OQ8T6Cq6656R0=;
        b=Ktv/0COrUAJCE6RqORsV7hm5dY3+DMmv/tf3umnSqDZVcNFX4Amee6mAaPrm5otyqx
         vzfxWlvbdypAYjm7hP+47zXhwP4h6ACwQKFTcglfzW+xfGTcFY5k7brDgxvfInM2BWKf
         bEG3fMAn+ZHXcbznHRbAixrCRIvONauGMfqOuYmvVlhcqKAadbpgE907CWwRYEwAHYe8
         cMsPUuXvoXmQctJP8N944Auybrfyu0UtSB2u+AvjIsVLH5k592bhLRd8dAMiiiJ9SG0g
         sk3NvqrRaD6FKKU6Ep37nfhfyrrbKXEAQKwwWKZH8L7u1iVfVHcEm8c7vE1camXSCCfr
         /Iqg==
X-Gm-Message-State: AOJu0YxOX72L3Dflf6ar481HqX3g9QffEoeIZuKvFv2R4V057Ikt3GO8
	kPzWEUE1deG8vhswsc1ppqjnvUGppUBjp+AbQu10gl4xMWnkljYszGue
X-Gm-Gg: AR+sD12bY5h85o50qPWU33wH8401xHcrtEO6Ey2+Cq5Vyhi4roaKfG8KcFiestge9Hx
	LgUnkmzLY7nEOC7/bGZ8vx2nVcXfTMfaryLtq+THyneTQ6QafmCcpeRVSIaYr/6heH5zOHWGHlw
	rRUIYVti5a4BQ8VQSR+tKu4a0BaKO21lXqwnlBg7pcoaO1Fhjbtc4VapYT1ZxxOnXtpkhICKwDL
	TaFzfn01XGklLSLKosxWmp0QVNeFApOhDygAeD66fl7xMembDIFoR1zL8wFenvxrTIPNAZpOB2W
	mXH5ofRRVRgY8JyWueXTLAoM6AwmvlEd2dkuVGtWu68I/I9XSgsRSdACgCO3iHBoIbOunUFVAT5
	B1JEP80zX6XBZhtSFw3TQZtsreIQ+OWns8S0BLtMbRIGoE2KAlGquVweffUQZSw34TJZW025WlG
	ZNVoMCGaG6LXDFFvkWbJwN/XYjujcU3EGlVAlg4qLpuOzS5bWauWvMj7myhkD3nl62
X-Received: by 2002:a05:600c:6989:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-4997842da5cmr91637965e9.1.1786477350688;
        Tue, 11 Aug 2026 12:42:30 -0700 (PDT)
Received: from antoniarch ([78.213.143.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b22784fsm2606535e9.2.2026.08.11.12.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:42:30 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v5 9/9] rtc: abx80x: add support for ABX81X
Date: Tue, 11 Aug 2026 21:40:34 +0200
Message-ID: <20260811194034.28937-10-apokusinski01@gmail.com>
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

Abracon ABX81X is a family of RTCs with SPI interface featuring
the same functionalities as the ABX80X I2C clocks.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/rtc/Kconfig      |  26 +++++-----
 drivers/rtc/rtc-abx80x.c | 106 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 115 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 4d14bcba616e..d35221f81024 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -212,18 +212,6 @@ config RTC_DRV_ABEOZ9
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ab-e0z9.
 
-config RTC_DRV_ABX80X
-	tristate "Abracon ABx80x"
-	select WATCHDOG_CORE if WATCHDOG
-	select REGMAP_I2C
-	help
-	  If you say yes here you get support for Abracon AB080X and AB180X
-	  families of ultra-low-power  battery- and capacitor-backed real-time
-	  clock chips.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-abx80x.
-
 config RTC_DRV_AC100
 	tristate "X-Powers AC100"
 	depends on MFD_AC100
@@ -955,6 +943,20 @@ config RTC_I2C_AND_SPI
 
 comment "SPI and I2C RTC drivers"
 
+config RTC_DRV_ABX80X
+	tristate "Abracon ABx80x"
+	depends on RTC_I2C_AND_SPI
+	select WATCHDOG_CORE if WATCHDOG
+	select REGMAP_I2C if I2C
+	select REGMAP_SPI if SPI_MASTER
+	help
+	  If you say yes here you get support for Abracon AB080X, AB180X,
+	  AB081X and AB181X families of ultra-low-power  battery- and
+	  capacitor-backed real-time clock chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-abx80x.
+
 config RTC_DRV_DS3232
 	tristate "Dallas/Maxim DS3232/DS3234"
 	depends on RTC_I2C_AND_SPI
diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 08b22c067699..7145de876b50 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * A driver for the I2C members of the Abracon AB x8xx RTC family,
- * and compatible: AB 1805 and AB 0805
+ * A driver for the I2C and SPI members of the Abracon AB x8xx RTC family,
+ * and compatible: AB 1805, AB 0805, AB 1815 and AB 0815
  *
  * Copyright 2014-2015 Macq S.A.
  *
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
+#include <linux/spi/spi.h>
 #include <linux/watchdog.h>
 
 #define ABX8XX_REG_HTH		0x00
@@ -109,8 +110,8 @@
 
 static u8 trickle_resistors[] = {0, 3, 6, 11};
 
-enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
-	AB1801, AB1803, AB1804, AB1805, RV1805, ABX80X};
+enum abx80x_chip {AB0801, AB0803, AB0804, AB0805, AB0815,
+	AB1801, AB1803, AB1804, AB1805, AB1815, RV1805, ABX80X};
 
 struct abx80x_cap {
 	u16 pn;
@@ -123,10 +124,12 @@ static struct abx80x_cap abx80x_caps[] = {
 	[AB0803] = {.pn = 0x0803},
 	[AB0804] = {.pn = 0x0804, .has_tc = true, .has_wdog = true},
 	[AB0805] = {.pn = 0x0805, .has_tc = true, .has_wdog = true},
+	[AB0815] = {.pn = 0x0815, .has_tc = true, .has_wdog = true},
 	[AB1801] = {.pn = 0x1801},
 	[AB1803] = {.pn = 0x1803},
 	[AB1804] = {.pn = 0x1804, .has_tc = true, .has_wdog = true},
 	[AB1805] = {.pn = 0x1805, .has_tc = true, .has_wdog = true},
+	[AB1815] = {.pn = 0x1815, .has_tc = true, .has_wdog = true},
 	[RV1805] = {.pn = 0x1805, .has_tc = true, .has_wdog = true},
 	[ABX80X] = {.pn = 0}
 };
@@ -1073,14 +1076,107 @@ static void abx80x_unregister_driver(void)
 
 #endif /* IS_ENABLED(CONFIG_I2C) */
 
+#if IS_ENABLED(CONFIG_SPI_MASTER)
+
+static const struct regmap_config abx80x_regmap_config_spi = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ABX8XX_SRAM_BASE + ABX8XX_SRAM_WIN_SIZE - 1,
+
+	.rd_table = &abx80x_read_table,
+	.wr_table = &abx80x_write_table,
+
+	.write_flag_mask = BIT(7),
+};
+
+static const struct spi_device_id abx81x_id[] = {
+	{ "ab0815", AB0815 },
+	{ "ab1815", AB1815 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, abx81x_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id abx81x_of_match[] = {
+	{
+		.compatible = "abracon,ab0815",
+		.data = (void *)AB0815
+	},
+	{
+		.compatible = "abracon,ab1815",
+		.data = (void *)AB1815
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, abx81x_of_match);
+#endif
+
+static int abx81x_spi_probe(struct spi_device *spi)
+{
+	unsigned int part = (uintptr_t)spi_get_device_match_data(spi);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &abx80x_regmap_config_spi);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Unable to allocate regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	return abx80x_probe(&spi->dev, regmap, spi->irq,
+			    spi->dev.of_node, part);
+}
+
+static struct spi_driver abx81x_driver = {
+	.driver		= {
+		.name	= "rtc-abx81x",
+		.of_match_table = of_match_ptr(abx81x_of_match),
+	},
+	.probe		= abx81x_spi_probe,
+	.id_table	= abx81x_id,
+};
+
+static int abx81x_register_driver(void)
+{
+	return spi_register_driver(&abx81x_driver);
+}
+
+static void abx81x_unregister_driver(void)
+{
+	spi_unregister_driver(&abx81x_driver);
+}
+
+#else
+
+static int abx81x_register_driver(void)
+{
+	return 0;
+}
+
+static void abx81x_unregister_driver(void)
+{
+}
+
+#endif /* IS_ENABLED(CONFIG_SPI_MASTER) */
+
 static int __init abx80x_init(void)
 {
-	return abx80x_register_driver();
+	int ret;
+
+	ret = abx80x_register_driver();
+	if (ret)
+		return ret;
+
+	ret = abx81x_register_driver();
+	if (ret)
+		abx80x_unregister_driver();
+
+	return ret;
 }
 module_init(abx80x_init);
 
 static void __exit abx80x_exit(void)
 {
+	abx81x_unregister_driver();
 	abx80x_unregister_driver();
 }
 module_exit(abx80x_exit);
-- 
2.55.0

