Return-Path: <rtc-linux+bncBCO7J6GN7ELBB2HK667QKGQEDVZVY2A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id um12si1185278pab.2.2016.10.12.01.33.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Oct 2016 01:33:44 -0700 (PDT)
Received: by mail-pf0-x241.google.com with SMTP id 190so2266707pfv.0
        for <rtc-linux@googlegroups.com>; Wed, 12 Oct 2016 01:33:44 -0700 (PDT)
From: VENKAT PRASHANTH B U <venkat.prashanth2498@gmail.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	VENKAT PRASHANTH B U <venkat.prashanth2498@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: Add support for maxim dallas rtc max-6917
Date: Wed, 12 Oct 2016 01:33:32 -0700
Message-Id: <1476261212-5754-1-git-send-email-venkat.prashanth2498@gmail.com>
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
maxim dallas rtc max6917.

Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
---
---
 drivers/rtc/Kconfig       |   9 +
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-max6917.c | 406 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 416 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e215f50..2163606 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -277,6 +277,15 @@ config RTC_DRV_MAX6900
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-max6900.
 
+config RTC_DRV_MAX6917
+	tristate "Maxim MAX6917"
+	help
+	  If you say yes here you will get support for the
+	  Maxim MAX6917 I2C RTC chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-max6917.
+
 config RTC_DRV_MAX8907
 	tristate "Maxim MAX8907"
 	depends on MFD_MAX8907
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 7cf7ad5..29332fb 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
 obj-$(CONFIG_RTC_DRV_MAX6900)	+= rtc-max6900.o
 obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
 obj-$(CONFIG_RTC_DRV_MAX6916)	+= rtc-max6916.o
+obj-$(CONFIG_RTC_DRV_MAX6917)	+= rtc-max6917.o
 obj-$(CONFIG_RTC_DRV_MAX77686)	+= rtc-max77686.o
 obj-$(CONFIG_RTC_DRV_MAX8907)	+= rtc-max8907.o
 obj-$(CONFIG_RTC_DRV_MAX8925)	+= rtc-max8925.o
