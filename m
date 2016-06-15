Return-Path: <rtc-linux+bncBDKOBWPM5ABRB3O5QO5QKGQEXO4LKNY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id 62si3602201pfx.1.2016.06.14.23.00.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 23:00:13 -0700 (PDT)
Received: by mail-pf0-x241.google.com with SMTP id 62so986725pfd.3
        for <rtc-linux@googlegroups.com>; Tue, 14 Jun 2016 23:00:13 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [rtc-linux] [PATCH 11/13] RTC: ds1307: Redefine RX8025_REG_* to
 minimize extra code
Date: Tue, 14 Jun 2016 22:59:37 -0700
Message-Id: <1465970379-14703-12-git-send-email-andrew.smirnov@gmail.com>
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

The only place in the driver where RX8025_REG_* are used they are always
shifted and ORed the same way, so instead of repeating that idiom make
it a part of symbolic constant.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 8ccfe5b..76e66a3 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -103,9 +103,11 @@ enum ds_type {
 
 #define DS13XX_TRICKLE_CHARGER_MAGIC	0xa0
 
-#define RX8025_REG_CTRL1	0x0e
+#define RX8025_REG_CTRL1_	0x0e
+#define RX8025_REG_CTRL1	((RX8025_REG_CTRL1_ << 4) | 0x08)
 #	define RX8025_BIT_2412		0x20
-#define RX8025_REG_CTRL2	0x0f
+#define RX8025_REG_CTRL2_	0x0f
+#define RX8025_REG_CTRL2	((RX8025_REG_CTRL2_ << 4) | 0x08)
 #	define RX8025_BIT_PON		0x10
 #	define RX8025_BIT_VDET		0x40
 #	define RX8025_BIT_XST		0x20
@@ -1353,7 +1355,7 @@ static int ds1307_chip_configure(const struct ds1307 *ds1307)
 	}
 	case rx_8025:
 		tmp = i2c_smbus_read_i2c_block_data(client,
-						    RX8025_REG_CTRL1 << 4 | 0x08,
+						    RX8025_REG_CTRL1,
 						    2, regs);
 		if (tmp != 2) {
 			dev_dbg(&client->dev, "read error %d\n", tmp);
@@ -1364,7 +1366,7 @@ static int ds1307_chip_configure(const struct ds1307 *ds1307)
 		if (!(regs[1] & RX8025_BIT_XST)) {
 			regs[1] |= RX8025_BIT_XST;
 			i2c_smbus_write_byte_data(client,
-						  RX8025_REG_CTRL2 << 4 | 0x08,
+						  RX8025_REG_CTRL2,
 						  regs[1]);
 			dev_warn(&client->dev,
 				 "oscillator stop detected - SET TIME!\n");
@@ -1373,7 +1375,7 @@ static int ds1307_chip_configure(const struct ds1307 *ds1307)
 		if (regs[1] & RX8025_BIT_PON) {
 			regs[1] &= ~RX8025_BIT_PON;
 			i2c_smbus_write_byte_data(client,
-						  RX8025_REG_CTRL2 << 4 | 0x08,
+						  RX8025_REG_CTRL2,
 						  regs[1]);
 			dev_warn(&client->dev, "power-on detected\n");
 		}
@@ -1381,7 +1383,7 @@ static int ds1307_chip_configure(const struct ds1307 *ds1307)
 		if (regs[1] & RX8025_BIT_VDET) {
 			regs[1] &= ~RX8025_BIT_VDET;
 			i2c_smbus_write_byte_data(client,
-						  RX8025_REG_CTRL2 << 4 | 0x08,
+						  RX8025_REG_CTRL2,
 						  regs[1]);
 			dev_warn(&client->dev, "voltage drop detected\n");
 		}
@@ -1392,11 +1394,11 @@ static int ds1307_chip_configure(const struct ds1307 *ds1307)
 
 			/* switch to 24 hour mode */
 			i2c_smbus_write_byte_data(client,
-						  RX8025_REG_CTRL1 << 4 | 0x08,
+						  RX8025_REG_CTRL1,
 						  regs[0] | RX8025_BIT_2412);
 
 			tmp = i2c_smbus_read_i2c_block_data(client,
-							    RX8025_REG_CTRL1 << 4 | 0x08,
+							    RX8025_REG_CTRL1,
 							    2, regs);
 			if (tmp != 2) {
 				dev_dbg(&client->dev, "read error %d\n", tmp);
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
