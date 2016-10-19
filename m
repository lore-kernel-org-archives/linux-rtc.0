Return-Path: <rtc-linux+bncBCO7J6GN7ELBB5PAT3AAKGQE3DWQMYI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com. [2607:f8b0:400e:c00::242])
        by gmr-mx.google.com with ESMTPS id f3si3281040pfa.0.2016.10.19.10.42.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2016 10:42:12 -0700 (PDT)
Received: by mail-pf0-x242.google.com with SMTP id s8so3025529pfj.2
        for <rtc-linux@googlegroups.com>; Wed, 19 Oct 2016 10:42:12 -0700 (PDT)
From: VENKAT PRASHANTH B U <venkat.prashanth2498@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	VENKAT PRASHANTH B U <venkat.prashanth2498@gmail.com>
Subject: [rtc-linux] [PATCH v2] rtc: add support for rtc NXP pca21125
Date: Wed, 19 Oct 2016 10:41:04 -0700
Message-Id: <1476898864-7004-1-git-send-email-venkat.prashanth2498@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is a patch to add support for
NXP rtc pca21125

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
changelog v2:
1. used the registers defined in pca21125_set_time function
2. code cleanup in the function pca21125_read_time function
3. Write the address on the bus with pca21125_write_reg function
4. code clean up on pca21125_probe function
5. Add the alarm feature support feature in the driver code
6. fixed the indentation of entire file
---
---
 drivers/rtc/Kconfig        |   9 ++
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-pca21125.c | 234 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e215f50..29f40cb 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -739,6 +739,15 @@ config RTC_DRV_PCF2123
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf2123.
 
+config RTC_DRV_PCA21125
+	tristate "NXP PCA21125"
+	help
+	  If you say yes here you get support for the NXP PCA21125
+	  RTC chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pca21125.
+
 config RTC_DRV_MCP795
 	tristate "Microchip MCP795"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 7cf7ad5..41a5807 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_RTC_DRV_OMAP)	+= rtc-omap.o
 obj-$(CONFIG_RTC_DRV_OPAL)	+= rtc-opal.o
 obj-$(CONFIG_RTC_DRV_PALMAS)	+= rtc-palmas.o
 obj-$(CONFIG_RTC_DRV_PCAP)	+= rtc-pcap.o
+obj-$(CONFIG_RTC_DRV_PCA21125)	+= rtc-pca21125.o
 obj-$(CONFIG_RTC_DRV_PCF2123)	+= rtc-pcf2123.o
 obj-$(CONFIG_RTC_DRV_PCF2127)	+= rtc-pcf2127.o
 obj-$(CONFIG_RTC_DRV_PCF50633)	+= rtc-pcf50633.o
