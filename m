Return-Path: <rtc-linux+bncBDKOBWPM5ABRB3W5QO5QKGQEQBGOG2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com. [2607:f8b0:400e:c03::242])
        by gmr-mx.google.com with ESMTPS id 62si3601890pfx.1.2016.06.14.23.00.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 23:00:14 -0700 (PDT)
Received: by mail-pa0-x242.google.com with SMTP id hf6so794121pac.2
        for <rtc-linux@googlegroups.com>; Tue, 14 Jun 2016 23:00:14 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [rtc-linux] [PATCH 13/13] RTC: ds1307: Move last bits of sanity
 checking out of chip_configure
Date: Tue, 14 Jun 2016 22:59:39 -0700
Message-Id: <1465970379-14703-14-git-send-email-andrew.smirnov@gmail.com>
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

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 106 ++++++++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 47 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index d9693bd..4452661 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1344,66 +1344,23 @@ static int ds1307_chip_configure(const struct ds1307 *ds1307)
 					  DS1337_REG_CONTROL,
 					  regs[0]);
 
-		/* oscillator fault?  clear flag, and warn */
-		if (regs[1] & DS1337_BIT_OSF) {
-			i2c_smbus_write_byte_data(client,
-						  DS1337_REG_STATUS,
-						  regs[1] & ~DS1337_BIT_OSF);
-			dev_warn(&ds1307->client->dev, "SET TIME!\n");
-		}
 		break;
 	}
 	case rx_8025:
-		tmp = i2c_smbus_read_i2c_block_data(client,
-						    RX8025_REG_CTRL1,
-						    2, regs);
-		if (tmp != 2) {
+		tmp = i2c_smbus_read_byte_data(client, RX8025_REG_CTRL1);
+		if (tmp < 0) {
 			dev_dbg(&client->dev, "read error %d\n", tmp);
 			return -EIO;
 		}
 
-		/* oscillator off?  turn it on, so clock can tick. */
-		if (!(regs[1] & RX8025_BIT_XST)) {
-			regs[1] |= RX8025_BIT_XST;
-			i2c_smbus_write_byte_data(client,
-						  RX8025_REG_CTRL2,
-						  regs[1]);
-			dev_warn(&client->dev,
-				 "oscillator stop detected - SET TIME!\n");
-		}
-
-		if (regs[1] & RX8025_BIT_PON) {
-			regs[1] &= ~RX8025_BIT_PON;
-			i2c_smbus_write_byte_data(client,
-						  RX8025_REG_CTRL2,
-						  regs[1]);
-			dev_warn(&client->dev, "power-on detected\n");
-		}
-
-		if (regs[1] & RX8025_BIT_VDET) {
-			regs[1] &= ~RX8025_BIT_VDET;
-			i2c_smbus_write_byte_data(client,
-						  RX8025_REG_CTRL2,
-						  regs[1]);
-			dev_warn(&client->dev, "voltage drop detected\n");
-		}
-
 		/* make sure we are running in 24hour mode */
-		if (!(regs[0] & RX8025_BIT_2412)) {
+		if (!(tmp & RX8025_BIT_2412)) {
 			u8 hour;
 
 			/* switch to 24 hour mode */
 			i2c_smbus_write_byte_data(client,
 						  RX8025_REG_CTRL1,
-						  regs[0] | RX8025_BIT_2412);
-
-			tmp = i2c_smbus_read_i2c_block_data(client,
-							    RX8025_REG_CTRL1,
-							    2, regs);
-			if (tmp != 2) {
-				dev_dbg(&client->dev, "read error %d\n", tmp);
-				return -EIO;
-			}
+						  tmp | RX8025_BIT_2412);
 
 			/* correct hour */
 			hour = bcd2bin(regs[DS1307_REG_HOUR]);
@@ -1486,6 +1443,27 @@ static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
 				continue;
 			}
 			break;
+
+		case ds_1337:
+		case ds_1339:
+		case ds_3231:
+		case ds_1341:
+			tmp = i2c_smbus_read_byte_data(client,
+						       DS1337_REG_STATUS);
+			if (tmp < 0) {
+				dev_dbg(&client->dev, "read error %d\n", tmp);
+				return -EIO;
+			}
+
+			/* oscillator fault?  clear flag, and warn */
+			if (tmp & DS1337_BIT_OSF) {
+				i2c_smbus_write_byte_data(client,
+							  DS1337_REG_STATUS,
+							  regs[1] & ~DS1337_BIT_OSF);
+				ds1307_report_oscillator_fault(ds1307);
+			}
+			return 0;
+
 		case ds_1340:
 			/* clock halted?  turn it on, so clock can tick. */
 			if (tmp & DS1340_BIT_nEOSC) {
@@ -1530,6 +1508,40 @@ static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
 			}
 
 			break;
+
+		case rx_8025:
+			tmp = i2c_smbus_read_byte_data(client,
+						       RX8025_REG_CTRL2);
+			if (tmp < 0) {
+				dev_dbg(&client->dev, "read error %d\n", tmp);
+				return -EIO;
+			}
+
+			/* oscillator off?  turn it on, so clock can tick. */
+			if (!(tmp & RX8025_BIT_XST)) {
+				tmp |= RX8025_BIT_XST;
+				i2c_smbus_write_byte_data(client,
+							  RX8025_REG_CTRL2,
+							  tmp);
+				ds1307_report_clock_halt(ds1307);
+			}
+
+			if (tmp & RX8025_BIT_PON) {
+				tmp &= ~RX8025_BIT_PON;
+				i2c_smbus_write_byte_data(client,
+							  RX8025_REG_CTRL2,
+							  tmp);
+				dev_warn(&client->dev, "power-on detected\n");
+			}
+
+			if (tmp & RX8025_BIT_VDET) {
+				tmp &= ~RX8025_BIT_VDET;
+				i2c_smbus_write_byte_data(client,
+							  RX8025_REG_CTRL2,
+							  tmp);
+				dev_warn(&client->dev, "voltage drop detected\n");
+			}
+			break;
 		default:
 			break;
 		}
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
