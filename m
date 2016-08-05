Return-Path: <rtc-linux+bncBDAKXCE7XADRBBNESO6QKGQEHHTIPHI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com. [2607:f8b0:4001:c0b::241])
        by gmr-mx.google.com with ESMTPS id d6si650374ith.1.2016.08.05.10.51.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Aug 2016 10:51:01 -0700 (PDT)
Received: by mail-it0-x241.google.com with SMTP id u186so2138509ita.1
        for <rtc-linux@googlegroups.com>; Fri, 05 Aug 2016 10:51:01 -0700 (PDT)
From: Ryan Jones <ryan@rjones.io>
To: rtc-linux@googlegroups.com
Cc: Ryan Jones <ryan@rjones.io>
Subject: [rtc-linux] [PATCH] rtc: Add support for RX4035
Date: Fri,  5 Aug 2016 11:54:36 -0600
Message-Id: <1470419676-5616-1-git-send-email-ryan@rjones.io>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add support for spi rtc rx4035. The driver is based off of rtc-rx4581 but
accounts for some discrepancies in device register map/ data transfer format.

Signed-off-by: Ryan Jones <ryan@rjones.io>
---
 drivers/rtc/Kconfig      |   8 ++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-rx4035.c | 222 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 drivers/rtc/rtc-rx4035.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e215f50..257808d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -695,6 +695,14 @@ config RTC_DRV_R9701
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-r9701.
 
+config RTC_DRV_RX4035
+	tristate "Epson RX-4035"
+	help
+	  If you say yes here you will get support for the Epson RX-4035.
+
+	  This driver can also be built as a module. If so the module
+	  will be called rtc-rx4035.
+
 config RTC_DRV_RX4581
 	tristate "Epson RX-4581"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 7cf7ad5..1c86a65 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -129,6 +129,7 @@ obj-$(CONFIG_RTC_DRV_RS5C348)	+= rtc-rs5c348.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
 obj-$(CONFIG_RTC_DRV_RV3029C2)	+= rtc-rv3029c2.o
 obj-$(CONFIG_RTC_DRV_RV8803)	+= rtc-rv8803.o
+obj-$(CONFIG_RTC_DRV_RX4035)	+= rtc-rx4035.o
 obj-$(CONFIG_RTC_DRV_RX4581)	+= rtc-rx4581.o
 obj-$(CONFIG_RTC_DRV_RX6110)	+= rtc-rx6110.o
 obj-$(CONFIG_RTC_DRV_RX8010)	+= rtc-rx8010.o
