Return-Path: <rtc-linux+bncBCO7J6GN7ELBBUPK53IAKGQERX6UQBY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com. [2607:f8b0:400e:c00::236])
        by gmr-mx.google.com with ESMTPS id j129si91433oib.5.2017.11.26.22.48.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 22:48:49 -0800 (PST)
Received: by mail-pf0-x236.google.com with SMTP id q63so5648731pfd.7
        for <rtc-linux@googlegroups.com>; Sun, 26 Nov 2017 22:48:49 -0800 (PST)
From: venkat.prashanth2498@gmail.com
To: alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	a.zummo@towertech.it,
	Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: add support for maxim dallas ds1682
Date: Mon, 27 Nov 2017 12:18:44 +0530
Message-Id: <1511765324-3645-1-git-send-email-venkat.prashanth2498@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>

Add supporting driver for Dallas Semiconductor
DS1682 2 wire total elapsed time recorder.

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
 drivers/rtc/rtc-ds1682.c | 284 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 284 insertions(+)

diff --git a/drivers/rtc/rtc-ds1682.c b/drivers/rtc/rtc-ds1682.c
index e69de29..a21c94d 100644
--- a/drivers/rtc/rtc-ds1682.c
+++ b/drivers/rtc/rtc-ds1682.c
@@ -0,0 +1,284 @@
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
+#include <linux/io.h>
+
+#define DS1682_READ_MEMORY_CMD 0x1D
+
+#ifndef __LINUX_DS1682_H
+#define __LINUX_DS1682_H
+
+const struct ds1682_platform_data {
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
+const struct ds1682_gpio ds1682_gpio[] = {
+	{ "RTC RST", 0 },
+	{ "RTC CLK", 0 },
+	{ "RTC DQ", 0 },
+};
+
+int ds1682_gpio_map(const struct ds1682 *chip, struct platform_device *pdev,
+			  const struct ds1682_platform_data *pdata)
+{
+	int i, err;
+
+	ds1682_gpio[DS1682_RST].gpio = pdata->gpio_rst;
+	ds1682_gpio[DS1682_CLK].gpio = pdata->gpio_clk;
+	ds1682_gpio[DS1682_DQ].gpio = pdata->gpio_dq;
+
+	for (i = 0; i < ARRAY_SIZE(ds1682_gpio); i++) {
+		err = gpio_request(ds1682_gpio[i].gpio, ds1682_gpio[i].name);
+		if (err) {
+			dev_err(&pdev->dev, "error mapping gpio %s: %d\n",
+				ds1682_gpio[i].name, err);
+			goto err_request;
+		}
+		if (i != DS1682_DQ)
+			gpio_direction_output(ds1682_gpio[i].gpio, 1);
+	}
+
+	chip->gpio = ds1682_gpio;
+	return 0;
+
+err_request:
+	while (--i >= 0)
+		gpio_free(ds1682_gpio[i].gpio);
+	return err;
+}
+
+static void ds1682_gpio_unmap(const struct ds1682 *chip)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ds1682_gpio); i++)
+		gpio_free(ds1682_gpio[i].gpio);
+}
+
+static const struct ds1682_chip_ops ds1682_gpio_ops = {
+	.map_io		= ds1682_gpio_map,
+	.unmap_io	= ds1682_gpio_unmap,
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
+	for (i = 0; i < 8; i++) {
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
+	u8 ret = 0;
+
+	gpio_direction_input(ds1682_gpio[DS1682_DQ].gpio);
+
+	for (i = 0; i < 8; i++) {
+		gpio_set_value(ds1682_gpio[DS1682_CLK].gpio, 0);
+		udelay(10);
+		if (gpio_get_value(ds1682_gpio[DS1682_DQ].gpio))
+			ret |= 1 << i;
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
+		*out++ = ds1682_read_byte(dev);
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
+	for (i = 0; i < length; i++)
+		ds1682_write_byte(dev, out[i]);
+
+	ds1682_reset(dev);
+	ta01 = ds1682_read_byte(dev);
+	ta02 = ds1682_read_byte(dev);
+	es = ds1682_read_byte(dev);
+
+	for (i = 0; i < length; i++) {
+		if (out[i] != ds1682_read_byte(dev)) {
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
+while (gpio_get_value(ds1682_gpio[DS1682_DQ].gpio))
+}
+
+static void ds1682_enable_osc(const struct device *dev)
+{
+	u8 in[1] = { 0x10 }; /* enable oscillator */
+
+	ds1682_write_memory(dev, 0x201, 1, in);
+}
+
+static int ds1682_read_time(const struct device *dev, struct rtc_time *dt)
+{
+	unsigned long time = 0;
+
+	ds1682_read_memory(dev, 0x203, 4, (u8 *)&time);
+	time = le32_to_cpu(time);
+	rtc_time_to_tm(time, dt);
+	return rtc_valid_tm(dt);
+}
+
+static int ds1682_set_mmss(const struct device *dev, unsigned long secs)
+{
+	u32 time = cpu_to_le32(secs);
+
+	ds1682_write_memory(dev, 0x203, 4, (u8 *)&time);
+	return 0;
+}
+
+static const struct rtc_class_ops ds1682_rtc_ops = {
+	.read_time	= ds1682_read_time,
+	.set_mmss	= ds1682_set_mmss,
+};
+
+static int rtc_probe(const struct platform_device *pdev)
+{
+const struct ds1682_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	const struct ds1682 *chip;
+	int retval = -EBUSY;
+
+chip = devm_kzalloc(&pdev->dev, sizeof(const struct ds1682), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->ops = &ds1682_gpio_ops;
+
+	retval = chip->ops->map_io(chip, pdev, pdata);
+	if (retval)
+		goto err_chip;
+
+	dev_info(&pdev->dev, "using GPIOs RST:%d, CLK:%d, DQ:%d\n",
+		 chip->gpio[DS1682_RST].gpio, chip->gpio[DS1682_CLK].gpio,
+		 chip->gpio[DS1682_DQ].gpio);
+
+	platform_set_drvdata(pdev, chip);
+
+	chip->rtc = devm_rtc_device_register(&pdev->dev, "ds1682",
+					&ds1682_rtc_ops, THIS_MODULE);
+	if (IS_ERR(chip->rtc)) {
+		retval = PTR_ERR(chip->rtc);
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
+const struct ds1682 *chip = platform_get_drvdata(dev);
+
+	chip->ops->unmap_io(chip);
+
+	return 0;
+}
+
+const struct platform_driver rtc_device_driver = {
+	.probe	= rtc_probe,
+	.remove = rtc_remove,
+	.driver = {
+		.name	= "ds1682",
+	},
+};
+module_platform_driver(rtc_device_driver);
+
+MODULE_DESCRIPTION("DS1682 Total Elapsed Time Recorder");
+MODULE_AUTHOR("Venkat Prashanth B U <venkat.prashanth2498@gmail.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ds1682");

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
