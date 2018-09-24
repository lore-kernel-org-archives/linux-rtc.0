Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-db5eur01on0087.outbound.protection.outlook.com ([104.47.2.87]:27232
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728236AbeIXRZz (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 24 Sep 2018 13:25:55 -0400
From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        lukas.stockmann@siemens.com, pascal.bach@siemens.com,
        urs.fassler@bbv.ch
Subject: [PATCH 2/2] rtc: pcf85063: add support for oscillator capacitor selection
Date: Mon, 24 Sep 2018 13:23:40 +0200
Message-Id: <20180924112340.2685-2-urs.fassler@bbv.ch>
In-Reply-To: <20180924112340.2685-1-urs.fassler@bbv.ch>
References: <20180924112340.2685-1-urs.fassler@bbv.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Configure the oscillator capacitor selection if specified.

Co-developed-by: Lukas Stockmann <lukas.stockmann@siemens.com>
Signed-off-by: Urs Fässler <urs.fassler@bbv.ch>
Signed-off-by: Lukas Stockmann <lukas.stockmann@siemens.com>
Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 drivers/rtc/rtc-pcf85063.c | 54 +++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 283c2335b01b..69ee72f00164 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -180,21 +180,67 @@ static const struct rtc_class_ops pcf85063_rtc_ops = {
 	.set_time	= pcf85063_rtc_set_time
 };
 
+
+#ifdef CONFIG_OF
+static int setup_oscillator_capacitor(struct i2c_client *client, u8 ctrl1)
+{
+	int ret;
+	u32 cap_sel;
+
+	ret = of_property_read_u32(client->dev.of_node, "cap-sel", &cap_sel);
+	if (ret != 0) {
+		/* no capacitor selection defined, but that is ok */
+		return 0;
+	}
+
+	if ((cap_sel & 0xfe) != 0) {
+		dev_err(&client->dev,
+			 "Unsupported cap-sel value %u in dt\n", cap_sel);
+		return -EINVAL;
+	}
+
+	ctrl1 = (ctrl1 & 0xfe) | cap_sel;
+	ret = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, ctrl1);
+
+	if (ret < 0) {
+		dev_err(&client->dev, "set oscillator capacitor failed\n");
+		return -EIO;
+	}
+
+	dev_info(&client->dev,
+		 "set oscillator capacitor selection to %u\n", cap_sel);
+
+	return 0;
+}
+#else
+static int setup_oscillator_capacitor(struct i2c_client *client, u8 ctrl1)
+{
+	return 0;
+}
+#endif
+
 static int pcf85063_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	struct rtc_device *rtc;
-	int err;
+	int ret;
+	u8 ctrl1;
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	err = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
-	if (err < 0) {
+	ret = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
+	if (ret < 0) {
 		dev_err(&client->dev, "RTC chip is not present\n");
-		return err;
+		return ret;
+	}
+	ctrl1 = ret;
+
+	ret = setup_oscillator_capacitor(client, ctrl1);
+	if (ret < 0) {
+		return ret;
 	}
 
 	rtc = devm_rtc_device_register(&client->dev,
-- 
2.18.0
