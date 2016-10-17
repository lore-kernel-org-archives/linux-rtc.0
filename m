Return-Path: <mirza.krak@gmail.com>
From: Mirza Krak <mirza.krak@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	Mirza Krak <mirza.krak@hostmobility.com>
Subject: [PATCH 1/1] rtc: pcf85063: do not register a RTC device if chip is not present
Date: Mon, 17 Oct 2016 15:53:31 +0200
Message-Id: <1476712411-20970-1-git-send-email-mirza.krak@gmail.com>
List-ID: <rtc-linux.googlegroups.com>

From: Mirza Krak <mirza.krak@hostmobility.com>

Add a sanity check to see if chip is present. If we can not communicate
with the chip there is no point in registering a RTC device.

Signed-off-by: Mirza Krak <mirza.krak@hostmobility.com>
---
 drivers/rtc/rtc-pcf85063.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index efb0a08..a06dff9 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -191,12 +191,19 @@ static int pcf85063_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	struct rtc_device *rtc;
+	int err;
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
+	err = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
+	if (err < 0) {
+		dev_err(&client->dev, "RTC chip is not present\n");
+		return err;
+	}
+
 	rtc = devm_rtc_device_register(&client->dev,
 				       pcf85063_driver.driver.name,
 				       &pcf85063_rtc_ops, THIS_MODULE);
-- 
2.1.4
