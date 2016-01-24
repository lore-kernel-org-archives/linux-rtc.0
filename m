Return-Path: <rtc-linux+bncBCPM5SUWUYIRBNOYSO2QKGQEUXWHOWI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id ui7si1547811pab.0.2016.01.24.07.22.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jan 2016 07:22:29 -0800 (PST)
Received: by mail-pf0-x241.google.com with SMTP id n128so5664941pfn.3
        for <rtc-linux@googlegroups.com>; Sun, 24 Jan 2016 07:22:29 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com,
	lm-sensors@lm-sensors.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [rtc-linux] [PATCH v4] rtc: rtc-ds1307: add temperature sensor
 support for ds3231
Date: Mon, 25 Jan 2016 00:22:16 +0900
Message-Id: <1453648936-17017-1-git-send-email-akinobu.mita@gmail.com>
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

DS3231 has the temperature registers with a resolution of 0.25
degree celsius.  This enables to get the value through hwmon.

	# cat /sys/class/i2c-adapter/i2c-2/2-0068/hwmon/hwmon0/temp1_input
	21000

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
* v4 (all changes are suggested by Guenter Roeck)
- drop the Cc: mailing lists in commit log
- add Acked-by line
- remove unnecessary header include
- s/s32/int/
- make ds1307_hwmon_register() a void function as the return value is not used

 drivers/rtc/Kconfig      |  9 +++++
 drivers/rtc/rtc-ds1307.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 2a52424..73a7e51 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -212,6 +212,15 @@ config RTC_DRV_DS1307
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds1307.
 
+config RTC_DRV_DS1307_HWMON
+	bool "HWMON support for rtc-ds1307"
+	depends on RTC_DRV_DS1307 && HWMON
+	depends on !(RTC_DRV_DS1307=y && HWMON=m)
+	default y
+	help
+	  Say Y here if you want to expose temperature sensor data on
+	  rtc-ds1307 (only DS3231)
+
 config RTC_DRV_DS1374
 	tristate "Dallas/Maxim DS1374"
 	help
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index aa705bb..34d92a0 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -19,6 +19,8 @@
 #include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 
 /*
  * We can't determine type by probing, but if we expect pre-Linux code
@@ -851,6 +853,90 @@ out:
 	return;
 }
 
+/*----------------------------------------------------------------------*/
+
+#ifdef CONFIG_RTC_DRV_DS1307_HWMON
+
+/*
+ * Temperature sensor support for ds3231 devices.
+ */
+
+#define DS3231_REG_TEMPERATURE	0x11
+
+/*
+ * A user-initiated temperature conversion is not started by this function,
+ * so the temperature is updated once every 64 seconds.
+ */
+static int ds3231_hwmon_read_temp(struct device *dev, s16 *mC)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	u8 temp_buf[2];
+	s16 temp;
+	int ret;
+
+	ret = ds1307->read_block_data(ds1307->client, DS3231_REG_TEMPERATURE,
+					sizeof(temp_buf), temp_buf);
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(temp_buf))
+		return -EIO;
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
+static ssize_t ds3231_hwmon_show_temp(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int ret;
+	s16 temp;
+
+	ret = ds3231_hwmon_read_temp(dev, &temp);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", temp);
+}
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ds3231_hwmon_show_temp,
+			NULL, 0);
+
+static struct attribute *ds3231_hwmon_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ds3231_hwmon);
+
+static void ds1307_hwmon_register(struct ds1307 *ds1307)
+{
+	struct device *dev;
+
+	if (ds1307->type != ds_3231)
+		return;
+
+	dev = devm_hwmon_device_register_with_groups(&ds1307->client->dev,
+						ds1307->client->name,
+						ds1307, ds3231_hwmon_groups);
+	if (IS_ERR(dev)) {
+		dev_warn(&ds1307->client->dev,
+			"unable to register hwmon device %ld\n", PTR_ERR(dev));
+	}
+}
+
+#else
+
+static void ds1307_hwmon_register(struct ds1307 *ds1307)
+{
+}
+
+#endif
+
 static int ds1307_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -1191,6 +1277,8 @@ read_rtc:
 		}
 	}
 
+	ds1307_hwmon_register(ds1307);
+
 	return 0;
 
 exit:
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
