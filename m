Return-Path: <rtc-linux+bncBDKOBWPM5ABRBWWWUO5QKGQEQJEYVBI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id po17si907962pab.2.2016.06.21.00.23.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 00:23:06 -0700 (PDT)
Received: by mail-pf0-x241.google.com with SMTP id t190so762020pfb.2
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 00:23:06 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	cphealy@gmail.com
Subject: [rtc-linux] [PATCH v2 08/17] RTC: ds1307: Move chip sanity checking
 into a separate routine
Date: Tue, 21 Jun 2016 00:22:41 -0700
Message-Id: <1466493770-11895-7-git-send-email-andrew.smirnov@gmail.com>
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

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 148 +++++++++++++++++++++++++----------------------
 1 file changed, 79 insertions(+), 69 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 4fa09dc..d262db5 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1422,79 +1422,20 @@ static int ds1307_chip_configure(struct ds1307 *ds1307)
 	return 0;
 }
 
-static int ds1307_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int ds1307_chip_sanity_check(struct ds1307 *ds1307)
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
-
-	err = ds1307_chip_configure(ds1307);
-	if (err < 0)
-		return err;
-
-	switch (ds1307->type) {
-	case ds_1388:
-		ds1307->offset = 1; /* Seconds starts at 1 */
-		break;
-	case mcp794xx:
-		rtc_ops = &mcp794xx_rtc_ops;
-		irq_handler = mcp794xx_irq;
-		break;
-	default:
-		break;
-	}
 
 read_rtc:
 	/* read RTC registers */
 	tmp = ds1307->read_block_data(ds1307->client, ds1307->offset, 8, buf);
 	if (tmp != 8) {
 		dev_dbg(&client->dev, "read error %d\n", tmp);
-		err = -EIO;
-		goto exit;
+		return -EIO;
 	}
 
 	/*
@@ -1535,8 +1476,7 @@ read_rtc:
 		tmp = i2c_smbus_read_byte_data(client, DS1340_REG_FLAG);
 		if (tmp < 0) {
 			dev_dbg(&client->dev, "read error %d\n", tmp);
-			err = -EIO;
-			goto exit;
+			return -EIO;
 		}
 
 		/* oscillator fault?  clear flag, and warn */
@@ -1566,6 +1506,79 @@ read_rtc:
 		break;
 	}
 
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
+	case ds_1388:
+		ds1307->offset = 1; /* Seconds starts at 1 */
+		break;
+	case mcp794xx:
+		rtc_ops = &mcp794xx_rtc_ops;
+		irq_handler = mcp794xx_irq;
+		break;
+	default:
+		break;
+	}
+
+	err = ds1307_chip_sanity_check(ds1307);
+	if (err < 0)
+		return err;
+
 	tmp = ds1307->regs[DS1307_REG_HOUR];
 	switch (ds1307->type) {
 	case ds_1340:
@@ -1663,9 +1676,6 @@ read_rtc:
 	ds1307_clks_register(ds1307);
 
 	return 0;
-
-exit:
-	return err;
 }
 
 static int ds1307_remove(struct i2c_client *client)
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
