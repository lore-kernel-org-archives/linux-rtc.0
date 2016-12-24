Return-Path: <rtc-linux+bncBCO7J6GN7ELBBJGN7LBAKGQEABEOGYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com. [2607:f8b0:400e:c05::244])
        by gmr-mx.google.com with ESMTPS id r1si10250688pfg.4.2016.12.24.08.47.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Dec 2016 08:47:32 -0800 (PST)
Received: by mail-pg0-x244.google.com with SMTP id g1so4126292pgn.0
        for <rtc-linux@googlegroups.com>; Sat, 24 Dec 2016 08:47:32 -0800 (PST)
From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: add support for maxim dallas ds1682
Date: Sat, 24 Dec 2016 08:47:14 -0800
Message-Id: <1482598034-3046-1-git-send-email-venkat.prashanth2498@gmail.com>
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

This is a patch to add support for
maxim dallas ds1682 total elapsed time recorder

Signed=E2=80=90off=E2=80=90by: Venkat Prashanth B U <venkat.prashanth2498@g=
mail.com>
---
---
 drivers/rtc/Kconfig      |   9 ++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-ds1682.c | 288 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 298 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e859d14..bcab91f 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -275,6 +275,15 @@ config RTC_DRV_DS1672
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds1672.
=20
+config RTC_DRV_DS1682
+	tristate "Dallas/Maxim DS1682"
+	help
+	  If you say yes here you get support for the
+	  Dallas/Maxim DS1682 total elapsed time recorder.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ds1682.
+
 config RTC_DRV_HYM8563
 	tristate "Haoyu Microelectronics HYM8563"
 	depends on OF
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 1ac694a..70bb28c 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_RTC_DRV_DS1390)	+=3D rtc-ds1390.o
 obj-$(CONFIG_RTC_DRV_DS1511)	+=3D rtc-ds1511.o
 obj-$(CONFIG_RTC_DRV_DS1553)	+=3D rtc-ds1553.o
 obj-$(CONFIG_RTC_DRV_DS1672)	+=3D rtc-ds1672.o
+obj-$(CONFIG_RTC_DRV_DS1682)	+=3D rtc-ds1682.o
 obj-$(CONFIG_RTC_DRV_DS1685_FAMILY)	+=3D rtc-ds1685.o
 obj-$(CONFIG_RTC_DRV_DS1742)	+=3D rtc-ds1742.o
 obj-$(CONFIG_RTC_DRV_DS2404)	+=3D rtc-ds2404.o
