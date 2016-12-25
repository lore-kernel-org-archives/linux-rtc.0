Return-Path: <rtc-linux+bncBCO7J6GN7ELBBE647XBAKGQEGH3MJPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com. [2607:f8b0:400e:c05::243])
        by gmr-mx.google.com with ESMTPS id z62si10601127pfz.1.2016.12.24.22.58.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Dec 2016 22:58:27 -0800 (PST)
Received: by mail-pg0-x243.google.com with SMTP id n5so5714308pgh.3
        for <rtc-linux@googlegroups.com>; Sat, 24 Dec 2016 22:58:27 -0800 (PST)
From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: manabian@gmail.com,
	a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: add support for rtc NXP pca21125 and pca8565
Date: Sat, 24 Dec 2016 22:58:08 -0800
Message-Id: <1482649088-2845-1-git-send-email-venkat.prashanth2498@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is a patch to support the SPI compatible PCA21125 device
with the I2C based rtc-pcf8563 driver using regmap layer.
Further this patch adds "pca8565" to the set of i2c ids.

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
change log v3:
1. Add a regmap layer to I2C PCF8563 to support SPI PCA21125.
2. Add pca8565 to the set of i2c ids of rtc-pcf8563.
---
---
 drivers/rtc/rtc-pcf8563.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 1227cea..26c8b9b 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -22,6 +22,8 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/err.h>
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
 
 #define PCF8563_REG_ST1		0x00 /* status */
 #define PCF8563_REG_ST2		0x01
@@ -59,6 +61,7 @@
 
 #define PCF8563_SC_LV		0x80 /* low voltage */
 #define PCF8563_MO_C		0x80 /* century */
+#define PCF8563_REG_SR		0x01 /*control-status register*/
 
 static struct i2c_driver pcf8563_driver;
 
@@ -84,6 +87,9 @@ struct pcf8563 {
 	struct i2c_client *client;
 #ifdef CONFIG_COMMON_CLK
 	struct clk_hw		clkout_hw;
+const	struct device *dev;
+const	struct regmap *regmap;
+	bool suspended;
 #endif
 };
 
@@ -629,6 +635,7 @@ static int pcf8563_probe(struct i2c_client *client,
 static const struct i2c_device_id pcf8563_id[] = {
 	{ "pcf8563", 0 },
 	{ "rtc8564", 0 },
+	{ "pca8565", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pcf8563_id);
@@ -636,11 +643,86 @@ MODULE_DEVICE_TABLE(i2c, pcf8563_id);
 #ifdef CONFIG_OF
 static const struct of_device_id pcf8563_of_match[] = {
 	{ .compatible = "nxp,pcf8563" },
+	{ .compatible = "nxp,pca8565" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pcf8563_of_match);
 #endif
 
+#if IS_ENABLED(CONFIG_SPI_MASTER)
+
+static int pca21125_probe(const struct spi_device *spi)
+{
+	int res;
+	unsigned int tmp;
+	static const struct regmap_config config = {
+				.reg_bits = 8,
+				.val_bits = 8,
+				.write_flag_mask = 0x80,
+		};
+const struct regmap *regmap;
+const struct pcf8563 *pcf8563;
+
+	regmap = devm_regmap_init_spi(spi, &config);
+
+			if (IS_ERR(regmap)) {
+				dev_err(&spi->dev, "%s: regmap allocation failed: %ld\n",
+					__func__, PTR_ERR(regmap));
+				return PTR_ERR(regmap);
+		}
+
+	spi->mode = SPI_MODE_3;
+	spi->bits_per_word = 8;
+	spi_setup(spi);
+
+	res = regmap_read(regmap, PCF8563_REG_SC, &tmp);
+
+	if (res)
+		return res;
+	res = regmap_read(regmap, PCF8563_REG_CLKO, &tmp);
+
+	if (res)
+		return res;
+
+	res = regmap_write(regmap, PCF8563_REG_CLKO, tmp & 0x1c);
+
+	if (res)
+		return res;
+
+	res = regmap_read(regmap, PCF8563_REG_SR, &tmp);
+
+	if (res)
+		return res;
+
+	res = regmap_write(regmap, PCF8563_REG_SR, tmp & 0x88);
+
+	if (res)
+		return res;
+
+       /* Print our settings */
+	res = regmap_read(regmap, PCF8563_REG_CLKO, &tmp);
+
+	if (res)
+		return res;
+
+	dev_info(&spi->dev, "Control Reg: 0x%02x\n", tmp);
+	res = regmap_read(regmap, PCF8563_REG_SR, &tmp);
+
+	if (res)
+		return res;
+
+	dev_info(&spi->dev, "Ctrl/Stat Reg: 0x%02x\n", tmp);
+
+	pcf8563->rtc = devm_rtc_device_register(&spi->dev,
+								"pcf8563",
+						&pcf8563_rtc_ops, THIS_MODULE);
+}
+
+const struct spi_driver pca21125_driver = {
+		.driver = {
+				.name    = "pca21125",
+		},
+
 static struct i2c_driver pcf8563_driver = {
 	.driver		= {
 		.name	= "rtc-pcf8563",
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
