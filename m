Return-Path: <rtc-linux+bncBCO7J6GN7ELBB54RTHAAKGQE6JRBUVQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id j64si8848wma.1.2016.10.18.09.08.23
        for <rtc-linux@googlegroups.com>;
        Tue, 18 Oct 2016 09:08:23 -0700 (PDT)
Received: from localhost (syi-ogw2-1179.syi.inet.fi [176.72.244.155])
	by mail.free-electrons.com (Postfix) with ESMTPSA id 8626A228D5
	for <rtc-linux@googlegroups.com>; Tue, 18 Oct 2016 18:08:20 +0200 (CEST)
Resent-Message-ID: <20161018160820.dghwdnvkanqertn2@piout.net>
From: VENKAT PRASHANTH B U <venkat.prashanth2498@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: linux-kernel@vger.kernel.org,
	a.zummo@towertech.it,
	VENKAT PRASHANTH B U <venkat.prashanth2498@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: add support for rtc NXP  pca21125
Date: Tue, 18 Oct 2016 07:47:24 -0700
Message-Id: <1476802044-6016-1-git-send-email-venkat.prashanth2498@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is the patch to add support for
NXP rtc pca21125

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
---
 drivers/rtc/Kconfig        |  12 ++++
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-pca21125.c | 164 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e215f50..df10e0e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -686,6 +686,18 @@ config RTC_DRV_MAX6916
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-max6916.
 
+config RTC_DRV_PCA21125
+	tristate "NXP PCA21125"
+	help
+	  If you say yes here you will get support for the
+	  NXP PCA21125 SPI RTC chip.
+
+	  This driver only supports the RTC feature, and not other chip
+	  features such as alarms.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pca21125.
+
 config RTC_DRV_R9701
 	tristate "Epson RTC-9701JE"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 7cf7ad5..2c6af37 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_RTC_DRV_NUC900)	+= rtc-nuc900.o
 obj-$(CONFIG_RTC_DRV_OMAP)	+= rtc-omap.o
 obj-$(CONFIG_RTC_DRV_OPAL)	+= rtc-opal.o
 obj-$(CONFIG_RTC_DRV_PALMAS)	+= rtc-palmas.o
+obj-$(CONFIG_RTC_DRV_PCA21125)	+= rtc-pca21125.o
 obj-$(CONFIG_RTC_DRV_PCAP)	+= rtc-pcap.o
 obj-$(CONFIG_RTC_DRV_PCF2123)	+= rtc-pcf2123.o
 obj-$(CONFIG_RTC_DRV_PCF2127)	+= rtc-pcf2127.o
