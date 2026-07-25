Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78A5322527
	for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991552; cv=none; b=e52E7GSj5Nv4w6ITGcY8gnpcK+QyBpXJakIveGUpT7QnLKOOcPrCth+NR/tDCwug3ElU7i3C7B0ZIWqGoYUHqnTswDoeZa9fSVgZbXQ/iZRKZ0hPI5wjKj7DODVAqLQWAdjjPzNBEspbYqCmISNruPdqvxEGN3C1ij2F+a7pdEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991552; c=relaxed/simple;
	bh=m12o7eVW8dThPSS4OtjUJzB8n/5ew0XJ/QsFak5h5zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOGspu6KlEFenwvQtwyNTyq0ULvUaPPyPcEuwudU4QWCCGYsakH0MuZ4Kr/zrNzdQBGbKE0BWX+7j+/760jDgP1DtCxWZtWG63ECqwruZJkXGXbROSDA7TcOdyiSIjGPMc4mXIvo58+ByKMc5SSJD0ZsqLIVQL8r3i1CDq6YhHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJCBxnbn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJCBxnbn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495437bb891so12617555e9.1
        for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784991549; x=1785596349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQ/fBWDw5Qf66Xo/6BCDYwxfdQSmisar2wJZtORK7eM=;
        b=NJCBxnbnah0eQ9HkD+rqmUfOEp/yeprapA5BYi+MA4PQ1mwYveXaV5wtF0dGHdyU7n
         YuZK2m7FhWfh9BMLZ+ZO16a9QDr+W5MJ25zvRqe/YlN4kEGFeGz1K1IUmZfkn8auvrDx
         bwZAdYLBJ3CDLJ+eOAaxTlMTFhRcEbeDE88SipICxYRN6HWW8R+TS39b/BRjrKHSdgmd
         5WhKoS0hOHUR3y9NhqOBUf5OSTjBH1ulZkW5g5IyjRDvGvvGhvWlU5csGwiDf5kDjqiK
         FbTYLI/p9OSGKO51Wmfrlyzt/oD9aqwZYLcF1IUmfnlOhHzYPWFKLZ5GnCCHZlcNGuO1
         HoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991549; x=1785596349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YQ/fBWDw5Qf66Xo/6BCDYwxfdQSmisar2wJZtORK7eM=;
        b=m7QSFFQCFttAIzJ9XKCPCwNTvuSA+6XA/pkq0SXU9pHj4LfIhx9ulMQuTgfrZuK3sz
         jXYafOFXO2mgPVq403W26B49UG4u/U3GXaG5KuT6vAs1fXsjDiV6496DAWC+BxWUOT6h
         J7JzH7pfLegD8Z7fEQgLodPzXpi3t4WnIGg5YlQKbS6dHMWNUfTE/lwtOdbWBsNVulUf
         CDlvt26Qq1Xlh3hw3Xt9PVPIbkzEwgDPmBGxqCUZb7S+cszPt3cgdZJpdoiC+yrz7yX4
         67tuDEEHviWS3sPQGDlrod8bLfsAieYr7U9wrNJmyFhHRzgdZsiHIERg3nUlcMM4+uOa
         GQ/A==
X-Forwarded-Encrypted: i=1; AHgh+RqK+oCxgJX1zcd7TSENEo/ye1z7LhHsf5mrJ0/G1m66PPu3egUh2KuVEVZMMu7F7yvX+Qxbee9yg2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0lFjp/6zHS1UvcY0JXrGLbhr2yM4/vRF6v+LbIUEneJ/uRW6
	7pRnnFTIjXE74Pw8/mymVwEPM8Oiy8BlBs4ei/g4crxzyT2PGd7xnkHt
X-Gm-Gg: AR+sD12fFd3R670Kfy9mfkV/F1d3zoGsEZB77hljOgDYXPDLcI0YPUlYDKT55D8i7Nv
	qvMYMMtFFl86DkVL68t5cN80iDdAU/Ic9PlsCb6pVKapXxfgfT1LH1rcIbYEwhS/1MZSruToUXq
	tTXTd4Fn2h7+zQ0Zjp8Ku6+jcryr49QOePgqYuwbW1ay0DC1VbONtxgo6dNP0Y+naC5xLrtnkfs
	Qr/ooVjL+vXNobTxt3qk+djJBYrq8PiA4G93nb5TDFgHetBpK83vKOdeNscZWfb+MLm6gSSawBQ
	qEYA0uDJfHGSDyvQJX0nhisz/uDT1FHhFXEfPS7fuGoOYFNLGh40eSLAtaEgKsRhjriC++wALTW
	COuz74T2kPilaig8RfP/WiBdrGD3dVYecIx9a+uL1C/oMMe+tUkBqogTiiZ++yBY3ose2qKU87u
	Dbxx2qMIP179fC
X-Received: by 2002:a05:600c:4585:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-496b5b59658mr29692425e9.8.1784991549011;
        Sat, 25 Jul 2026 07:59:09 -0700 (PDT)
Received: from antoniarch ([78.212.96.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f24a93sm79704435e9.11.2026.07.25.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:59:08 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: marex@denx.de,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 8/8] rtc: abx80x: add support for ABX81X
Date: Sat, 25 Jul 2026 16:57:18 +0200
Message-ID: <20260725145718.14733-9-apokusinski01@gmail.com>
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
index 7cba72656d09..46434f05a1f7 100644
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
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
+#include <linux/spi/spi.h>
 #include <linux/watchdog.h>
 
 #define ABX8XX_REG_HTH		0x00
@@ -102,8 +103,8 @@
 
 static u8 trickle_resistors[] = {0, 3, 6, 11};
 
-enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
-	AB1801, AB1803, AB1804, AB1805, RV1805, ABX80X};
+enum abx80x_chip {AB0801, AB0803, AB0804, AB0805, AB0815,
+	AB1801, AB1803, AB1804, AB1805, AB1815, RV1805, ABX80X};
 
 struct abx80x_cap {
 	u16 pn;
@@ -116,10 +117,12 @@ static struct abx80x_cap abx80x_caps[] = {
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
@@ -1026,14 +1029,107 @@ static void abx80x_unregister_driver(void)
 
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
+		return -EIO;
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

