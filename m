Return-Path: <akpm@linux-foundation.org>
Date: Mon, 2 Mar 2015 15:53:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com, Philippe De Muyter <phdm@macqel.be>
Subject: Re: [PATCH v2] rtc: add Abracon ABx80x driver
Message-Id: <20150302155337.7876cfb631552427187c4c0a@linux-foundation.org>
In-Reply-To: <1425205635-3587-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425205635-3587-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <rtc-linux.googlegroups.com>

On Sun,  1 Mar 2015 11:27:15 +0100 Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Add support for the i2c RTC from Abracon.

What is the relationship between this patch and
http://ozlabs.org/~akpm/mmots/broken-out/rtc-add-rtc-abx805-a-driver-for-the-abracon-ab-1805-i2c-rtc.patch?


From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: rtc: add Abracon ABx80x driver

Add support for the i2c RTC from Abracon.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Philippe De Muyter <phdm@macqel.be>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/rtc/Kconfig      |    9 +
 drivers/rtc/Makefile     |    1 
 drivers/rtc/rtc-abx80x.c |  193 +++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)

diff -puN drivers/rtc/Kconfig~rtc-add-abracon-abx80x-driver drivers/rtc/Kconfig
--- a/drivers/rtc/Kconfig~rtc-add-abracon-abx80x-driver
+++ a/drivers/rtc/Kconfig
@@ -164,6 +164,15 @@ config RTC_DRV_ABB5ZES3
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ab-b5ze-s3.
 
+config RTC_DRV_ABX80X
+	tristate "Abracon ABx80x"
+	help
+	  If you say yes here you get support for Abracon AB080x and AB180x
+	  real-time clock chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-abx80x.
+
 config RTC_DRV_AS3722
 	tristate "ams AS3722 RTC driver"
 	depends on MFD_AS3722
diff -puN drivers/rtc/Makefile~rtc-add-abracon-abx80x-driver drivers/rtc/Makefile
--- a/drivers/rtc/Makefile~rtc-add-abracon-abx80x-driver
+++ a/drivers/rtc/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_RTC_DRV_AB3100)	+= rtc-ab31
 obj-$(CONFIG_RTC_DRV_AB8500)	+= rtc-ab8500.o
 obj-$(CONFIG_RTC_DRV_ABB5ZES3)	+= rtc-ab-b5ze-s3.o
 obj-$(CONFIG_RTC_DRV_ABX805)	+= rtc-abx805.o
+obj-$(CONFIG_RTC_DRV_ABX80X)	+= rtc-abx80x.o
 obj-$(CONFIG_RTC_DRV_ARMADA38X)	+= rtc-armada38x.o
 obj-$(CONFIG_RTC_DRV_AS3722)	+= rtc-as3722.o
 obj-$(CONFIG_RTC_DRV_AT32AP700X)+= rtc-at32ap700x.o
