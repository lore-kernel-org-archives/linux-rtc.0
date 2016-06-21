Return-Path: <rtc-linux+bncBDKOBWPM5ABRBWOWUO5QKGQE33LHVFQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com. [2607:f8b0:400e:c03::241])
        by gmr-mx.google.com with ESMTPS id c11si5951032pfc.2.2016.06.21.00.23.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 00:23:04 -0700 (PDT)
Received: by mail-pa0-x241.google.com with SMTP id us13so739156pab.1
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 00:23:04 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	cphealy@gmail.com
Subject: [rtc-linux] [PATCH v2 07/17] RTC: ds1307: Move chip configuration
 into a separate routine
Date: Tue, 21 Jun 2016 00:22:40 -0700
Message-Id: <1466493770-11895-6-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Move chip configuration into a separate routine to improve readablity of
the code.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 172 ++++++++++++++++++++++++++---------------------
 1 file changed, 97 insertions(+), 75 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index ccfaba4..4fa09dc 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1271,74 +1271,32 @@ static bool ds1307_want_irq(const struct ds1307 *ds1307,
 	return false;
 }
 
-static int ds1307_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int ds1307_chip_configure(struct ds1307 *ds1307)
 {
-	struct ds1307		*ds1307;
-	int			err = -ENODEV;
-	int			tmp;
-	struct chip_desc	*chip = &chips[id->driver_data];
-	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
-	unsigned char		*buf;
-	struct ds1307_platform_data *pdata = dev_get_platdata(&client->dev);
-	irq_handler_t	irq_handler = ds1307_irq;
-
-	static const int	bbsqi_bitpos[] = {
-		[ds_1337] = 0,
-		[ds_1341] = 0,
-		[ds_1339] = DS1339_BIT_BBSQI,
-		[ds_3231] = DS3231_BIT_BBSQW,
-	};
-	const struct rtc_class_ops *rtc_ops = &ds13xx_rtc_ops;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)
-	    && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
-		return -EIO;
-
-	ds1307 = devm_kzalloc(&client->dev, sizeof(struct ds1307), GFP_KERNEL);
-	if (!ds1307)
-		return -ENOMEM;
-
-	i2c_set_clientdata(client, ds1307);
-
-	ds1307->client	= client;
-	ds1307->type	= id->driver_data;
-
-	if (!pdata && client->dev.of_node)
-		ds1307_trickle_of_init(client, chip);
-	else if (pdata && pdata->trickle_charger_setup)
-		chip->trickle_charger_setup = pdata->trickle_charger_setup;
-
-	if (chip->trickle_charger_setup && chip->trickle_charger_reg) {
-		dev_dbg(&client->dev, "writing trickle charger info 0x%x to 0x%x\n",
-		    DS13XX_TRICKLE_CHARGER_MAGIC | chip->trickle_charger_setup,
-		    chip->trickle_charger_reg);
-		i2c_smbus_write_byte_data(client, chip->trickle_charger_reg,
-		    DS13XX_TRICKLE_CHARGER_MAGIC |
-		    chip->trickle_charger_setup);
-	}
+	int tmp;
+	unsigned char *buf;
+	struct i2c_client *client = ds1307->client;
 
 	buf = ds1307->regs;
