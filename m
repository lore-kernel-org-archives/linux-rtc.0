Return-Path: <rtc-linux+bncBCPM5SUWUYIRBS6A2G3AKGQELT6THRA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com. [2607:f8b0:400e:c00::230])
        by gmr-mx.google.com with ESMTPS id 12si3739497pfb.1.2016.02.29.07.14.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Feb 2016 07:14:19 -0800 (PST)
Received: by mail-pf0-x230.google.com with SMTP id 4so15580308pfd.1
        for <rtc-linux@googlegroups.com>; Mon, 29 Feb 2016 07:14:19 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] [PATCH v3 3/8] rtc: ds3234: use rtc-ds3232 core and
 support alarm
Date: Tue,  1 Mar 2016 00:13:47 +0900
Message-Id: <1456758832-10590-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1456758832-10590-1-git-send-email-akinobu.mita@gmail.com>
References: <1456758832-10590-1-git-send-email-akinobu.mita@gmail.com>
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

Use rtc-ds3232 core module.  This change enables to
support alarm for rtc-ds3234.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dennis Aberilla <denzzzhome@yahoo.com>
---
* v3
- convert to use regmap

 drivers/rtc/Kconfig      |   1 +
 drivers/rtc/rtc-ds3234.c | 141 ++++++++++++++---------------------------------
 2 files changed, 43 insertions(+), 99 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a489d89..cb27ace 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -733,6 +733,7 @@ config RTC_DRV_RS5C348
 
 config RTC_DRV_DS3234
 	tristate "Maxim/Dallas DS3234"
+	select RTC_DRV_DS3232_CORE
 	help
 	  If you say yes here you get support for the
 	  Maxim/Dallas DS3234 SPI RTC chip.
diff --git a/drivers/rtc/rtc-ds3234.c b/drivers/rtc/rtc-ds3234.c
index 570ab28..fb92919 100644
--- a/drivers/rtc/rtc-ds3234.c
+++ b/drivers/rtc/rtc-ds3234.c
@@ -18,105 +18,37 @@
 #include <linux/rtc.h>
 #include <linux/spi/spi.h>
 #include <linux/bcd.h>
+#include <linux/regmap.h>
 
-#define DS3234_REG_SECONDS	0x00
-#define DS3234_REG_MINUTES	0x01
-#define DS3234_REG_HOURS	0x02
-#define DS3234_REG_DAY		0x03
-#define DS3234_REG_DATE		0x04
-#define DS3234_REG_MONTH	0x05
-#define DS3234_REG_YEAR		0x06
-#define DS3234_REG_CENTURY	(1 << 7) /* Bit 7 of the Month register */
+#include "rtc-ds3232.h"
 
 #define DS3234_REG_CONTROL	0x0E
 #define DS3234_REG_CONT_STAT	0x0F
 
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
 static int ds3234_probe(struct spi_device *spi)
 {
-	struct rtc_device *rtc;
-	unsigned char tmp;
 	int res;
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
 
 	spi->mode = SPI_MODE_3;
 	spi->bits_per_word = 8;
 	spi_setup(spi);
 
-	res = ds3234_get_reg(&spi->dev, DS3234_REG_SECONDS, &tmp);
-	if (res != 0)
+	res = regmap_read(regmap, 0, &tmp);
+	if (res)
 		return res;
 
 	/* Control settings
@@ -133,27 +65,38 @@ static int ds3234_probe(struct spi_device *spi)
 	 *
 	 *     1	0	0	0	1	0	0	0
 	 */
-	ds3234_get_reg(&spi->dev, DS3234_REG_CONTROL, &tmp);
-	ds3234_set_reg(&spi->dev, DS3234_REG_CONTROL, tmp & 0x1c);
+	res = regmap_read(regmap, DS3234_REG_CONTROL, &tmp);
+	if (res)
+		return res;
+	res = regmap_write(regmap, DS3234_REG_CONTROL, tmp & 0x1c);
+	if (res)
+		return res;
 
-	ds3234_get_reg(&spi->dev, DS3234_REG_CONT_STAT, &tmp);
-	ds3234_set_reg(&spi->dev, DS3234_REG_CONT_STAT, tmp & 0x88);
+	res = regmap_read(regmap, DS3234_REG_CONT_STAT, &tmp);
+	if (res)
+		return res;
+	res = regmap_write(regmap, DS3234_REG_CONT_STAT, tmp & 0x88);
+	if (res)
+		return res;
 
 	/* Print our settings */
-	ds3234_get_reg(&spi->dev, DS3234_REG_CONTROL, &tmp);
+	res = regmap_read(regmap, DS3234_REG_CONTROL, &tmp);
+	if (res)
+		return res;
 	dev_info(&spi->dev, "Control Reg: 0x%02x\n", tmp);
 
-	ds3234_get_reg(&spi->dev, DS3234_REG_CONT_STAT, &tmp);
+	res = regmap_read(regmap, DS3234_REG_CONT_STAT, &tmp);
+	if (res)
+		return res;
 	dev_info(&spi->dev, "Ctrl/Stat Reg: 0x%02x\n", tmp);
 
-	rtc = devm_rtc_device_register(&spi->dev, "ds3234",
-				&ds3234_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
+	return ds3232_probe(&spi->dev, regmap, spi->irq, "ds3234");
 
-	spi_set_drvdata(spi, rtc);
+}
 
-	return 0;
+static int ds3234_remove(struct spi_device *spi)
+{
+	return ds3232_remove(&spi->dev);
 }
 
 static struct spi_driver ds3234_driver = {
@@ -161,8 +104,8 @@ static struct spi_driver ds3234_driver = {
 		.name	 = "ds3234",
 	},
 	.probe	 = ds3234_probe,
+	.remove = ds3234_remove,
 };
-
 module_spi_driver(ds3234_driver);
 
 MODULE_DESCRIPTION("DS3234 SPI RTC driver");
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
