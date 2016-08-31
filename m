Return-Path: <rtc-linux+bncBDJN3U5DZYHRBEFKTS7AKGQELMEVKOQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com. [2607:f8b0:400e:c03::242])
        by gmr-mx.google.com with ESMTPS id z4si338223pam.0.2016.08.31.10.34.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 10:34:08 -0700 (PDT)
Received: by mail-pa0-x242.google.com with SMTP id cf3so2934972pad.2
        for <rtc-linux@googlegroups.com>; Wed, 31 Aug 2016 10:34:08 -0700 (PDT)
To: a.zummo@towertech.it,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
From: Raghavendra Chandra Ganiga <ravi23ganiga@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: ds1347: changed raw spi calls to register
 map calls
Message-ID: <57C71506.6000202@gmail.com>
Date: Wed, 31 Aug 2016 23:03:58 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

>From 633c012ba6c8f9bc6cf475d2434ca450cd06b18e Mon Sep 17 00:00:00 2001
From: Raghavendra Ganiga <ravi23ganiga@gmail.com>
Date: Wed, 31 Aug 2016 22:56:41 +0530
Subject: [PATCH] rtc: ds1347: changed raw spi calls to register map calls

This patch changes calls of spi read write calls to register map
read and write calls in rtc ds1347

Signed-off-by: Raghavendra Chandra Ganiga <ravi23ganiga@gmail.com>
---
 drivers/rtc/Kconfig      |  1 +
 drivers/rtc/rtc-ds1347.c | 96 ++++++++++++++++++++++++++----------------------
 2 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 4621cd0..da2e331 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -655,6 +655,7 @@ config RTC_DRV_DS1343
 	  will be called rtc-ds1343.
 
 config RTC_DRV_DS1347
+	select REGMAP_SPI
 	tristate "Dallas/Maxim DS1347"
 	help
 	  If you say yes here you get support for the
diff --git a/drivers/rtc/rtc-ds1347.c b/drivers/rtc/rtc-ds1347.c
index 641e8e8..7faf2f0 100644
--- a/drivers/rtc/rtc-ds1347.c
+++ b/drivers/rtc/rtc-ds1347.c
@@ -18,6 +18,7 @@
 #include <linux/rtc.h>
 #include <linux/spi/spi.h>
 #include <linux/bcd.h>
+#include <linux/regmap.h>
 
 /* Registers in ds1347 rtc */
 
@@ -32,37 +33,28 @@
 #define DS1347_STATUS_REG	0x17
 #define DS1347_CLOCK_BURST	0x3F
 
-static int ds1347_read_reg(struct device *dev, unsigned char address,
-				unsigned char *data)
-{
-	struct spi_device *spi = to_spi_device(dev);
-
-	*data = address | 0x80;
-
-	return spi_write_then_read(spi, data, 1, data, 1);
-}
-
-static int ds1347_write_reg(struct device *dev, unsigned char address,
-				unsigned char data)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	unsigned char buf[2];
-
-	buf[0] = address & 0x7F;
-	buf[1] = data;
+static const struct regmap_range ds1347_ranges[] = {
+	{
+		.range_min = DS1347_SECONDS_REG,
+		.range_max = DS1347_STATUS_REG,
+	},
+};
 