-	if (i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK)) {
-		ds1307->read_block_data = ds1307_native_smbus_read_block_data;
-		ds1307->write_block_data = ds1307_native_smbus_write_block_data;
-	} else {
-		ds1307->read_block_data = ds1307_read_block_data;
-		ds1307->write_block_data = ds1307_write_block_data;
-	}
 
 	switch (ds1307->type) {
 	case ds_1337:
 	case ds_1339:
 	case ds_3231:
-	case ds_1341:
+	case ds_1341: {
+		static const int bbsqi_bitpos[] = {
+			[ds_1337] = 0,
+			[ds_1341] = 0,
+			[ds_1339] = DS1339_BIT_BBSQI,
+			[ds_3231] = DS3231_BIT_BBSQW,
+		};
+
 		/* get registers that the "rtc" read below won't read... */
-		tmp = ds1307->read_block_data(ds1307->client,
-				DS1337_REG_CONTROL, 2, buf);
+		tmp = ds1307->read_block_data(client,
+					      DS1337_REG_CONTROL, 2, buf);
 		if (tmp != 2) {
-			dev_dbg(&client->dev, "read error %d\n", tmp);
-			err = -EIO;
-			goto exit;
+			dev_dbg(&ds1307->client->dev, "read error %d\n", tmp);
+			return -EIO;
 		}
 
 		/* oscillator off?  turn it on, so clock can tick. */
@@ -1366,7 +1324,8 @@ static int ds1307_probe(struct i2c_client *client,
 			 * Write status register. Control register
 			 * would be set by the code below
 			 */
-			i2c_smbus_write_byte_data(client, DS1337_REG_STATUS,
+			i2c_smbus_write_byte_data(client,
+						  DS1337_REG_STATUS,
 						  ds1307->regs[1]);
 		}
 
@@ -1379,24 +1338,26 @@ static int ds1307_probe(struct i2c_client *client,
 			| bbsqi_bitpos[ds1307->type];
 		ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
 
-		i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL,
-							ds1307->regs[0]);
+		i2c_smbus_write_byte_data(client,
+					  DS1337_REG_CONTROL,
+					  ds1307->regs[0]);
 
 		/* oscillator fault?  clear flag, and warn */
 		if (ds1307->regs[1] & DS1337_BIT_OSF) {
-			i2c_smbus_write_byte_data(client, DS1337_REG_STATUS,
-				ds1307->regs[1] & ~DS1337_BIT_OSF);
-			dev_warn(&client->dev, "SET TIME!\n");
+			i2c_smbus_write_byte_data(client,
+						  DS1337_REG_STATUS,
+						  ds1307->regs[1] & ~DS1337_BIT_OSF);
+			dev_warn(&ds1307->client->dev, "SET TIME!\n");
 		}
 		break;
-
+	}
 	case rx_8025:
-		tmp = i2c_smbus_read_i2c_block_data(ds1307->client,
-				RX8025_REG_CTRL1 << 4 | 0x08, 2, buf);
+		tmp = i2c_smbus_read_i2c_block_data(client,
+						    RX8025_REG_CTRL1 << 4 | 0x08,
+						    2, buf);
 		if (tmp != 2) {
 			dev_dbg(&client->dev, "read error %d\n", tmp);
-			err = -EIO;
-			goto exit;
+			return -EIO;
 		}
 
 		/* oscillator off?  turn it on, so clock can tick. */
@@ -1432,15 +1393,14 @@ static int ds1307_probe(struct i2c_client *client,
 			/* switch to 24 hour mode */
 			i2c_smbus_write_byte_data(client,
 						  RX8025_REG_CTRL1 << 4 | 0x08,
-						  ds1307->regs[0] |
-						  RX8025_BIT_2412);
+						  ds1307->regs[0] | RX8025_BIT_2412);
 
-			tmp = i2c_smbus_read_i2c_block_data(ds1307->client,
-					RX8025_REG_CTRL1 << 4 | 0x08, 2, buf);
+			tmp = i2c_smbus_read_i2c_block_data(client,
+							    RX8025_REG_CTRL1 << 4 | 0x08,
+							    2, buf);
 			if (tmp != 2) {
 				dev_dbg(&client->dev, "read error %d\n", tmp);
-				err = -EIO;
-				goto exit;
+				return -EIO;
 			}
 
 			/* correct hour */
@@ -1455,6 +1415,68 @@ static int ds1307_probe(struct i2c_client *client,
 						  hour);
 		}
 		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int ds1307_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct ds1307		*ds1307;
+	int			err = -ENODEV;
+	int			tmp;
+	struct chip_desc	*chip = &chips[id->driver_data];
+	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
+	unsigned char		*buf;
+	struct ds1307_platform_data *pdata = dev_get_platdata(&client->dev);
+	irq_handler_t	irq_handler = ds1307_irq;
+
+	const struct rtc_class_ops *rtc_ops = &ds13xx_rtc_ops;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)
+	    && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -EIO;
+
+	ds1307 = devm_kzalloc(&client->dev, sizeof(struct ds1307), GFP_KERNEL);
+	if (!ds1307)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, ds1307);
+
+	ds1307->client	= client;
+	ds1307->type	= id->driver_data;
+
+	if (!pdata && client->dev.of_node)
+		ds1307_trickle_of_init(client, chip);
+	else if (pdata && pdata->trickle_charger_setup)
+		chip->trickle_charger_setup = pdata->trickle_charger_setup;
+
+	if (chip->trickle_charger_setup && chip->trickle_charger_reg) {
+		dev_dbg(&client->dev, "writing trickle charger info 0x%x to 0x%x\n",
+		    DS13XX_TRICKLE_CHARGER_MAGIC | chip->trickle_charger_setup,
+		    chip->trickle_charger_reg);
+		i2c_smbus_write_byte_data(client, chip->trickle_charger_reg,
+		    DS13XX_TRICKLE_CHARGER_MAGIC |
+		    chip->trickle_charger_setup);
+	}
+
+	buf = ds1307->regs;
+	if (i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK)) {
+		ds1307->read_block_data = ds1307_native_smbus_read_block_data;
+		ds1307->write_block_data = ds1307_native_smbus_write_block_data;
+	} else {
+		ds1307->read_block_data = ds1307_read_block_data;
+		ds1307->write_block_data = ds1307_write_block_data;
+	}
+
+	err = ds1307_chip_configure(ds1307);
+	if (err < 0)
+		return err;
+
+	switch (ds1307->type) {
 	case ds_1388:
 		ds1307->offset = 1; /* Seconds starts at 1 */
 		break;
-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
