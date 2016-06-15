Return-Path: <rtc-linux+bncBDKOBWPM5ABRB3G5QO5QKGQEDFJYDCY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id 62si3602201pfx.1.2016.06.14.23.00.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 23:00:12 -0700 (PDT)
Received: by mail-pf0-x241.google.com with SMTP id 62so986725pfd.3
        for <rtc-linux@googlegroups.com>; Tue, 14 Jun 2016 23:00:12 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [rtc-linux] [PATCH 10/13] RTC: ds1307: Convert goto to a loop
Date: Tue, 14 Jun 2016 22:59:36 -0700
Message-Id: <1465970379-14703-11-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
References: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Convert goto to a loop and set a hard upper limit on the number of times
driver would try to make RTC work (as opposed to having an infinite
retry loop).

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 151 +++++++++++++++++++++++++----------------------
 1 file changed, 82 insertions(+), 69 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index dbf8361..8ccfe5b 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1424,87 +1424,100 @@ static int ds1307_chip_configure(const struct ds1307 *ds1307)
 
 static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
 {
-	int tmp;
+	int tmp, retries;
 	u8  regs[DS1307_REG_COUNT];
 	struct i2c_client *client = ds1307->client;
 
-read_rtc:
-	/* read RTC registers */
-	tmp = ds1307->read_block_data(ds1307->client, ds1307->offset, 8, regs);
-	if (tmp != 8) {
-		dev_dbg(&client->dev, "read error %d\n", tmp);
-		return -EIO;
-	}
-
-	/*
-	 * minimal sanity checking; some chips (like DS1340) don't
-	 * specify the extra bits as must-be-zero, but there are
-	 * still a few values that are clearly out-of-range.
-	 */
-	tmp = regs[DS1307_REG_SECS];
-	switch (ds1307->type) {
-	case ds_1307:
-	case m41t00:
-		/* clock halted?  turn it on, so clock can tick. */
-		if (tmp & DS1307_BIT_CH) {
-			i2c_smbus_write_byte_data(client, DS1307_REG_SECS, 0);
-			dev_warn(&client->dev, "SET TIME!\n");
-			goto read_rtc;
-		}
-		break;
-	case ds_1338:
-		/* clock halted?  turn it on, so clock can tick. */
-		if (tmp & DS1307_BIT_CH)
-			i2c_smbus_write_byte_data(client, DS1307_REG_SECS, 0);
-
-		/* oscillator fault?  clear flag, and warn */
-		if (regs[DS1307_REG_CONTROL] & DS1338_BIT_OSF) {
-			i2c_smbus_write_byte_data(client, DS1307_REG_CONTROL,
-					regs[DS1307_REG_CONTROL]
-					& ~DS1338_BIT_OSF);
-			dev_warn(&client->dev, "SET TIME!\n");
-			goto read_rtc;
-		}
-		break;
-	case ds_1340:
-		/* clock halted?  turn it on, so clock can tick. */
-		if (tmp & DS1340_BIT_nEOSC)
-			i2c_smbus_write_byte_data(client, DS1307_REG_SECS, 0);
-
-		tmp = i2c_smbus_read_byte_data(client, DS1340_REG_FLAG);
-		if (tmp < 0) {
+	for (retries = 0; retries < 5; retries++) {
+		/* read RTC registers */
+		tmp = ds1307->read_block_data(ds1307->client,
+					      ds1307->offset, 8, regs);
+		if (tmp != 8) {
 			dev_dbg(&client->dev, "read error %d\n", tmp);
 			return -EIO;
 		}
 
-		/* oscillator fault?  clear flag, and warn */
-		if (tmp & DS1340_BIT_OSF) {
-			i2c_smbus_write_byte_data(client, DS1340_REG_FLAG, 0);
-			dev_warn(&client->dev, "SET TIME!\n");
-		}
-		break;
-	case mcp794xx:
-		/* make sure that the backup battery is enabled */
-		if (!(regs[DS1307_REG_WDAY] & MCP794XX_BIT_VBATEN)) {
-			i2c_smbus_write_byte_data(client, DS1307_REG_WDAY,
-					regs[DS1307_REG_WDAY]
-					| MCP794XX_BIT_VBATEN);
-		}
+		/*
+		 * minimal sanity checking; some chips (like DS1340)
+		 * don't specify the extra bits as must-be-zero, but
+		 * there are still a few values that are clearly
+		 * out-of-range.
+		 */
+		tmp = regs[DS1307_REG_SECS];
+		switch (ds1307->type) {
+		case ds_1307:
+		case m41t00:
+			/* clock halted?  turn it on, so clock can tick. */
+			if (tmp & DS1307_BIT_CH) {
+				i2c_smbus_write_byte_data(client,
+							  DS1307_REG_SECS, 0);
+				dev_warn(&client->dev, "SET TIME!\n");
+				continue;
+			}
+			break;
+		case ds_1338:
+			/* clock halted?  turn it on, so clock can tick. */
+			if (tmp & DS1307_BIT_CH)
+				i2c_smbus_write_byte_data(client,
+							  DS1307_REG_SECS, 0);
+
+			/* oscillator fault?  clear flag, and warn */
+			if (regs[DS1307_REG_CONTROL] & DS1338_BIT_OSF) {
+				i2c_smbus_write_byte_data(client,
+							  DS1307_REG_CONTROL,
+							  regs[DS1307_REG_CONTROL]
+							  & ~DS1338_BIT_OSF);
+				dev_warn(&client->dev, "SET TIME!\n");
+				continue;
+			}
+			break;
+		case ds_1340:
+			/* clock halted?  turn it on, so clock can tick. */
+			if (tmp & DS1340_BIT_nEOSC)
+				i2c_smbus_write_byte_data(client,
+							  DS1307_REG_SECS, 0);
+
+			tmp = i2c_smbus_read_byte_data(client, DS1340_REG_FLAG);
+			if (tmp < 0) {
+				dev_dbg(&client->dev, "read error %d\n", tmp);
+				return -EIO;
+			}
+
+			/* oscillator fault?  clear flag, and warn */
+			if (tmp & DS1340_BIT_OSF) {
+				i2c_smbus_write_byte_data(client,
+							  DS1340_REG_FLAG, 0);
+				dev_warn(&client->dev, "SET TIME!\n");
+			}
+			return 0;
 
-		/* clock halted?  turn it on, so clock can tick. */
-		if (!(tmp & MCP794XX_BIT_ST)) {
-			i2c_smbus_write_byte_data(client, DS1307_REG_SECS,
-					MCP794XX_BIT_ST);
-			dev_warn(&client->dev, "SET TIME!\n");
-			goto read_rtc;
+		case mcp794xx:
+			/* make sure that the backup battery is enabled */
+			if (!(regs[DS1307_REG_WDAY] & MCP794XX_BIT_VBATEN)) {
+				i2c_smbus_write_byte_data(client,
+							  DS1307_REG_WDAY,
+							  regs[DS1307_REG_WDAY]
+							  | MCP794XX_BIT_VBATEN);
+			}
+
+			/* clock halted?  turn it on, so clock can tick. */
+			if (!(tmp & MCP794XX_BIT_ST)) {
+				i2c_smbus_write_byte_data(client,
+							  DS1307_REG_SECS,
+							  MCP794XX_BIT_ST);
+				dev_warn(&client->dev, "SET TIME!\n");
+				continue;
+			}
+
+			break;
+		default:
+			break;
 		}
 
-		break;
-	default:
-		break;
+		return 0;
 	}
 
-	return 0;
+	return -EIO;
 }
 
 static int ds1307_probe(struct i2c_client *client,
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
