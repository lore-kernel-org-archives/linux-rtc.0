Return-Path: <rtc-linux+bncBCPM5SUWUYIRBEEZ6G3AKGQE4OFEJLQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com. [2607:f8b0:400e:c03::241])
        by gmr-mx.google.com with ESMTPS id r75si2465645pfr.0.2016.03.06.07.28.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2016 07:28:15 -0800 (PST)
Received: by mail-pa0-x241.google.com with SMTP id 1so520481pal.3
        for <rtc-linux@googlegroups.com>; Sun, 06 Mar 2016 07:28:15 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] [PATCH v4 2/7] rtc: merge ds3232 and ds3234
Date: Mon,  7 Mar 2016 00:27:48 +0900
Message-Id: <1457278073-11627-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1457278073-11627-1-git-send-email-akinobu.mita@gmail.com>
References: <1457278073-11627-1-git-send-email-akinobu.mita@gmail.com>
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

According to "Feature Comparison of the DS323x Real-Time Clocks"
(http://pdfserv.maximintegrated.com/en/an/AN5143.pdf), DS3232 and
DS3234 are very similar.

This merges rtc-ds3232 and rtc-ds3234 with using regmap.
This change also enables to support alarm for ds3234.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Suggested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dennis Aberilla <denzzzhome@yahoo.com>
---
* v4
- stop splitting core and i2c modules

 drivers/rtc/Kconfig      |  42 ++++++------
 drivers/rtc/Makefile     |   1 -
 drivers/rtc/rtc-ds3232.c | 167 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/rtc/rtc-ds3234.c | 171 -----------------------------------------------
 4 files changed, 187 insertions(+), 194 deletions(-)
 delete mode 100644 drivers/rtc/rtc-ds3234.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a9a2185..01aa595 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -248,16 +248,6 @@ config RTC_DRV_DS1672
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds1672.
 
-config RTC_DRV_DS3232
-	tristate "Dallas/Maxim DS3232"
-	help
-	  If you say yes here you get support for Dallas Semiconductor
-	  DS3232 real-time clock chips. If an interrupt is associated
-	  with the device, the alarm functionality is supported.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called rtc-ds3232.
-
 config RTC_DRV_HYM8563
 	tristate "Haoyu Microelectronics HYM8563"
 	depends on OF
@@ -727,15 +717,6 @@ config RTC_DRV_RS5C348
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-rs5c348.
 
-config RTC_DRV_DS3234
-	tristate "Maxim/Dallas DS3234"
-	help
-	  If you say yes here you get support for the
-	  Maxim/Dallas DS3234 SPI RTC chip.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-ds3234.
-
 config RTC_DRV_PCF2123
 	tristate "NXP PCF2123"
 	help
@@ -763,6 +744,29 @@ config RTC_DRV_MCP795
 
 endif # SPI_MASTER
 
+#
+# Helper to resolve issues with configs that have SPI enabled but I2C
+# modular.  See SND_SOC_I2C_AND_SPI for more information
+#
+config RTC_I2C_AND_SPI
+	tristate
+	default m if I2C=m
+	default y if I2C=y
+	default y if SPI_MASTER=y
+
+comment "SPI and I2C RTC drivers"
+
+config RTC_DRV_DS3232
+	tristate "Dallas/Maxim DS3232/DS3234"
+	depends on RTC_I2C_AND_SPI
+	help
+	  If you say yes here you get support for Dallas Semiconductor
+	  DS3232 and DS3234 real-time clock chips. If an interrupt is associated
+	  with the device, the alarm functionality is supported.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called rtc-ds3232.
+
 comment "Platform RTC drivers"
 
 # this 'CMOS' RTC driver is arch dependent because <asm-generic/rtc.h>
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 62d61b2..a396cb8 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -59,7 +59,6 @@ obj-$(CONFIG_RTC_DRV_DS1685_FAMILY)	+= rtc-ds1685.o
 obj-$(CONFIG_RTC_DRV_DS1742)	+= rtc-ds1742.o
 obj-$(CONFIG_RTC_DRV_DS2404)	+= rtc-ds2404.o
 obj-$(CONFIG_RTC_DRV_DS3232)	+= rtc-ds3232.o
-obj-$(CONFIG_RTC_DRV_DS3234)	+= rtc-ds3234.o
 obj-$(CONFIG_RTC_DRV_EFI)	+= rtc-efi.o
 obj-$(CONFIG_RTC_DRV_EM3027)	+= rtc-em3027.o
 obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 3044440..81aa104 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -1,8 +1,9 @@
 /*
- * RTC client/driver for the Maxim/Dallas DS3232 Real-Time Clock over I2C
+ * RTC client/driver for the Maxim/Dallas DS3232/DS3234 Real-Time Clock
  *
  * Copyright (C) 2009-2011 Freescale Semiconductor.
  * Author: Jack Lan <jack.lan@freescale.com>
+ * Copyright (C) 2008 MIMOMax Wireless Ltd.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -16,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/workqueue.h>
@@ -481,6 +483,8 @@ static const struct dev_pm_ops ds3232_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ds3232_suspend, ds3232_resume)
 };
 
+#if IS_ENABLED(CONFIG_I2C)
+
 static int ds3232_i2c_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -520,8 +524,165 @@ static struct i2c_driver ds3232_driver = {
 	.remove = ds3232_i2c_remove,
 	.id_table = ds3232_id,
 };
-module_i2c_driver(ds3232_driver);
+
+static int ds3232_register_driver(void)
+{
+	return i2c_add_driver(&ds3232_driver);
+}
+
+static void ds3232_unregister_driver(void)
+{
+	i2c_del_driver(&ds3232_driver);
+}
+
+#else
+
+static int ds3232_register_driver(void)
+{
+	return 0;
+}
+
+static int ds3232_unregister_driver(void)
+{
+}
+
+#endif
+
+#if IS_ENABLED(CONFIG_SPI_MASTER)
+
+static int ds3234_probe(struct spi_device *spi)
+{
+	int res;
+	unsigned int tmp;
+	static const struct regmap_config config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.write_flag_mask = 0x80,
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
+	spi->mode = SPI_MODE_3;
+	spi->bits_per_word = 8;
+	spi_setup(spi);
+
+	res = regmap_read(regmap, DS3232_REG_SECONDS, &tmp);
+	if (res)
+		return res;
+
+	/* Control settings
+	 *
+	 * CONTROL_REG
+	 * BIT 7	6	5	4	3	2	1	0
+	 *     EOSC	BBSQW	CONV	RS2	RS1	INTCN	A2IE	A1IE
+	 *
+	 *     0	0	0	1	1	1	0	0
+	 *
+	 * CONTROL_STAT_REG
+	 * BIT 7	6	5	4	3	2	1	0
+	 *     OSF	BB32kHz	CRATE1	CRATE0	EN32kHz	BSY	A2F	A1F
+	 *
+	 *     1	0	0	0	1	0	0	0
+	 */
+	res = regmap_read(regmap, DS3232_REG_CR, &tmp);
+	if (res)
+		return res;
+	res = regmap_write(regmap, DS3232_REG_CR, tmp & 0x1c);
+	if (res)
+		return res;
+
+	res = regmap_read(regmap, DS3232_REG_SR, &tmp);
+	if (res)
+		return res;
+	res = regmap_write(regmap, DS3232_REG_SR, tmp & 0x88);
+	if (res)
+		return res;
+
+	/* Print our settings */
+	res = regmap_read(regmap, DS3232_REG_CR, &tmp);
+	if (res)
+		return res;
+	dev_info(&spi->dev, "Control Reg: 0x%02x\n", tmp);
+
+	res = regmap_read(regmap, DS3232_REG_SR, &tmp);
+	if (res)
+		return res;
+	dev_info(&spi->dev, "Ctrl/Stat Reg: 0x%02x\n", tmp);
+
+	return ds3232_probe(&spi->dev, regmap, spi->irq, "ds3234");
+}
+
+static int ds3234_remove(struct spi_device *spi)
+{
+	return ds3232_remove(&spi->dev);
+}
+
+static struct spi_driver ds3234_driver = {
+	.driver = {
+		.name	 = "ds3234",
+	},
+	.probe	 = ds3234_probe,
+	.remove = ds3234_remove,
+};
+
+static int ds3234_register_driver(void)
+{
+	return spi_register_driver(&ds3234_driver);
+}
+
+static void ds3234_unregister_driver(void)
+{
+	spi_unregister_driver(&ds3234_driver);
+}
+
+#else
+
+static int ds3234_register_driver(void)
+{
+	return 0;
+}
+
+static int ds3234_unregister_driver(void)
+{
+}
+
+#endif
+
+static int __init ds323x_init(void)
+{
+	int ret;
+
+	ret = ds3232_register_driver();
+	if (ret) {
+		pr_err("Failed to register ds3232 driver: %d\n", ret);
+		return ret;
+	}
+
+	ret = ds3234_register_driver();
+	if (ret) {
+		pr_err("Failed to register ds3234 driver: %d\n", ret);
+		ds3232_unregister_driver();
+	}
+
+	return ret;
+}
+module_init(ds323x_init)
+
+static void __exit ds323x_exit(void)
+{
+	ds3234_unregister_driver();
+	ds3232_unregister_driver();
+}
+module_exit(ds323x_exit)
 
 MODULE_AUTHOR("Srikanth Srinivasan <srikanth.srinivasan@freescale.com>");
