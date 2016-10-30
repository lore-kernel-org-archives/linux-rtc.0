Return-Path: <rtc-linux+bncBCO7J6GN7ELBBVOS23AAKGQEVBSPIHI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com. [2607:f8b0:400e:c00::242])
        by gmr-mx.google.com with ESMTPS id h11si3413063pfe.0.2016.10.30.01.03.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2016 01:03:33 -0700 (PDT)
Received: by mail-pf0-x242.google.com with SMTP id s8so5664172pfj.2
        for <rtc-linux@googlegroups.com>; Sun, 30 Oct 2016 01:03:33 -0700 (PDT)
From: VENKAT PRASHANTH B U <venkat.prashanth2498@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	VENKAT PRASHANTH B U <venkat.prashanth2498@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: add support for rtc NXP pca8565
Date: Sun, 30 Oct 2016 01:03:06 -0700
Message-Id: <1477814586-4795-1-git-send-email-venkat.prashanth2498@gmail.com>
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
NXP rtc pca8565

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
---
 drivers/rtc/Kconfig       |   9 ++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-pca8565.c | 221 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e215f50..f28b569 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -392,6 +392,15 @@ config RTC_DRV_PCF8523
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf8523.
 
+config RTC_DRV_PCA8565
+	tristate "NXP PCA8565"
+	help
+	  If you say yes here you get support for the NXP PCA8565 RTC
+	  chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pca8565.
+
 config RTC_DRV_PCF85063
 	tristate "NXP PCF85063"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 7cf7ad5..ec709a4 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_RTC_DRV_OMAP)	+= rtc-omap.o
 obj-$(CONFIG_RTC_DRV_OPAL)	+= rtc-opal.o
 obj-$(CONFIG_RTC_DRV_PALMAS)	+= rtc-palmas.o
 obj-$(CONFIG_RTC_DRV_PCAP)	+= rtc-pcap.o
+obj-$(CONFIG_RTC_DRV_PCA8565)	+= rtc-pca8565.o
 obj-$(CONFIG_RTC_DRV_PCF2123)	+= rtc-pcf2123.o
 obj-$(CONFIG_RTC_DRV_PCF2127)	+= rtc-pcf2127.o
 obj-$(CONFIG_RTC_DRV_PCF50633)	+= rtc-pcf50633.o
