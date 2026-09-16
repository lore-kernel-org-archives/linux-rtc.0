Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244ED4E2F07
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592039; cv=none; b=BU8PbatU/iRY6hS8QOx5fdirsDaEGJeuKWP71+RYt1sbhnzahiYckPQ/JprdMc8DyVgY2IwdSzVTj8FcoHs2Z9c7cNIxOPnZBR7a8zg0/iXc715DJZgM+xvMp3wICwxwZpglpKIxOK6wCjnFkAPtdDyzji+T/XT8SouvFB0nblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592039; c=relaxed/simple;
	bh=QHKmi4S892gGqNg6pBl9u9FP37yr1KqOqVmUXFSF6Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjfLp+pCNICljGks1fQQwOXUqvNgrGcfJFKs01zITIIfSPsi1Jda+gNVBuufbImcC0yWC2FTmlCL2A26vEYjJH05IFxaixOxC8cLFt5cJxtHj9bUV3tmwjsBH8eeMszqL9u4QQypXz4yDBoqKPlDyivjIH5NZaFWrQESW9T5/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rl6vbCZx; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl6vbCZx"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-482f635552aso120070f8f.2
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789592021; x=1790196821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vA3yGa/rngc4Mu+qB0qMb9WEK6nF8DEqyJ8hSv4vu7s=;
        b=Rl6vbCZxwmYNksiZzLqjiO1GUjyHDXIVclrU4aVyrXcq4RNDdT46In947egTloVO24
         WbJsb9of+9H2nNL+/5FgoyEYg3M8pFNQCRseu7iwnScV6XXilGsM1gOZRgahtCEePU46
         zDTPZHIZxzeDOPNsx5m0wwdxjTZYTOt79hw6YMEXlgt5LFojgUhB+EDJswCTdySWmIqQ
         G9th+KMvkRTC5lFYedtExOexrsFyfT/y2Yo8LuRIxPlCZUq52axwjwOl26Cn8ttNymFA
         CFs49sSVr5/RG5q2UPNN65JsV0XIUFFLFgSOr/q9r4ZETRNPd9xVFznLYf9uqdZEkatu
         cCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789592021; x=1790196821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vA3yGa/rngc4Mu+qB0qMb9WEK6nF8DEqyJ8hSv4vu7s=;
        b=GWoHQdasVgwv/FOZzSsa0jSzoAVlZQrQZyEzbDoEQLbKv2f7LMkkaALKEHzQ4g7XC4
         LzHTJrHxUQPNDS4pHnWbic/g8k1uMKRWtAWby6hBKCU81Wqw3ZgCK15pOXmtdwgIuZzN
         +cp6AmbAs52i8hXNfu9CEg1u8+blDgV0z3Min+FlWjTDCqe8OQNm3qp72Hrx+IgNayHq
         33+A+E4UDWpysPwVMCIwiCRL+2o5/8BaFRbKHUIV3AkTPj5vNjSXL4/OkZSAjcbg3B25
         EOwi7bPaAXwaxm/ze+V/JfQOPJRi/jg13VrF0q7GFcQEopj5sW9wl+wlsgOkjxoMFwo+
         5lPg==
X-Gm-Message-State: AFuF++mK/VqeyBjhdu0d02zI59IsnmU72Zlg4XS1d7DikBaH57p+9Ank
	kDv9l5iegTYX8SglNtfIqCR+O18vftcqYadx7YTstclLJIbuhhjnN5wp
X-Gm-Gg: AYBFou2LKDLDEsmLgxXUr+U5R80rGODMHGP2AXaMBCHjGmbMWAVObzpXUQxA4ZnVJYj
	oYeiqZ9zjoDXw/UZlKGsXAIL1qNU/1a5YEr5VRWSfkdAaau34oNk8Wnzp/TklEmEDdBRmlUEjzp
	n4jn5FPv0zlYVOrr+4o1GYtAHq/LzXzdO3UoCea4fxWP0bXmrI5rIw82kT8Q1oWUfDnDyfd+DkL
	JKMj2kq3Ofqv494sHxiDVuKFgxlWgqng0NAPJawdAKiqrejKW2prfAdwdKGZMDd15q7kl7lgiiF
	lb9yb0JDmECm+RanvDXH9f8z1+sxZuZSbOtsqPoC1LqfEfABCYivqZZRs3Xbo07B7gkuV5sJnOt
	0Nn5tAnC7sGvV4Z3lh8xRycrcUrDjF5QEZG7lWa2svWTw201orL32MNq/AXwRaZgkOgRe07r1Ni
	sdify/fWdSSJaMcjSdDWUDzeACVGGbUwAmnzivck71P6UujWCQKrqo3BtACIlas74hwbTJR9U=
X-Received: by 2002:a05:6000:60e:b0:487:6d9:dbe5 with SMTP id ffacd0b85a97d-4870cee4914mr5784145f8f.9.1789592020628;
        Wed, 16 Sep 2026 13:53:40 -0700 (PDT)
Received: from antoniarch ([78.210.41.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7678sm11086166f8f.2.2026.09.16.13.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 13:53:40 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v7 9/9] rtc: abx80x: add support for ABX81X
Date: Wed, 16 Sep 2026 22:51:38 +0200
Message-ID: <20260916205138.16771-10-apokusinski01@gmail.com>
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
index 3f0f8d7f8761..718e6b8555f5 100644
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
@@ -1076,14 +1079,107 @@ static void abx80x_unregister_driver(void)
 
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