diff --git a/drivers/rtc/rtc-max6917.c b/drivers/rtc/rtc-max6917.c
index e69de29..1176384 100644
--- a/drivers/rtc/rtc-max6917.c
+++ b/drivers/rtc/rtc-max6917.c
@@ -0,0 +1,406 @@
+	/* rtc-max6917.c
+	*
+	* Driver for MAXIM  max6917  I2C-Compatible Real Time Clock
+	*
+	* Author : Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
+	*
+	* This program is free software; you can redistribute it and/or modify
+	* it under the terms of the GNU General Public License version 2 as
+	* published by the Free Software Foundation.
+	*
+	*/
+
+	#include <linux/bcd.h>
+	#include <linux/i2c.h>
+	#include <linux/init.h>
+	#include <linux/module.h>
+	#include <linux/rtc.h>
+	#include <linux/string.h>
+	#include <linux/delay.h>
+	#include <linux/clk-provider.h>
+	#include <linux/slab.h>
+
+	#define MAX6917_REG_SECS		0x01	/* 00-59 */
+	#define MAX6917_REG_MIN			0x02	/* 00-59 */
+	#define MAX6917_REG_HOUR		0x03	/* 00-23, or 1-12{am,pm} */
+	#define MAX6917_REG_WDAY		0x04	/* 01-07 */
+	#define MAX6917_REG_MDAY		0x05	/* 01-31 */
+	#define MAX6917_REG_MONTH		0x06	/* 01-12 */
+	#define MAX6917_REG_YEAR		0x07	/* 00-99 */
+	#define MAX6917_REG_CONTROL		0x08
+	#define MAX6917_REG_STATUS		0x0c
+	#define MAX6917_REG_ALARM		0x0a
+	#define MAX6917_BURST_LEN		8	/* can burst r/w first 8 regs */
+	#define MAX6917_REG_CENTURY		9	/* century */
+	#define MAX6917_REG_LEN			10
+	#define MAX6917_REG_CT_WP		(1 << 7)	/* Write Protect */
+	/*
+	* register read/write commands
+	*/
+	#define MAX6917_REG_CONTROL_WRITE	0x8e
+	#define MAX6917_REG_CENTURY_WRITE	0x92
+	#define MAX6917_REG_CENTURY_READ	0x93
+	#define MAX6917_REG_RESERVED_READ	0x96
+	#define MAX6917_REG_BURST_WRITE		0xbe
+	#define MAX6917_REG_BURST_READ		0xbf
+
+	#define MAX6917_IDLE_TIME_AFTER_WRITE	3	/* specification says 2.5 mS */
+
+	static struct i2c_driver max6917_driver;
+
+	struct max6917
+	{
+	u8 offset;			/* register's offset */
+	u8 regs[11];
+	u16 nvram_offset;
+	struct bin_attribute *nvram;
+	unsigned long flags;
+	#define HAS_NVRAM			0	/* bit 0 == sysfs file active */
+	#define HAS_ALARM			1	/* bit 1 == irq claimed */
+	struct i2c_client *client;
+	struct rtc_device *rtc;
+		s32 (*read_block_data) (const struct i2c_client * client, u8 command,
+					u8 length, u8 * values);
+		s32 (*write_block_data) (const struct i2c_client * client, u8 command,
+					u8 length, const u8 * values);
+	};
+
+	struct chip_desc
+	{
+	unsigned alarm:1;
+	u16 nvram_offset;
+	u16 nvram_size;
+	};
+
+	static int
+	max6917_i2c_read_regs (struct i2c_client *client, u8 * buf)
+	{
+	u8 reg_burst_read[1] = { MAX6917_REG_BURST_READ };
+	u8 reg_century_read[1] = { MAX6917_REG_CENTURY_READ };
+	struct i2c_msg msgs[4] = {
+		{
+		.addr = client->addr,
+		.flags = 0,		/* write */
+		.len = sizeof (reg_burst_read),
+		.buf = reg_burst_read}
+		,
+		{
+		.addr = client->addr,
+		.flags = I2C_M_RD,
+		.len = MAX6917_BURST_LEN,
+		.buf = buf}
+		,
+		{
+		.addr = client->addr,
+		.flags = 0,		/* write */
+		.len = sizeof (reg_century_read),
+		.buf = reg_century_read}
+		,
+		{
+		.addr = client->addr,
+		.flags = I2C_M_RD,
+		.len = sizeof (buf[MAX6917_REG_CENTURY]),
+		.buf = &buf[MAX6917_REG_CENTURY]}
+	};
+	int rc;
+
+	rc = i2c_transfer (client->adapter, msgs, ARRAY_SIZE (msgs));
+	if (rc != ARRAY_SIZE (msgs))
+		{
+			dev_err (&client->dev, "%s: register read failed\n", __func__);
+			return -EIO;
+		}
+	return 0;
+	}
+
+	static int
+	max6917_i2c_write_regs (struct i2c_client *client, u8 const *buf)
+	{
+	u8 i2c_century_buf[1 + 1] = { MAX6917_REG_CENTURY_WRITE };
+	struct i2c_msg century_msgs[1] = {
+		{
+		.addr = client->addr,
+		.flags = 0,		/* write */
+		.len = sizeof (i2c_century_buf),
+		.buf = i2c_century_buf}
+	};
+	u8 i2c_burst_buf[MAX6917_BURST_LEN + 1] = { MAX6917_REG_BURST_WRITE };
+	struct i2c_msg burst_msgs[1] = {
+		{
+		.addr = client->addr,
+		.flags = 0,		/* write */
+		.len = sizeof (i2c_burst_buf),
+		.buf = i2c_burst_buf}
+	};
+	int rc;
+
+	/*
+		* We have to make separate calls to i2c_transfer because of
+		* the need to delay after each write to the chip.  Also,
+		* we write the century byte first, since we set the write-protect
+		* bit as part of the burst write.
+		*/
+	i2c_century_buf[1] = buf[MAX6917_REG_CENTURY];
+
+	rc = i2c_transfer (client->adapter, century_msgs,
+				ARRAY_SIZE (century_msgs));
+	if (rc != ARRAY_SIZE (century_msgs))
+		goto write_failed;
+
+	msleep (MAX6917_IDLE_TIME_AFTER_WRITE);
+
+	memcpy (&i2c_burst_buf[1], buf, MAX6917_BURST_LEN);
+
+	rc = i2c_transfer (client->adapter, burst_msgs, ARRAY_SIZE (burst_msgs));
+	if (rc != ARRAY_SIZE (burst_msgs))
+		goto write_failed;
+	msleep (MAX6917_IDLE_TIME_AFTER_WRITE);
+
+	return 0;
+
+	write_failed:
+	dev_err (&client->dev, "%s: register write failed\n", __func__);
+	return -EIO;
+	}
+
+	static int
+	max6917_i2c_read_time (struct i2c_client *client, struct rtc_time *tm)
+	{
+	int rc;
+	u8 regs[MAX6917_REG_LEN];
+
+	rc = max6917_i2c_read_regs (client, regs);
+	if (rc < 0)
+		return rc;
+
+	tm->tm_sec = bcd2bin (regs[MAX6917_REG_SECS]);
+	tm->tm_min = bcd2bin (regs[MAX6917_REG_MIN]);
+	tm->tm_hour = bcd2bin (regs[MAX6917_REG_HOUR] & 0x3f);
+	tm->tm_mday = bcd2bin (regs[MAX6917_REG_MDAY]);
+	tm->tm_mon = bcd2bin (regs[MAX6917_REG_MONTH]) - 1;
+	tm->tm_year = bcd2bin (regs[MAX6917_REG_YEAR]) +
+		bcd2bin (regs[MAX6917_REG_CENTURY]) * 100 - 1900;
+	tm->tm_wday = bcd2bin (regs[MAX6917_REG_WDAY]);
+
+	return rtc_valid_tm (tm);
+	}
+
+	static int
+	max6917_i2c_clear_write_protect (struct i2c_client *client)
+	{
+	return i2c_smbus_write_byte_data (client, MAX6917_REG_CONTROL_WRITE, 0);
+	}
+
+	static int
+	max6917_i2c_set_time (struct i2c_client *client, struct rtc_time const *tm)
+	{
+	u8 regs[MAX6917_REG_LEN];
+	int rc;
+
+	rc = max6917_i2c_clear_write_protect (client);
+	if (rc < 0)
+		return rc;
+
+	regs[MAX6917_REG_SECS] = bin2bcd (tm->tm_sec);
+	regs[MAX6917_REG_MIN] = bin2bcd (tm->tm_min);
+	regs[MAX6917_REG_HOUR] = bin2bcd (tm->tm_hour);
+	regs[MAX6917_REG_MDAY] = bin2bcd (tm->tm_mday);
+	regs[MAX6917_REG_MONTH] = bin2bcd (tm->tm_mon + 1);
+	regs[MAX6917_REG_WDAY] = bin2bcd (tm->tm_wday);
+	regs[MAX6917_REG_YEAR] = bin2bcd (tm->tm_year % 100);
+	regs[MAX6917_REG_CENTURY] = bin2bcd ((tm->tm_year + 1900) / 100);
+	/* set write protect */
+	regs[MAX6917_REG_CONTROL] = MAX6917_REG_CT_WP;
+
+	rc = max6917_i2c_write_regs (client, regs);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+	}
+
+	static int
+	max6917_rtc_read_time (struct device *dev, struct rtc_time *tm)
+	{
+	return max6917_i2c_read_time (to_i2c_client (dev), tm);
+	}
+
+	static int
+	max6917_rtc_set_time (struct device *dev, struct rtc_time *tm)
+	{
+	return max6917_i2c_set_time (to_i2c_client (dev), tm);
+	}
+
+	static int
+	max6917_read_alarm (struct device *dev, struct rtc_wkalrm *t)
+	{
+	struct i2c_client *client = to_i2c_client (dev);
+	struct max6917 *max6917 = i2c_get_clientdata (client);
+	int ret;
+
+	if (!test_bit (HAS_ALARM, &max6917->flags))
+		return -EINVAL;
+
+	/* read all ALARM1, ALARM2, and status registers at once */
+	ret = max6917->read_block_data (client,
+					MAX6917_REG_ALARM, 9, max6917->regs);
+	if (ret != 9)
+		{
+			dev_err (dev, " error %d\n", "alarm read", ret);
+			return -EIO;
+		}
+
+	dev_dbg (dev, "%4ph, %3ph, %2ph\n", "alarm read",
+			&max6917->regs[0], &max6917->regs[4], &max6917->regs[7]);
+
+	/*
+		* report alarm time (ALARM1); assume 24 hour and day-of-month modes,
+		* and that all four fields are checked matches
+		*/
+	t->time.tm_sec = bcd2bin (max6917->regs[0] & 0x7f);
+	t->time.tm_min = bcd2bin (max6917->regs[1] & 0x7f);
+	t->time.tm_hour = bcd2bin (max6917->regs[2] & 0x3f);
+	t->time.tm_mday = bcd2bin (max6917->regs[3] & 0x3f);
+
+	dev_dbg (dev, " %s secs=%d, mins=%d, "
+			"hours=%d, mday=%d, enabled=%d, pending=%d\n",
+			"alarm read", t->time.tm_sec, t->time.tm_min,
+			t->time.tm_hour, t->time.tm_mday);
+
+	return 0;
+	}
+
+	static int
+	max6917_set_alarm (struct device *dev, struct rtc_wkalrm *t)
+	{
+	struct i2c_client *client = to_i2c_client (dev);
+	struct max6917 *max6917 = i2c_get_clientdata (client);
+	unsigned char *buf = max6917->regs;
+	u8 control, status;
+	int ret;
+
+	if (!test_bit (HAS_ALARM, &max6917->flags))
+		return -EINVAL;
+
+	dev_dbg (dev, " %s secs=%d, mins=%d, "
+			"hours=%d, mday=%d, enabled=%d, pending=%d\n",
+			"alarm set", t->time.tm_sec, t->time.tm_min,
+			t->time.tm_hour, t->time.tm_mday);
+
+	/* read current status of both alarms and the chip */
+	ret = max6917->read_block_data (client, MAX6917_REG_ALARM, 9, buf);
+	if (ret != 9)
+		{
+			dev_err (dev, "%s error %d\n", "alarm write", ret);
+			return -EIO;
+		}
+	control = max6917->regs[7];
+	status = max6917->regs[8];
+
+	dev_dbg (dev, "%s: %4ph, %3ph, %02x %02x\n", "alarm set (old status)",
+			&max6917->regs[0], &max6917->regs[4], control, status);
+
+	/* set ALARM1, using 24 hour and day-of-month modes */
+	buf[0] = bin2bcd (t->time.tm_sec);
+	buf[1] = bin2bcd (t->time.tm_min);
+	buf[2] = bin2bcd (t->time.tm_hour);
+	buf[3] = bin2bcd (t->time.tm_mday);
+	buf[4] = 0;
+	buf[5] = 0;
+	buf[6] = 0;
+
+	ret = max6917->write_block_data (client, MAX6917_REG_ALARM, 9, buf);
+	if (ret < 0)
+		{
+			dev_err (dev, "can't set alarm time\n");
+			return ret;
+		}
+	return 0;
+	}
+
+	static ssize_t
+	max6917_nvram_read (struct file *filp, struct kobject *kobj,
+				struct bin_attribute *attr,
+				char *buf, loff_t off, size_t count)
+	{
+	struct i2c_client *client;
+	struct max6917 *max6917;
+	int result;
+
+	client = kobj_to_i2c_client (kobj);
+	max6917 = i2c_get_clientdata (client);
+
+	result = max6917->read_block_data (client, max6917->nvram_offset + off,
+						count, buf);
+	if (result < 0)
+		dev_err (&client->dev, "%s error %d\n", "nvram read", result);
+	return result;
+	}
+
+	static ssize_t
+	max6917_nvram_write (struct file *filp, struct kobject *kobj,
+				struct bin_attribute *attr,
+				char *buf, loff_t off, size_t count)
+	{
+	struct i2c_client *client;
+	struct max6917 *max6917;
+	int result;
+
+	client = kobj_to_i2c_client (kobj);
+	max6917 = i2c_get_clientdata (client);
+
+	result = max6917->write_block_data (client, max6917->nvram_offset + off,
+						count, buf);
+	if (result < 0)
+		{
+			dev_err (&client->dev, "%s error %d\n", "nvram write", result);
+			return result;
+		}
+	return count;
+	}
+
+	static const struct rtc_class_ops max6917_rtc_ops = {
+	.read_time = max6917_rtc_read_time,
+	.set_time = max6917_rtc_set_time,
+	.read_alarm = max6917_read_alarm,
+	.set_alarm = max6917_set_alarm,
+	};
+
+	static int
+	max6917_probe (struct i2c_client *client, const struct i2c_device_id *id)
+	{
+	struct rtc_device *rtc;
+
+	if (!i2c_check_functionality (client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	rtc = devm_rtc_device_register (&client->dev, max6917_driver.driver.name,
+					&max6917_rtc_ops, THIS_MODULE);
+	if (IS_ERR (rtc))
+		return PTR_ERR (rtc);
+
+	i2c_set_clientdata (client, rtc);
+
+	return 0;
+	}
+
+	static struct i2c_device_id max6917_id[] = {
+	{"max6917", 0},
+	{}
+	};
+
+	MODULE_DEVICE_TABLE (i2c, max6917_id);
+
+	static struct i2c_driver max6917_driver = {
+	.driver = {
+			.name = "rtc-max6917",
+			},
+	.probe = max6917_probe,
+	.id_table = max6917_id,
+	};
+
+	module_i2c_driver (max6917_driver);
+
+	MODULE_DESCRIPTION ("Maxim MAX6917 RTC driver");
+	MODULE_AUTHOR ("Venkat Prashanth B U");
+	MODULE_LICENSE ("GPL");
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
