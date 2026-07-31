Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB347D450
	for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523819; cv=none; b=CiGq3vcEZyAvmcwtpxTk5vplZvxsJ524NBeCPFTC50txdEjEnjA6txQiLJFjGTM203gOJ+uzemyozYtxTGTa2sIm3xZ+pAe2E9hJ5EhKavUV4CAQNIBgA55ZwHdi4UrfrCGuwcEHDQCQrzckkgVRpVjiysIjtD4AhIM0/l8fYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523819; c=relaxed/simple;
	bh=443eWXg5FjQPj4trLApqnDHq69yrp6EdIljcAeoVzFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUR+JYtJp8YvP03O0be/mZUVkXqzkfGhjYNSEaLLQQM8B3rJhipsfExqDo0qwcVKtA4FY1eG8u1yL32W1/5WuFF+lAGGZeaNTYR7qsgdyc+2SLirI/k0sSdMSUzrb8U3JDr68imFLcq4QmtfX9VptGnN8+XSN6ESzIKrTYhXDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUIMMAKW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUIMMAKW"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4798bea72f9so966241f8f.1
        for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 11:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785523816; x=1786128616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=btuhTN+ZZ/Hk7oFpgCvWRIlgckbrnHIqKNkWEKSD9wc=;
        b=MUIMMAKWYleX6UV72y3ftE8Vr+/CMQSGcm1sAVBgS/a6RVqbIdRGg5+ZHD7IfEDaCF
         4Is3rg84c3IB+ImbvvFfcloAEMZJEdiSUktqsHuLkBzFfVIPvovF09JDSOwcNV1r1TPp
         fNDOutyjzO5byrS0NKel6I7+Gwcl6kun/J3zjr/4CigUBKrGPZFTO+kbv5cZW6vJJROw
         +B+OF6Y8R8kUHzFOH4/QZFVPAPCWuNybYj6RIfEe3MVSrRCydvFYwxNHptzdf/xh9kHv
         Qqf5ZTb59aEp28mdSSIkfARC0DMXL5P2j0g7K89QJKzyhAelIYz6UdXMIxSJJmx7fKR8
         sqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523816; x=1786128616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=btuhTN+ZZ/Hk7oFpgCvWRIlgckbrnHIqKNkWEKSD9wc=;
        b=B1KBRa7a24jc3JP8YMIwC6Pg+EPVew3hln3SQpDkRBRGp3+SokXDYBpANyIANPRQ8E
         Ej68acxt+6dbxji5W+TeF7VdXNVbkjx5z96nk4QTT/TliWxsmZYhxZoSynmA4acUM+d+
         1sP4ktQGD5yCcA9tJpS9qy5LVn7We9yxYaC1wkoyQV4gonq3WE+SHBHJgM0SoRKek64v
         D+BClitCjWZrOaDUpiwkHJtYSjlTKbsMy6co7tYWhI2zfIUWfbjyLo0XuWb4XraWqxfX
         lW6defGU82x0UEjfqP98FZJ/bLm9RYJlkX4BhaqjjbUWI/u8Dpt1YckO0hUfwtzAQU0d
         IFEA==
X-Gm-Message-State: AOJu0Yzyj38xbB2wfeqeI9TQWZVuWyzUeenhZV3N8/cLhVz8L8rIVJn7
	o1ZSDv8xu2rio+q3MnIgXViMwb6s3eV7RuCp4uakzxjjaPYOWBAsKOnJ
X-Gm-Gg: AR+sD13TcSd3N04T+0p3A2YiTqiXJvgak/XpZ2eL9IKI2PIQ9mYKis31PEQqlzWgdLe
	v6Q2oWtPMhXMajj6GNPAjnOoKqsZgzIlvXC0jDn71qikh62S2RTJPC9ZgGeWwO5UgWe1Qe/yJqu
	3YRHTfXZccy0MEJNqRIU2MQMgCofOdi9fIeckq5Cqq1L0hKm7YZ8XTH7OJA8pGG/UrI+OIeQ0Qd
	Z8KiBU0f2eGdyIAkSRyhG3T7udxQqkxXzJv4dWN/82ZiKwE9ByFV0ZNvsugxkwsxu5YldoH4vzg
	T/a/rpP8RU54EKwwISwaJ56EfGDkuRS1ahk0N2A9xSD89Mld87JQnR8dPynY7d5vvGZQjhLfuu3
	xlCn2tlawWsICLSkkM8w/cNGsNS7hhlTrW5+DoyktJ2t6H61a52AHkzD5ESnkAk6iQ1w1WoDduJ
	Jf2sg++7DVVZQn/HI/qpbtNwBAvsx7fcoAaz7xPRWPmY5eh1S6SbdkNsNpATFhw07u
X-Received: by 2002:adf:ed87:0:b0:47f:4919:d5b2 with SMTP id ffacd0b85a97d-47fd72bafffmr1193108f8f.1.1785523815514;
        Fri, 31 Jul 2026 11:50:15 -0700 (PDT)
Received: from antoniarch ([78.211.133.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91b3sm8741488f8f.14.2026.07.31.11.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:50:15 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 8/8] rtc: abx80x: add support for ABX81X
Date: Fri, 31 Jul 2026 20:48:31 +0200
Message-ID: <20260731184831.44037-9-apokusinski01@gmail.com>
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
index 6583e097af68..e5116c034d04 100644
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
@@ -103,8 +104,8 @@
 
 static u8 trickle_resistors[] = {0, 3, 6, 11};
 
-enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
-	AB1801, AB1803, AB1804, AB1805, RV1805, ABX80X};
+enum abx80x_chip {AB0801, AB0803, AB0804, AB0805, AB0815,
+	AB1801, AB1803, AB1804, AB1805, AB1815, RV1805, ABX80X};
 
 struct abx80x_cap {
 	u16 pn;
@@ -117,10 +118,12 @@ static struct abx80x_cap abx80x_caps[] = {
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
@@ -1049,14 +1052,107 @@ static void abx80x_unregister_driver(void)
 
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

