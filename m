Return-Path: <rtc-linux+bncBCPM5SUWUYIRBRXBRO3QKGQEBAADNCI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com. [2607:f8b0:400e:c03::229])
        by gmr-mx.google.com with ESMTPS id ui7si1469185pab.0.2016.03.11.08.22.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Mar 2016 08:22:30 -0800 (PST)
Received: by mail-pa0-x229.google.com with SMTP id fl4so102037223pad.0
        for <rtc-linux@googlegroups.com>; Fri, 11 Mar 2016 08:22:30 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Renaud Cerrato <r.cerrato@til-technologies.fr>
Subject: [rtc-linux] [PATCH 1/3] rtc: pcf2127: conver to use regmap
Date: Sat, 12 Mar 2016 01:22:14 +0900
Message-Id: <1457713336-24262-1-git-send-email-akinobu.mita@gmail.com>
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

pcf2127 has selectable I2C-bus and SPI-bus interface support.
Currently rtc-pcf2127 driver only supports I2C.

This is preparation for support for SPI interface.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Renaud Cerrato <r.cerrato@til-technologies.fr>
---
 drivers/rtc/rtc-pcf2127.c | 209 ++++++++++++++++++++++++++++++----------------
 1 file changed, 139 insertions(+), 70 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 629bfdf..8f269e3 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 
 #define PCF2127_REG_CTRL1       (0x00)  /* Control Register 1 */
 #define PCF2127_REG_CTRL2       (0x01)  /* Control Register 2 */
@@ -36,29 +37,30 @@
 
 #define PCF2127_OSF             BIT(7)  /* Oscillator Fail flag */
 
-static struct i2c_driver pcf2127_driver;
-
 struct pcf2127 {
 	struct rtc_device *rtc;
+	struct regmap *regmap;
 };
 
 /*
  * In the routines that deal directly with the pcf2127 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
  */
-static int pcf2127_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	unsigned char buf[10] = { PCF2127_REG_CTRL1 };
+	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
+	unsigned char buf[10];
+	int ret;
 
-	/* read registers */
-	if (i2c_master_send(client, buf, 1) != 1 ||
-		i2c_master_recv(client, buf, sizeof(buf)) != sizeof(buf)) {
-		dev_err(&client->dev, "%s: read error\n", __func__);
-		return -EIO;
+	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL1, buf,
+				sizeof(buf));
+	if (ret) {
+		dev_err(dev, "%s: read error\n", __func__);
+		return ret;
 	}
 
 	if (buf[PCF2127_REG_CTRL3] & PCF2127_REG_CTRL3_BLF)
