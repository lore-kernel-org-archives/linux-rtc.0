Return-Path: <rtc-linux+bncBCPM5SUWUYIRBU4XYS5QKGQE3WBZ3PA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com. [2607:f8b0:400e:c00::244])
        by gmr-mx.google.com with ESMTPS id c11si2169679pfc.2.2016.06.27.04.19.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 04:19:47 -0700 (PDT)
Received: by mail-pf0-x244.google.com with SMTP id c74so15620836pfb.0
        for <rtc-linux@googlegroups.com>; Mon, 27 Jun 2016 04:19:47 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Sergey Yanovich <ynvich@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH v2 2/2] rtc: ds1302: support control with using
 GPIO lines
Date: Mon, 27 Jun 2016 20:19:22 +0900
Message-Id: <1467026362-29446-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1467026362-29446-1-git-send-email-akinobu.mita@gmail.com>
References: <1467026362-29446-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This adds support control with GPIO lines connected to the DS1302
which can communicate with three wires.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/rtc/maxim-ds1302.txt       |  13 +
 drivers/rtc/Kconfig                                |  17 +-
 drivers/rtc/rtc-ds1302.c                           | 320 ++++++++++++++++++++-
 3 files changed, 331 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt b/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
index ba470c5..d489753 100644
--- a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
+++ b/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
@@ -27,6 +27,12 @@ Required SPI properties:
 - spi-cs-high: DS-1302 has active high chip select line. This is
   required unless inverted in hardware.
 
+Required properties when using GPIO lines:
+
+- gpio-ce: GPIO connected to CE pin
+- gpio-io: GPIO connected to I/O pin
+- gpio-reset: GPIO connected to SCLK pin
+
 Example:
 
 spi@901c {
@@ -44,3 +50,10 @@ spi@901c {
 		spi-cs-high;
 	};
 };
+
+	rtc: ds1302 {
+		compatible = "maxim,ds1302";
+		gpio-ce = <&gpio2 6 GPIO_ACTIVE_HIGH>;
+		gpio-io = <&gpio2 7 GPIO_ACTIVE_HIGH>;
+		gpio-sclk = <&gpio2 8 GPIO_ACTIVE_HIGH>;
+	};
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 18639e0..618f644 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -616,15 +616,6 @@ config RTC_DRV_M41T94
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-m41t94.
 
-config RTC_DRV_DS1302
-	tristate "Dallas/Maxim DS1302"
-	depends on SPI
-	help
-	  If you say yes here you get support for the Dallas DS1302 RTC chips.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-ds1302.
-
 config RTC_DRV_DS1305
 	tristate "Dallas/Maxim DS1305/DS1306"
 	help
@@ -844,6 +835,14 @@ config RTC_DRV_DS1286
 	help
 	  If you say yes here you get support for the Dallas DS1286 RTC chips.
 
+config RTC_DRV_DS1302
+	tristate "Dallas/Maxim DS1302"
+	help
+	  If you say yes here you get support for the Dallas DS1302 RTC chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ds1302.
+
 config RTC_DRV_DS1511
 	tristate "Dallas DS1511"
 	depends on HAS_IOMEM
diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index 635288d..5a21785 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -19,6 +19,10 @@
 #include <linux/of.h>
 #include <linux/rtc.h>
 #include <linux/spi/spi.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 
 #define DRV_NAME	"rtc-ds1302"
 