diff --git a/drivers/rtc/rtc-rx4035.c b/drivers/rtc/rtc-rx4035.c
new file mode 100644
index 0000000..82f26a8
--- /dev/null
+++ b/drivers/rtc/rtc-rx4035.c
@@ -0,0 +1,222 @@
+/* drivers/rtc/rtc-rx4035.c
+ *
+ * written by Ryan Jones <ryan@rjones.io>
+ *
+ * RTC SPI Driver for Epson RX4035
+ *
+ * Based on:
+ * drivers/rtc/rtc-rx4581.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/rtc.h>
+#include <linux/spi/spi.h>
+#include <linux/bcd.h>
+
+#define RX4035_REG_SC		0x00 /* Second in BCD */
+#define RX4035_REG_MN		0x01 /* Minute in BCD */
+#define RX4035_REG_HR		0x02 /* Hour in BCD */
+#define RX4035_REG_DW		0x03 /* Day of Week */
+#define RX4035_REG_DM		0x04 /* Day of Month in BCD */
+#define RX4035_REG_MO		0x05 /* Month in BCD */
+#define RX4035_REG_YR		0x06 /* Year in BCD */
+#define RX4035_REG_RAM		0x0D /* RAM */
+#define RX4035_REG_CTL1		0x0E /* Control Register 1*/
+#define RX4035_REG_CTL2		0x0F /* Control Register 2*/
+
+/* Flag Register bit definitions */
+#define RX4035_FLAG_VDET	0x40 /* Low Voltage Detection */
+#define RX4035_FLAG_PON		0x10 /* Indicates a Power On condition */
+
+static int rx4035_set_reg(struct spi_device *spi, unsigned char address,
+	unsigned char data)
+{
+	unsigned char buf[2];
+
+	/*Set MSB to indicate a write transfer*/
+	buf[0] = (address<<4) | 0x08;
+	buf[1] = data;
+
+	return spi_write_then_read(spi, buf, 2, NULL, 0);
+}
+
+static int rx4035_get_reg(struct spi_device *spi, unsigned char address,
+	unsigned char *data)
+{
+	/*Set MSB to indicate a write transfer*/
+	*data = (address<<4) | 0x0c;
+
+	return spi_write_then_read(spi, data, 1, data, 1);
+}
+
+/*
+ * In the routines that deal directly with the rx4035 hardware, we use
+ * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
+ */
+static int rx4035_get_datetime(struct device *dev, struct rtc_time *tm)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned char date[7];
+	unsigned char data;
+	int err;
+
+	/*Check that data is reliable*/
+	err = rx4035_get_reg(spi, RX4035_REG_CTL1, &data);
+	if (err != 0) {
+		dev_err(dev, "Unable to read control register\n");
+		return -EIO;
+	}
+	if (data & (RX4035_FLAG_VDET | RX4035_FLAG_PON))
+		dev_err(dev, "RTC DATA UNRELIABLE - battery voltage fell below minimum value\n");
+
+	/* Read time and date */
+	date[0] = 0x04;
+	err = spi_write_then_read(spi, date, 1, date, 7);
+	if (err < 0) {
+		dev_err(dev, "Unable to read date\n");
+		return -EIO;
+	}
+
+	dev_dbg(dev,
+		"%s: raw data is sec=%02x, min=%02x, hr=%02x, wday=%02x, mday=%02x, mon=%02x, year=%02x\n",
+		__func__,
+		date[0], date[1], date[2], date[3], date[4], date[5], date[6]);
+
+	tm->tm_sec = bcd2bin(date[RX4035_REG_SC] & 0x7F);
+	tm->tm_min = bcd2bin(date[RX4035_REG_MN] & 0x7F);
+	tm->tm_hour = bcd2bin(date[RX4035_REG_HR] & 0x3F); /* rtc hr 0-23 */
+	tm->tm_wday = date[RX4035_REG_DW] & 0x7F;
+	tm->tm_mday = bcd2bin(date[RX4035_REG_DM] & 0x3F);
+	tm->tm_mon = bcd2bin(date[RX4035_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
+	tm->tm_year = bcd2bin(date[RX4035_REG_YR]);
+	if (tm->tm_year < 70)
+		tm->tm_year += 100; /* assume we are in 1970...2069 */
+
+	dev_dbg(dev,
+		"%s: tm is secs=%d, mins=%d, hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
+		__func__,
+		tm->tm_sec, tm->tm_min, tm->tm_hour,
+		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+
+	err = rtc_valid_tm(tm);
+	if (err < 0)
+		dev_err(dev, "retrieved date/time is not valid.\n");
+
+	return err;
+}
+
+static int rx4035_set_datetime(struct device *dev, struct rtc_time *tm)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int err;
+	unsigned char buf[8], *data;
+
+	data = buf;
+
+	/*
+	 *		Clear power-on / low voltage flags
+	 * We aren't concerned if this is the first power up or if data
+	 * is unreliable in date setting operations - clear flags
+	 */
+	err = rx4035_get_reg(spi, RX4035_REG_CTL1, data);
+	if (err != 0) {
+		dev_err(dev, "Unable to read control register\n");
+		return -EIO;
+	}
+
+	*data &= ~(RX4035_FLAG_PON|RX4035_FLAG_VDET);
+
+	err = rx4035_set_reg(spi, RX4035_REG_CTL1, *data);
+	if (err != 0) {
+		dev_err(dev, "Unable to load control register\n");
+		return -EIO;
+	}
+
+	dev_dbg(dev, "%s: secs=%d, mins=%d, hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
+		__func__,
+		tm->tm_sec, tm->tm_min, tm->tm_hour,
+		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+
+	/*Set write xfer format address 0 and offset*/
+	*data++ = 0x00;
+
+	/* minutes and seconds */
+	data[RX4035_REG_SC] = bin2bcd(tm->tm_sec);
+	data[RX4035_REG_MN] = bin2bcd(tm->tm_min);
+
+	/*hours, indicating 24 hour mode*/
+	data[RX4035_REG_HR] = bin2bcd(tm->tm_hour) | 0x80;
+
+	data[RX4035_REG_DM] = bin2bcd(tm->tm_mday);
+
+	/* month, 1 - 12 */
+	data[RX4035_REG_MO] = bin2bcd(tm->tm_mon + 1);
+
+	/* year and century */
+	data[RX4035_REG_YR] = bin2bcd(tm->tm_year % 100);
+
+	/* day of week */
+	data[RX4035_REG_DW] = tm->tm_wday;
+
+	/* write time data */
+	err = spi_write_then_read(spi, buf, 8, NULL, 0);
+	if (err != 0) {
+		dev_err(dev, "Unable to write to date registers\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static const struct rtc_class_ops rx4035_rtc_ops = {
+	.read_time	= rx4035_get_datetime,
+	.set_time	= rx4035_set_datetime,
+};
+
+static int rx4035_probe(struct spi_device *spi)
+{
+	struct rtc_device *rtc;
+	unsigned char tmp;
+	int res;
+
+	res = rx4035_get_reg(spi, RX4035_REG_SC, &tmp);
+	if (res != 0)
+		return res;
+
+	rtc = devm_rtc_device_register(&spi->dev, "rx4035",
+		&rx4035_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	spi_set_drvdata(spi, rtc);
+	return 0;
+}
+
+static const struct spi_device_id rx4035_id[] = {
+	{ "rx4035", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, rx4035_id);
+
+static struct spi_driver rx4035_driver = {
+	.driver = {
+		.name = "rtc-rx4035",
+	},
+	.probe = rx4035_probe,
+	.id_table = rx4035_id,
+};
+
+module_spi_driver(rx4035_driver);
+
+MODULE_DESCRIPTION("rx4035 spi RTC driver");
+MODULE_AUTHOR("Ryan Jones");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:rtc-rx4035");
-- 
2.1.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
