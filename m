Return-Path: <rtc-linux+bncBDS7HNEFSALRB6PKY6ZQKGQE3BM64CQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s6si305710wmf.1.2015.12.16.15.36.24
        for <rtc-linux@googlegroups.com>;
        Wed, 16 Dec 2015 15:36:24 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 2/2] rtc: abx80x: add alarm support
Date: Thu, 17 Dec 2015 00:36:22 +0100
Message-Id: <1450308982-21073-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1450308982-21073-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1450308982-21073-1-git-send-email-alexandre.belloni@free-electrons.com>
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

Add alarm support to the abx80x driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-abx80x.c | 145 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 141 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 203e6616d413..d41bbcd653f6 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -27,10 +27,28 @@
 #define ABX8XX_REG_YR		0x06
 #define ABX8XX_REG_WD		0x07
 
+#define ABX8XX_REG_AHTH		0x08
+#define ABX8XX_REG_ASC		0x09
+#define ABX8XX_REG_AMN		0x0a
+#define ABX8XX_REG_AHR		0x0b
+#define ABX8XX_REG_ADA		0x0c
+#define ABX8XX_REG_AMO		0x0d
+#define ABX8XX_REG_AWD		0x0e
+
+#define ABX8XX_REG_STATUS	0x0f
+#define ABX8XX_STATUS_AF	BIT(2)
+
 #define ABX8XX_REG_CTRL1	0x10
 #define ABX8XX_CTRL_WRITE	BIT(0)
+#define ABX8XX_CTRL_ARST	BIT(2)
 #define ABX8XX_CTRL_12_24	BIT(6)
 
+#define ABX8XX_REG_IRQ		0x12
+#define ABX8XX_IRQ_AIE		BIT(2)
+#define ABX8XX_IRQ_IM_1_4	(0x3 << 5)
+
+#define ABX8XX_REG_CD_TIMER_CTL	0x18
+
 #define ABX8XX_REG_CFG_KEY	0x1f
 #define ABX8XX_CFG_KEY_MISC	0x9d
 
@@ -63,8 +81,6 @@ static struct abx80x_cap abx80x_caps[] = {
 	[ABX80X] = {.pn = 0}
 };
 
-static struct i2c_driver abx80x_driver;
-
 static int abx80x_enable_trickle_charger(struct i2c_client *client,
 					 u8 trickle_cfg)
 {
@@ -148,9 +164,111 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
+{
+	struct i2c_client *client = dev_id;
+	struct rtc_device *rtc = i2c_get_clientdata(client);
+	int status;
+
+	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
+	if (status < 0)
+		return IRQ_NONE;
+
+	if (status & ABX8XX_STATUS_AF)
+		rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
+
+	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
+
+	return IRQ_HANDLED;
+}
+
+static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned char buf[7];
+
+	int irq_mask, err;
+
+	if (client->irq <= 0)
+		return -EINVAL;
+
+	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
+					    sizeof(buf), buf);
+	if (err)
+		return err;
+
+	irq_mask = i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);
+	if (irq_mask < 0)
+		return irq_mask;
+
+	t->time.tm_sec = bcd2bin(buf[0] & 0x7F);
+	t->time.tm_min = bcd2bin(buf[1] & 0x7F);
+	t->time.tm_hour = bcd2bin(buf[2] & 0x3F);
+	t->time.tm_mday = bcd2bin(buf[3] & 0x3F);
+	t->time.tm_mon = bcd2bin(buf[4] & 0x1F) - 1;
+	t->time.tm_wday = buf[5] & 0x7;
+
+	t->enabled = !!(irq_mask & ABX8XX_IRQ_AIE);
+	t->pending = (buf[6] & ABX8XX_STATUS_AF) && t->enabled;
+
+	return err;
+}
+
+static int abx80x_set_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 alarm[6];
+	int err;
+
+	if (client->irq <= 0)
+		return -EINVAL;
+
+	alarm[0] = 0x0;
+	alarm[1] = bin2bcd(t->time.tm_sec);
+	alarm[2] = bin2bcd(t->time.tm_min);
+	alarm[3] = bin2bcd(t->time.tm_hour);
+	alarm[4] = bin2bcd(t->time.tm_mday);
+	alarm[5] = bin2bcd(t->time.tm_mon + 1);
+
+	err = i2c_smbus_write_i2c_block_data(client, ABX8XX_REG_AHTH,
+					     sizeof(alarm), alarm);
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write alarm registers\n");
+		return -EIO;
+	}
+
+	if (t->enabled) {
+		err = i2c_smbus_write_byte_data(client, ABX8XX_REG_IRQ,
+						(ABX8XX_IRQ_IM_1_4 |
+						 ABX8XX_IRQ_AIE));
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int abx80x_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int err;
+
+	if (enabled)
+		err = i2c_smbus_write_byte_data(client, ABX8XX_REG_IRQ,
+						(ABX8XX_IRQ_IM_1_4 |
+						 ABX8XX_IRQ_AIE));
+	else
+		err = i2c_smbus_write_byte_data(client, ABX8XX_REG_IRQ,
+						ABX8XX_IRQ_IM_1_4);
+	return err;
+}
+
 static const struct rtc_class_ops abx80x_rtc_ops = {
 	.read_time	= abx80x_rtc_read_time,
 	.set_time	= abx80x_rtc_set_time,
+	.read_alarm	= abx80x_read_alarm,
+	.set_alarm	= abx80x_set_alarm,
+	.alarm_irq_enable = abx80x_alarm_irq_enable,
 };
 
 static int abx80x_dt_trickle_cfg(struct device_node *np)
@@ -225,7 +343,8 @@ static int abx80x_probe(struct i2c_client *client,
 	}
 
 	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_CTRL1,
-					((data & ~ABX8XX_CTRL_12_24) |
+					((data & ~(ABX8XX_CTRL_12_24 |
+						   ABX8XX_CTRL_ARST)) |
 					 ABX8XX_CTRL_WRITE));
 	if (err < 0) {
 		dev_err(&client->dev, "Unable to write control register\n");
@@ -260,7 +379,12 @@ static int abx80x_probe(struct i2c_client *client,
 		abx80x_enable_trickle_charger(client, trickle_cfg);
 	}
 
-	rtc = devm_rtc_device_register(&client->dev, abx80x_driver.driver.name,
+	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_CD_TIMER_CTL,
+					BIT(2));
+	if (err)
+		return err;
+
+	rtc = devm_rtc_device_register(&client->dev, "abx8xx",
 				       &abx80x_rtc_ops, THIS_MODULE);
 
 	if (IS_ERR(rtc))
@@ -268,6 +392,19 @@ static int abx80x_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, rtc);
 
+	if (client->irq > 0) {
+		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
+		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+						abx80x_handle_irq,
+						IRQF_SHARED | IRQF_ONESHOT,
+						"abx8xx",
+						client);
+		if (err) {
+			dev_err(&client->dev, "unable to request IRQ, alarms disabled\n");
+			client->irq = 0;
+		}
+	}
+
 	return 0;
 }
 
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
