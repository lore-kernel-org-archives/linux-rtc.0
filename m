Return-Path: <alexandre.belloni@free-electrons.com>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: add Abracon ABx80x driver
Date: Sat, 28 Feb 2015 20:14:36 +0100
Message-Id: <1425150876-8141-1-git-send-email-alexandre.belloni@free-electrons.com>
List-ID: <rtc-linux.googlegroups.com>

Add support for the i2c RTC from Abracon.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/Kconfig      |   9 +++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-abx80x.c | 203 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/rtc/rtc-abx80x.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b5b5c3d485d6..e230722fce49 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -174,6 +174,15 @@ config RTC_DRV_AS3722
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-as3722.
 
+config RTC_DRV_ABX80X
+	tristate "Abracon ABx80x"
+	help
+	  If you say yes here you get support for Abracon AB080x and AB180x
+	  real-time clock chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-abx80x.
+
 config RTC_DRV_DS1307
 	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00, EPSON RX-8025"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 69c87062b098..e8e60c2c8aeb 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -22,6 +22,7 @@ rtc-core-$(CONFIG_RTC_INTF_SYSFS) += rtc-sysfs.o
 
 obj-$(CONFIG_RTC_DRV_88PM860X)  += rtc-88pm860x.o
 obj-$(CONFIG_RTC_DRV_88PM80X)	+= rtc-88pm80x.o
+obj-$(CONFIG_RTC_DRV_ABX80X)	+= rtc-abx80x.o
 obj-$(CONFIG_RTC_DRV_AB3100)	+= rtc-ab3100.o
 obj-$(CONFIG_RTC_DRV_AB8500)	+= rtc-ab8500.o
 obj-$(CONFIG_RTC_DRV_ABB5ZES3)	+= rtc-ab-b5ze-s3.o
diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
new file mode 100644
index 000000000000..e51ac5554a9e
--- /dev/null
+++ b/drivers/rtc/rtc-abx80x.c
@@ -0,0 +1,203 @@
+/*
+ * An I2C driver for the Abracon AB08xx
+ *
+ * Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/bcd.h>
+#include <linux/rtc.h>
+#include <linux/log2.h>
+
+#define AB08XX_REG_HTH		0x00
+#define AB08XX_REG_SC		0x01
+#define AB08XX_REG_MN		0x02
+#define AB08XX_REG_HR		0x03
+#define AB08XX_REG_DA		0x04
+#define AB08XX_REG_MO		0x05
+#define AB08XX_REG_YR		0x06
+#define AB08XX_REG_WD		0x07
+
+#define AB08XX_REG_CTRL1	0x10
+
+#define AB08XX_REG_PART0	0x28
+#define AB08XX_REG_PART1	0x29
+
+#define AB08XX_CTRL_WRITE	BIT(1)
+#define AB08XX_CTRL_12_24	BIT(6)
+
+enum ab08xx_chip {ABX80X, AB0801, AB0802, AB0803, AB0804, AB0805,
+		  AB1801, AB1802, AB1803, AB1804, AB1805};
+
+static int ab08xx_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	unsigned char date[8];
+	int err;
+
+	/* Now read time and date */
+	err = i2c_smbus_read_i2c_block_data(client, AB08XX_REG_HTH,
+		8, date);
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to read date\n");
+		return -EIO;
+	}
+
+	tm->tm_sec = bcd2bin(date[AB08XX_REG_SC] & 0x7F);
+	tm->tm_min = bcd2bin(date[AB08XX_REG_MN] & 0x7F);
+	tm->tm_hour = bcd2bin(date[AB08XX_REG_HR] & 0x3F);
+	tm->tm_wday = date[AB08XX_REG_WD] & 0x7;
+	tm->tm_mday = bcd2bin(date[AB08XX_REG_DA] & 0x3F);
+	tm->tm_mon = bcd2bin(date[AB08XX_REG_MO] & 0x1F) - 1;
+	tm->tm_year = bcd2bin(date[AB08XX_REG_YR]);
+	if (tm->tm_year < 70)
+		tm->tm_year += 100;
+
+	err = rtc_valid_tm(tm);
+	if (err < 0)
+		dev_err(&client->dev, "retrieved date/time is not valid.\n");
+
+	return err;
+}
+
+static int ab08xx_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	int data, err;
+	unsigned char buf[8];
+
+	buf[AB08XX_REG_SC] = bin2bcd(tm->tm_sec);
+	buf[AB08XX_REG_MN] = bin2bcd(tm->tm_min);
+	buf[AB08XX_REG_HR] = bin2bcd(tm->tm_hour);
+	buf[AB08XX_REG_DA] = bin2bcd(tm->tm_mday);
+	buf[AB08XX_REG_MO] = bin2bcd(tm->tm_mon + 1);
+	buf[AB08XX_REG_YR] = bin2bcd(tm->tm_year % 100);
+	buf[AB08XX_REG_WD] = (0x1 << tm->tm_wday);
+
+	data = i2c_smbus_read_byte_data(client, AB08XX_REG_CTRL1);
+	if (data < 0) {
+		dev_err(&client->dev, "Unable to read control register\n");
+		return -EIO;
+	}
+
+	err = i2c_smbus_write_byte_data(client, AB08XX_REG_CTRL1,
+		(data | AB08XX_CTRL_WRITE));
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write control register\n");
+		return -EIO;
+	}
+
+	err = i2c_smbus_write_i2c_block_data(client, AB08XX_REG_SC, 7,
+					     &buf[AB08XX_REG_SC]);
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write to date registers\n");
+		return -EIO;
+	}
+
+	err = i2c_smbus_write_byte_data(client, AB08XX_REG_CTRL1,
+		(data & ~AB08XX_CTRL_WRITE));
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write control register\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int ab08xx_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	return ab08xx_get_datetime(to_i2c_client(dev), tm);
+}
+
+static int ab08xx_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	return ab08xx_set_datetime(to_i2c_client(dev), tm);
+}
+
+static const struct rtc_class_ops ab08xx_rtc_ops = {
+	.read_time	= ab08xx_rtc_read_time,
+	.set_time	= ab08xx_rtc_set_time,
+};
+
+static int ab08xx_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct rtc_device *rtc;
+	int data, err, part0, part1;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+
+	part0 = i2c_smbus_read_byte_data(client, AB08XX_REG_PART0);
+	part1 = i2c_smbus_read_byte_data(client, AB08XX_REG_PART1);
+	if ((part0 < 0) || (part1 < 0)) {
+		dev_err(&client->dev, "Unable to read part number\n");
+		return -EIO;
+	}
+	dev_info(&client->dev, "chip found %2x%2x\n", part0, part1);
+
+	data = i2c_smbus_read_byte_data(client, AB08XX_REG_CTRL1);
+	if (data < 0) {
+		dev_err(&client->dev, "Unable to read control register\n");
+		return -EIO;
+	}
+
+	err = i2c_smbus_write_byte_data(client, AB08XX_REG_CTRL1,
+		(data & ~AB08XX_CTRL_12_24));
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write control register\n");
+		return -EIO;
+	}
+
+	rtc = devm_rtc_device_register(&client->dev, "rtc-ab08xx",
+					&ab08xx_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	i2c_set_clientdata(client, rtc);
+
+	return 0;
+}
+
+static int ab08xx_remove(struct i2c_client *client)
+{
+	return 0;
+}
+
+static const struct i2c_device_id ab08xx_id[] = {
+	{ "abx80x", ABX80X },
+	{ "ab0801", AB0801 },
+	{ "ab0802", AB0802 },
+	{ "ab0803", AB0803 },
+	{ "ab0804", AB0804 },
+	{ "ab0805", AB0805 },
+	{ "ab1801", AB1801 },
+	{ "ab1802", AB1802 },
+	{ "ab1803", AB1803 },
+	{ "ab1804", AB1804 },
+	{ "ab1805", AB1805 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ab08xx_id);
+
+static struct i2c_driver ab08xx_driver = {
+	.driver		= {
+		.name	= "rtc-ab08xx",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ab08xx_probe,
+	.remove		= ab08xx_remove,
+	.id_table	= ab08xx_id,
+};
+
+module_i2c_driver(ab08xx_driver);
+
+MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
+MODULE_DESCRIPTION("Abracon AB08xx RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.1.0
