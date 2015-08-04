Return-Path: <rtc-linux+bncBDS7HNEFSALRBTETQKXAKGQE4KWQEWI@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id jv9si51676wid.0.2015.08.04.02.45.47
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:47 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 09/15] rtc: rx8025: cleanup accessors
Date: Tue,  4 Aug 2015 11:45:28 +0200
Message-Id: <1438681534-12027-10-git-send-email-alexandre.belloni@free-electrons.com>
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

Remove useless error messages, at that point, the user already knows
something went wrong but will not be able to do anything about it anyway.
It is also highly unlikely that some registers are readable/writable
but not some other ones.

Also, transform rx8025_read_reg to be more resemblant to
i2c_smbus_read_byte_data()

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 85 ++++++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 54 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index d158a640299e..bf96f40fd200 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -75,65 +75,43 @@ struct rx8025_data {
 	u8 ctrl1;
 };
 
-static int rx8025_read_reg(struct i2c_client *client, int number, u8 *value)
+static s32 rx8025_read_reg(const struct i2c_client *client, u8 number)
 {
-	int ret = i2c_smbus_read_byte_data(client, number << 4);
-
-	if (ret < 0) {
-		dev_err(&client->dev, "Unable to read register #%d\n", number);
-		return ret;
-	}
-
-	*value = ret;
-	return 0;
+	return i2c_smbus_read_byte_data(client, number << 4);
 }
 
-static int rx8025_read_regs(struct i2c_client *client,
-			    int number, u8 length, u8 *values)
+static int rx8025_read_regs(const struct i2c_client *client,
+			    u8 number, u8 length, u8 *values)
 {
-	int ret = i2c_smbus_read_i2c_block_data(client, number << 4,
-						length, values);
-
-	if (ret != length) {
-		dev_err(&client->dev, "Unable to read registers #%d..#%d\n",
-			number, number + length - 1);
+	int ret = i2c_smbus_read_i2c_block_data(client, number << 4, length,
+						values);
+	if (ret != length)
 		return ret < 0 ? ret : -EIO;
-	}
 
 	return 0;
 }
 
-static int rx8025_write_reg(struct i2c_client *client, int number, u8 value)
+static s32 rx8025_write_reg(const struct i2c_client *client, u8 number,
+			    u8 value)
 {
-	int ret = i2c_smbus_write_byte_data(client, number << 4, value);
-
-	if (ret)
-		dev_err(&client->dev, "Unable to write register #%d\n",
-			number);
-
-	return ret;
+	return i2c_smbus_write_byte_data(client, number << 4, value);
 }
 
-static int rx8025_write_regs(struct i2c_client *client,
-			     int number, u8 length, u8 *values)
+static s32 rx8025_write_regs(const struct i2c_client *client,
+			     u8 number, u8 length, const u8 *values)
 {
-	int ret = i2c_smbus_write_i2c_block_data(client, number << 4,
-						 length, values);
-
-	if (ret)
-		dev_err(&client->dev, "Unable to write registers #%d..#%d\n",
-			number, number + length - 1);
-
-	return ret;
+	return i2c_smbus_write_i2c_block_data(client, number << 4,
+					      length, values);
 }
 
 static irqreturn_t rx8025_handle_irq(int irq, void *dev_id)
 {
 	struct i2c_client *client = dev_id;
 	struct rx8025_data *rx8025 = i2c_get_clientdata(client);
-	u8 status;
+	int status;
 
-	if (rx8025_read_reg(client, RX8025_REG_CTRL2, &status))
+	status = rx8025_read_reg(client, RX8025_REG_CTRL2);
+	if (status < 0)
 		goto out;
 
 	if (!(status & RX8025_BIT_CTRL2_XST))
@@ -166,12 +144,12 @@ out:
 static int rx8025_get_time(struct device *dev, struct rtc_time *dt)
 {
 	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
-	u8 date[7], ctrl;
-	int err;
+	u8 date[7];
+	int ctrl, err;
 
-	err = rx8025_read_reg(rx8025->client, RX8025_REG_CTRL2, &ctrl);
-	if (err)
-		return err;
+	ctrl = rx8025_read_reg(rx8025->client, RX8025_REG_CTRL2);
+	if (ctrl < 0)
+		return ctrl;
 
 	if (ctrl & RX8025_BIT_CTRL2_PON) {
 		dev_warn(dev, "power-on reset detected, date is invalid\n");
@@ -302,8 +280,8 @@ static int rx8025_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
 	struct i2c_client *client = rx8025->client;
-	u8 ctrl2, ald[2];
-	int err;
+	u8 ald[2];
+	int ctrl2, err;
 
 	if (client->irq <= 0)
 		return -EINVAL;
@@ -312,9 +290,9 @@ static int rx8025_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	if (err)
 		return err;
 
-	err = rx8025_read_reg(client, RX8025_REG_CTRL2, &ctrl2);
-	if (err)
-		return err;
+	ctrl2 = rx8025_read_reg(client, RX8025_REG_CTRL2);
+	if (ctrl2 < 0)
+		return ctrl2;
 
 	dev_dbg(dev, "%s: read alarm 0x%02x 0x%02x ctrl2 %02x\n",
 		__func__, ald[0], ald[1], ctrl2);
@@ -435,12 +413,11 @@ static struct rtc_class_ops rx8025_rtc_ops = {
 static int rx8025_get_clock_adjust(struct device *dev, int *adj)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	u8 digoff;
-	int err;
+	int digoff;
 
-	err = rx8025_read_reg(client, RX8025_REG_DIGOFF, &digoff);
-	if (err)
-		return err;
+	digoff = rx8025_read_reg(client, RX8025_REG_DIGOFF);
+	if (digoff < 0)
+		return digoff;
 
 	*adj = digoff >= 64 ? digoff - 128 : digoff;
 	if (*adj > 0)
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