-MODULE_DESCRIPTION("Maxim/Dallas DS3232 RTC Driver");
+MODULE_AUTHOR("Dennis Aberilla <denzzzhome@yahoo.com>");
+MODULE_DESCRIPTION("Maxim/Dallas DS3232/DS3234 RTC Driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:ds3234");
diff --git a/drivers/rtc/rtc-ds3234.c b/drivers/rtc/rtc-ds3234.c
deleted file mode 100644
index 570ab28..0000000
--- a/drivers/rtc/rtc-ds3234.c
+++ /dev/null
@@ -1,171 +0,0 @@
-/* rtc-ds3234.c
- *
- * Driver for Dallas Semiconductor (DS3234) SPI RTC with Integrated Crystal
- * and SRAM.
- *
- * Copyright (C) 2008 MIMOMax Wireless Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/rtc.h>
-#include <linux/spi/spi.h>
-#include <linux/bcd.h>
-
-#define DS3234_REG_SECONDS	0x00
-#define DS3234_REG_MINUTES	0x01
-#define DS3234_REG_HOURS	0x02
-#define DS3234_REG_DAY		0x03
-#define DS3234_REG_DATE		0x04
-#define DS3234_REG_MONTH	0x05
-#define DS3234_REG_YEAR		0x06
-#define DS3234_REG_CENTURY	(1 << 7) /* Bit 7 of the Month register */
-
-#define DS3234_REG_CONTROL	0x0E
-#define DS3234_REG_CONT_STAT	0x0F
-
-static int ds3234_set_reg(struct device *dev, unsigned char address,
-				unsigned char data)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	unsigned char buf[2];
-
-	/* MSB must be '1' to indicate write */
-	buf[0] = address | 0x80;
-	buf[1] = data;
-
-	return spi_write_then_read(spi, buf, 2, NULL, 0);
-}
-
-static int ds3234_get_reg(struct device *dev, unsigned char address,
-				unsigned char *data)
-{
-	struct spi_device *spi = to_spi_device(dev);
-
-	*data = address & 0x7f;
-
-	return spi_write_then_read(spi, data, 1, data, 1);
-}
-
-static int ds3234_read_time(struct device *dev, struct rtc_time *dt)
-{
-	int err;
-	unsigned char buf[8];
-	struct spi_device *spi = to_spi_device(dev);
-
-	buf[0] = 0x00; /* Start address */
-
-	err = spi_write_then_read(spi, buf, 1, buf, 8);
-	if (err != 0)
-		return err;
-
-	/* Seconds, Minutes, Hours, Day, Date, Month, Year */
-	dt->tm_sec	= bcd2bin(buf[0]);
-	dt->tm_min	= bcd2bin(buf[1]);
-	dt->tm_hour	= bcd2bin(buf[2] & 0x3f);
-	dt->tm_wday	= bcd2bin(buf[3]) - 1; /* 0 = Sun */
-	dt->tm_mday	= bcd2bin(buf[4]);
-	dt->tm_mon	= bcd2bin(buf[5] & 0x1f) - 1; /* 0 = Jan */
-	dt->tm_year	= bcd2bin(buf[6] & 0xff) + 100; /* Assume 20YY */
-
-	return rtc_valid_tm(dt);
-}
-
-static int ds3234_set_time(struct device *dev, struct rtc_time *dt)
-{
-	ds3234_set_reg(dev, DS3234_REG_SECONDS, bin2bcd(dt->tm_sec));
-	ds3234_set_reg(dev, DS3234_REG_MINUTES, bin2bcd(dt->tm_min));
-	ds3234_set_reg(dev, DS3234_REG_HOURS, bin2bcd(dt->tm_hour) & 0x3f);
-
-	/* 0 = Sun */
-	ds3234_set_reg(dev, DS3234_REG_DAY, bin2bcd(dt->tm_wday + 1));
-	ds3234_set_reg(dev, DS3234_REG_DATE, bin2bcd(dt->tm_mday));
-
-	/* 0 = Jan */
-	ds3234_set_reg(dev, DS3234_REG_MONTH, bin2bcd(dt->tm_mon + 1));
-
-	/* Assume 20YY although we just want to make sure not to go negative. */
-	if (dt->tm_year > 100)
-		dt->tm_year -= 100;
-
-	ds3234_set_reg(dev, DS3234_REG_YEAR, bin2bcd(dt->tm_year));
-
-	return 0;
-}
-
-static const struct rtc_class_ops ds3234_rtc_ops = {
-	.read_time	= ds3234_read_time,
-	.set_time	= ds3234_set_time,
-};
-
-static int ds3234_probe(struct spi_device *spi)
-{
-	struct rtc_device *rtc;
-	unsigned char tmp;
-	int res;
-
-	spi->mode = SPI_MODE_3;
-	spi->bits_per_word = 8;
-	spi_setup(spi);
-
-	res = ds3234_get_reg(&spi->dev, DS3234_REG_SECONDS, &tmp);
-	if (res != 0)
-		return res;
-
-	/* Control settings
-	 *
-	 * CONTROL_REG
-	 * BIT 7	6	5	4	3	2	1	0
-	 *     EOSC	BBSQW	CONV	RS2	RS1	INTCN	A2IE	A1IE
-	 *
-	 *     0	0	0	1	1	1	0	0
-	 *
-	 * CONTROL_STAT_REG
-	 * BIT 7	6	5	4	3	2	1	0
-	 *     OSF	BB32kHz	CRATE1	CRATE0	EN32kHz	BSY	A2F	A1F
-	 *
-	 *     1	0	0	0	1	0	0	0
-	 */
-	ds3234_get_reg(&spi->dev, DS3234_REG_CONTROL, &tmp);
-	ds3234_set_reg(&spi->dev, DS3234_REG_CONTROL, tmp & 0x1c);
-
-	ds3234_get_reg(&spi->dev, DS3234_REG_CONT_STAT, &tmp);
-	ds3234_set_reg(&spi->dev, DS3234_REG_CONT_STAT, tmp & 0x88);
-
-	/* Print our settings */
-	ds3234_get_reg(&spi->dev, DS3234_REG_CONTROL, &tmp);
-	dev_info(&spi->dev, "Control Reg: 0x%02x\n", tmp);
-
-	ds3234_get_reg(&spi->dev, DS3234_REG_CONT_STAT, &tmp);
-	dev_info(&spi->dev, "Ctrl/Stat Reg: 0x%02x\n", tmp);
-
-	rtc = devm_rtc_device_register(&spi->dev, "ds3234",
-				&ds3234_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
-	spi_set_drvdata(spi, rtc);
-
-	return 0;
-}
-
-static struct spi_driver ds3234_driver = {
-	.driver = {
-		.name	 = "ds3234",
-	},
-	.probe	 = ds3234_probe,
-};
-
-module_spi_driver(ds3234_driver);
-
-MODULE_DESCRIPTION("DS3234 SPI RTC driver");
-MODULE_AUTHOR("Dennis Aberilla <denzzzhome@yahoo.com>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:ds3234");
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