-	return spi_write_then_read(spi, buf, 2, NULL, 0);
-}
+static const struct regmap_access_table ds1347_access_table = {
+	.yes_ranges = ds1347_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ds1347_ranges),
+};
 
 static int ds1347_read_time(struct device *dev, struct rtc_time *dt)
 {
 	struct spi_device *spi = to_spi_device(dev);
+	struct regmap *map;
 	int err;
 	unsigned char buf[8];
 
-	buf[0] = DS1347_CLOCK_BURST | 0x80;
+	map = spi_get_drvdata(spi);
 
-	err = spi_write_then_read(spi, buf, 1, buf, 8);
+	err = regmap_bulk_read(map, DS1347_CLOCK_BURST, buf, 8);
 	if (err)
 		return err;
 
@@ -80,25 +72,27 @@ static int ds1347_read_time(struct device *dev, struct rtc_time *dt)
 static int ds1347_set_time(struct device *dev, struct rtc_time *dt)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	unsigned char buf[9];
+	struct regmap *map;
+	unsigned char buf[8];
+
+	map = spi_get_drvdata(spi);
 
-	buf[0] = DS1347_CLOCK_BURST & 0x7F;
-	buf[1] = bin2bcd(dt->tm_sec);
-	buf[2] = bin2bcd(dt->tm_min);
-	buf[3] = (bin2bcd(dt->tm_hour) & 0x3F);
-	buf[4] = bin2bcd(dt->tm_mday);
-	buf[5] = bin2bcd(dt->tm_mon + 1);
-	buf[6] = bin2bcd(dt->tm_wday + 1);
+	buf[0] = bin2bcd(dt->tm_sec);
+	buf[1] = bin2bcd(dt->tm_min);
+	buf[2] = (bin2bcd(dt->tm_hour) & 0x3F);
+	buf[3] = bin2bcd(dt->tm_mday);
+	buf[4] = bin2bcd(dt->tm_mon + 1);
+	buf[5] = bin2bcd(dt->tm_wday + 1);
 
 	/* year in linux is from 1900 i.e in range of 100
 	in rtc it is from 00 to 99 */
 	dt->tm_year = dt->tm_year % 100;
 
-	buf[7] = bin2bcd(dt->tm_year);
-	buf[8] = bin2bcd(0x00);
+	buf[6] = bin2bcd(dt->tm_year);
+	buf[7] = bin2bcd(0x00);
 
 	/* write the rtc settings */
-	return spi_write_then_read(spi, buf, 9, NULL, 0);
+	return regmap_bulk_write(map, DS1347_CLOCK_BURST, buf, 8);
 }
 
 static const struct rtc_class_ops ds1347_rtc_ops = {
@@ -109,35 +103,53 @@ static const struct rtc_class_ops ds1347_rtc_ops = {
 static int ds1347_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
-	unsigned char data;
+	struct regmap_config config;
+	struct regmap *map;
+	unsigned int data;
 	int res;
 
+	memset(&config, 0, sizeof(config));
+	config.reg_bits = 8;
+	config.val_bits = 8;
+	config.read_flag_mask = 0x80;
+	config.max_register = 0x3F;
+	config.wr_table = &ds1347_access_table;
+
 	/* spi setup with ds1347 in mode 3 and bits per word as 8 */
 	spi->mode = SPI_MODE_3;
 	spi->bits_per_word = 8;
 	spi_setup(spi);
 
+	map = devm_regmap_init_spi(spi, &config);
+
+	if (IS_ERR(map)) {
+		dev_err(&spi->dev, "ds1347 regmap init spi failed\n");
+		return PTR_ERR(map);
+	}
+
+	spi_set_drvdata(spi, map);
+
 	/* RTC Settings */
-	res = ds1347_read_reg(&spi->dev, DS1347_SECONDS_REG, &data);
+	res = regmap_read(map, DS1347_SECONDS_REG, &data);
 	if (res)
 		return res;
 
 	/* Disable the write protect of rtc */
-	ds1347_read_reg(&spi->dev, DS1347_CONTROL_REG, &data);
+	regmap_read(map, DS1347_CONTROL_REG, &data);
 	data = data & ~(1<<7);
-	ds1347_write_reg(&spi->dev, DS1347_CONTROL_REG, data);
+	regmap_write(map, DS1347_CONTROL_REG, data);
 
 	/* Enable the oscillator , disable the oscillator stop flag,
 	 and glitch filter to reduce current consumption */
-	ds1347_read_reg(&spi->dev, DS1347_STATUS_REG, &data);
+	regmap_read(map, DS1347_STATUS_REG, &data);
 	data = data & 0x1B;
-	ds1347_write_reg(&spi->dev, DS1347_STATUS_REG, data);
+	regmap_write(map, DS1347_STATUS_REG, data);
 
 	/* display the settings */
-	ds1347_read_reg(&spi->dev, DS1347_CONTROL_REG, &data);
+	regmap_read(map, DS1347_CONTROL_REG, &data);
 	dev_info(&spi->dev, "DS1347 RTC CTRL Reg = 0x%02x\n", data);
 
-	ds1347_read_reg(&spi->dev, DS1347_STATUS_REG, &data);
+	regmap_read(map, DS1347_STATUS_REG, &data);
 	dev_info(&spi->dev, "DS1347 RTC Status Reg = 0x%02x\n", data);
 
 	rtc = devm_rtc_device_register(&spi->dev, "ds1347",
@@ -146,8 +158,6 @@ static int ds1347_probe(struct spi_device *spi)
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
-	spi_set_drvdata(spi, rtc);
-
 	return 0;
 }
 
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