diff -puN /dev/null drivers/rtc/rtc-abx80x.c
--- /dev/null
+++ a/drivers/rtc/rtc-abx80x.c
@@ -0,0 +1,193 @@
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
+#define ABX8XX_REG_HTH		0x00
+#define ABX8XX_REG_SC		0x01
+#define ABX8XX_REG_MN		0x02
+#define ABX8XX_REG_HR		0x03
+#define ABX8XX_REG_DA		0x04
+#define ABX8XX_REG_MO		0x05
+#define ABX8XX_REG_YR		0x06
+#define ABX8XX_REG_WD		0x07
+
+#define ABX8XX_REG_CTRL1	0x10
+
+#define ABX8XX_REG_PART0	0x28
+#define ABX8XX_REG_PART1	0x29
+
+#define ABX8XX_CTRL_WRITE	BIT(1)
+#define ABX8XX_CTRL_12_24	BIT(6)
+
+enum abx80x_chip {ABX80X, AB0801, AB0802, AB0803, AB0804, AB0805,
+	AB1801, AB1802, AB1803, AB1804, AB1805};
+
+static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned char date[8];
+	int err;
+
+	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_HTH,
+					    8, date);
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to read date\n");
+		return -EIO;
+	}
+
+	tm->tm_sec = bcd2bin(date[ABX8XX_REG_SC] & 0x7F);
+	tm->tm_min = bcd2bin(date[ABX8XX_REG_MN] & 0x7F);
+	tm->tm_hour = bcd2bin(date[ABX8XX_REG_HR] & 0x3F);
+	tm->tm_wday = date[ABX8XX_REG_WD] & 0x7;
+	tm->tm_mday = bcd2bin(date[ABX8XX_REG_DA] & 0x3F);
+	tm->tm_mon = bcd2bin(date[ABX8XX_REG_MO] & 0x1F) - 1;
+	tm->tm_year = bcd2bin(date[ABX8XX_REG_YR]);
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
+static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int data, err;
+	unsigned char buf[8];
+
+	buf[ABX8XX_REG_SC] = bin2bcd(tm->tm_sec);
+	buf[ABX8XX_REG_MN] = bin2bcd(tm->tm_min);
+	buf[ABX8XX_REG_HR] = bin2bcd(tm->tm_hour);
+	buf[ABX8XX_REG_DA] = bin2bcd(tm->tm_mday);
+	buf[ABX8XX_REG_MO] = bin2bcd(tm->tm_mon + 1);
+	buf[ABX8XX_REG_YR] = bin2bcd(tm->tm_year % 100);
+	buf[ABX8XX_REG_WD] = (0x1 << tm->tm_wday);
+
+	data = i2c_smbus_read_byte_data(client, ABX8XX_REG_CTRL1);
+	if (data < 0) {
+		dev_err(&client->dev, "Unable to read control register\n");
+		return -EIO;
+	}
+
+	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_CTRL1,
+					(data | ABX8XX_CTRL_WRITE));
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write control register\n");
+		return -EIO;
+	}
+
+	err = i2c_smbus_write_i2c_block_data(client, ABX8XX_REG_SC, 7,
+					     &buf[ABX8XX_REG_SC]);
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write to date registers\n");
+		return -EIO;
+	}
+
+	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_CTRL1,
+					(data & ~ABX8XX_CTRL_WRITE));
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write control register\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static const struct rtc_class_ops abx80x_rtc_ops = {
+	.read_time	= abx80x_rtc_read_time,
+	.set_time	= abx80x_rtc_set_time,
+};
+
+static int abx80x_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct rtc_device *rtc;
+	int data, err, part0, part1;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	part0 = i2c_smbus_read_byte_data(client, ABX8XX_REG_PART0);
+	part1 = i2c_smbus_read_byte_data(client, ABX8XX_REG_PART1);
+	if ((part0 < 0) || (part1 < 0)) {
+		dev_err(&client->dev, "Unable to read part number\n");
+		return -EIO;
+	}
+	dev_info(&client->dev, "chip found %02x%02x\n", part0, part1);
+
+	data = i2c_smbus_read_byte_data(client, ABX8XX_REG_CTRL1);
+	if (data < 0) {
+		dev_err(&client->dev, "Unable to read control register\n");
+		return -EIO;
+	}
+
+	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_CTRL1,
+					(data & ~ABX8XX_CTRL_12_24));
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write control register\n");
+		return -EIO;
+	}
+
+	rtc = devm_rtc_device_register(&client->dev, "rtc-abx80x",
+				       &abx80x_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	i2c_set_clientdata(client, rtc);
+
+	return 0;
+}
+
+static int abx80x_remove(struct i2c_client *client)
+{
+	return 0;
+}
+
+static const struct i2c_device_id abx80x_id[] = {
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
+MODULE_DEVICE_TABLE(i2c, abx80x_id);
+
+static struct i2c_driver abx80x_driver = {
+	.driver		= {
+		.name	= "rtc-abx80x",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= abx80x_probe,
+	.remove		= abx80x_remove,
+	.id_table	= abx80x_id,
+};
+
+module_i2c_driver(abx80x_driver);
+
+MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
+MODULE_DESCRIPTION("Abracon ABX80X RTC driver");
+MODULE_LICENSE("GPL");
_
