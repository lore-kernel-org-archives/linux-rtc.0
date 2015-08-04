Return-Path: <rtc-linux+bncBDS7HNEFSALRBS4TQKXAKGQEYFFENWA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id jf3si51225wic.0.2015.08.04.02.45.47
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:47 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 08/15] rtc: rx8025: don't reset the time
Date: Tue,  4 Aug 2015 11:45:27 +0200
Message-Id: <1438681534-12027-9-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1438681534-12027-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438681534-12027-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Stop setting the time to epoch when it is invalid. The proper way to handle
that is to return an error when it is invalid instead of returning an
incorrect value.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 771558602409..d158a640299e 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -166,9 +166,23 @@ out:
 static int rx8025_get_time(struct device *dev, struct rtc_time *dt)
 {
 	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
-	u8 date[7];
+	u8 date[7], ctrl;
 	int err;
 
+	err = rx8025_read_reg(rx8025->client, RX8025_REG_CTRL2, &ctrl);
+	if (err)
+		return err;
+
+	if (ctrl & RX8025_BIT_CTRL2_PON) {
+		dev_warn(dev, "power-on reset detected, date is invalid\n");
+		return -EINVAL;
+	}
+
+	if (!(ctrl & RX8025_BIT_CTRL2_XST)) {
+		dev_warn(dev, "crystal stopped, date is invalid\n");
+		return -EINVAL;
+	}
+
 	err = rx8025_read_regs(rx8025->client, RX8025_REG_SEC, 7, date);
 	if (err)
 		return err;
@@ -230,7 +244,7 @@ static int rx8025_set_time(struct device *dev, struct rtc_time *dt)
 	return rx8025_write_regs(rx8025->client, RX8025_REG_SEC, 7, date);
 }
 
-static int rx8025_init_client(struct i2c_client *client, int *need_reset)
+static int rx8025_init_client(struct i2c_client *client)
 {
 	struct rx8025_data *rx8025 = i2c_get_clientdata(client);
 	u8 ctrl[2], ctrl2;
@@ -247,19 +261,19 @@ static int rx8025_init_client(struct i2c_client *client, int *need_reset)
 	if (ctrl[1] & RX8025_BIT_CTRL2_PON) {
 		dev_warn(&client->dev, "power-on reset was detected, "
 			 "you may have to readjust the clock\n");
-		*need_reset = 1;
+		need_clear = 1;
 	}
 
 	if (ctrl[1] & RX8025_BIT_CTRL2_VDET) {
 		dev_warn(&client->dev, "a power voltage drop was detected, "
 			 "you may have to readjust the clock\n");
-		*need_reset = 1;
+		need_clear = 1;
 	}
 
 	if (!(ctrl[1] & RX8025_BIT_CTRL2_XST)) {
 		dev_warn(&client->dev, "Oscillation stop was detected,"
 			 "you may have to readjust the clock\n");
-		*need_reset = 1;
+		need_clear = 1;
 	}
 
 	if (ctrl[1] & (RX8025_BIT_CTRL2_DAFG | RX8025_BIT_CTRL2_WAFG)) {
@@ -270,7 +284,7 @@ static int rx8025_init_client(struct i2c_client *client, int *need_reset)
 	if (!(ctrl[1] & RX8025_BIT_CTRL2_CTFG))
 		need_clear = 1;
 
-	if (*need_reset || need_clear) {
+	if (need_clear) {
 		ctrl2 = ctrl[0];
 		ctrl2 &= ~(RX8025_BIT_CTRL2_PON | RX8025_BIT_CTRL2_VDET |
 			   RX8025_BIT_CTRL2_CTFG | RX8025_BIT_CTRL2_WAFG |
@@ -508,7 +522,7 @@ static int rx8025_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct rx8025_data *rx8025;
-	int err = 0, need_reset = 0;
+	int err = 0;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
 				     | I2C_FUNC_SMBUS_I2C_BLOCK)) {
@@ -525,18 +539,10 @@ static int rx8025_probe(struct i2c_client *client,
 	rx8025->client = client;
 	i2c_set_clientdata(client, rx8025);
 
-	err = rx8025_init_client(client, &need_reset);
+	err = rx8025_init_client(client);
 	if (err)
 		return err;
 
-	if (need_reset) {
-		struct rtc_time tm;
-		dev_info(&client->dev,
-			 "bad conditions detected, resetting date\n");
-		rtc_time_to_tm(0, &tm);	/* 1970/1/1 */
-		rx8025_set_time(&client->dev, &tm);
-	}
-
 	rx8025->rtc = devm_rtc_device_register(&client->dev, client->name,
 					  &rx8025_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rx8025->rtc)) {
-- 
2.1.4

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
