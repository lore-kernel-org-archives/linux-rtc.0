Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [v2,4/4] rtc: pcf85063Add support for different loads
From: =?utf-8?q?S=C3=B8ren_Andersen?= <san@rosetechnology.dk>
Message-Id: <1426020040.5476.25.camel@sanws1.rosetechnology.dk>
To: a.zummo@towertech.it
Cc: rtc-linux@googlegroups.com
Date: Tue, 10 Mar 2015 21:40:40 +0100
List-ID: <rtc-linux.googlegroups.com>

Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
---
 drivers/rtc/rtc-pcf85063.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 6a12bf6..dff5d84 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -16,10 +16,12 @@
 #include <linux/rtc.h>
 #include <linux/module.h>
 
-#define DRV_VERSION "0.0.1"
+#define DRV_VERSION "0.0.2"
 
 #define PCF85063_REG_CTRL1		0x00 /* status */
+#define PCF85063_REG_CTRL1_CAP_SEL	(1 << 0)
 #define PCF85063_REG_CTRL2		0x01
+#define PCF85063_REG_OFFSET		0x02
 
 #define PCF85063_REG_SC			0x04 /* datetime */
 #define PCF85063_REG_MN			0x05
@@ -94,10 +96,6 @@ static int pcf85063_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	int i = 0, err = 0;
 	unsigned char buf[11];
 
-	/* Control & status */
-	buf[PCF85063_REG_CTRL1] = 0;
-	buf[PCF85063_REG_CTRL2] = 5;
-
 	/* hours, minutes and seconds */
 	buf[PCF85063_REG_SC] = bin2bcd(tm->tm_sec) & 0x7F;
 
@@ -117,7 +115,7 @@ static int pcf85063_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	buf[PCF85063_REG_YR] = bin2bcd(tm->tm_year % 100);
 
 	/* write register's data */
-	for (i = 0; i < sizeof(buf); i++) {
+	for (i = PCF85063_REG_SC; i < sizeof(buf); i++) {
 		unsigned char data[2] = { i, buf[i] };
 
 		err = i2c_master_send(client, data, sizeof(data));
@@ -149,7 +147,14 @@ static const struct rtc_class_ops pcf85063_rtc_ops = {
 static int pcf85063_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
+	int i = 0, err = 0;
 	struct pcf85063 *pcf85063;
+	unsigned char buf[3];
+
+	/* Control & status */
+	buf[PCF85063_REG_CTRL1] = 0;
+	buf[PCF85063_REG_CTRL2] = 7;
+	buf[PCF85063_REG_OFFSET] = 0x00;
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
@@ -169,6 +174,26 @@ static int pcf85063_probe(struct i2c_client *client,
 				pcf85063_driver.driver.name,
 				&pcf85063_rtc_ops, THIS_MODULE);
 
+	if (of_property_match_string(client->dev.of_node,
+				     "quartz_load", "12.5pF") == 0)
+		buf[PCF85063_REG_CTRL1] |= PCF85063_REG_CTRL1_CAP_SEL;
+
+	if (of_property_match_string(client->dev.of_node,
+				     "quartz_load", "7pF") == 0)
+		buf[PCF85063_REG_CTRL1] &= ~PCF85063_REG_CTRL1_CAP_SEL;
+
+	/* write register's data */
+	for (i = 0; i < sizeof(buf); i++) {
+		unsigned char data[3] = { i, buf[i] };
+
+		err = i2c_master_send(client, data, sizeof(data));
+		if (err != sizeof(data)) {
+			dev_err(&client->dev, "%s: err=%d addr=%02x, data=%02x\n",
+			__func__, err, data[0], data[1]);
+			return -EIO;
+		}
+	}
+
 	return PTR_ERR_OR_ZERO(pcf85063->rtc);
 }
 