diff --git a/drivers/rtc/rtc-pca21125.c b/drivers/rtc/rtc-pca21125.c
index e69de29..8d42e4e 100644
--- a/drivers/rtc/rtc-pca21125.c
+++ b/drivers/rtc/rtc-pca21125.c
@@ -0,0 +1,164 @@
+	/* rtc-pca21125.c
+	*
+	* Driver for NXP  PCA21125 CMOS, SPI Compatible
+	* Real Time Clock
+	*
+	* Author : Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
+	*
+	* This program is free software; you can redistribute it and/or modify
+	* it under the terms of the GNU General Public License version 2 as
+	* published by the Free Software Foundation.
+	*
+	*/
+	
+	#include <linux/init.h>
+	#include <linux/module.h>
+	#include <linux/device.h>
+	#include <linux/platform_device.h>
+	#include <linux/rtc.h>
+	#include <linux/spi/spi.h>
+	#include <linux/bcd.h>
+	
+	/* Registers in pca21125 rtc */
+	
+	#define PCA21125_SECONDS_REG	0x02
+	#define PCA21125_MINUTES_REG	0x03
+	#define PCA21125_HOURS_REG		0x04
+	#define PCA21125_DATE_REG		0x05
+	#define PCA21125_DAY_REG		0x06
+	#define PCA21125_MONTH_REG		0x07
+	#define PCA21125_YEAR_REG		0x08
+	#define PCA21125_CONTROL_REG	0x01
+	#define PCA21125_STATUS_REG	0x00
+	#define PCA21125_CLOCK_BURST	0x0D
+	
+	static int pca21125_read_reg(struct device *dev, unsigned char address,
+					unsigned char *data)
+	{
+		struct spi_device *spi = to_spi_device(dev);
+	
+		*data = address | 0x80;
+	
+		return spi_write_then_read(spi, data, 1, data, 1);
+	}
+	
+	static int pca21125_write_reg(struct device *dev, unsigned char address,
+					unsigned char data)
+	{
+		struct spi_device *spi = to_spi_device(dev);
+		unsigned char buf[2];
+	
+		buf[0] = address & 0x7F;
+		buf[1] = data;
+	
+		return spi_write_then_read(spi, buf, 2, NULL, 0);
+	}
+	
+	static int pca21125_read_time(struct device *dev, struct rtc_time *dt)
+	{
+		struct spi_device *spi = to_spi_device(dev);
+		int err;
+		unsigned char buf[8];
+	
+		buf[0] = PCA21125_CLOCK_BURST | 0x80;
+	
+		err = spi_write_then_read(spi, buf, 1, buf, 8);
+	
+		if (err)
+			return err;
+	
+		dt->tm_sec = bcd2bin(buf[0]);
+		dt->tm_min = bcd2bin(buf[1]);
+		dt->tm_hour = bcd2bin(buf[2] & 0x3F);
+		dt->tm_mday = bcd2bin(buf[3]);
+		dt->tm_mon = bcd2bin(buf[4]) - 1;
+		dt->tm_wday = bcd2bin(buf[5]) - 1;
+		dt->tm_year = bcd2bin(buf[6]) + 100;
+	
+		return rtc_valid_tm(dt);
+	}
+	
+	static int pca21125_set_time(struct device *dev, struct rtc_time *dt)
+	{
+		struct spi_device *spi = to_spi_device(dev);
+		unsigned char buf[9];
+	
+		if (dt->tm_year < 100 || dt->tm_year > 199) {
+			dev_err(&spi->dev, "Year must be between 2000 and 2099. It's %d.\n",
+				dt->tm_year + 1900);
+		return -EINVAL;
+		}
+	
+		buf[0] = bin2bcd(dt->tm_sec);
+		buf[1] = bin2bcd(dt->tm_min);
+		buf[2] = (bin2bcd(dt->tm_hour) & 0X3F);
+		buf[3] = bin2bcd(dt->tm_mday);
+		buf[4] = bin2bcd(dt->tm_mon + 1);
+		buf[5] = bin2bcd(dt->tm_wday + 1);
+		buf[6] = bin2bcd(dt->tm_year % 100);
+		buf[7] = bin2bcd(0x00);
+	
+		/* write the rtc settings */
+		return spi_write_then_read(spi, buf, 9, NULL, 0);
+	}
+	
+	static const struct rtc_class_ops pca21125_rtc_ops = {
+		.read_time = pca21125_read_time,
+		.set_time = pca21125_set_time,
+	};
+	
+	static int pca21125_probe(struct spi_device *spi)
+	{
+		struct rtc_device *rtc;
+		unsigned char data;
+		int res;
+	
+		/* spi setup with pca21125 in mode 3 and bits per word as 8 */
+		spi->mode = SPI_MODE_3;
+		spi->bits_per_word = 8;
+		spi_setup(spi);
+	
+		/* RTC Settings */
+		res = pca21125_read_reg(&spi->dev, PCA21125_SECONDS_REG, &data);
+		if (res)
+			return res;
+	
+		/* Disable the write protect of rtc */
+		pca21125_read_reg(&spi->dev, PCA21125_CONTROL_REG, &data);
+		data = data & ~(1 << 7);
+		pca21125_write_reg(&spi->dev, PCA21125_CONTROL_REG, data);
+	
+		/*Enable oscillator,disable oscillator stop flag, glitch filter*/
+		pca21125_read_reg(&spi->dev, PCA21125_STATUS_REG, &data);
+		data = data & 0x1B;
+		pca21125_write_reg(&spi->dev, PCA21125_STATUS_REG, data);
+	
+		/* display the settings */
+		pca21125_read_reg(&spi->dev, PCA21125_CONTROL_REG, &data);
+		dev_info(&spi->dev, "PCA21125 RTC CTRL Reg = 0x%02x\n", data);
+	
+		pca21125_read_reg(&spi->dev, PCA21125_STATUS_REG, &data);
+		dev_info(&spi->dev, "PCA21125 RTC Status Reg = 0x%02x\n", data);
+	
+		rtc = devm_rtc_device_register(&spi->dev, "pca21125",
+							&pca21125_rtc_ops, THIS_MODULE);
+		if (IS_ERR(rtc))
+			return PTR_ERR(rtc);
+	
+		spi_set_drvdata(spi, rtc);
+	
+		return 0;
+	}
+	
+	static struct spi_driver pca21125_driver = {
+		.driver = {
+			.name = "pca21125",
+		},
+		.probe = pca21125_probe,
+	};
+	module_spi_driver(pca21125_driver);
+	
+	MODULE_DESCRIPTION("PCA21125 SPI RTC DRIVER");
+	MODULE_AUTHOR("Venkat Prashanth B U <venkat.prashanth2498@gmail.com>");
+	MODULE_LICENSE("GPL v2");
+	
-- 
1.9.2

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