@@ -197,6 +201,16 @@ static int ds1302_probe(struct ds1302 *ds1302)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id ds1302_dt_ids[] = {
+	{ .compatible = "maxim,ds1302", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ds1302_dt_ids);
+#endif
+
+#if IS_ENABLED(CONFIG_SPI_MASTER)
+
 static int ds1302_spi_read(struct ds1302 *ds1302, u8 addr, u8 *buf, int size)
 {
 	struct spi_device *spi = to_spi_device(ds1302->dev);
@@ -259,21 +273,307 @@ static int ds1302_spi_probe(struct spi_device *spi)
 	return ds1302_probe(ds1302);
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id ds1302_dt_ids[] = {
-	{ .compatible = "maxim,ds1302", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, ds1302_dt_ids);
-#endif
-
-static struct spi_driver ds1302_driver = {
+static struct spi_driver ds1302_spi_driver = {
 	.driver.name	= "rtc-ds1302",
 	.driver.of_match_table = of_match_ptr(ds1302_dt_ids),
 	.probe		= ds1302_spi_probe,
 };
 
-module_spi_driver(ds1302_driver);
+static int ds1302_spi_register_driver(void)
+{
+	return spi_register_driver(&ds1302_spi_driver);
+}
+
+static void ds1302_spi_unregister_driver(void)
+{
+	spi_unregister_driver(&ds1302_spi_driver);
+}
+
+#else
+
+static int ds1302_spi_register_driver(void)
+{
+	return 0;
+}
+
+static void ds1302_spi_unregister_driver(void)
+{
+}
+
+#endif
+
+/*
+ * ds1302 driver using three GPIO lines
+ *
+ * The information to implement this is gleaned from
+ * http://playground.arduino.cc/Main/DS1302
+ */
+struct ds1302_gpio {
+	struct gpio_desc *gpiod_ce;
+	struct gpio_desc *gpiod_io;
+	struct gpio_desc *gpiod_sclk;
+
+	struct ds1302 ds1302;
+};
+
+static struct ds1302_gpio *to_ds1302_gpio(struct ds1302 *ds1302)
+{
+	return container_of(ds1302, struct ds1302_gpio, ds1302);
+}
+
+static int ds1302_gpio_reset(struct ds1302 *ds1302)
+{
+	struct ds1302_gpio *gpio = to_ds1302_gpio(ds1302);
+	int ret;
+
+	ret = gpiod_direction_output(gpio->gpiod_ce, 0);
+	if (ret)
+		return ret;
+
+	ret = gpiod_direction_output(gpio->gpiod_io, 0);
+	if (ret)
+		return ret;
+
+	return gpiod_direction_output(gpio->gpiod_sclk, 0);
+}
+
+static void ds1302_gpio_chip_enable(struct ds1302 *ds1302, int enable)
+{
+	struct ds1302_gpio *gpio = to_ds1302_gpio(ds1302);
+
+	gpiod_set_value(gpio->gpiod_ce, enable);
+	if (enable) {
+		/*
+		 * tCC (CE to CLK Setup): 4us
+		 */
+		udelay(4);
+	} else {
+		/*
+		 * tCWH (CE Inactive Time): 4us
+		 */
+		udelay(4);
+	}
+}
+
+static int ds1302_gpio_sendbits(struct ds1302 *ds1302, u8 val)
+{
+	struct ds1302_gpio *gpio = to_ds1302_gpio(ds1302);
+	int i;
+
+	for (i = 0; i < 8; i++, val >>= 1) {
+		gpiod_set_value(gpio->gpiod_sclk, 0);
+		/* tCL (CLK Low Time): 1000ns */
+		udelay(1);
+
+		gpiod_set_value(gpio->gpiod_io, val & 0x1);
+		/* tDC (Data to CLK Setup): 200ns */
+		udelay(1);
+
+		gpiod_set_value(gpio->gpiod_sclk, 1);
+		/*
+		 * tCH (CLK High Time): 1000ns
+		 * tCDH (CLK to Data Hold): 800ns
+		 */
+		udelay(1);
+	}
+
+	return 0;
+}
+
+static unsigned int ds1302_gpio_recvbits(struct ds1302 *ds1302)
+{
+	unsigned int val;
+	int i;
+	struct ds1302_gpio *gpio = to_ds1302_gpio(ds1302);
+
+	for (i = 0, val = 0; i < 8; i++) {
+		int bit;
+
+		gpiod_set_value(gpio->gpiod_sclk, 0);
+		/*
+		 * tCL (CLK Low Time): 1000ns
+		 * tCDD (CLK to Data Delay): 800ns
+		 */
+		udelay(1);
+
+		bit = gpiod_get_value(gpio->gpiod_io);
+		if (bit < 0)
+			return bit;
+		val |= bit << i;
+
+		gpiod_set_value(gpio->gpiod_sclk, 1);
+		/* tCH (CLK High Time): 1000ns */
+		udelay(1);
+	}
+
+	return val;
+}
+
+static int ds1302_gpio_read(struct ds1302 *ds1302, u8 addr, u8 *buf, int size)
+{
+	int i;
+	int ret;
+	struct ds1302_gpio *gpio = to_ds1302_gpio(ds1302);
+
+	ret = ds1302_gpio_reset(ds1302);
+	if (ret)
+		return ret;
+
+	ds1302_gpio_chip_enable(ds1302, true);
+
+	ds1302_gpio_sendbits(ds1302, ((addr & 0x3f) << 1) | RTC_CMD_READ);
+
+	ret = gpiod_direction_input(gpio->gpiod_io);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < size; i++) {
+		ret = ds1302_gpio_recvbits(ds1302);
+		if (ret < 0)
+			break;
+		 buf[i] = ret;
+	}
+
+	ds1302_gpio_chip_enable(ds1302, false);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int ds1302_gpio_write(struct ds1302 *ds1302, u8 addr, const u8 *buf,
+			     int size)
+{
+	int err;
+	int i;
+
+	err = ds1302_gpio_reset(ds1302);
+	if (err)
+		return err;
+
+	ds1302_gpio_chip_enable(ds1302, true);
+
+	ds1302_gpio_sendbits(ds1302, ((addr & 0x3f) << 1) | RTC_CMD_WRITE);
+
+	for (i = 0; i < size; i++) {
+		err = ds1302_gpio_sendbits(ds1302, buf[i]);
+		if (err)
+			break;
+	}
+
+	ds1302_gpio_chip_enable(ds1302, false);
+
+	return err;
+}
+
+static const struct ds1302_ops ds1302_gpio_ops = {
+	.read = ds1302_gpio_read,
+	.write = ds1302_gpio_write,
+};
+
+static struct gpio_desc *ds1302_gpiod_request(struct device *dev,
+						const char *name)
+{
+	int gpio;
+	int ret;
+
+	if (!dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	gpio = of_get_named_gpio(dev->of_node, name, 0);
+	if (!gpio_is_valid(gpio))
+		return ERR_PTR(gpio);
+
+	ret = devm_gpio_request_one(dev, gpio, 0, name);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return gpio_to_desc(gpio);
+}
+
+static struct ds1302 *ds1302_gpio_init(struct device *dev)
+{
+	struct ds1302_gpio *ds1302_gpio;
+	struct gpio_desc *gpiod;
+
+	ds1302_gpio = devm_kzalloc(dev, sizeof(*ds1302_gpio), GFP_KERNEL);
+	if (!ds1302_gpio)
+		return ERR_PTR(-ENOMEM);
+
+	ds1302_gpio->ds1302.ops = &ds1302_gpio_ops;
+	ds1302_gpio->ds1302.dev = dev;
+
+	gpiod = ds1302_gpiod_request(dev, "gpio-ce");
+	if (IS_ERR(gpiod))
+		return ERR_CAST(gpiod);
+	ds1302_gpio->gpiod_ce = gpiod;
+
+	gpiod = ds1302_gpiod_request(dev, "gpio-io");
+	if (IS_ERR(gpiod))
+		return ERR_CAST(gpiod);
+	ds1302_gpio->gpiod_io = gpiod;
+
+	gpiod = ds1302_gpiod_request(dev, "gpio-sclk");
+	if (IS_ERR(gpiod))
+		return ERR_CAST(gpiod);
+	ds1302_gpio->gpiod_sclk = gpiod;
+
+	return &ds1302_gpio->ds1302;
+}
+
+static int ds1302_gpio_probe(struct platform_device *pdev)
+{
+	struct ds1302 *ds1302;
+
+	ds1302 = ds1302_gpio_init(&pdev->dev);
+	if (IS_ERR(ds1302))
+		return PTR_ERR(ds1302);
+
+	return ds1302_probe(ds1302);
+}
+
+static struct platform_driver ds1302_gpio_driver = {
+	.probe = ds1302_gpio_probe,
+	.driver		= {
+		.name	= "rtc-ds1302",
+		.of_match_table = of_match_ptr(ds1302_dt_ids),
+	},
+};
+
+static int ds1302_gpio_register_driver(void)
+{
+	return platform_driver_register(&ds1302_gpio_driver);
+}
+
+static void ds1302_gpio_unregister_driver(void)
+{
+	return platform_driver_unregister(&ds1302_gpio_driver);
+}
+
+static int __init ds1302_init(void)
+{
+	int ret;
+
+	ret = ds1302_spi_register_driver();
+	if (ret) {
+		pr_err("Failed to register ds1302 spi driver: %d\n", ret);
+		return ret;
+	}
+
+	ret = ds1302_gpio_register_driver();
+	if (ret) {
+		pr_err("Failed to register ds1302 gpio driver: %d\n", ret);
+		ds1302_spi_unregister_driver();
+	}
+
+	return ret;
+}
+module_init(ds1302_init)
+
+static void __exit ds1302_exit(void)
+{
+	ds1302_spi_unregister_driver();
+	ds1302_gpio_unregister_driver();
+}
+module_exit(ds1302_exit)
 
 MODULE_DESCRIPTION("Dallas DS1302 RTC driver");
 MODULE_AUTHOR("Paul Mundt, David McCullough");
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