diff --git a/drivers/rtc/rtc-pca8565.c b/drivers/rtc/rtc-pca8565.c
index e69de29..ec678ee 100644
--- a/drivers/rtc/rtc-pca8565.c
+++ b/drivers/rtc/rtc-pca8565.c
@@ -0,0 +1,221 @@
+/*
+ * An I2C driver for the PCA8565 RTC
+ *
+ * Author: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/i2c.h>
+#include <linux/bcd.h>
+#include <linux/rtc.h>
+#include <linux/module.h>
+
+#define PCA8565_REG_CTRL1		0x00 /* status */
+#define PCA8565_REG_CTRL1_STOP	BIT(5)
+#define PCA8565_REG_CTRL2		0x01
+#define PCA8565_REG_SC			0x02 /* datetime */
+#define PCA8565_REG_SC_OS		0x80
+#define PCA8565_REG_MN			0x03
+#define PCA8565_REG_HR			0x04
+#define PCA8565_REG_DM			0x05
+#define PCA8565_REG_DW			0x06
+#define PCA8565_REG_MO			0x07
+#define PCA8565_REG_YR			0x08
+
+static struct i2c_driver pca8565_driver;
+
+static int pca8565_stop_clock(struct i2c_client *client, u8 *ctrl1)
+{
+	s32 ret;
+
+	ret = i2c_smbus_read_byte_data(client, PCA8565_REG_CTRL1);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failing to stop the clock\n");
+		return -EIO;
+	}
+
+	/* stop the clock */
+	ret |= PCA8565_REG_CTRL1_STOP;
+
+	ret = i2c_smbus_write_byte_data(client, PCA8565_REG_CTRL1, ret);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failing to stop the clock\n");
+		return -EIO;
+	}
+
+	*ctrl1 = ret;
+
+	return 0;
+}
+
+static int pca8565_start_clock(struct i2c_client *client, u8 ctrl1)
+{
+	s32 ret;
+
+	/* start the clock */
+	ctrl1 &= PCA8565_REG_CTRL1_STOP;
+
+	ret = i2c_smbus_write_byte_data(client, PCA8565_REG_CTRL1, ctrl1);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failing to start the clock\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int pca8565_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	int rc;
+	u8 regs[7];
+
+	/*
+	 * while reading, the time/date registers are blocked and not updated
+	 * anymore until the access is finished. To not lose a second
+	 * event, the access must be finished within one second. So, read all
+	 * time/date registers in one turn.
+	 */
+	rc = i2c_smbus_read_i2c_block_data(client, PCA8565_REG_SC,
+					   sizeof(regs), regs);
+	if (rc != sizeof(regs)) {
+		dev_err(&client->dev, "date/time register read error\n");
+		return -EIO;
+	}
+
+	/* if the clock has lost its power it makes no sense to use its time */
+	if (regs[0] & PCA8565_REG_SC_OS) {
+		dev_warn(&client->dev, "Power loss detected, invalid time\n");
+		return -EINVAL;
+	}
+
+	tm->tm_sec = bcd2bin(regs[0] & 0x7F);
+	tm->tm_min = bcd2bin(regs[1] & 0x7F);
+	tm->tm_hour = bcd2bin(regs[2] & 0x3F); /* rtc hr 0-23 */
+	tm->tm_mday = bcd2bin(regs[3] & 0x3F);
+	tm->tm_wday = regs[4] & 0x07;
+	tm->tm_mon = bcd2bin(regs[5] & 0x1F) - 1; /* rtc mn 1-12 */
+	tm->tm_year = bcd2bin(regs[6]);
+	tm->tm_year += 100;
+
+	return rtc_valid_tm(tm);
+}
+
+static int pca8565_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	int rc;
+	u8 regs[7];
+	u8 ctrl1;
+
+	if ((tm->tm_year < 100) || (tm->tm_year > 199))
+		return -EINVAL;
+
+	/*
+	 * to accurately set the time, reset the divider chain and keep it in
+	 * reset state until all time/date registers are written
+	 */
+	rc = pca8565_stop_clock(client, &ctrl1);
+	if (rc != 0)
+		return rc;
+
+	/* hours, minutes and seconds */
+	regs[0] = bin2bcd(tm->tm_sec) & 0x7F; /* clear OS flag */
+
+	regs[1] = bin2bcd(tm->tm_min);
+	regs[2] = bin2bcd(tm->tm_hour);
+
+	/* Day of month, 1 - 31 */
+	regs[3] = bin2bcd(tm->tm_mday);
+
+	/* Day, 0 - 6 */
+	regs[4] = tm->tm_wday & 0x07;
+
+	/* month, 1 - 12 */
+	regs[5] = bin2bcd(tm->tm_mon + 1);
+
+	/* year and century */
+	regs[6] = bin2bcd(tm->tm_year - 100);
+
+	/* write all registers at once */
+	rc = i2c_smbus_write_i2c_block_data(client, PCA8565_REG_SC,
+					    sizeof(regs), regs);
+	if (rc < 0) {
+		dev_err(&client->dev, "date/time register write error\n");
+		return rc;
+	}
+
+	/*
+	 * Write the control register as a separate action since the size of
+	 * the register space is different between the PCA8565TP and
+	 * PCA8565A devices.  The rollover point can not be used.
+	 */
+	rc = pca8565_start_clock(client, ctrl1);
+	if (rc != 0)
+		return rc;
+
+	return 0;
+}
+
+static int pca8565_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	return pca8565_get_datetime(to_i2c_client(dev), tm);
+}
+
+static int pca8565_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	return pca8565_set_datetime(to_i2c_client(dev), tm);
+}
+
+static const struct rtc_class_ops pca8565_rtc_ops = {
+	.read_time	= pca8565_rtc_read_time,
+	.set_time	= pca8565_rtc_set_time
+};
+
+static int pca8565_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct rtc_device *rtc;
+
+	dev_dbg(&client->dev, "%s\n", __func__);
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	rtc = devm_rtc_device_register(&client->dev,
+				       pca8565_driver.driver.name,
+				       &pca8565_rtc_ops, THIS_MODULE);
+
+	return PTR_ERR_OR_ZERO(rtc);
+}
+
+static const struct i2c_device_id pca8565_id[] = {
+	{ "pca8565", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pca8565_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id pca8565_of_match[] = {
+	{ .compatible = "nxp,pca8565" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pca8565_of_match);
+#endif
+
+static struct i2c_driver pca8565_driver = {
+	.driver		= {
+		.name	= "rtc-pca8565",
+		.of_match_table = of_match_ptr(pca8565_of_match),
+	},
+	.probe		= pca8565_probe,
+	.id_table	= pca8565_id,
+};
+
+module_i2c_driver(pca8565_driver);
+
+MODULE_AUTHOR("Venkat Prashanth B U <venkat.prashanth2498@gmail.com>");
+MODULE_DESCRIPTION("PCA8565 RTC driver");
+MODULE_LICENSE("GPL");
+
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
