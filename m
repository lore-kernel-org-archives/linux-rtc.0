Return-Path: <rtc-linux+bncBAABBGGVYC3QKGQEZLUATYQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si498862wmd.1.2016.03.21.10.08.39
        for <rtc-linux@googlegroups.com>;
        Mon, 21 Mar 2016 10:08:39 -0700 (PDT)
From: Mylene JOSSERAND <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 1/2] rtc: abx80x: handle autocalibration
Date: Mon, 21 Mar 2016 18:06:09 +0100
Message-Id: <2a00014c532ffc84e0da1ad93d02b9c0731827d8.1458579029.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1458579029.git.mylene.josserand@free-electrons.com>
References: <cover.1458579029.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1458579029.git.mylene.josserand@free-electrons.com>
References: <cover.1458579029.git.mylene.josserand@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The autocalibration is separated in two bits to set in Oscillator
Control register (0x1c) :
 - OSEL bit to select the oscillator type (XT or RC).
 - ACAL bit to select the autocalibration type.

These functionnalities are exported in sysfs entries : "oscillator"
and "autocalibration". Respectively, the values are "xtal" for XT
oscillator and "rc" for RC oscillator and 0 to disable the
autocalibration cycle, 512 for a 512 seconds autocalibration cycle
and 1024 for a cycle of 1024 seconds.

Examples :
Set to XT Oscillator
echo xtal > /sys/class/rtc/rtc0/device/oscillator
Activate an autocalibration every 512 seconds
echo 512 > /sys/class/rtc/rtc0/device/autocalibration

Signed-off-by: Mylene JOSSERAND <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-abx80x.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index d41bbcd..0e4c9a0 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -49,7 +49,19 @@
 
 #define ABX8XX_REG_CD_TIMER_CTL	0x18
 
+#define ABX8XX_REG_OSC		0x1c
+#define ABX8XX_OSC_FOS		BIT(3)
+#define ABX8XX_OSC_BOS		BIT(4)
+#define ABX8XX_OSC_ACAL_512	BIT(5)
+#define ABX8XX_OSC_ACAL_1024	BIT(6)
+
+#define ABX8XX_OSC_OSEL		BIT(7)
+
+#define ABX8XX_REG_OSS		0x1d
+#define ABX8XX_OSS_OMODE	BIT(4)
+
 #define ABX8XX_REG_CFG_KEY	0x1f
+#define ABX8XX_CFG_KEY_OSC	0xa1
 #define ABX8XX_CFG_KEY_MISC	0x9d
 
 #define ABX8XX_REG_ID0		0x28
@@ -81,6 +93,20 @@ static struct abx80x_cap abx80x_caps[] = {
 	[ABX80X] = {.pn = 0}
 };
 
+static int abx80x_is_rc_mode(struct i2c_client *client)
+{
+	int flags = 0;
+
+	flags =  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSS);
+	if (flags < 0) {
+		dev_err(&client->dev,
+			"Failed to read autocalibration attribute\n");
+		return flags;
+	}
+
+	return (flags & ABX8XX_OSS_OMODE) ? 1 : 0;
+}
+
 static int abx80x_enable_trickle_charger(struct i2c_client *client,
 					 u8 trickle_cfg)
 {
@@ -248,6 +274,174 @@ static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	return 0;
 }
 
