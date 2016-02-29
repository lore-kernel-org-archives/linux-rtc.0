Return-Path: <rtc-linux+bncBCPM5SUWUYIRBR6A2G3AKGQEPFNM7GA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com. [2607:f8b0:400e:c03::230])
        by gmr-mx.google.com with ESMTPS id 12si3733355pfb.1.2016.02.29.07.14.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Feb 2016 07:14:15 -0800 (PST)
Received: by mail-pa0-x230.google.com with SMTP id fy10so93299592pac.1
        for <rtc-linux@googlegroups.com>; Mon, 29 Feb 2016 07:14:15 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] [PATCH v3 2/8] rtc: ds3232: split into core module and
 i2c driver
Date: Tue,  1 Mar 2016 00:13:46 +0900
Message-Id: <1456758832-10590-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1456758832-10590-1-git-send-email-akinobu.mita@gmail.com>
References: <1456758832-10590-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

According to "Feature Comparison of the DS323x Real-Time Clocks"
(http://pdfserv.maximintegrated.com/en/an/AN5143.pdf), DS3232 and
DS3234 are very similar.

In order to share common code between rtc-ds3232 and rtc-ds3234,
this splits rtc-ds3232 driver into core module and i2c driver.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dennis Aberilla <denzzzhome@yahoo.com>
---
* v3
- convert to use regmap

 drivers/rtc/Kconfig           |   4 +
 drivers/rtc/Makefile          |   2 +-
 drivers/rtc/rtc-ds3232-core.c | 215 ++++++++++++++++++------------------------
 drivers/rtc/rtc-ds3232.c      |  63 +++++++++++++
 drivers/rtc/rtc-ds3232.h      |  23 +++++
 5 files changed, 185 insertions(+), 122 deletions(-)
 create mode 100644 drivers/rtc/rtc-ds3232.c
 create mode 100644 drivers/rtc/rtc-ds3232.h

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a9a2185..a489d89 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -139,6 +139,9 @@ config RTC_DRV_TEST
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-test.
 
+config RTC_DRV_DS3232_CORE
+	tristate
+
 comment "I2C RTC drivers"
 	depends on I2C
 
@@ -250,6 +253,7 @@ config RTC_DRV_DS1672
 
 config RTC_DRV_DS3232
 	tristate "Dallas/Maxim DS3232"
+	select RTC_DRV_DS3232_CORE
 	help
 	  If you say yes here you get support for Dallas Semiconductor
 	  DS3232 real-time clock chips. If an interrupt is associated
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 0b8cb6c..f2d236f 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -58,8 +58,8 @@ obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
 obj-$(CONFIG_RTC_DRV_DS1685_FAMILY)	+= rtc-ds1685.o
 obj-$(CONFIG_RTC_DRV_DS1742)	+= rtc-ds1742.o
 obj-$(CONFIG_RTC_DRV_DS2404)	+= rtc-ds2404.o
+obj-$(CONFIG_RTC_DRV_DS3232_CORE)	+= rtc-ds3232-core.o
 obj-$(CONFIG_RTC_DRV_DS3232)	+= rtc-ds3232.o
-rtc-ds3232-objs			:= rtc-ds3232-core.o
 obj-$(CONFIG_RTC_DRV_DS3234)	+= rtc-ds3234.o
 obj-$(CONFIG_RTC_DRV_EFI)	+= rtc-efi.o
 obj-$(CONFIG_RTC_DRV_EM3027)	+= rtc-em3027.o
diff --git a/drivers/rtc/rtc-ds3232-core.c b/drivers/rtc/rtc-ds3232-core.c
index 4e99ace..d44c84e 100644
--- a/drivers/rtc/rtc-ds3232-core.c
+++ b/drivers/rtc/rtc-ds3232-core.c
@@ -1,5 +1,5 @@
 /*
- * RTC client/driver for the Maxim/Dallas DS3232 Real-Time Clock over I2C
+ * RTC client/driver for the Maxim/Dallas DS3232/DS3234 Real-Time Clock
  *
  * Copyright (C) 2009-2011 Freescale Semiconductor.
  * Author: Jack Lan <jack.lan@freescale.com>
@@ -9,22 +9,19 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
-/*
- * It would be more efficient to use i2c msgs/i2c_transfer directly but, as
- * recommened in .../Documentation/i2c/writing-clients section
- * "Sending and receiving", using SMBus level communication is preferred.
- */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/i2c.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
+#include <linux/regmap.h>
+
+#include "rtc-ds3232.h"
 
 #define DS3232_REG_SECONDS	0x00
 #define DS3232_REG_MINUTES	0x01
@@ -50,7 +47,9 @@
 #       define DS3232_REG_SR_A1F   0x01
 
 struct ds3232 {
-	struct i2c_client *client;
+	struct device *dev;
+	struct regmap *regmap;
+	int irq;
 	struct rtc_device *rtc;
 	struct work_struct work;
 
@@ -63,26 +62,25 @@ struct ds3232 {
 	int exiting;
 };
 
-static struct i2c_driver ds3232_driver;
-
-static int ds3232_check_rtc_status(struct i2c_client *client)
+static int ds3232_check_rtc_status(struct device *dev)
 {
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 	int ret = 0;
 	int control, stat;
 
-	stat = i2c_smbus_read_byte_data(client, DS3232_REG_SR);
-	if (stat < 0)
-		return stat;
+	ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
+	if (ret)
+		return ret;
 
 	if (stat & DS3232_REG_SR_OSF)
-		dev_warn(&client->dev,
+		dev_warn(dev,
 				"oscillator discontinuity flagged, "
 				"time unreliable\n");
 
 	stat &= ~(DS3232_REG_SR_OSF | DS3232_REG_SR_A1F | DS3232_REG_SR_A2F);
 
-	ret = i2c_smbus_write_byte_data(client, DS3232_REG_SR, stat);
-	if (ret < 0)
+	ret = regmap_write(ds3232->regmap, DS3232_REG_SR, stat);
+	if (ret)
 		return ret;
 
 	/* If the alarm is pending, clear it before requesting
@@ -90,31 +88,28 @@ static int ds3232_check_rtc_status(struct i2c_client *client)
 	 * before everything is initialized.
 	 */
 
-	control = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
-	if (control < 0)
-		return control;
+	ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
+	if (ret)
+		return ret;
 
 	control &= ~(DS3232_REG_CR_A1IE | DS3232_REG_CR_A2IE);
 	control |= DS3232_REG_CR_INTCN;
 
-	return i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
+	return regmap_write(ds3232->regmap, DS3232_REG_CR, control);
 }
 
 static int ds3232_read_time(struct device *dev, struct rtc_time *time)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 	int ret;
 	u8 buf[7];
 	unsigned int year, month, day, hour, minute, second;
 	unsigned int week, twelve_hr, am_pm;
 	unsigned int century, add_century = 0;
 
-	ret = i2c_smbus_read_i2c_block_data(client, DS3232_REG_SECONDS, 7, buf);
-
-	if (ret < 0)
+	ret = regmap_bulk_read(ds3232->regmap, DS3232_REG_SECONDS, buf, 7);
+	if (ret)
 		return ret;
-	if (ret < 7)
-		return -EIO;
 
 	second = buf[0];
 	minute = buf[1];
@@ -159,7 +154,7 @@ static int ds3232_read_time(struct device *dev, struct rtc_time *time)
 
 static int ds3232_set_time(struct device *dev, struct rtc_time *time)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 	u8 buf[7];
 
 	/* Extract time from rtc_time and load into ds3232*/
@@ -179,8 +174,7 @@ static int ds3232_set_time(struct device *dev, struct rtc_time *time)
 		buf[6] = bin2bcd(time->tm_year);
 	}
 
-	return i2c_smbus_write_i2c_block_data(client,
-					      DS3232_REG_SECONDS, 7, buf);
+	return regmap_bulk_write(ds3232->regmap, DS3232_REG_SECONDS, buf, 7);
 }
 
 /*
@@ -190,24 +184,21 @@ static int ds3232_set_time(struct device *dev, struct rtc_time *time)
  */
 static int ds3232_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct ds3232 *ds3232 = i2c_get_clientdata(client);
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 	int control, stat;
 	int ret;
 	u8 buf[4];
 
 	mutex_lock(&ds3232->mutex);
 
-	ret = i2c_smbus_read_byte_data(client, DS3232_REG_SR);
-	if (ret < 0)
+	ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
+	if (ret)
 		goto out;
-	stat = ret;
-	ret = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
-	if (ret < 0)
+	ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
+	if (ret)
 		goto out;
-	control = ret;
-	ret = i2c_smbus_read_i2c_block_data(client, DS3232_REG_ALARM1, 4, buf);
-	if (ret < 0)
+	ret = regmap_bulk_read(ds3232->regmap, DS3232_REG_ALARM1, buf, 4);
+	if (ret)
 		goto out;
 
 	alarm->time.tm_sec = bcd2bin(buf[0] & 0x7F);
@@ -236,13 +227,12 @@ out:
  */
 static int ds3232_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct ds3232 *ds3232 = i2c_get_clientdata(client);
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 	int control, stat;
 	int ret;
 	u8 buf[4];
 
-	if (client->irq <= 0)
+	if (ds3232->irq <= 0)
 		return -EINVAL;
 
 	mutex_lock(&ds3232->mutex);
@@ -253,47 +243,45 @@ static int ds3232_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	buf[3] = bin2bcd(alarm->time.tm_mday);
 
 	/* clear alarm interrupt enable bit */
-	ret = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
-	if (ret < 0)
+	ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
+	if (ret)
 		goto out;
-	control = ret;
 	control &= ~(DS3232_REG_CR_A1IE | DS3232_REG_CR_A2IE);
-	ret = i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
-	if (ret < 0)
+	ret = regmap_write(ds3232->regmap, DS3232_REG_CR, control);
+	if (ret)
 		goto out;
 
 	/* clear any pending alarm flag */
-	ret = i2c_smbus_read_byte_data(client, DS3232_REG_SR);
-	if (ret < 0)
+	ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
+	if (ret)
 		goto out;
-	stat = ret;
 	stat &= ~(DS3232_REG_SR_A1F | DS3232_REG_SR_A2F);
-	ret = i2c_smbus_write_byte_data(client, DS3232_REG_SR, stat);
-	if (ret < 0)
+	ret = regmap_write(ds3232->regmap, DS3232_REG_SR, stat);
+	if (ret)
 		goto out;
 
-	ret = i2c_smbus_write_i2c_block_data(client, DS3232_REG_ALARM1, 4, buf);
+	ret = regmap_bulk_write(ds3232->regmap, DS3232_REG_ALARM1, buf, 4);
 
 	if (alarm->enabled) {
 		control |= DS3232_REG_CR_A1IE;
-		ret = i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
+		ret = regmap_write(ds3232->regmap, DS3232_REG_CR, control);
 	}
 out:
 	mutex_unlock(&ds3232->mutex);
 	return ret;
 }
 
