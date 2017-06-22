Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33018 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdFVQ73 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 22 Jun 2017 12:59:29 -0400
From: Kirill Esipov <yesipov@gmail.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kirill Esipov <yesipov@gmail.com>
Subject: [PATCH v2] rtc: ds3232: add temperature support
Date: Thu, 22 Jun 2017 19:58:24 +0300
Message-Id: <1498150704-21777-1-git-send-email-yesipov@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

DS3232/DS3234 has the temperature registers with a resolution of 0.25
degree celsius. This enables to get the value through hwmon.

	# cat /sys/class/hwmon/hwmon0/temp1_input
	37250

Signed-off-by: Kirill Esipov <yesipov@gmail.com>
---
 drivers/rtc/Kconfig      |   9 ++++
 drivers/rtc/rtc-ds3232.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8d3b95728326..b4a6a916d4df 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -791,6 +791,15 @@ config RTC_DRV_DS3232
 	  This driver can also be built as a module.  If so, the module
 	  will be called rtc-ds3232.
 
+config RTC_DRV_DS3232_HWMON
+	bool "HWMON support for Dallas/Maxim DS3232/DS3234"
+	depends on RTC_DRV_DS3232 && HWMON
+	depends on !(RTC_DRV_DS3232=y && HWMON=m)
+	default y
+	help
+	  Say Y here if you want to expose temperature sensor data on
+	  rtc-ds3232
+
 config RTC_DRV_PCF2127
 	tristate "NXP PCF2127"
 	depends on RTC_I2C_AND_SPI
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index deff431a37c4..4e7913c2ed79 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -22,6 +22,7 @@
 #include <linux/bcd.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
+#include <linux/hwmon.h>
 
 #define DS3232_REG_SECONDS      0x00
 #define DS3232_REG_MINUTES      0x01
@@ -275,6 +276,137 @@ static int ds3232_update_alarm(struct device *dev, unsigned int enabled)
 	return ret;
 }
 
+/*----------------------------------------------------------------------*/
+
+#ifdef CONFIG_RTC_DRV_DS3232_HWMON
+
+/*
+ * Temperature sensor support for ds3232/ds3234 devices.
+ */
+
+#define DS3232_REG_TEMPERATURE	0x11
+
+/*
+ * A user-initiated temperature conversion is not started by this function,
+ * so the temperature is updated once every 64 seconds.
+ */
+static int ds3232_hwmon_read_temp(struct device *dev, long int *mC)
+{
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
+	u8 temp_buf[2];
+	s16 temp;
+	int ret;
+
+	ret = regmap_bulk_read(ds3232->regmap, DS3232_REG_TEMPERATURE, temp_buf,
+				sizeof(temp_buf));
+
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Temperature is represented as a 10-bit code with a resolution of
+	 * 0.25 degree celsius and encoded in two's complement format.
+	 */
+	temp = (temp_buf[0] << 8) | temp_buf[1];
+	temp >>= 6;
+	*mC = temp * 250;
+
+	return 0;
+}
+
+static umode_t ds3232_hwmon_is_visible(const void *data,
+					 enum hwmon_sensor_types type,
+					 u32 attr, int channel)
+{
+	if (type != hwmon_temp)
+		return 0;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static int ds3232_hwmon_read(struct device *dev,
+			       enum hwmon_sensor_types type,
+			       u32 attr, int channel, long *temp)
+{
+	int err;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ds3232_hwmon_read_temp(dev, temp);
+		err = 0;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
+
+static u32 ds3232_hwmon_chip_config[] = {
+	HWMON_C_REGISTER_TZ,
+	0
+};
+
+static const struct hwmon_channel_info ds3232_hwmon_chip = {
+	.type = hwmon_chip,
+	.config = ds3232_hwmon_chip_config,
+};
+
+static u32 ds3232_hwmon_temp_config[] = {
+	HWMON_T_INPUT,
+	0
+};
+
+static const struct hwmon_channel_info ds3232_hwmon_temp = {
+	.type = hwmon_temp,
+	.config = ds3232_hwmon_temp_config,
+};
+
+static const struct hwmon_channel_info *ds3232_hwmon_info[] = {
+	&ds3232_hwmon_chip,
+	&ds3232_hwmon_temp,
+	NULL
+};
+
+static const struct hwmon_ops ds3232_hwmon_hwmon_ops = {
+	.is_visible = ds3232_hwmon_is_visible,
+	.read = ds3232_hwmon_read,
+};
+
+static const struct hwmon_chip_info ds3232_hwmon_chip_info = {
+	.ops = &ds3232_hwmon_hwmon_ops,
+	.info = ds3232_hwmon_info,
+};
+
+static void ds3232_hwmon_register(struct device *dev, const char *name)
+{
+	struct ds3232 *ds3232 = dev_get_drvdata(dev);
+	struct device *hwmon_dev;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, name, ds3232,
+							&ds3232_hwmon_chip_info,
+							NULL);
+
+	if (IS_ERR(hwmon_dev)) {
+		dev_warn(dev, "unable to register hwmon device %ld\n",
+			 PTR_ERR(hwmon_dev));
+	}
+}
+
+#else
+
+static void ds3232_hwmon_register(struct device *dev, const char *name)
+{
+}
+
+#endif
+
 static int ds3232_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct ds3232 *ds3232 = dev_get_drvdata(dev);
@@ -366,6 +498,8 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 	if (ds3232->irq > 0)
 		device_init_wakeup(dev, 1);
 
+	ds3232_hwmon_register(dev, name);
+
 	ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
 						THIS_MODULE);
 	if (IS_ERR(ds3232->rtc))
-- 
2.7.4