diff --git a/drivers/rtc/rtc-pca21125.c b/drivers/rtc/rtc-pca21125.c
index e69de29..536cf50 100644
--- a/drivers/rtc/rtc-pca21125.c
+++ b/drivers/rtc/rtc-pca21125.c
@@ -0,0 +1,234 @@
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
+	#include <linux/interrupt.h>
+	#include <linux/regmap.h>
+	#include <linux/pm.h>
+	#include <linux/pm_wakeirq.h>
+	#include <linux/slab.h>
+
+	/* Registers in pca21125 rtc */
+	#define PCA21125_SECONDS_REG	0x02
+	#define PCA21125_MINUTES_REG	0x03
+	#define PCA21125_HOURS_REG	0x04
+	#define PCA21125_DATE_REG	0x05
+	#define PCA21125_DAY_REG	0x06
+	#define PCA21125_MONTH_REG	0x07
+	#define PCA21125_YEAR_REG	0x08
+	#define PCA21125_CONTROL_REG	0x01
+	#define PCA21125_STATUS_REG	0x00
+	#define PCA21125_CLOCK_BURST	0x0D
+
+	struct pca21125_priv {
+
+	struct spi_device *spi;
+	struct rtc_device *rtc;
+	struct regmap *map;
+	struct mutex mutex;
+	unsigned int irqen;
+	int irq;
+	int alarm_sec;
+	int alarm_min;
+	int alarm_hour;
+	int alarm_mday;
+	};
+
+	static int
+	pca21125_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+	{
+	struct pca21125_priv *priv = dev_get_drvdata(dev);
+	int res = 0;
+	unsigned int stat;
+
+	if (priv->irq <= 0)
+		return -EINVAL;
+
+	mutex_lock(&priv->mutex);
+
+	res = regmap_read(priv->map, PCA21125_STATUS_REG, &stat);
+	if (res)
+		goto out;
+
+	alarm->enabled = !!(priv->irqen & RTC_AF);
+
+	alarm->time.tm_sec = priv->alarm_sec < 0 ? 0 : priv->alarm_sec;
+	alarm->time.tm_min = priv->alarm_min < 0 ? 0 : priv->alarm_min;
+	alarm->time.tm_hour = priv->alarm_hour < 0 ? 0 : priv->alarm_hour;
+	alarm->time.tm_mday = priv->alarm_mday < 0 ? 0 : priv->alarm_mday;
+
+out:
+	mutex_unlock(&priv->mutex);
+	return res;
+	}
+
+	static int
+	pca21125_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+	{
+	struct pca21125_priv *priv = dev_get_drvdata(dev);
+	int res = 0;
+
+	if (priv->irq <= 0)
+		return -EINVAL;
+
+	mutex_lock(&priv->mutex);
+
+	priv->alarm_sec = alarm->time.tm_sec;
+	priv->alarm_min = alarm->time.tm_min;
+	priv->alarm_hour = alarm->time.tm_hour;
+	priv->alarm_mday = alarm->time.tm_mday;
+
+	if (alarm->enabled)
+		priv->irqen |= RTC_AF;
+
+	mutex_unlock(&priv->mutex);
+
+	return res;
+	}
+
+	static int
+	pca21125_read_reg(struct device *dev, unsigned char address,
+				unsigned char *data)
+	{
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned char buf[2];
+
+	/* Set MSB to indicate read */
+	*data = address | 0x80;
+
+	return spi_write_then_read(spi, buf, 1, data, 1);
+	}
+
+	static int
+	pca21125_write_reg(struct device *dev, unsigned char address,
+				unsigned char data)
+	{
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned char buf[2];
+
+	/* MSB must be '0' to write */
+	buf[0] = address & 0x7F;
+	buf[1] = data;
+
+	return spi_write_then_read(spi, buf, 2, NULL, 0);
+	}
+
+	static int
+	pca21125_read_time(struct device *dev, struct rtc_time *dt)
+	{
+	struct spi_device *spi = to_spi_device(dev);
+	int err;
+	unsigned char buf[8];
+
+	buf[0] = 0xbf;		/* Burst read */
+
+	err = spi_write_then_read(spi, buf, 1, buf, 8);
+
+	if (err)
+		return err;
+
+	/* The chip sends data in the order mentioned below*/
+
+	dt->tm_sec = bcd2bin(buf[0]);
+	dt->tm_min = bcd2bin(buf[1]);
+	dt->tm_hour = bcd2bin(buf[2]);
+	dt->tm_mday = bcd2bin(buf[3]);
+	dt->tm_mon = bcd2bin(buf[4]);
+	dt->tm_wday = bcd2bin(buf[5]);
+	dt->tm_year = bcd2bin(buf[6]);
+
+	return rtc_valid_tm(dt);
+	}
+
+	static int
+	pca21125_set_time(struct device *dev, struct rtc_time *dt)
+	{
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned char buf[9];
+
+	dt->tm_year = dt->tm_year + 1900;
+
+	if (dt->tm_year < 100 || dt->tm_year > 199) {
+
+		dev_err(&spi->dev, "Year must be between 2000 and 2099. It's %d.\n",
+				dt->tm_year + 1900);
+			return -EINVAL;
+		}
+
+	/* Remove write protection */
+	pca21125_write_reg(dev, PCA21125_CONTROL_REG, 0);
+
+	pca21125_write_reg(dev, PCA21125_SECONDS_REG, bin2bcd(dt->tm_sec));
+	pca21125_write_reg(dev, PCA21125_MINUTES_REG, bin2bcd(dt->tm_min));
+	pca21125_write_reg(dev, PCA21125_HOURS_REG, bin2bcd(dt->tm_hour));
+	pca21125_write_reg(dev, PCA21125_DATE_REG, bin2bcd(dt->tm_mday));
+	pca21125_write_reg(dev, PCA21125_MONTH_REG, bin2bcd(dt->tm_mon + 1));
+	pca21125_write_reg(dev, PCA21125_DAY_REG, bin2bcd(dt->tm_wday));
+	pca21125_write_reg(dev, PCA21125_YEAR_REG, bin2bcd(dt->tm_year % 100));
+
+	/* Write protect */
+	pca21125_write_reg(dev, PCA21125_CONTROL_REG, 0x80);
+
+	/* write the rtc settings */
+	return spi_write_then_read(spi, buf, 9, NULL, 0);
+	}
+
+	static const struct rtc_class_ops pca21125_rtc_ops = {
+	.read_time = pca21125_read_time,
+	.set_time = pca21125_set_time,
+	.read_alarm = pca21125_read_alarm,
+	.set_alarm = pca21125_set_alarm,
+	};
+
+	static int
+	pca21125_probe(struct spi_device *spi)
+	{
+	struct rtc_device *rtc;
+	unsigned char tmp;
+	int res;
+
+	spi->mode = SPI_MODE_3;
+	spi->bits_per_word = 8;
+	spi_setup(spi);
+
+	res = pca21125_read_reg(&spi->dev, PCA21125_SECONDS_REG, &tmp);
+	if (res != 0)
+		return res;
+
+	rtc = devm_rtc_device_register(&spi->dev, "pca21125",
+					&pca21125_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	spi_set_drvdata(spi, rtc);
+	return 0;
+	}
+
+	static struct spi_driver pca21125_driver = {
+	.driver = {
+			.name = "pca21125",
+			},
+	.probe = pca21125_probe,
+	};
+
+	module_spi_driver(pca21125_driver);
+
+	MODULE_DESCRIPTION("PCA21125 SPI RTC DRIVER");
+	MODULE_AUTHOR("Venkat Prashanth B U <venkat.prashanth2498@gmail.com>");
+	MODULE_LICENSE("GPL v2");
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