-static void ds3232_update_alarm(struct i2c_client *client)
+static void ds3232_update_alarm(struct device *dev)
 {
-	struct ds3232 *ds3232 = i2c_get_clientdata(client);
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 	int control;
 	int ret;
 	u8 buf[4];
 
 	mutex_lock(&ds3232->mutex);
 
-	ret = i2c_smbus_read_i2c_block_data(client, DS3232_REG_ALARM1, 4, buf);
-	if (ret < 0)
+	ret = regmap_bulk_read(ds3232->regmap, DS3232_REG_ALARM1, buf, 4);
+	if (ret)
 		goto unlock;
 
 	buf[0] = bcd2bin(buf[0]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
@@ -305,12 +293,12 @@ static void ds3232_update_alarm(struct i2c_client *client)
 	buf[3] = bcd2bin(buf[3]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
 								0x80 : buf[3];
 
-	ret = i2c_smbus_write_i2c_block_data(client, DS3232_REG_ALARM1, 4, buf);
-	if (ret < 0)
+	ret = regmap_bulk_write(ds3232->regmap, DS3232_REG_ALARM1, buf, 4);
+	if (ret)
 		goto unlock;
 
-	control = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
-	if (control < 0)
+	ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
+	if (ret)
 		goto unlock;
 
 	if (ds3232->rtc->irq_data & (RTC_AF | RTC_UF))
@@ -319,7 +307,7 @@ static void ds3232_update_alarm(struct i2c_client *client)
 	else
 		/* disable alarm1 interrupt */
 		control &= ~(DS3232_REG_CR_A1IE);
-	i2c_smbus_write_byte_data(client, DS3232_REG_CR, control);
+	regmap_write(ds3232->regmap, DS3232_REG_CR, control);
 
 unlock:
 	mutex_unlock(&ds3232->mutex);
@@ -327,10 +315,9 @@ unlock:
 
 static int ds3232_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct ds3232 *ds3232 = i2c_get_clientdata(client);
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 
-	if (client->irq <= 0)
+	if (ds3232->irq <= 0)
 		return -EINVAL;
 
 	if (enabled)
@@ -338,14 +325,14 @@ static int ds3232_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	else
 		ds3232->rtc->irq_data &= ~RTC_AF;
 
-	ds3232_update_alarm(client);
+	ds3232_update_alarm(dev);
 	return 0;
 }
 
 static irqreturn_t ds3232_irq(int irq, void *dev_id)
 {
-	struct i2c_client *client = dev_id;
-	struct ds3232 *ds3232 = i2c_get_clientdata(client);
+	struct device *dev = dev_id;
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 
 	disable_irq_nosync(irq);
 
@@ -363,34 +350,33 @@ static irqreturn_t ds3232_irq(int irq, void *dev_id)
 static void ds3232_work(struct work_struct *work)
 {
 	struct ds3232 *ds3232 = container_of(work, struct ds3232, work);
-	struct i2c_client *client = ds3232->client;
+	int ret;
 	int stat, control;
 
 	mutex_lock(&ds3232->mutex);
 
-	stat = i2c_smbus_read_byte_data(client, DS3232_REG_SR);
-	if (stat < 0)
+	ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
+	if (ret)
 		goto unlock;
 
 	if (stat & DS3232_REG_SR_A1F) {
-		control = i2c_smbus_read_byte_data(client, DS3232_REG_CR);
-		if (control < 0) {
+		ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
+		if (ret) {
 			pr_warn("Read Control Register error - Disable IRQ%d\n",
-				client->irq);
+				ds3232->irq);
 		} else {
 			/* disable alarm1 interrupt */
 			control &= ~(DS3232_REG_CR_A1IE);
-			i2c_smbus_write_byte_data(client, DS3232_REG_CR,
-						control);
+			regmap_write(ds3232->regmap, DS3232_REG_CR, control);
 
 			/* clear the alarm pend flag */
 			stat &= ~DS3232_REG_SR_A1F;
-			i2c_smbus_write_byte_data(client, DS3232_REG_SR, stat);
+			regmap_write(ds3232->regmap, DS3232_REG_SR, stat);
 
 			rtc_update_irq(ds3232->rtc, 1, RTC_AF | RTC_IRQF);
 
 			if (!ds3232->exiting)
-				enable_irq(client->irq);
+				enable_irq(ds3232->irq);
 		}
 	}
 
@@ -406,64 +392,69 @@ static const struct rtc_class_ops ds3232_rtc_ops = {
 	.alarm_irq_enable = ds3232_alarm_irq_enable,
 };
 
-static int ds3232_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+int __ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
+		const char *name, struct module *owner)
 {
 	struct ds3232 *ds3232;
 	int ret;
 
-	ds3232 = devm_kzalloc(&client->dev, sizeof(struct ds3232), GFP_KERNEL);
+	ds3232 = devm_kzalloc(dev, sizeof(*ds3232), GFP_KERNEL);
 	if (!ds3232)
 		return -ENOMEM;
 
-	ds3232->client = client;
-	i2c_set_clientdata(client, ds3232);
+	ds3232->regmap = regmap;
+	ds3232->irq = irq;
+	ds3232->dev = dev;
+	dev_set_drvdata(dev, ds3232);
 
 	INIT_WORK(&ds3232->work, ds3232_work);
 	mutex_init(&ds3232->mutex);
 
-	ret = ds3232_check_rtc_status(client);
+	ret = ds3232_check_rtc_status(dev);
 	if (ret)
 		return ret;
 
-	if (client->irq > 0) {
-		ret = devm_request_irq(&client->dev, client->irq, ds3232_irq,
-				       IRQF_SHARED, "ds3232", client);
+	if (ds3232->irq > 0) {
+		ret = devm_request_irq(dev, ds3232->irq, ds3232_irq,
+				       IRQF_SHARED, name, dev);
 		if (ret) {
-			dev_err(&client->dev, "unable to request IRQ\n");
-		}
-		device_init_wakeup(&client->dev, 1);
+			ds3232->irq = 0;
+			dev_err(dev, "unable to request IRQ\n");
+		} else
+			device_init_wakeup(dev, 1);
 	}
-	ds3232->rtc = devm_rtc_device_register(&client->dev, client->name,
-					  &ds3232_rtc_ops, THIS_MODULE);
+	ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
+						owner);
+
 	return PTR_ERR_OR_ZERO(ds3232->rtc);
 }
+EXPORT_SYMBOL_GPL(__ds3232_probe);
 
-static int ds3232_remove(struct i2c_client *client)
+int ds3232_remove(struct device *dev)
 {
-	struct ds3232 *ds3232 = i2c_get_clientdata(client);
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 
-	if (client->irq > 0) {
+	if (ds3232->irq > 0) {
 		mutex_lock(&ds3232->mutex);
 		ds3232->exiting = 1;
 		mutex_unlock(&ds3232->mutex);
 
-		devm_free_irq(&client->dev, client->irq, client);
+		devm_free_irq(dev, ds3232->irq, dev);
 		cancel_work_sync(&ds3232->work);
 	}
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ds3232_remove);
 
 #ifdef CONFIG_PM_SLEEP
 static int ds3232_suspend(struct device *dev)
 {
 	struct ds3232 *ds3232 = dev_get_drvdata(dev);
-	struct i2c_client *client = to_i2c_client(dev);
 
 	if (device_can_wakeup(dev)) {
 		ds3232->suspended = true;
-		if (irq_set_irq_wake(client->irq, 1)) {
+		if (irq_set_irq_wake(ds3232->irq, 1)) {
 			dev_warn_once(dev, "Cannot set wakeup source\n");
 			ds3232->suspended = false;
 		}
@@ -475,7 +466,6 @@ static int ds3232_suspend(struct device *dev)
 static int ds3232_resume(struct device *dev)
 {
 	struct ds3232 *ds3232 = dev_get_drvdata(dev);
-	struct i2c_client *client = to_i2c_client(dev);
 
 	if (ds3232->suspended) {
 		ds3232->suspended = false;
@@ -483,34 +473,17 @@ static int ds3232_resume(struct device *dev)
 		/* Clear the hardware alarm pend flag */
 		schedule_work(&ds3232->work);
 
-		irq_set_irq_wake(client->irq, 0);
+		irq_set_irq_wake(ds3232->irq, 0);
 	}
 
 	return 0;
 }
 #endif
 
-static const struct dev_pm_ops ds3232_pm_ops = {
+const struct dev_pm_ops ds3232_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ds3232_suspend, ds3232_resume)
 };
-
-static const struct i2c_device_id ds3232_id[] = {
-	{ "ds3232", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, ds3232_id);
-
-static struct i2c_driver ds3232_driver = {
-	.driver = {
-		.name = "rtc-ds3232",
-		.pm	= &ds3232_pm_ops,
-	},
-	.probe = ds3232_probe,
-	.remove = ds3232_remove,
-	.id_table = ds3232_id,
-};
-
-module_i2c_driver(ds3232_driver);
+EXPORT_SYMBOL_GPL(ds3232_pm_ops);
 
 MODULE_AUTHOR("Srikanth Srinivasan <srikanth.srinivasan@freescale.com>");
 MODULE_DESCRIPTION("Maxim/Dallas DS3232 RTC Driver");
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
new file mode 100644
index 0000000..72e6805
--- /dev/null
+++ b/drivers/rtc/rtc-ds3232.c
@@ -0,0 +1,63 @@
+/*
+ * RTC client/driver for the Maxim/Dallas DS3232 Real-Time Clock over I2C
+ *
+ * Copyright (C) 2009-2011 Freescale Semiconductor.
+ * Author: Jack Lan <jack.lan@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+#include "rtc-ds3232.h"
+
+static int ds3232_i2c_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	static const struct regmap_config config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+	};
+
+	regmap = devm_regmap_init_i2c(client, &config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "%s: regmap allocation failed: %ld\n",
+			__func__, PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return ds3232_probe(&client->dev, regmap, client->irq, client->name);
+}
+
+static int ds3232_i2c_remove(struct i2c_client *client)
+{
+	return ds3232_remove(&client->dev);
+}
+
+static const struct i2c_device_id ds3232_id[] = {
+	{ "ds3232", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ds3232_id);
+
+static struct i2c_driver ds3232_driver = {
+	.driver = {
+		.name = "rtc-ds3232",
+		.pm	= &ds3232_pm_ops,
+	},
+	.probe = ds3232_i2c_probe,
+	.remove = ds3232_i2c_remove,
+	.id_table = ds3232_id,
+};
+module_i2c_driver(ds3232_driver);
+
+MODULE_AUTHOR("Srikanth Srinivasan <srikanth.srinivasan@freescale.com>");
+MODULE_DESCRIPTION("Maxim/Dallas DS3232 RTC Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/rtc/rtc-ds3232.h b/drivers/rtc/rtc-ds3232.h
new file mode 100644
index 0000000..94bec04
--- /dev/null
+++ b/drivers/rtc/rtc-ds3232.h
@@ -0,0 +1,23 @@
+/*
+ * RTC client/driver for the Maxim/Dallas DS3232/DS3234 Real-Time Clock
+ *
+ * Copyright (C) 2009-2011 Freescale Semiconductor.
+ * Author: Jack Lan <jack.lan@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __RTC_DS3232_H__
+#define __RTC_DS3232_H__
+
+int __ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
+		const char *name, struct module *owner);
+#define ds3232_probe(dev, regmap, irq, name)	\
+	__ds3232_probe(dev, regmap, irq, name, THIS_MODULE)
+
+int ds3232_remove(struct device *dev);
+extern const struct dev_pm_ops ds3232_pm_ops;
+
+#endif
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
