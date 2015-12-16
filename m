Return-Path: <rtc-linux+bncBCPM5SUWUYIRBKPVY6ZQKGQEXXBVTNQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com. [2607:f8b0:400e:c00::22d])
        by gmr-mx.google.com with ESMTPS id bb9si258240pac.2.2015.12.16.15.58.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2015 15:58:32 -0800 (PST)
Received: by mail-pf0-x22d.google.com with SMTP id o64so20130602pfb.3
        for <rtc-linux@googlegroups.com>; Wed, 16 Dec 2015 15:58:32 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: rtc-ds1307: add temperature sensor support
 for ds3231
Date: Thu, 17 Dec 2015 08:58:16 +0900
Message-Id: <1450310296-12153-1-git-send-email-akinobu.mita@gmail.com>
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
degree celsius.  This enables to get the value through sysfs file.

	# cat /sys/class/i2c-adapter/i2c-9/9-0068/temperature
	22.50

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
---
 drivers/rtc/rtc-ds1307.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index aa705bb..c0cd447 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -19,6 +19,7 @@
 #include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/delay.h>
 
 /*
  * We can't determine type by probing, but if we expect pre-Linux code
@@ -75,6 +76,7 @@ enum ds_type {
 #	define DS1337_BIT_nEOSC		0x80
 #	define DS1339_BIT_BBSQI		0x20
 #	define DS3231_BIT_BBSQW		0x40 /* same as BBSQI */
+#	define DS3231_BIT_CONV		0x20
 #	define DS1337_BIT_RS2		0x10
 #	define DS1337_BIT_RS1		0x08
 #	define DS1337_BIT_INTCN		0x04
@@ -89,6 +91,7 @@ enum ds_type {
 #	define DS1340_BIT_OSF		0x80
 #define DS1337_REG_STATUS	0x0f
 #	define DS1337_BIT_OSF		0x80
+#	define DS3231_BIT_BSY		0x04
 #	define DS1337_BIT_A2I		0x02
 #	define DS1337_BIT_A1I		0x01
 #define DS1339_REG_ALARM1_SECS	0x07
@@ -110,8 +113,10 @@ struct ds1307 {
 	struct bin_attribute	*nvram;
 	enum ds_type		type;
 	unsigned long		flags;
-#define HAS_NVRAM	0		/* bit 0 == sysfs file active */
-#define HAS_ALARM	1		/* bit 1 == irq claimed */
+#define HAS_NVRAM	0	/* bit 0 == nvram sysfs file active */
+#define HAS_ALARM	1	/* bit 1 == irq claimed */
+#define HAS_TEMP	2	/* bit 2 == temperature sysfs file active */
+
 	struct i2c_client	*client;
 	struct rtc_device	*rtc;
 	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
@@ -851,6 +856,112 @@ out:
 	return;
 }
 
+/*----------------------------------------------------------------------*/
+
+/*
+ * Temperature sensor support for ds3231 devices.
+ */
+
+#define DS3231_REG_TEMPERATURE	0x11
+
+static ssize_t ds3231_sysfs_show_temperature(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct ds1307	*ds1307 = dev_get_drvdata(dev);
+	struct i2c_client *client = ds1307->client;
+	u8 temp_buf[2];
+	s16 temp;
+	bool negative;
+	int control;
+	int status;
+	s32 ret;
+	unsigned long timeout;
+
+	status = i2c_smbus_read_byte_data(client, DS1337_REG_STATUS);
+	if (status < 0)
+		return status;
+
+	/*
+	 * Start user-initiated temperature conversion
+	 */
+	if (!(status & DS3231_BIT_BSY)) {
+		struct mutex	*lock = &ds1307->rtc->ops_lock;
+
+		mutex_lock(lock);
+
+		control = i2c_smbus_read_byte_data(client, DS1337_REG_CONTROL);
+		if (control < 0) {
+			mutex_unlock(lock);
+			return control;
+		}
+		ret = i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL,
+						control | DS3231_BIT_CONV);
+		if (ret)
+			return ret;
+
+		mutex_unlock(lock);
+
+		/*
+		 * A user-initiated temperature conversion does not affect
+		 * the BSY bit for approximately 2ms.
+		 */
+		usleep_range(2000, 3000);
+	}
+
+	/*
+	 * Wait until the conversion is finished
+	 */
+	timeout = jiffies + HZ;
+
+	do {
+		control = i2c_smbus_read_byte_data(client, DS1337_REG_CONTROL);
+		if (control < 0)
+			return control;
+		if (!(control & DS3231_BIT_CONV))
+			break;
+		if (time_after(jiffies, timeout))
+			return -EIO;
+		usleep_range(2000, 3000);
+	} while (1);
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
+	negative = (temp < 0) ? true : false;
+	temp = abs(temp);
+
+	return sprintf(buf, "%s%d.%d\n", negative ? "-" : "",
+			temp >> 2, 25 * (temp & 0x3));
+}
+static DEVICE_ATTR(temperature, S_IRUGO, ds3231_sysfs_show_temperature, NULL);
+
+static int ds1307_temperature_register(struct ds1307 *ds1307)
+{
+	if (ds1307->type != ds_3231)
+		return 0;
+
+	if (!device_create_file(&ds1307->client->dev, &dev_attr_temperature))
+		set_bit(HAS_TEMP, &ds1307->flags);
+
+	return 0;
+}
+
+static void ds1307_temperature_unregister(struct ds1307 *ds1307)
+{
+	if (test_and_clear_bit(HAS_TEMP, &ds1307->flags))
+		device_remove_file(&ds1307->client->dev, &dev_attr_temperature);
+}
+
 static int ds1307_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -1191,6 +1302,8 @@ read_rtc:
 		}
 	}
 
+	ds1307_temperature_register(ds1307);
+
 	return 0;
 
 exit:
@@ -1201,6 +1314,8 @@ static int ds1307_remove(struct i2c_client *client)
 {
 	struct ds1307 *ds1307 = i2c_get_clientdata(client);
 
+	ds1307_temperature_unregister(ds1307);
+
 	if (test_and_clear_bit(HAS_NVRAM, &ds1307->flags))
 		sysfs_remove_bin_file(&client->dev.kobj, ds1307->nvram);
 
-- 
1.9.1

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