-		dev_info(&client->dev,
+		dev_info(dev,
 			"low voltage detected, check/replace RTC battery.\n");
 
 	if (buf[PCF2127_REG_SC] & PCF2127_OSF) {
@@ -66,12 +68,12 @@ static int pcf2127_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 		 * no need clear the flag here,
 		 * it will be cleared once the new date is saved
 		 */
-		dev_warn(&client->dev,
+		dev_warn(dev,
 			 "oscillator stop detected, date/time is not reliable\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(&client->dev,
+	dev_dbg(dev,
 		"%s: raw data is cr1=%02x, cr2=%02x, cr3=%02x, "
 		"sec=%02x, min=%02x, hr=%02x, "
 		"mday=%02x, wday=%02x, mon=%02x, year=%02x\n",
@@ -91,7 +93,7 @@ static int pcf2127_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	if (tm->tm_year < 70)
 		tm->tm_year += 100;	/* assume we are in 1970...2069 */
 
-	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
+	dev_dbg(dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
 		__func__,
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
@@ -100,20 +102,18 @@ static int pcf2127_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	return rtc_valid_tm(tm);
 }
 
-static int pcf2127_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	unsigned char buf[8];
+	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
+	unsigned char buf[7];
 	int i = 0, err;
 
-	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
+	dev_dbg(dev, "%s: secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
 		__func__,
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
 		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
-	/* start register address */
-	buf[i++] = PCF2127_REG_SC;
-
 	/* hours, minutes and seconds */
 	buf[i++] = bin2bcd(tm->tm_sec);	/* this will also clear OSF flag */
 	buf[i++] = bin2bcd(tm->tm_min);
@@ -128,11 +128,11 @@ static int pcf2127_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	buf[i++] = bin2bcd(tm->tm_year % 100);
 
 	/* write register's data */
-	err = i2c_master_send(client, buf, i);
-	if (err != i) {
-		dev_err(&client->dev,
+	err = regmap_bulk_write(pcf2127->regmap, PCF2127_REG_SC, buf, i);
+	if (err) {
+		dev_err(dev,
 			"%s: err=%d", __func__, err);
-		return -EIO;
+		return err;
 	}
 
 	return 0;
@@ -142,26 +142,17 @@ static int pcf2127_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 static int pcf2127_rtc_ioctl(struct device *dev,
 				unsigned int cmd, unsigned long arg)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	unsigned char buf = PCF2127_REG_CTRL3;
+	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
 	int touser;
 	int ret;
 
 	switch (cmd) {
 	case RTC_VL_READ:
-		ret = i2c_master_send(client, &buf, 1);
-		if (!ret)
-			ret = -EIO;
-		if (ret < 0)
-			return ret;
-
-		ret = i2c_master_recv(client, &buf, 1);
-		if (!ret)
-			ret = -EIO;
-		if (ret < 0)
+		ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL3, &touser);
+		if (ret)
 			return ret;
 
-		touser = buf & PCF2127_REG_CTRL3_BLF ? 1 : 0;
+		touser = touser & PCF2127_REG_CTRL3_BLF ? 1 : 0;
 
 		if (copy_to_user((void __user *)arg, &touser, sizeof(int)))
 			return -EFAULT;
@@ -174,52 +165,33 @@ static int pcf2127_rtc_ioctl(struct device *dev,
 #define pcf2127_rtc_ioctl NULL
 #endif
 
-static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	return pcf2127_get_datetime(to_i2c_client(dev), tm);
-}
-
-static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	return pcf2127_set_datetime(to_i2c_client(dev), tm);
-}
-
 static const struct rtc_class_ops pcf2127_rtc_ops = {
 	.ioctl		= pcf2127_rtc_ioctl,
 	.read_time	= pcf2127_rtc_read_time,
 	.set_time	= pcf2127_rtc_set_time,
 };
 
-static int pcf2127_probe(struct i2c_client *client,
-				const struct i2c_device_id *id)
+static int pcf2127_probe(struct device *dev, struct regmap *regmap,
+			const char *name)
 {
 	struct pcf2127 *pcf2127;
 
-	dev_dbg(&client->dev, "%s\n", __func__);
-
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
-		return -ENODEV;
+	dev_dbg(dev, "%s\n", __func__);
 
-	pcf2127 = devm_kzalloc(&client->dev, sizeof(struct pcf2127),
-				GFP_KERNEL);
+	pcf2127 = devm_kzalloc(dev, sizeof(*pcf2127), GFP_KERNEL);
 	if (!pcf2127)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, pcf2127);
+	pcf2127->regmap = regmap;
+
+	dev_set_drvdata(dev, pcf2127);
 
-	pcf2127->rtc = devm_rtc_device_register(&client->dev,
-				pcf2127_driver.driver.name,
-				&pcf2127_rtc_ops, THIS_MODULE);
+	pcf2127->rtc = devm_rtc_device_register(dev, name, &pcf2127_rtc_ops,
+						THIS_MODULE);
 
 	return PTR_ERR_OR_ZERO(pcf2127->rtc);
 }
 
-static const struct i2c_device_id pcf2127_id[] = {
-	{ "pcf2127", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, pcf2127_id);
-
 #ifdef CONFIG_OF
 static const struct of_device_id pcf2127_of_match[] = {
 	{ .compatible = "nxp,pcf2127" },
@@ -228,16 +200,113 @@ static const struct of_device_id pcf2127_of_match[] = {
 MODULE_DEVICE_TABLE(of, pcf2127_of_match);
 #endif
 
-static struct i2c_driver pcf2127_driver = {
+static int pcf2127_i2c_write(void *context, const void *data, size_t count)
+{
+	struct device *dev = context;
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+
+	ret = i2c_master_send(client, data, count);
+	if (ret != count)
+		return ret < 0 ? ret : -EIO;
+
+	return 0;
+}
+
+static int pcf2127_i2c_gather_write(void *context,
+				const void *reg, size_t reg_size,
+				const void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+	void *buf;
+
+	if (WARN_ON(reg_size != 1))
+		return -EINVAL;
+
+	buf = kmalloc(val_size + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memcpy(buf, reg, 1);
+	memcpy(buf + 1, val, val_size);
+
+	ret = i2c_master_send(client, buf, val_size + 1);
+	if (ret != val_size + 1)
+		return ret < 0 ? ret : -EIO;
+
+	return 0;
+}
+
+static int pcf2127_i2c_read(void *context, const void *reg, size_t reg_size,
+				void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+
+	if (WARN_ON(reg_size != 1))
+		return -EINVAL;
+
+	ret = i2c_master_send(client, reg, 1);
+	if (ret != 1)
+		return ret < 0 ? ret : -EIO;
+
+	ret = i2c_master_recv(client, val, val_size);
+	if (ret != val_size)
+		return ret < 0 ? ret : -EIO;
+
+	return 0;
+}
+
+static const struct regmap_bus pcf2127_i2c_regmap = {
+	.write = pcf2127_i2c_write,
+	.gather_write = pcf2127_i2c_gather_write,
+	.read = pcf2127_i2c_read,
+};
+
+static struct i2c_driver pcf2127_i2c_driver;
+
+static int pcf2127_i2c_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	static const struct regmap_config config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+	};
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	regmap = devm_regmap_init(&client->dev, &pcf2127_i2c_regmap,
+					&client->dev, &config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "%s: regmap allocation failed: %ld\n",
+			__func__, PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return pcf2127_probe(&client->dev, regmap,
+				pcf2127_i2c_driver.driver.name);
+}
+
+static const struct i2c_device_id pcf2127_i2c_id[] = {
+	{ "pcf2127", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pcf2127_i2c_id);
+
+static struct i2c_driver pcf2127_i2c_driver = {
 	.driver		= {
-		.name	= "rtc-pcf2127",
+		.name	= "rtc-pcf2127-i2c",
 		.of_match_table = of_match_ptr(pcf2127_of_match),
 	},
-	.probe		= pcf2127_probe,
-	.id_table	= pcf2127_id,
+	.probe		= pcf2127_i2c_probe,
+	.id_table	= pcf2127_i2c_id,
 };
-
-module_i2c_driver(pcf2127_driver);
+module_i2c_driver(pcf2127_i2c_driver);
 
 MODULE_AUTHOR("Renaud Cerrato <r.cerrato@til-technologies.fr>");
 MODULE_DESCRIPTION("NXP PCF2127 RTC driver");
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
