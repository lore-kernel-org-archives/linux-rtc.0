Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:48577 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdJKP6f (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 11 Oct 2017 11:58:35 -0400
Received: by mail-pg0-f44.google.com with SMTP id v78so1215939pgb.5
        for <linux-rtc@vger.kernel.org>; Wed, 11 Oct 2017 08:58:35 -0700 (PDT)
From: Eric Nelson <eric@nelint.com>
To: linux-rtc@vger.kernel.org
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, otavio.salvador@ossystems.com.br,
        festevam@gmail.com, Eric Nelson <eric@nelint.com>
Subject: [PATCH V2] rtc: add support for NXP PCF85363 real-time clock
Date: Wed, 11 Oct 2017 08:56:30 -0700
Message-Id: <1507737390-27818-1-git-send-email-eric@nelint.com>
In-Reply-To: <CAOMZO5C_boginn88C7zgXSBaikx==5FHJrgaE1ewYUyUgGfnFQ@mail.gmail.com>
References: <CAOMZO5C_boginn88C7zgXSBaikx==5FHJrgaE1ewYUyUgGfnFQ@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Note that alarms are not currently implemented.

64 bytes of nvmem is supported and exposed in
sysfs (# is the instance number, starting with 0):

	/sys/bus/nvmem/devices/pcf85363-#/nvmem

Signed-off-by: Eric Nelson <eric@nelint.com>
---
V2 addresses a couple of issues highlighted by Fabio Estevam
    1. Kconfig updated to select REGMAP_I2C
    2. Switch to of_device_id from i2c_device_id for driver matching

 Documentation/devicetree/bindings/rtc/pcf85363.txt |  16 ++
 drivers/rtc/Kconfig                                |  13 ++
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-pcf85363.c                         | 221 +++++++++++++++++++++
 4 files changed, 251 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/pcf85363.txt
 create mode 100644 drivers/rtc/rtc-pcf85363.c

diff --git a/Documentation/devicetree/bindings/rtc/pcf85363.txt b/Documentation/devicetree/bindings/rtc/pcf85363.txt
new file mode 100644
index 0000000..5fddb9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/pcf85363.txt
@@ -0,0 +1,16 @@
+NXP PCF85363 Real Time Clock
+============================
+
+Required properties:
+- compatible: Should contain "nxp,pcf85363".
+- reg: I2C address for chip.
+
+Example:
+
+pcf85363: pcf85363@51 {
+	compatible = "nxp,pcf85363";
+	reg = <0x51>;
+};
+
+Note that alarms are not yet supported, so a specifier for
+"interrupts" will be ignored.
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e0e58f3..15306ed 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -433,6 +433,19 @@ config RTC_DRV_PCF85063
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf85063.
 
+config RTC_DRV_PCF85363
+	tristate "NXP PCF85363"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the PCF85363 RTC chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pcf85363.
+
+	  The nvmem interface will be named pcf85363-#, where # is the
+	  zero-based instance number.
+
 config RTC_DRV_PCF8563
 	tristate "Philips PCF8563/Epson RTC8564"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 7230014..934a9dd 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_RTC_DRV_PCF2123)	+= rtc-pcf2123.o
 obj-$(CONFIG_RTC_DRV_PCF2127)	+= rtc-pcf2127.o
 obj-$(CONFIG_RTC_DRV_PCF50633)	+= rtc-pcf50633.o
 obj-$(CONFIG_RTC_DRV_PCF85063)	+= rtc-pcf85063.o
+obj-$(CONFIG_RTC_DRV_PCF85363)	+= rtc-pcf85363.o
 obj-$(CONFIG_RTC_DRV_PCF8523)	+= rtc-pcf8523.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
 obj-$(CONFIG_RTC_DRV_PCF8583)	+= rtc-pcf8583.o
diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
new file mode 100644
index 0000000..cf1e70c
--- /dev/null
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -0,0 +1,221 @@
+/*
+ * drivers/rtc/rtc-pcf85363.c
+ *
+ * Driver for NXP PCF85363 real-time clock.
+ *
+ * Copyright (C) 2017 Eric Nelson
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Based loosely on rtc-8583 by Russell King, Wolfram Sang and Juergen Beisert
+ */
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/rtc.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/bcd.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+/*
+ * Date/Time registers
+ */
+#define DT_100THS	0x00
+#define DT_SECS		0x01
+#define DT_MINUTES	0x02
+#define DT_HOURS	0x03
+#define DT_DAYS		0x04
+#define DT_WEEKDAYS	0x05
+#define DT_MONTHS	0x06
+#define DT_YEARS	0x07
+
+/*
+ * Alarm registers
+ */
+#define DT_SECOND_ALM1	0x08
+#define DT_MINUTE_ALM1	0x09
+#define DT_HOUR_ALM1	0x0a
+#define DT_DAY_ALM1	0x0b
+#define DT_MONTH_ALM1	0x0c
+#define DT_MINUTE_ALM2	0x0d
+#define DT_HOUR_ALM2	0x0e
+#define DT_WEEKDAY_ALM2	0x0f
+#define DT_ALARM_EN	0x10
+
+/*
+ * Time stamp registers
+ */
+#define DT_TIMESTAMP1	0x11
+#define DT_TIMESTAMP2	0x17
+#define DT_TIMESTAMP3	0x1d
+#define DT_TS_MODE	0x23
+
+/*
+ * control registers
+ */
+#define CTRL_OFFSET	0x24
+#define CTRL_OSCILLATOR	0x25
+#define CTRL_BATTERY	0x26
+#define CTRL_PIN_IO	0x27
+#define CTRL_FUNCTION	0x28
+#define CTRL_INTA_EN	0x29
+#define CTRL_INTB_EN	0x2a
+#define CTRL_FLAGS	0x2b
+#define CTRL_RAMBYTE	0x2c
+#define CTRL_WDOG	0x2d
+#define CTRL_STOP_EN	0x2e
+#define CTRL_RESETS	0x2f
+#define CTRL_RAM	0x40
+
+#define NVRAM_SIZE	0x40
+
+static struct i2c_driver pcf85363_driver;
+
+struct pcf85363 {
+	struct device		*dev;
+	struct rtc_device	*rtc;
+	struct nvmem_config	nvmem_cfg;
+	struct regmap		*regmap;
+};
+
+static int pcf85363_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
+	unsigned char buf[DT_YEARS + 1];
+	int ret, len = sizeof(buf);
+
+	/* read the RTC date and time registers all at once */
+	ret = regmap_bulk_read(pcf85363->regmap, DT_100THS, buf, len);
+	if (ret) {
+		dev_err(dev, "%s: error %d\n", __func__, ret);
+		return ret;
+	}
+
+	tm->tm_year = bcd2bin(buf[DT_YEARS]);
+	/* adjust for 1900 base of rtc_time */
+	tm->tm_year += 100;
+
+	tm->tm_wday = buf[DT_WEEKDAYS] & 7;
+	buf[DT_SECS] &= 0x7F;
+	tm->tm_sec = bcd2bin(buf[DT_SECS]);
+	buf[DT_MINUTES] &= 0x7F;
+	tm->tm_min = bcd2bin(buf[DT_MINUTES]);
+	tm->tm_hour = bcd2bin(buf[DT_HOURS]);
+	tm->tm_mday = bcd2bin(buf[DT_DAYS]);
+	tm->tm_mon = bcd2bin(buf[DT_MONTHS]) - 1;
+
+	return 0;
+}
+
+static int pcf85363_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
+	unsigned char buf[DT_YEARS + 1];
+	int len = sizeof(buf);
+
+	buf[DT_100THS] = 0;
+	buf[DT_SECS] = bin2bcd(tm->tm_sec);
+	buf[DT_MINUTES] = bin2bcd(tm->tm_min);
+	buf[DT_HOURS] = bin2bcd(tm->tm_hour);
+	buf[DT_DAYS] = bin2bcd(tm->tm_mday);
+	buf[DT_WEEKDAYS] = tm->tm_wday;
+	buf[DT_MONTHS] = bin2bcd(tm->tm_mon + 1);
+	buf[DT_YEARS] = bin2bcd(tm->tm_year % 100);
+
+	return regmap_bulk_write(pcf85363->regmap, DT_100THS,
+				 buf, len);
+}
+
+static const struct rtc_class_ops rtc_ops = {
+	.read_time	= pcf85363_rtc_read_time,
+	.set_time	= pcf85363_rtc_set_time,
+};
+
+static int pcf85363_nvram_read(void *priv, unsigned int offset, void *val,
+			       size_t bytes)
+{
+	struct pcf85363 *pcf85363 = priv;
+
+	return regmap_bulk_read(pcf85363->regmap, CTRL_RAM + offset,
+				val, bytes);
+}
+
+static int pcf85363_nvram_write(void *priv, unsigned int offset, void *val,
+				size_t bytes)
+{
+	struct pcf85363 *pcf85363 = priv;
+
+	return regmap_bulk_write(pcf85363->regmap, CTRL_RAM + offset,
+				 val, bytes);
+}
+
+static const struct regmap_config regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int pcf85363_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct pcf85363 *pcf85363;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	pcf85363 = devm_kzalloc(&client->dev, sizeof(struct pcf85363),
+				GFP_KERNEL);
+	if (!pcf85363)
+		return -ENOMEM;
+
+	pcf85363->regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(pcf85363->regmap)) {
+		dev_err(&client->dev, "regmap allocation failed\n");
+		return PTR_ERR(pcf85363->regmap);
+	}
+
+	pcf85363->dev = &client->dev;
+	i2c_set_clientdata(client, pcf85363);
+
+	pcf85363->rtc = devm_rtc_allocate_device(pcf85363->dev);
+	if (IS_ERR(pcf85363->rtc))
+		return PTR_ERR(pcf85363->rtc);
+
+	pcf85363->nvmem_cfg.name = "pcf85363-";
+	pcf85363->nvmem_cfg.word_size = 1;
+	pcf85363->nvmem_cfg.stride = 1;
+	pcf85363->nvmem_cfg.size = NVRAM_SIZE;
+	pcf85363->nvmem_cfg.reg_read = pcf85363_nvram_read;
+	pcf85363->nvmem_cfg.reg_write = pcf85363_nvram_write;
+	pcf85363->nvmem_cfg.priv = pcf85363;
+	pcf85363->rtc->nvmem_config = &pcf85363->nvmem_cfg;
+	pcf85363->rtc->nvram_old_abi = true;
+	pcf85363->rtc->ops = &rtc_ops;
+
+	return rtc_register_device(pcf85363->rtc);
+}
+
+static const struct of_device_id dev_ids[] = {
+	{ .compatible = "nxp,pcf85363" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, dev_ids);
+
+static struct i2c_driver pcf85363_driver = {
+	.driver	= {
+		.name	= "pcf85363",
+		.of_match_table = of_match_ptr(dev_ids),
+	},
+	.probe	= pcf85363_probe,
+};
+
+module_i2c_driver(pcf85363_driver);
+
+MODULE_AUTHOR("Eric Nelson");
+MODULE_DESCRIPTION("pcf85363 I2C RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4
