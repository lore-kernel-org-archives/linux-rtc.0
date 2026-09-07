Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0CB52ED4F
	for <linux-rtc@vger.kernel.org>; Mon,  7 Sep 2026 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813260; cv=none; b=cDzABKQnTz3HWk4i3w/7uFqGK9iFxEyc0fKEaCK/iFpEz0BwHP5fmEX0qUhVOoFhp/RKrgwBhGHWMTYc0cb7b39TWmivOwSTDKUWY+RYnbqf+caxuhE4O9sa85Ogy1p2Qx6X3/oeV0L21X5ODVu1WYDvoithYfJAqdhS/TKhMA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813260; c=relaxed/simple;
	bh=PG2uHUEbkCrEzYXipxjXZRMZBQvnmVaucGzN7IM7zZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1oRa+Wnar5N5eBvH8TT97CfLktI8JDFbbMNXWQ/O+dedZxbGiPDWtFjlP7UWv3XJdYaNxXHbIu+PfjHZXsjK9nmtv7YDkOcDO5oXTq52RufyDkGndOXzbBdOqTmDyocwrq4N57FyW63AhTfve88pIlH9eqp1olnaJwJuelDyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q3DFGxlJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3DFGxlJ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso35293625e9.0
        for <linux-rtc@vger.kernel.org>; Mon, 07 Sep 2026 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788813256; x=1789418056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7E1qEp5el0vMy4z578Uuf+/aSLygb8nTGKBm40Vll7E=;
        b=q3DFGxlJo05mK7li1bO16cZ/KeRXxWuFrg86TdIxlJi2VnEv6pCMQmjnrV8/ukuxq0
         +ESF2iyiWqbdOwGliYoHcWeEwcEI4bI8qLMIp0ZR/XvZsfeNHqseUMDNu9DnzhCF71iu
         LDAb5JDnCge6kf2TiLO5wxF2rqKLsIERwQH5BvTenf+4LaR46ko+4XwKk+NPpezI90H8
         Q+wPkLxWKFJVWfPm/3mq4lRBDZLdPxFggQxNG3gMcwCjM+PKCq9BLsq+aiKPoePLCAX6
         MpDq8dF2atSpT3ZnwOS/eO2ugYPU+js2zN7hEJpQeezq8CUy+DtmTD7qN3FB5yBJc5Y8
         xfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813256; x=1789418056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7E1qEp5el0vMy4z578Uuf+/aSLygb8nTGKBm40Vll7E=;
        b=aahruN3u4EKc1wOkXru/PG64AVHd2tf7bFxRFqa7f5XLTTLW82FWDrKaxKqS0T/ZIH
         +WvlFW85Kp4f7CHnQlw9dUrhCxK1SNgmfDj7P4dYa3g8GbU+uFAUPzB/qSyfGtv6Nokp
         mEOo613kgyQk3O9cAyzKczaaGco0DMAhFjvXNhu0DvbyFJ9fQHhZ6VlG0R0ex3Ad9ltK
         WyvyK1YHPvmXoI9ZT8rzi+NZTkCQxPPIl06x6rw0r9ETP4zyx7/HiJJ+ALwq9ETaSEXr
         raH/ojt4qv6pGQj95a5ARfKdVOadbD8v9ahRysEqhvro/AP/p0B2mOV+wW33Y4U+2hld
         P3wg==
X-Gm-Message-State: AFuF++mYH1AtXqUZpRT2Kugh4OHvwMDuUf1InF+xl57KCLnS1omfiXtO
	SFsDYN6Oe8XgkBXLBwjpEhLvQts31DcJE6HSzaNh4+d9hL2sPWpquk3w
X-Gm-Gg: AYBFou1d5zznngP7HvZ3Pfdrbt12WNhPopOt1LfxDnpf2u0S0b09N1kPi3nEyfSy66a
	6WefKZaiLxcsan6EITgP9bfu2V27RY0Cgr9OERLilk9aAT6jB/1y3l2wBgYHrh5ZOPdSU4UgYh3
	NT76R4oio+m6WAO84WVcz18U7y33LNh7kJ8us5TZXOOf9w9S25syRsg2V2zl705cwIKS7XlUawF
	yrmHj8Of92b61hz+R7Hz4AySMi3tr/cSOKTc+MylvP7KRehU2a31BQJMWVEtWUU+rMQPyw+WH01
	4po0Hux+LMOm/yFHBwgWPjzJJ++RX5QLvH+9YpmoIQ9gHE0e7CJDDHw4h/xNJwondHUyv7nHAXG
	YR/ElkgzxZYfqsv+LP6xMEY9C3OPwXsODCfL6rtkfrd1gO2XAK1e+wGQkOguMPU2GhJUJOZMU1E
	1NJd9FPYnQ8uOP9t0B7bOf1k6W98+urQnyQFWuTUpjaGeCk+xqjFDgED/BG2mZAw==
X-Received: by 2002:a05:600c:e556:10b0:49d:e27:d381 with SMTP id 5b1f17b1804b1-49d0e27d56cmr71117815e9.6.1788813255885;
        Mon, 07 Sep 2026 13:34:15 -0700 (PDT)
Received: from antoniarch ([78.212.37.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858e239862sm25959116f8f.9.2026.09.07.13.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:34:15 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v6 9/9] rtc: abx80x: add support for ABX81X
Date: Mon,  7 Sep 2026 22:32:16 +0200
Message-ID: <20260907203216.53192-10-apokusinski01@gmail.com>
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
index c90407a023fe..c3bf6f0ae48b 100644
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
@@ -1078,14 +1081,107 @@ static void abx80x_unregister_driver(void)
 
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

