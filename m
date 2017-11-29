Return-Path: <rtc-linux+bncBCO7J6GN7ELBBSM77LIAKGQEBID77HI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com. [2607:f8b0:400e:c00::244])
        by gmr-mx.google.com with ESMTPS id o16si81183ywm.4.2017.11.29.02.45.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Nov 2017 02:45:29 -0800 (PST)
Received: by mail-pf0-x244.google.com with SMTP id d23so1369156pfe.9
        for <rtc-linux@googlegroups.com>; Wed, 29 Nov 2017 02:45:29 -0800 (PST)
From: venkat.prashanth2498@gmail.com
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kumba@gentoo.org,
	Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: rtc-ds1683 Maxim/Dallas I2C compatible
Date: Wed, 29 Nov 2017 16:15:22 +0530
Message-Id: <1511952322-5609-1-git-send-email-venkat.prashanth2498@gmail.com>
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

This is a patch to add support for
maxim/dallas I2C rtc ds1683 chip.

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
 drivers/rtc/Kconfig      |   9 +++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-ds1683.c | 203 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e0e58f3..2528b79 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -294,6 +294,15 @@ config RTC_DRV_DS1672
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds1672.

+config RTC_DRV_DS1683
+	tristate "Dallas/Maxim DS1683"
+	help
+	  If you say yes here you get support for the
+	  Dallas/Maxim DS1683 I2C timekeeping chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ds1683.
+
 config RTC_DRV_HYM8563
 	tristate "Haoyu Microelectronics HYM8563"
 	depends on OF
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 0bf1fc0..a6f4419 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_RTC_DRV_DS1390)	+= rtc-ds1390.o
 obj-$(CONFIG_RTC_DRV_DS1511)	+= rtc-ds1511.o
 obj-$(CONFIG_RTC_DRV_DS1553)	+= rtc-ds1553.o
 obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
+obj-$(CONFIG_RTC_DRV_DS1683)	+= rtc-ds1683.o
 obj-$(CONFIG_RTC_DRV_DS1685_FAMILY)	+= rtc-ds1685.o
 obj-$(CONFIG_RTC_DRV_DS1742)	+= rtc-ds1742.o
 obj-$(CONFIG_RTC_DRV_DS2404)	+= rtc-ds2404.o
diff --git a/drivers/rtc/rtc-ds1683.c b/drivers/rtc/rtc-ds1683.c
index e69de29..7b6dac3 100644
--- a/drivers/rtc/rtc-ds1683.c
+++ b/drivers/rtc/rtc-ds1683.c
@@ -0,0 +1,203 @@
+/* rtc-ds1683.c
+ *
+ * Driver for Maxim/Dallas ds1683, I2C Compatible
+ * Real Time Clock
+ *
+ * Author : Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/i2c.h>
+#include <linux/rtc.h>
+#include <linux/module.h>
+
+/* Registers */
+
+#define ds1683_REG_CNT_BASE	0
+#define ds1683_REG_EVENT	4
+
+#define ds1683_REG_CONTROL_EOSC	0x80
+
+static struct i2c_driver ds1683_driver;
+
+static int ds1683_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	unsigned long time;
+	unsigned char addr = ds1683_REG_CNT_BASE;
+	unsigned char buf[4];
+
+	struct i2c_msg msgs[] = {
+		{	/* setup read pointer */
+			.addr = client->addr,
+			.len = 1,
+			.buf = &addr
+		},
+		{/* read date */
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = 4,
+			.buf = buf
+		},
+	};
+
+	/* read date registers */
+	if ((i2c_transfer(client->adapter, &msgs[0], 2)) != 2) {
+		dev_err(&client->dev, "%s: read error\n", __func__);
+		return -EIO;
+	}
+
+	time = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+
+	rtc_time_to_tm(time, tm);
+
+	return 0;
+}
+
+static int ds1683_set_mmss(struct i2c_client *client, unsigned long secs)
+{
+	int xfer;
+	unsigned char buf[6];
+
+	buf[0] = ds1683_REG_CNT_BASE;
+	buf[1] = secs & 0x000000FF;
+	buf[2] = (secs & 0x0000FF00) >> 8;
+	buf[3] = (secs & 0x00FF0000) >> 16;
+	buf[4] = (secs & 0xFF000000) >> 24;
+	buf[5] = 0;		/* set control reg to enable counting */
+
+	xfer = i2c_master_send(client, buf, 6);
+	if (xfer != 6) {
+		dev_err(&client->dev, "%s: send: %d\n", __func__, xfer);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int ds1683_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	return ds1683_get_datetime(to_i2c_client(dev), tm);
+}
+
+static int ds1683_rtc_set_mmss(struct device *dev, unsigned long secs)
+{
+	return ds1683_set_mmss(to_i2c_client(dev), secs);
+}
+
+static int ds1683_get_control(struct i2c_client *client, u8 *status)
+{
+	unsigned char addr = ds1683_REG_CONTROL;
+
+	struct i2c_msg msgs[] = {
+		{/* setup read pointer */
+			.addr = client->addr,
+			.len = 1,
+			.buf = &addr
+		},
+		{/* read control */
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = 1,
+			.buf = status
+		},
+	};
+
+	/* read control register */
+	if ((i2c_transfer(client->adapter, &msgs[0], 2)) != 2) {
+		dev_err(&client->dev, "%s: read error\n", __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* sysfs callback functions */
+static ssize_t show_control(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 control;
+	int err;
+
+	err = ds1683_get_control(client, &control);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%s\n", (control & ds1683_REG_CONTROL_EOSC)
+		       ? "disabled" : "enabled");
+}
+
+static DEVICE_ATTR(control, 0444, show_control, NULL);
+
+static const struct rtc_class_ops ds1683_rtc_ops = {
+	.read_time = ds1683_rtc_read_time,
+	.set_mmss = ds1683_rtc_set_mmss,
+};
+
+static int ds1683_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	int err = 0;
+	u8 control;
+	struct rtc_device *rtc;
+
+	dev_dbg(&client->dev, "%s\n", __func__);
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	rtc = devm_rtc_device_register(&client->dev, ds1683_driver.driver.name,
+			&ds1683_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	i2c_set_clientdata(client, rtc);
+
+	/* read control register */
+	err = ds1683_get_control(client, &control);
+	if (err)
+		dev_warn(&client->dev, "Unable to read the control register\n");
+
+	if (control & ds1683_REG_CONTROL_EOSC)
+		dev_warn(&client->dev, "Oscillator not enabled Set time to enable.\n");
+
+	/* Register sysfs hooks */
+	err = device_create_file(&client->dev, &dev_attr_control);
+	if (err)
+		dev_err(&client->dev, "Unable to create sysfs entry: %s\n",
+			dev_attr_control.attr.name);
+
+	return 0;
+}
+
+static const struct i2c_device_id ds1683_id[] = {
+	{ "ds1683", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ds1683_id);
+
+static const struct of_device_id ds1683_of_match[] = {
+	{ "dallas,ds1683", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ds1683_of_match);
+
+static struct i2c_driver ds1683_driver = {
+	.driver = {
+		   .name = "rtc-ds1683",
+		   .of_match_table = of_match_ptr(ds1683_of_match),
+	},
+	.probe = &ds1683_probe,
+	.id_table = ds1683_id,
+};
+
+module_i2c_driver(ds1683_driver);
+
+MODULE_AUTHOR("Venkat Prashanth B U <venkat.prashanth2498@gmail.com>");
+MODULE_DESCRIPTION("Dallas/Maxim ds1683 I2C driver");
+MODULE_LICENSE("GPL");
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