diff --git a/drivers/rtc/rtc-ds1682.c b/drivers/rtc/rtc-ds1682.c
index e69de29..fad440e 100644
--- a/drivers/rtc/rtc-ds1682.c
+++ b/drivers/rtc/rtc-ds1682.c
@@ -0,0 +1,288 @@
+/* Driver for Dallas Semiconductor DS1682 2 wire total elapsed
+ * time recorder
+ *
+ * Author : Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rtc.h>
+#include <linux/types.h>
+#include <linux/bcd.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+
+#include <linux/io.h>
+
+#define DS1682_READ_MEMORY_CMD 0x1D
+
+#ifndef __LINUX_DS1682_H
+#define __LINUX_DS1682_H
+
+const struct ds1682_platform_data {
+
+
+	unsigned int gpio_rst;
+	unsigned int gpio_clk;
+	unsigned int gpio_dq;
+};
+#endif
+
+const struct ds1682;
+
+const struct ds1682_chip_ops {
+	int (*map_io)(const struct ds1682 *chip, struct platform_device *pdev,
+		  const struct ds1682_platform_data *pdata);
+	void (*unmap_io)(const struct ds1682 *chip);
+};
+
+#define DS1682_RST	0
+#define DS1682_CLK	1
+#define DS1682_DQ	2
+
+const struct ds1682_gpio {
+	const char *name;
+	unsigned int gpio;
+};
+
+const struct ds1682 {
+	const struct ds1682_gpio *gpio;
+	const struct ds1682_chip_ops *ops;
+	const struct rtc_device *rtc;
+};
+
+const struct ds1682_gpio ds1682_gpio[] =3D {
+	{ "RTC RST", 0 },
+	{ "RTC CLK", 0 },
+	{ "RTC DQ", 0 },
+};
+
+int ds1682_gpio_map(const struct ds1682 *chip, struct platform_device *pde=
v,
+			  const struct ds1682_platform_data *pdata)
+{
+	int i, err;
+
+	ds1682_gpio[DS1682_RST].gpio =3D pdata->gpio_rst;
+	ds1682_gpio[DS1682_CLK].gpio =3D pdata->gpio_clk;
+	ds1682_gpio[DS1682_DQ].gpio =3D pdata->gpio_dq;
+
+	for (i =3D 0; i < ARRAY_SIZE(ds1682_gpio); i++) {
+		err =3D gpio_request(ds1682_gpio[i].gpio, ds1682_gpio[i].name);
+		if (err) {
+			dev_err(&pdev->dev, "error mapping gpio %s: %d\n",
+				ds1682_gpio[i].name, err);
+			goto err_request;
+		}
+		if (i !=3D DS1682_DQ)
+			gpio_direction_output(ds1682_gpio[i].gpio, 1);
+	}
+
+	chip->gpio =3D ds1682_gpio;
+	return 0;
+
+err_request:
+	while (--i >=3D 0)
+		gpio_free(ds1682_gpio[i].gpio);
+	return err;
+}
+
+static void ds1682_gpio_unmap(const struct ds1682 *chip)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(ds1682_gpio); i++)
+		gpio_free(ds1682_gpio[i].gpio);
+}
+
+static const struct ds1682_chip_ops ds1682_gpio_ops =3D {
+	.map_io		=3D ds1682_gpio_map,
+	.unmap_io	=3D ds1682_gpio_unmap,
+};
+
+static void ds1682_reset(const struct device *dev)
+{
+	gpio_set_value(ds1682_gpio[DS1682_RST].gpio, 0);
+	udelay(1000);
+	gpio_set_value(ds1682_gpio[DS1682_RST].gpio, 1);
+	gpio_set_value(ds1682_gpio[DS1682_CLK].gpio, 0);
+	gpio_direction_output(ds1682_gpio[DS1682_DQ].gpio, 0);
+	udelay(10);
+}
+
+static void ds1682_write_byte(const struct device *dev, u8 byte)
+{
+	int i;
+
+	gpio_direction_output(ds1682_gpio[DS1682_DQ].gpio, 1);
+	for (i =3D 0; i < 8; i++) {
+		gpio_set_value(ds1682_gpio[DS1682_DQ].gpio, byte & (1 << i));
+		udelay(10);
+		gpio_set_value(ds1682_gpio[DS1682_CLK].gpio, 1);
+		udelay(10);
+		gpio_set_value(ds1682_gpio[DS1682_CLK].gpio, 0);
+		udelay(10);
+	}
+}
+
+static u8 ds1682_read_byte(const struct device *dev)
+{
+	int i;
+	u8 ret =3D 0;
+
+	gpio_direction_input(ds1682_gpio[DS1682_DQ].gpio);
+
+	for (i =3D 0; i < 8; i++) {
+		gpio_set_value(ds1682_gpio[DS1682_CLK].gpio, 0);
+		udelay(10);
+		if (gpio_get_value(ds1682_gpio[DS1682_DQ].gpio))
+			ret |=3D 1 << i;
+		gpio_set_value(ds1682_gpio[DS1682_CLK].gpio, 1);
+		udelay(10);
+	}
+	return ret;
+}
+
+static void ds1682_read_memory(const struct device *dev, u16 offset,
+			       int length, u8 *out)
+{
+	ds1682_reset(dev);
+	ds1682_write_byte(dev, DS1682_READ_MEMORY_CMD);
+	ds1682_write_byte(dev, offset & 0xff);
+	ds1682_write_byte(dev, (offset >> 8) & 0xff);
+	while (length--)
+		*out++ =3D ds1682_read_byte(dev);
+}
+
+static void ds1682_write_memory(const struct device *dev, u16 offset,
+				int length, u8 *out)
+{
+	int i;
+	u8 ta01, ta02, es;
+
+	ds1682_reset(dev);
+	ds1682_write_byte(dev, offset & 0xff);
+	ds1682_write_byte(dev, (offset >> 8) & 0xff);
+
+	for (i =3D 0; i < length; i++)
+		ds1682_write_byte(dev, out[i]);
+
+	ds1682_reset(dev);
+
+	ta01 =3D ds1682_read_byte(dev);
+	ta02 =3D ds1682_read_byte(dev);
+	es =3D ds1682_read_byte(dev);
+
+	for (i =3D 0; i < length; i++) {
+		if (out[i] !=3D ds1682_read_byte(dev)) {
+			dev_err(dev, "read invalid data\n");
+			return;
+		}
+	}
+
+	ds1682_reset(dev);
+	ds1682_write_byte(dev, ta01);
+	ds1682_write_byte(dev, ta02);
+	ds1682_write_byte(dev, es);
+	gpio_direction_input(ds1682_gpio[DS1682_DQ].gpio);
+	while (gpio_get_value(ds1682_gpio[DS1682_DQ].gpio))
+	;
+}
+
+static void ds1682_enable_osc(const struct device *dev)
+{
+	u8 in[1] =3D { 0x10 }; /* enable oscillator */
+
+	ds1682_write_memory(dev, 0x201, 1, in);
+}
+
+static int ds1682_read_time(const struct device *dev, struct rtc_time *dt)
+{
+	unsigned long time =3D 0;
+
+	ds1682_read_memory(dev, 0x203, 4, (u8 *)&time);
+	time =3D le32_to_cpu(time);
+	rtc_time_to_tm(time, dt);
+	return rtc_valid_tm(dt);
+}
+
+static int ds1682_set_mmss(const struct device *dev, unsigned long secs)
+{
+	u32 time =3D cpu_to_le32(secs);
+
+	ds1682_write_memory(dev, 0x203, 4, (u8 *)&time);
+	return 0;
+}
+
+static const struct rtc_class_ops ds1682_rtc_ops =3D {
+	.read_time	=3D ds1682_read_time,
+	.set_mmss	=3D ds1682_set_mmss,
+};
+
+static int rtc_probe(const struct platform_device *pdev)
+{
+const struct ds1682_platform_data *pdata =3D dev_get_platdata(&pdev->dev);
+	const struct ds1682 *chip;
+	int retval =3D -EBUSY;
+
+chip =3D devm_kzalloc(&pdev->dev, sizeof(const struct ds1682), GFP_KERNEL)=
;
+	if (!chip)
+		return -ENOMEM;
+
+	chip->ops =3D &ds1682_gpio_ops;
+
+	retval =3D chip->ops->map_io(chip, pdev, pdata);
+	if (retval)
+		goto err_chip;
+
+	dev_info(&pdev->dev, "using GPIOs RST:%d, CLK:%d, DQ:%d\n",
+		 chip->gpio[DS1682_RST].gpio, chip->gpio[DS1682_CLK].gpio,
+		 chip->gpio[DS1682_DQ].gpio);
+
+	platform_set_drvdata(pdev, chip);
+
+	chip->rtc =3D devm_rtc_device_register(&pdev->dev, "ds1682",
+					&ds1682_rtc_ops, THIS_MODULE);
+	if (IS_ERR(chip->rtc)) {
+		retval =3D PTR_ERR(chip->rtc);
+		goto err_io;
+	}
+
+	ds1682_enable_osc(&pdev->dev);
+	return 0;
+
+err_io:
+	chip->ops->unmap_io(chip);
+err_chip:
+	return retval;
+}
+
+static int rtc_remove(const struct platform_device *dev)
+{
+const struct ds1682 *chip =3D platform_get_drvdata(dev);
+
+	chip->ops->unmap_io(chip);
+
+	return 0;
+}
+
+const struct platform_driver rtc_device_driver =3D {
+	.probe	=3D rtc_probe,
+	.remove =3D rtc_remove,
+	.driver =3D {
+		.name	=3D "ds1682",
+	},
+};
+module_platform_driver(rtc_device_driver);
+
+MODULE_DESCRIPTION("DS1682 Total Elapsed Time Recorder");
+MODULE_AUTHOR("Venkat Prashanth B U <venkat.prashanth2498@gmail.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ds1682");
+
--=20
1.9.2

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
