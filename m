Return-Path: <rtc-linux+bncBDS7HNEFSALRBRGQ36YQKGQEGCUF7XA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s134si539470wmb.3.2015.11.02.14.48.36
        for <rtc-linux@googlegroups.com>;
        Mon, 02 Nov 2015 14:48:36 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCHv2] rtc: Add a driver for Micro Crystal RV8803
Date: Mon,  2 Nov 2015 23:48:32 +0100
Message-Id: <1446504512-9079-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

This driver supports the following functions:
 - reading and settings time
 - alarms when connected to an IRQ
 - reading and clearing the voltage low flags
 - nvram

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---

Changes in v2:
 - Added locking around the flags modifications
 - return IRQ_NONE when no irq condition is met
 - register alarm callbacks only when irq registration succeed

 drivers/rtc/Kconfig      |   9 +
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-rv8803.c | 521 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 531 insertions(+)
 create mode 100644 drivers/rtc/rtc-rv8803.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 9d4290617cee..3ae131334a84 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -593,6 +593,15 @@ config RTC_DRV_RV3029C2
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-rv3029c2.
 
+config RTC_DRV_RV8803
+	tristate "Micro Crystal RV8803"
+	help
+	  If you say yes here you get support for the Micro Crystal
+	  RV8803 RTC chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-rv8803.
+
 config RTC_DRV_S5M
 	tristate "Samsung S2M/S5M series"
 	depends on MFD_SEC_CORE
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index e491eb524434..231f76451615 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_RTC_DRV_RS5C313)	+= rtc-rs5c313.o
 obj-$(CONFIG_RTC_DRV_RS5C348)	+= rtc-rs5c348.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
 obj-$(CONFIG_RTC_DRV_RV3029C2)	+= rtc-rv3029c2.o
+obj-$(CONFIG_RTC_DRV_RV8803)	+= rtc-rv8803.o
 obj-$(CONFIG_RTC_DRV_RX4581)	+= rtc-rx4581.o
 obj-$(CONFIG_RTC_DRV_RX8025)	+= rtc-rx8025.o
 obj-$(CONFIG_RTC_DRV_RX8581)	+= rtc-rx8581.o
diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
new file mode 100644
index 000000000000..63244eb1123a
--- /dev/null
+++ b/drivers/rtc/rtc-rv8803.c
@@ -0,0 +1,521 @@
+/*
+ * RTC driver for the Micro Crystal RV8803
+ *
+ * Copyright (C) 2015 Micro Crystal SA
+ *
+ * Alexandre Belloni <alexandre.belloni@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/bcd.h>
+#include <linux/bitops.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rtc.h>
+
+#define RV8803_SEC			0x00
+#define RV8803_MIN			0x01
+#define RV8803_HOUR			0x02
+#define RV8803_WEEK			0x03
+#define RV8803_DAY			0x04
+#define RV8803_MONTH			0x05
+#define RV8803_YEAR			0x06
+#define RV8803_RAM			0x07
+#define RV8803_ALARM_MIN		0x08
+#define RV8803_ALARM_HOUR		0x09
+#define RV8803_ALARM_WEEK_OR_DAY	0x0A
+#define RV8803_EXT			0x0D
+#define RV8803_FLAG			0x0E
+#define RV8803_CTRL			0x0F
+
+#define RV8803_EXT_WADA			BIT(6)
+
+#define RV8803_FLAG_V1F			BIT(0)
+#define RV8803_FLAG_V2F			BIT(1)
+#define RV8803_FLAG_AF			BIT(3)
+#define RV8803_FLAG_TF			BIT(4)
+#define RV8803_FLAG_UF			BIT(5)
+
+#define RV8803_CTRL_RESET		BIT(0)
+
+#define RV8803_CTRL_EIE			BIT(2)
+#define RV8803_CTRL_AIE			BIT(3)
+#define RV8803_CTRL_TIE			BIT(4)
+#define RV8803_CTRL_UIE			BIT(5)
+
+struct rv8803_data {
+	struct i2c_client *client;
+	struct rtc_device *rtc;
+	spinlock_t flags_lock;
+	u8 ctrl;
+};
+
+static irqreturn_t rv8803_handle_irq(int irq, void *dev_id)
+{
+	struct i2c_client *client = dev_id;
+	struct rv8803_data *rv8803 = i2c_get_clientdata(client);
+	unsigned long events = 0;
+	u8 flags;
+
+	spin_lock(&rv8803->flags_lock);
+
+	flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
+	if (flags <= 0) {
+		spin_unlock(&rv8803->flags_lock);
+		return IRQ_NONE;
+	}
+
+	if (flags & RV8803_FLAG_V1F)
+		dev_warn(&client->dev, "Voltage low, temperature compensation stopped.\n");
+
+	if (flags & RV8803_FLAG_V2F)
+		dev_warn(&client->dev, "Voltage low, data loss detected.\n");
+
+	if (flags & RV8803_FLAG_TF) {
+		flags &= ~RV8803_FLAG_TF;
+		rv8803->ctrl &= ~RV8803_CTRL_TIE;
+		events |= RTC_PF;
+	}
+
+	if (flags & RV8803_FLAG_AF) {
+		flags &= ~RV8803_FLAG_AF;
+		rv8803->ctrl &= ~RV8803_CTRL_AIE;
+		events |= RTC_AF;
+	}
+
+	if (flags & RV8803_FLAG_UF) {
+		flags &= ~RV8803_FLAG_UF;
+		rv8803->ctrl &= ~RV8803_CTRL_UIE;
+		events |= RTC_UF;
+	}
+
+	if (events) {
+		rtc_update_irq(rv8803->rtc, 1, events);
+		i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);
+		i2c_smbus_write_byte_data(rv8803->client, RV8803_CTRL,
+					  rv8803->ctrl);
+	}
+
+	spin_unlock(&rv8803->flags_lock);
+
+	return IRQ_HANDLED;
+}
+
+static int rv8803_get_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rv8803_data *rv8803 = dev_get_drvdata(dev);
+	u8 date1[7];
+	u8 *date = date1;
+	int ret, flags;
+
+	flags = i2c_smbus_read_byte_data(rv8803->client, RV8803_FLAG);
+	if (flags < 0)
+		return flags;
+
+	if (flags & RV8803_FLAG_V2F) {
+		dev_warn(dev, "Voltage low, data is invalid.\n");
+		return -EINVAL;
+	}
+
+	ret = i2c_smbus_read_i2c_block_data(rv8803->client, RV8803_SEC,
+					    7, date);
+	if (ret != 7)
+		return ret < 0 ? ret : -EIO;
+
+	if ((date1[RV8803_SEC] & 0x7f) == bin2bcd(59)) {
+		u8 date2[7];
+
+		ret = i2c_smbus_read_i2c_block_data(rv8803->client, RV8803_SEC,
+						    7, date2);
+		if (ret != 7)
+			return ret < 0 ? ret : -EIO;
+
+		if ((date2[RV8803_SEC] & 0x7f) != bin2bcd(59))
+			date = date2;
+	}
+
+	tm->tm_sec  = bcd2bin(date[RV8803_SEC] & 0x7f);
+	tm->tm_min  = bcd2bin(date[RV8803_MIN] & 0x7f);
+	tm->tm_hour = bcd2bin(date[RV8803_HOUR] & 0x3f);
+	tm->tm_wday = ffs(date[RV8803_WEEK] & 0x7f);
+	tm->tm_mday = bcd2bin(date[RV8803_DAY] & 0x3f);
+	tm->tm_mon  = bcd2bin(date[RV8803_MONTH] & 0x1f) - 1;
+	tm->tm_year = bcd2bin(date[RV8803_YEAR]) + 100;
+
+	return rtc_valid_tm(tm);
+}
+
+static int rv8803_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rv8803_data *rv8803 = dev_get_drvdata(dev);
+	u8 date[7];
+	int flags, ret;
+	unsigned long irqflags;
+
+	if ((tm->tm_year < 100) || (tm->tm_year > 199))
+		return -EINVAL;
+
+	date[RV8803_SEC]   = bin2bcd(tm->tm_sec);
+	date[RV8803_MIN]   = bin2bcd(tm->tm_min);
+	date[RV8803_HOUR]  = bin2bcd(tm->tm_hour);
+	date[RV8803_WEEK]  = 1 << (tm->tm_wday);
+	date[RV8803_DAY]   = bin2bcd(tm->tm_mday);
+	date[RV8803_MONTH] = bin2bcd(tm->tm_mon + 1);
+	date[RV8803_YEAR]  = bin2bcd(tm->tm_year - 100);
+
+	ret = i2c_smbus_write_i2c_block_data(rv8803->client, RV8803_SEC,
+					     7, date);
+	if (ret < 0)
+		return ret;
+
+	spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+
+	flags = i2c_smbus_read_byte_data(rv8803->client, RV8803_FLAG);
+	if (flags < 0) {
+		spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+		return flags;
+	}
+
+	ret = i2c_smbus_write_byte_data(rv8803->client, RV8803_FLAG,
+					flags & ~RV8803_FLAG_V2F);
+
+	spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+
+	return ret;
+}
+
+static int rv8803_get_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct rv8803_data *rv8803 = dev_get_drvdata(dev);
+	struct i2c_client *client = rv8803->client;
+	u8 alarmvals[3];
+	int flags, ret;
+
+	ret = i2c_smbus_read_i2c_block_data(client, RV8803_ALARM_MIN,
+					    3, alarmvals);
+	if (ret != 3)
+		return ret < 0 ? ret : -EIO;
+
+	flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
+	if (flags < 0)
+		return flags;
+
+	alrm->time.tm_sec  = 0;
+	alrm->time.tm_min  = bcd2bin(alarmvals[0] & 0x7f);
+	alrm->time.tm_hour = bcd2bin(alarmvals[1] & 0x3f);
+	alrm->time.tm_wday = -1;
+	alrm->time.tm_mday = bcd2bin(alarmvals[2] & 0x3f);
+	alrm->time.tm_mon  = -1;
+	alrm->time.tm_year = -1;
+
+	alrm->enabled = !!(rv8803->ctrl & RV8803_CTRL_AIE);
+	alrm->pending = (flags & RV8803_FLAG_AF) && alrm->enabled;
+
+	return 0;
+}
+
+static int rv8803_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct rv8803_data *rv8803 = dev_get_drvdata(dev);
+	u8 alarmvals[3];
+	u8 ctrl[2];
+	int ret, err;
+	unsigned long irqflags;
+
+	/* The alarm has no seconds, round up to nearest minute */
+	if (alrm->time.tm_sec) {
+		time64_t alarm_time = rtc_tm_to_time64(&alrm->time);
+
+		alarm_time += 60 - alrm->time.tm_sec;
+		rtc_time64_to_tm(alarm_time, &alrm->time);
+	}
+
+	spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+
+	ret = i2c_smbus_read_i2c_block_data(client, RV8803_FLAG, 2, ctrl);
+	if (ret != 2)
+		return ret < 0 ? ret : -EIO;
+
+	alarmvals[0] = bin2bcd(alrm->time.tm_min);
+	alarmvals[1] = bin2bcd(alrm->time.tm_hour);
+	alarmvals[2] = bin2bcd(alrm->time.tm_mday);
+
+	if (rv8803->ctrl & (RV8803_CTRL_AIE | RV8803_CTRL_UIE)) {
+		rv8803->ctrl &= ~(RV8803_CTRL_AIE | RV8803_CTRL_UIE);
+		err = i2c_smbus_write_byte_data(rv8803->client, RV8803_CTRL,
+						rv8803->ctrl);
+		if (err) {
+			spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+			return err;
+		}
+	}
+
+	ctrl[1] &= ~RV8803_FLAG_AF;
+	err = i2c_smbus_write_byte_data(rv8803->client, RV8803_FLAG, ctrl[1]);
+	spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+	if (err)
+		return err;
+
+	err = i2c_smbus_write_i2c_block_data(rv8803->client, RV8803_ALARM_MIN,
+					     3, alarmvals);
+	if (err)
+		return err;
+
+	if (alrm->enabled) {
+		if (rv8803->rtc->uie_rtctimer.enabled)
+			rv8803->ctrl |= RV8803_CTRL_UIE;
+		if (rv8803->rtc->aie_timer.enabled)
+			rv8803->ctrl |= RV8803_CTRL_AIE;
+
+		err = i2c_smbus_write_byte_data(rv8803->client, RV8803_CTRL,
+						rv8803->ctrl);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int rv8803_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct rv8803_data *rv8803 = dev_get_drvdata(dev);
+	int ctrl, flags, err;
+	unsigned long irqflags;
+
+	ctrl = rv8803->ctrl;
+
+	if (enabled) {
+		if (rv8803->rtc->uie_rtctimer.enabled)
+			ctrl |= RV8803_CTRL_UIE;
+		if (rv8803->rtc->aie_timer.enabled)
+			ctrl |= RV8803_CTRL_AIE;
+	} else {
+		if (!rv8803->rtc->uie_rtctimer.enabled)
+			ctrl &= ~RV8803_CTRL_UIE;
+		if (!rv8803->rtc->aie_timer.enabled)
+			ctrl &= ~RV8803_CTRL_AIE;
+	}
+
+	spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+	flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
+	if (flags < 0) {
+		spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+		return flags;
+	}
+	flags &= ~(RV8803_FLAG_AF | RV8803_FLAG_UF);
+	err = i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);
+	spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+	if (err)
+		return err;
+
+	if (ctrl != rv8803->ctrl) {
+		rv8803->ctrl = ctrl;
+		err = i2c_smbus_write_byte_data(client, RV8803_CTRL,
+						rv8803->ctrl);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int rv8803_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct rv8803_data *rv8803 = dev_get_drvdata(dev);
+	int flags, ret = 0;
+	unsigned long irqflags;
+
+	switch (cmd) {
+	case RTC_VL_READ:
+		spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+		flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
+		if (flags < 0)
+			return flags;
+
+		if (flags & RV8803_FLAG_V1F)
+			dev_warn(&client->dev, "Voltage low, temperature compensation stopped.\n");
+
+		if (flags & RV8803_FLAG_V2F)
+			dev_warn(&client->dev, "Voltage low, data loss detected.\n");
+
+		flags &= RV8803_FLAG_V1F | RV8803_FLAG_V2F;
+
+		if (copy_to_user((void __user *)arg, &flags, sizeof(int)))
+			return -EFAULT;
+
+		return 0;
+
+	case RTC_VL_CLR:
+		spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+		flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
+		if (flags < 0) {
+			spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+			return flags;
+		}
+
+		flags &= ~(RV8803_FLAG_V1F | RV8803_FLAG_V2F);
+		ret = i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);
+		spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+		if (ret < 0)
+			return ret;
+
+		return 0;
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+static ssize_t rv8803_nvram_write(struct file *filp, struct kobject *kobj,
+				  struct bin_attribute *attr,
+				  char *buf, loff_t off, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, RV8803_RAM, buf[0]);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
+static ssize_t rv8803_nvram_read(struct file *filp, struct kobject *kobj,
+				 struct bin_attribute *attr,
+				 char *buf, loff_t off, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, RV8803_RAM);
+	if (ret < 0)
+		return ret;
+
+	buf[0] = ret;
+
+	return 1;
+}
+
+static struct bin_attribute rv8803_nvram_attr = {
+	.attr = {
+		.name = "nvram",
+		.mode = S_IRUGO | S_IWUSR,
+	},
+	.size = 1,
+	.read = rv8803_nvram_read,
+	.write = rv8803_nvram_write,
+};
+
+static struct rtc_class_ops rv8803_rtc_ops = {
+	.read_time = rv8803_get_time,
+	.set_time = rv8803_set_time,
+	.ioctl = rv8803_ioctl,
+};
+
+static int rv8803_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct rv8803_data *rv8803;
+	int err, flags;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_I2C_BLOCK)) {
+		dev_err(&adapter->dev, "doesn't support I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_I2C_BLOCK\n");
+		return -EIO;
+	}
+
+	rv8803 = devm_kzalloc(&client->dev, sizeof(struct rv8803_data),
+			      GFP_KERNEL);
+	if (!rv8803)
+		return -ENOMEM;
+
+	rv8803->client = client;
+	i2c_set_clientdata(client, rv8803);
+
+	flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
+	if (flags < 0)
+		return flags;
+
+	if (flags & RV8803_FLAG_V1F)
+		dev_warn(&client->dev, "Voltage low, temperature compensation stopped.\n");
+
+	if (flags & RV8803_FLAG_V2F)
+		dev_warn(&client->dev, "Voltage low, data loss detected.\n");
+
+	if (flags & RV8803_FLAG_AF)
+		dev_warn(&client->dev, "An alarm maybe have been missed.\n");
+
+	if (client->irq > 0) {
+		err = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, rv8803_handle_irq,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						"rv8803", client);
+		if (err) {
+			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
+			client->irq = 0;
+		} else {
+			rv8803_rtc_ops.read_alarm = rv8803_get_alarm;
+			rv8803_rtc_ops.set_alarm = rv8803_set_alarm;
+			rv8803_rtc_ops.alarm_irq_enable = rv8803_alarm_irq_enable;
+		}
+	}
+
+	rv8803->rtc = devm_rtc_device_register(&client->dev, client->name,
+					       &rv8803_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rv8803->rtc)) {
+		dev_err(&client->dev, "unable to register the class device\n");
+		return PTR_ERR(rv8803->rtc);
+	}
+
+	err = i2c_smbus_write_byte_data(rv8803->client, RV8803_EXT,
+					RV8803_EXT_WADA);
+	if (err)
+		return err;
+
+	err = device_create_bin_file(&client->dev, &rv8803_nvram_attr);
+	if (err)
+		return err;
+
+	rv8803->rtc->max_user_freq = 1;
+
+	return 0;
+}
+
+static int rv8803_remove(struct i2c_client *client)
+{
+	device_remove_bin_file(&client->dev, &rv8803_nvram_attr);
+
+	return 0;
+}
+
+static const struct i2c_device_id rv8803_id[] = {
+	{ "rv8803", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rv8803_id);
+
+static struct i2c_driver rv8803_driver = {
+	.driver = {
+		.name = "rtc-rv8803",
+	},
+	.probe		= rv8803_probe,
+	.remove		= rv8803_remove,
+	.id_table	= rv8803_id,
+};
+module_i2c_driver(rv8803_driver);
+
+MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
+MODULE_DESCRIPTION("Micro Crystal RV8803 RTC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.5.0

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