+static int abx80x_rtc_set_autocalibration(struct device *dev,
+					  int autocalibration)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int retval, flags = 0;
+
+	if ((autocalibration != 0) && (autocalibration != 1024) &&
+	    (autocalibration != 512)) {
+		dev_err(dev, "autocalibration value outside permitted range\n");
+		return -EINVAL;
+	}
+
+	flags = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
+	if (flags < 0)
+		return flags;
+
+	if (autocalibration == 0) {
+		flags &= ~(ABX8XX_OSC_ACAL_512 | ABX8XX_OSC_ACAL_1024);
+	} else if (autocalibration == 1024) {
+		/* 1024 autocalibration is 0x10 */
+		flags |= ABX8XX_OSC_ACAL_1024;
+		flags &= ~(ABX8XX_OSC_ACAL_512);
+	} else {
+		/* 512 autocalibration is 0x11 */
+		flags |= (ABX8XX_OSC_ACAL_1024 | ABX8XX_OSC_ACAL_512);
+	}
+
+	/* Unlock write access to Oscillator Control Register */
+	retval = i2c_smbus_write_byte_data(client, ABX8XX_REG_CFG_KEY,
+					   ABX8XX_CFG_KEY_OSC);
+	if (retval < 0) {
+		dev_err(dev, "Failed to write CONFIG_KEY register\n");
+		return retval;
+	}
+
+	retval = i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC, flags);
+
+	return retval;
+}
+
+static int abx80x_rtc_get_autocalibration(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int flags = 0, autocalibration;
+
+	flags =  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
+	if (flags < 0)
+		return flags;
+
+	if (flags & ABX8XX_OSC_ACAL_512)
+		autocalibration = 512;
+	else if (flags & ABX8XX_OSC_ACAL_1024)
+		autocalibration = 1024;
+	else
+		autocalibration = 0;
+
+	return autocalibration;
+}
+
+static ssize_t autocalibration_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int retval;
+	unsigned long autocalibration = 0;
+
+	retval = kstrtoul(buf, 10, &autocalibration);
+	if (retval < 0) {
+		dev_err(dev, "Failed to store RTC autocalibration attribute\n");
+		return -EINVAL;
+	}
+
+	retval = abx80x_rtc_set_autocalibration(dev, autocalibration);
+
+	return retval ? retval : count;
+}
+
+static ssize_t autocalibration_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	int autocalibration = 0;
+
+	autocalibration = abx80x_rtc_get_autocalibration(dev);
+	if (autocalibration < 0) {
+		dev_err(dev, "Failed to read RTC autocalibration\n");
+		sprintf(buf, "0\n");
+		return autocalibration;
+	}
+
+	return sprintf(buf, "%d\n", autocalibration);
+}
+
+static DEVICE_ATTR_RW(autocalibration);
+
+static ssize_t oscillator_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int retval, flags, rc_mode = 0;
+
+	if (strncmp(buf, "rc", 2) == 0) {
+		rc_mode = 1;
+	} else if (strncmp(buf, "xtal", 4) == 0) {
+		rc_mode = 0;
+	} else {
+		dev_err(dev, "Oscillator selection value outside permitted ones\n");
+		return -EINVAL;
+	}
+
+	flags =  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
+	if (flags < 0)
+		return flags;
+
+	if (rc_mode == 0)
+		flags &= ~(ABX8XX_OSC_OSEL);
+	else
+		flags |= (ABX8XX_OSC_OSEL);
+
+	/* Unlock write access on Oscillator Control register */
+	retval = i2c_smbus_write_byte_data(client, ABX8XX_REG_CFG_KEY,
+					   ABX8XX_CFG_KEY_OSC);
+	if (retval < 0) {
+		dev_err(dev, "Failed to write CONFIG_KEY register\n");
+		return retval;
+	}
+
+	retval = i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC, flags);
+	if (retval < 0) {
+		dev_err(dev, "Failed to write Oscillator Control register\n");
+		return retval;
+	}
+
+	return retval ? retval : count;
+}
+
+static ssize_t oscillator_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc_mode = 0;
+	struct i2c_client *client = to_i2c_client(dev);
+
+	rc_mode = abx80x_is_rc_mode(client);
+
+	if (rc_mode < 0) {
+		dev_err(dev, "Failed to read RTC oscillator selection\n");
+		sprintf(buf, "\n");
+		return rc_mode;
+	}
+
+	if (rc_mode)
+		return sprintf(buf, "rc\n");
+	else
+		return sprintf(buf, "xtal\n");
+}
+
+static DEVICE_ATTR_RW(oscillator);
+
+static struct attribute *rtc_calib_attrs[] = {
+	&dev_attr_autocalibration.attr,
+	&dev_attr_oscillator.attr,
+	NULL,
+};
+
+static const struct attribute_group rtc_calib_attr_group = {
+	.attrs		= rtc_calib_attrs,
+};
+
 static int abx80x_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -303,6 +497,13 @@ static int abx80x_dt_trickle_cfg(struct device_node *np)
 	return (trickle_cfg | i);
 }
 
+static void rtc_calib_remove_sysfs_group(void *_dev)
+{
+	struct device *dev = _dev;
+
+	sysfs_remove_group(&dev->kobj, &rtc_calib_attr_group);
+}
+
 static int abx80x_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -405,6 +606,24 @@ static int abx80x_probe(struct i2c_client *client,
 		}
 	}
 
+	/* Export sysfs entries */
+	err = sysfs_create_group(&(&client->dev)->kobj, &rtc_calib_attr_group);
+	if (err) {
+		dev_err(&client->dev, "Failed to create sysfs group: %d\n",
+			err);
+		return err;
+	}
+
+	err = devm_add_action(&client->dev, rtc_calib_remove_sysfs_group,
+			      &client->dev);
+	if (err) {
+		rtc_calib_remove_sysfs_group(&client->dev);
+		dev_err(&client->dev,
+			"Failed to add sysfs cleanup action: %d\n",
+			err);
+		return err;
+	}
+
 	return 0;
 }
 
-- 
2.7.0

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
