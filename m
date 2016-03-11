Return-Path: <rtc-linux+bncBCPM5SUWUYIRBSPBRO3QKGQEN35JZLY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com. [2607:f8b0:400e:c03::22c])
        by gmr-mx.google.com with ESMTPS id ui7si1463890pab.0.2016.03.11.08.22.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Mar 2016 08:22:32 -0800 (PST)
Received: by mail-pa0-x22c.google.com with SMTP id tt10so102462448pab.3
        for <rtc-linux@googlegroups.com>; Fri, 11 Mar 2016 08:22:32 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Renaud Cerrato <r.cerrato@til-technologies.fr>
Subject: [rtc-linux] [PATCH 2/3] rtc: pcf2127: add support for spi interface
Date: Sat, 12 Mar 2016 01:22:15 +0900
Message-Id: <1457713336-24262-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1457713336-24262-1-git-send-email-akinobu.mita@gmail.com>
References: <1457713336-24262-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

pcf2127 has selectable I2C-bus and SPI-bus interface support.

This adds support for SPI interface.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Renaud Cerrato <r.cerrato@til-technologies.fr>
---
 drivers/rtc/Kconfig       |  19 ++++----
 drivers/rtc/rtc-pcf2127.c | 118 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 126 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 777fa2d..9d0f4da 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -400,15 +400,6 @@ config RTC_DRV_PALMAS
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-palma.
 
-config RTC_DRV_PCF2127
-	tristate "NXP PCF2127"
-	help
-	  If you say yes here you get support for the NXP PCF2127/29 RTC
-	  chips.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-pcf2127.
-
 config RTC_DRV_PCF8523
 	tristate "NXP PCF8523"
 	help
@@ -767,6 +758,16 @@ config RTC_DRV_DS3232
 	  This driver can also be built as a module.  If so, the module
 	  will be called rtc-ds3232.
 
+config RTC_DRV_PCF2127
+	tristate "NXP PCF2127"
+	depends on RTC_I2C_AND_SPI
+	help
+	  If you say yes here you get support for the NXP PCF2127/29 RTC
+	  chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pcf2127.
+
 comment "Platform RTC drivers"
 
 # this 'CMOS' RTC driver is arch dependent because <asm-generic/rtc.h>
diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 8f269e3..5729ee9 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -1,5 +1,5 @@
 /*
- * An I2C driver for the NXP PCF2127 RTC
+ * An I2C and SPI driver for the NXP PCF2127 RTC
  * Copyright 2013 Til-Technologies
  *
  * Author: Renaud Cerrato <r.cerrato@til-technologies.fr>
@@ -14,6 +14,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <linux/bcd.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
@@ -200,6 +201,8 @@ static const struct of_device_id pcf2127_of_match[] = {
 MODULE_DEVICE_TABLE(of, pcf2127_of_match);
 #endif
 
+#if IS_ENABLED(CONFIG_I2C)
+
 static int pcf2127_i2c_write(void *context, const void *data, size_t count)
 {
 	struct device *dev = context;
@@ -306,7 +309,118 @@ static struct i2c_driver pcf2127_i2c_driver = {
 	.probe		= pcf2127_i2c_probe,
 	.id_table	= pcf2127_i2c_id,
 };
-module_i2c_driver(pcf2127_i2c_driver);
+
+static int pcf2127_i2c_register_driver(void)
+{
+	return i2c_add_driver(&pcf2127_i2c_driver);
+}
+
+static void pcf2127_i2c_unregister_driver(void)
+{
+	i2c_del_driver(&pcf2127_i2c_driver);
+}
+
+#else
+
+static int pcf2127_i2c_register_driver(void)
+{
+	return 0;
+}
+
+static void pcf2127_i2c_unregister_driver(void)
+{
+}
+
+#endif
+
+#if IS_ENABLED(CONFIG_SPI_MASTER)
+
+static struct spi_driver pcf2127_spi_driver;
+
+static int pcf2127_spi_probe(struct spi_device *spi)
+{
+	static const struct regmap_config config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.read_flag_mask = 0xa0,
+		.write_flag_mask = 0x20,
+	};
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "%s: regmap allocation failed: %ld\n",
+			__func__, PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return pcf2127_probe(&spi->dev, regmap, pcf2127_spi_driver.driver.name);
+}
+
+static const struct spi_device_id pcf2127_spi_id[] = {
+	{ "pcf2127", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, pcf2127_spi_id);
+
+static struct spi_driver pcf2127_spi_driver = {
+	.driver		= {
+		.name	= "rtc-pcf2127-spi",
+		.of_match_table = of_match_ptr(pcf2127_of_match),
+	},
+	.probe		= pcf2127_spi_probe,
+	.id_table	= pcf2127_spi_id,
+};
+
+static int pcf2127_spi_register_driver(void)
+{
+	return spi_register_driver(&pcf2127_spi_driver);
+}
+
+static void pcf2127_spi_unregister_driver(void)
+{
+	spi_unregister_driver(&pcf2127_spi_driver);
+}
+
+#else
+
+static int pcf2127_spi_register_driver(void)
+{
+	return 0;
+}
+
+static void pcf2127_spi_unregister_driver(void)
+{
+}
+
+#endif
+
+static int __init pcf2127_init(void)
+{
+	int ret;
+
+	ret = pcf2127_i2c_register_driver();
+	if (ret) {
+		pr_err("Failed to register pcf2127 i2c driver: %d\n", ret);
+		return ret;
+	}
+
+	ret = pcf2127_spi_register_driver();
+	if (ret) {
+		pr_err("Failed to register pcf2127 spi driver: %d\n", ret);
+		pcf2127_i2c_unregister_driver();
+	}
+
+	return ret;
+}
+module_init(pcf2127_init)
+
+static void __exit pcf2127_exit(void)
+{
+	pcf2127_spi_unregister_driver();
+	pcf2127_i2c_unregister_driver();
+}
+module_exit(pcf2127_exit)
 
 MODULE_AUTHOR("Renaud Cerrato <r.cerrato@til-technologies.fr>");
 MODULE_DESCRIPTION("NXP PCF2127 RTC driver");
-- 
2.5.0

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
