Return-Path: <rtc-linux+bncBDKOBWPM5ABRBW6WUO5QKGQEG7YTU6Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com. [2607:f8b0:400e:c03::241])
        by gmr-mx.google.com with ESMTPS id c11si5951032pfc.2.2016.06.21.00.23.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 00:23:07 -0700 (PDT)
Received: by mail-pa0-x241.google.com with SMTP id us13so739156pab.1
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 00:23:07 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	cphealy@gmail.com
Subject: [rtc-linux] [PATCH v2 09/17] RTC: ds1307: Remove register "cache"
Date: Tue, 21 Jun 2016 00:22:42 -0700
Message-Id: <1466493770-11895-8-git-send-email-andrew.smirnov@gmail.com>
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

Remove shared area used by many subroutines to store values of RTC's
registers. There wasn't very much caching or sharing going on in the
code and that register cache, being a semi-global variable, only created
additional implicit dependencies between function and made code more
confusing (there were a number of functions that defined a convenience
variable pointing to ds1307->regs, but failed to use it in the code
consistently).

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 229 ++++++++++++++++++++++++-----------------------
 1 file changed, 116 insertions(+), 113 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index d262db5..66e7168 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -110,10 +110,10 @@ enum ds_type {
 #	define RX8025_BIT_VDET		0x40
 #	define RX8025_BIT_XST		0x20
 
+#define DS1307_REG_COUNT	11
 
 struct ds1307 {
 	u8			offset; /* register's offset */
-	u8			regs[11];
 	u16			nvram_offset;
 	struct bin_attribute	*nvram;
 	enum ds_type		type;
@@ -366,30 +366,31 @@ out:
 
 static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 {
+	u8              regs[DS1307_REG_COUNT];
 	struct ds1307	*ds1307 = dev_get_drvdata(dev);
 	int		tmp;
 
 	/* read the RTC date and time registers all at once */
 	tmp = ds1307->read_block_data(ds1307->client,
-		ds1307->offset, 7, ds1307->regs);
+		ds1307->offset, 7, regs);
 	if (tmp != 7) {
 		dev_err(dev, "%s error %d\n", "read", tmp);
 		return -EIO;
 	}
 
-	dev_dbg(dev, "%s: %7ph\n", "read", ds1307->regs);
+	dev_dbg(dev, "%s: %7ph\n", "read", regs);
 
-	t->tm_sec = bcd2bin(ds1307->regs[DS1307_REG_SECS] & 0x7f);
-	t->tm_min = bcd2bin(ds1307->regs[DS1307_REG_MIN] & 0x7f);
-	tmp = ds1307->regs[DS1307_REG_HOUR] & 0x3f;
+	t->tm_sec = bcd2bin(regs[DS1307_REG_SECS] & 0x7f);
+	t->tm_min = bcd2bin(regs[DS1307_REG_MIN] & 0x7f);
+	tmp = regs[DS1307_REG_HOUR] & 0x3f;
 	t->tm_hour = bcd2bin(tmp);
-	t->tm_wday = bcd2bin(ds1307->regs[DS1307_REG_WDAY] & 0x07) - 1;
-	t->tm_mday = bcd2bin(ds1307->regs[DS1307_REG_MDAY] & 0x3f);
-	tmp = ds1307->regs[DS1307_REG_MONTH] & 0x1f;
+	t->tm_wday = bcd2bin(regs[DS1307_REG_WDAY] & 0x07) - 1;
+	t->tm_mday = bcd2bin(regs[DS1307_REG_MDAY] & 0x3f);
+	tmp = regs[DS1307_REG_MONTH] & 0x1f;
 	t->tm_mon = bcd2bin(tmp) - 1;
 
 	/* assume 20YY not 19YY, and ignore DS1337_BIT_CENTURY */
-	t->tm_year = bcd2bin(ds1307->regs[DS1307_REG_YEAR]) + 100;
+	t->tm_year = bcd2bin(regs[DS1307_REG_YEAR]) + 100;
 
 	dev_dbg(dev, "%s secs=%d, mins=%d, "
 		"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
@@ -406,7 +407,7 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 	struct ds1307	*ds1307 = dev_get_drvdata(dev);
 	int		result;
 	int		tmp;
-	u8		*buf = ds1307->regs;
+	u8		regs[DS1307_REG_COUNT];
 
 	dev_dbg(dev, "%s secs=%d, mins=%d, "
 		"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
@@ -414,26 +415,26 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		t->tm_hour, t->tm_mday,
 		t->tm_mon, t->tm_year, t->tm_wday);
 
-	buf[DS1307_REG_SECS] = bin2bcd(t->tm_sec);
-	buf[DS1307_REG_MIN] = bin2bcd(t->tm_min);
-	buf[DS1307_REG_HOUR] = bin2bcd(t->tm_hour);
-	buf[DS1307_REG_WDAY] = bin2bcd(t->tm_wday + 1);
-	buf[DS1307_REG_MDAY] = bin2bcd(t->tm_mday);
-	buf[DS1307_REG_MONTH] = bin2bcd(t->tm_mon + 1);
+	regs[DS1307_REG_SECS]  = bin2bcd(t->tm_sec);
+	regs[DS1307_REG_MIN]   = bin2bcd(t->tm_min);
+	regs[DS1307_REG_HOUR]  = bin2bcd(t->tm_hour);
+	regs[DS1307_REG_WDAY]  = bin2bcd(t->tm_wday + 1);
+	regs[DS1307_REG_MDAY]  = bin2bcd(t->tm_mday);
+	regs[DS1307_REG_MONTH] = bin2bcd(t->tm_mon + 1);
 
 	/* assume 20YY not 19YY */
 	tmp = t->tm_year - 100;
-	buf[DS1307_REG_YEAR] = bin2bcd(tmp);
+	regs[DS1307_REG_YEAR] = bin2bcd(tmp);
 
 	switch (ds1307->type) {
 	case ds_1337:
 	case ds_1339:
 	case ds_3231:
 	case ds_1341:
-		buf[DS1307_REG_MONTH] |= DS1337_BIT_CENTURY;
+		regs[DS1307_REG_MONTH] |= DS1337_BIT_CENTURY;
 		break;
 	case ds_1340:
-		buf[DS1307_REG_HOUR] |= DS1340_BIT_CENTURY_EN
+		regs[DS1307_REG_HOUR] |= DS1340_BIT_CENTURY_EN
 				| DS1340_BIT_CENTURY;
 		break;
 	case mcp794xx:
@@ -442,17 +443,17 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		 * values and need to be set again before writing the
 		 * buffer out to the device.
 		 */
-		buf[DS1307_REG_SECS] |= MCP794XX_BIT_ST;
-		buf[DS1307_REG_WDAY] |= MCP794XX_BIT_VBATEN;
+		regs[DS1307_REG_SECS] |= MCP794XX_BIT_ST;
+		regs[DS1307_REG_WDAY] |= MCP794XX_BIT_VBATEN;
 		break;
 	default:
 		break;
 	}
 
-	dev_dbg(dev, "%s: %7ph\n", "write", buf);
+	dev_dbg(dev, "%s: %7ph\n", "write", regs);
 
 	result = ds1307->write_block_data(ds1307->client,
-		ds1307->offset, 7, buf);
+		ds1307->offset, 7, regs);
 	if (result < 0) {
 		dev_err(dev, "%s error %d\n", "write", result);
 		return result;
@@ -465,29 +466,30 @@ static int ds1337_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	struct i2c_client       *client = to_i2c_client(dev);
 	struct ds1307		*ds1307 = i2c_get_clientdata(client);
 	int			ret;
+	u8			regs[DS1307_REG_COUNT];
 
 	if (!test_bit(HAS_ALARM, &ds1307->flags))
 		return -EINVAL;
 
 	/* read all ALARM1, ALARM2, and status registers at once */
 	ret = ds1307->read_block_data(client,
-			DS1339_REG_ALARM1_SECS, 9, ds1307->regs);
+			DS1339_REG_ALARM1_SECS, 9, regs);
 	if (ret != 9) {
 		dev_err(dev, "%s error %d\n", "alarm read", ret);
 		return -EIO;
 	}
 
 	dev_dbg(dev, "%s: %4ph, %3ph, %2ph\n", "alarm read",
-		&ds1307->regs[0], &ds1307->regs[4], &ds1307->regs[7]);
+		&regs[0], &regs[4], &regs[7]);
 
 	/*
 	 * report alarm time (ALARM1); assume 24 hour and day-of-month modes,
 	 * and that all four fields are checked matches
 	 */
-	t->time.tm_sec = bcd2bin(ds1307->regs[0] & 0x7f);
-	t->time.tm_min = bcd2bin(ds1307->regs[1] & 0x7f);
-	t->time.tm_hour = bcd2bin(ds1307->regs[2] & 0x3f);
-	t->time.tm_mday = bcd2bin(ds1307->regs[3] & 0x3f);
+	t->time.tm_sec = bcd2bin(regs[0] & 0x7f);
+	t->time.tm_min = bcd2bin(regs[1] & 0x7f);
+	t->time.tm_hour = bcd2bin(regs[2] & 0x3f);
+	t->time.tm_mday = bcd2bin(regs[3] & 0x3f);
 	t->time.tm_mon = -1;
 	t->time.tm_year = -1;
 	t->time.tm_wday = -1;
@@ -495,8 +497,8 @@ static int ds1337_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	t->time.tm_isdst = -1;
 
 	/* ... and status */
-	t->enabled = !!(ds1307->regs[7] & DS1337_BIT_A1IE);
-	t->pending = !!(ds1307->regs[8] & DS1337_BIT_A1I);
+	t->enabled = !!(regs[7] & DS1337_BIT_A1IE);
+	t->pending = !!(regs[8] & DS1337_BIT_A1I);
 
 	dev_dbg(dev, "%s secs=%d, mins=%d, "
 		"hours=%d, mday=%d, enabled=%d, pending=%d\n",
@@ -511,7 +513,7 @@ static int ds1337_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client	*client = to_i2c_client(dev);
 	struct ds1307		*ds1307 = i2c_get_clientdata(client);
-	unsigned char		*buf = ds1307->regs;
+	u8			regs[DS1307_REG_COUNT];
 	u8			control, status;
 	int			ret;
 
@@ -526,34 +528,34 @@ static int ds1337_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	/* read current status of both alarms and the chip */
 	ret = ds1307->read_block_data(client,
-			DS1339_REG_ALARM1_SECS, 9, buf);
+			DS1339_REG_ALARM1_SECS, 9, regs);
 	if (ret != 9) {
 		dev_err(dev, "%s error %d\n", "alarm write", ret);
 		return -EIO;
 	}
-	control = ds1307->regs[7];
-	status = ds1307->regs[8];
+	control = regs[7];
+	status  = regs[8];
 
 	dev_dbg(dev, "%s: %4ph, %3ph, %02x %02x\n", "alarm set (old status)",
-		&ds1307->regs[0], &ds1307->regs[4], control, status);
+		&regs[0], &regs[4], control, status);
 
 	/* set ALARM1, using 24 hour and day-of-month modes */
-	buf[0] = bin2bcd(t->time.tm_sec);
-	buf[1] = bin2bcd(t->time.tm_min);
-	buf[2] = bin2bcd(t->time.tm_hour);
-	buf[3] = bin2bcd(t->time.tm_mday);
+	regs[0] = bin2bcd(t->time.tm_sec);
+	regs[1] = bin2bcd(t->time.tm_min);
+	regs[2] = bin2bcd(t->time.tm_hour);
+	regs[3] = bin2bcd(t->time.tm_mday);
 
 	/* set ALARM2 to non-garbage */
-	buf[4] = 0;
-	buf[5] = 0;
-	buf[6] = 0;
+	regs[4] = 0;
+	regs[5] = 0;
+	regs[6] = 0;
 
 	/* disable alarms */
-	buf[7] = control & ~(DS1337_BIT_A1IE | DS1337_BIT_A2IE);
-	buf[8] = status & ~(DS1337_BIT_A1I | DS1337_BIT_A2I);
+	regs[7] = control & ~(DS1337_BIT_A1IE | DS1337_BIT_A2IE);
+	regs[8] = status & ~(DS1337_BIT_A1I | DS1337_BIT_A2I);
 
 	ret = ds1307->write_block_data(client,
-			DS1339_REG_ALARM1_SECS, 9, buf);
+			DS1339_REG_ALARM1_SECS, 9, regs);
 	if (ret < 0) {
 		dev_err(dev, "can't set alarm time\n");
 		return ret;
@@ -562,8 +564,8 @@ static int ds1337_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	/* optionally enable ALARM1 */
 	if (t->enabled) {
 		dev_dbg(dev, "alarm IRQ armed\n");
-		buf[7] |= DS1337_BIT_A1IE;	/* only ALARM1 is used */
-		i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL, buf[7]);
+		regs[7] |= DS1337_BIT_A1IE;	/* only ALARM1 is used */
+		i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL, regs[7]);
 	}
 
 	return 0;
@@ -665,7 +667,7 @@ static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ds1307 *ds1307 = i2c_get_clientdata(client);
-	u8 *regs = ds1307->regs;
+	u8  regs[DS1307_REG_COUNT];
 	int ret;
 
 	if (!test_bit(HAS_ALARM, &ds1307->flags))
@@ -679,12 +681,12 @@ static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	t->enabled = !!(regs[0] & MCP794XX_BIT_ALM0_EN);
 
 	/* Report alarm 0 time assuming 24-hour and day-of-month modes. */
-	t->time.tm_sec = bcd2bin(ds1307->regs[3] & 0x7f);
-	t->time.tm_min = bcd2bin(ds1307->regs[4] & 0x7f);
-	t->time.tm_hour = bcd2bin(ds1307->regs[5] & 0x3f);
-	t->time.tm_wday = bcd2bin(ds1307->regs[6] & 0x7) - 1;
-	t->time.tm_mday = bcd2bin(ds1307->regs[7] & 0x3f);
-	t->time.tm_mon = bcd2bin(ds1307->regs[8] & 0x1f) - 1;
+	t->time.tm_sec = bcd2bin(regs[3] & 0x7f);
+	t->time.tm_min = bcd2bin(regs[4] & 0x7f);
+	t->time.tm_hour = bcd2bin(regs[5] & 0x3f);
+	t->time.tm_wday = bcd2bin(regs[6] & 0x7) - 1;
+	t->time.tm_mday = bcd2bin(regs[7] & 0x3f);
+	t->time.tm_mon = bcd2bin(regs[8] & 0x1f) - 1;
 	t->time.tm_year = -1;
 	t->time.tm_yday = -1;
 	t->time.tm_isdst = -1;
@@ -693,9 +695,9 @@ static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 		"enabled=%d polarity=%d irq=%d match=%d\n", __func__,
 		t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
 		t->time.tm_wday, t->time.tm_mday, t->time.tm_mon, t->enabled,
-		!!(ds1307->regs[6] & MCP794XX_BIT_ALMX_POL),
-		!!(ds1307->regs[6] & MCP794XX_BIT_ALMX_IF),
-		(ds1307->regs[6] & MCP794XX_MSK_ALMX_MATCH) >> 4);
+		!!(regs[6] & MCP794XX_BIT_ALMX_POL),
+		!!(regs[6] & MCP794XX_BIT_ALMX_IF),
+		(regs[6] & MCP794XX_MSK_ALMX_MATCH) >> 4);
 
 	return 0;
 }
@@ -704,7 +706,7 @@ static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ds1307 *ds1307 = i2c_get_clientdata(client);
-	unsigned char *regs = ds1307->regs;
+	u8  regs[DS1307_REG_COUNT];
 	int ret;
 
 	if (!test_bit(HAS_ALARM, &ds1307->flags))
@@ -1274,11 +1276,9 @@ static bool ds1307_want_irq(const struct ds1307 *ds1307,
 static int ds1307_chip_configure(struct ds1307 *ds1307)
 {
 	int tmp;
-	unsigned char *buf;
+	u8  regs[DS1307_REG_COUNT];
 	struct i2c_client *client = ds1307->client;
 
-	buf = ds1307->regs;
-
 	switch (ds1307->type) {
 	case ds_1337:
 	case ds_1339:
@@ -1293,32 +1293,32 @@ static int ds1307_chip_configure(struct ds1307 *ds1307)
 
 		/* get registers that the "rtc" read below won't read... */
 		tmp = ds1307->read_block_data(client,
-					      DS1337_REG_CONTROL, 2, buf);
+					      DS1337_REG_CONTROL, 2, regs);
 		if (tmp != 2) {
 			dev_dbg(&ds1307->client->dev, "read error %d\n", tmp);
 			return -EIO;
 		}
 
 		/* oscillator off?  turn it on, so clock can tick. */
-		if (ds1307->regs[0] & DS1337_BIT_nEOSC)
-			ds1307->regs[0] &= ~DS1337_BIT_nEOSC;
+		if (regs[0] & DS1337_BIT_nEOSC)
+			regs[0] &= ~DS1337_BIT_nEOSC;
 
 		if (ds1307->type == ds_1341) {
 			/* Make sure we are not generating square wave
 			 * output */
-			ds1307->regs[1] &= ~DS1341_BIT_ECLK;
+			regs[1] &= ~DS1341_BIT_ECLK;
 
 			if (of_property_read_bool(client->dev.of_node,
 						  "dallas,disable-oscillator-stop-flag"))
-				ds1307->regs[1] |= DS1341_BIT_DOSF;
+				regs[1] |= DS1341_BIT_DOSF;
 			else
-				ds1307->regs[1] &= ~DS1341_BIT_DOSF;
+				regs[1] &= ~DS1341_BIT_DOSF;
 
 			if (of_property_read_bool(client->dev.of_node,
 						  "dallas,enable-glitch-filter"))
-				ds1307->regs[0] |= DS1341_BIT_EGFIL;
+				regs[0] |= DS1341_BIT_EGFIL;
 			else
-				ds1307->regs[0] &= ~DS1341_BIT_EGFIL;
+				regs[0] &= ~DS1341_BIT_EGFIL;
 
 			/*
 			 * Write status register. Control register
@@ -1326,7 +1326,7 @@ static int ds1307_chip_configure(struct ds1307 *ds1307)
 			 */
 			i2c_smbus_write_byte_data(client,
 						  DS1337_REG_STATUS,
-						  ds1307->regs[1]);
+						  regs[1]);
 		}
 
 		/*
@@ -1334,19 +1334,19 @@ static int ds1307_chip_configure(struct ds1307 *ds1307)
 		 * For some variants, be sure alarms can trigger when we're
 		 * running on Vbackup (BBSQI/BBSQW)
 		 */
-		ds1307->regs[0] |= DS1337_BIT_INTCN
+		regs[0] |= DS1337_BIT_INTCN
 			| bbsqi_bitpos[ds1307->type];
-		ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
+		regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
 
 		i2c_smbus_write_byte_data(client,
 					  DS1337_REG_CONTROL,
-					  ds1307->regs[0]);
+					  regs[0]);
 
 		/* oscillator fault?  clear flag, and warn */
-		if (ds1307->regs[1] & DS1337_BIT_OSF) {
+		if (regs[1] & DS1337_BIT_OSF) {
 			i2c_smbus_write_byte_data(client,
 						  DS1337_REG_STATUS,
-						  ds1307->regs[1] & ~DS1337_BIT_OSF);
+						  regs[1] & ~DS1337_BIT_OSF);
 			dev_warn(&ds1307->client->dev, "SET TIME!\n");
 		}
 		break;
@@ -1354,60 +1354,60 @@ static int ds1307_chip_configure(struct ds1307 *ds1307)
 	case rx_8025:
 		tmp = i2c_smbus_read_i2c_block_data(client,
 						    RX8025_REG_CTRL1 << 4 | 0x08,
-						    2, buf);
+						    2, regs);
 		if (tmp != 2) {
 			dev_dbg(&client->dev, "read error %d\n", tmp);
 			return -EIO;
 		}
 
 		/* oscillator off?  turn it on, so clock can tick. */
-		if (!(ds1307->regs[1] & RX8025_BIT_XST)) {
-			ds1307->regs[1] |= RX8025_BIT_XST;
+		if (!(regs[1] & RX8025_BIT_XST)) {
+			regs[1] |= RX8025_BIT_XST;
 			i2c_smbus_write_byte_data(client,
 						  RX8025_REG_CTRL2 << 4 | 0x08,
-						  ds1307->regs[1]);
+						  regs[1]);
 			dev_warn(&client->dev,
 				 "oscillator stop detected - SET TIME!\n");
 		}
 
-		if (ds1307->regs[1] & RX8025_BIT_PON) {
-			ds1307->regs[1] &= ~RX8025_BIT_PON;
+		if (regs[1] & RX8025_BIT_PON) {
+			regs[1] &= ~RX8025_BIT_PON;
 			i2c_smbus_write_byte_data(client,
 						  RX8025_REG_CTRL2 << 4 | 0x08,
-						  ds1307->regs[1]);
+						  regs[1]);
 			dev_warn(&client->dev, "power-on detected\n");
 		}
 
-		if (ds1307->regs[1] & RX8025_BIT_VDET) {
-			ds1307->regs[1] &= ~RX8025_BIT_VDET;
+		if (regs[1] & RX8025_BIT_VDET) {
+			regs[1] &= ~RX8025_BIT_VDET;
 			i2c_smbus_write_byte_data(client,
 						  RX8025_REG_CTRL2 << 4 | 0x08,
-						  ds1307->regs[1]);
+						  regs[1]);
 			dev_warn(&client->dev, "voltage drop detected\n");
 		}
 
 		/* make sure we are running in 24hour mode */
-		if (!(ds1307->regs[0] & RX8025_BIT_2412)) {
+		if (!(regs[0] & RX8025_BIT_2412)) {
 			u8 hour;
 
 			/* switch to 24 hour mode */
 			i2c_smbus_write_byte_data(client,
 						  RX8025_REG_CTRL1 << 4 | 0x08,
-						  ds1307->regs[0] | RX8025_BIT_2412);
+						  regs[0] | RX8025_BIT_2412);
 
 			tmp = i2c_smbus_read_i2c_block_data(client,
 							    RX8025_REG_CTRL1 << 4 | 0x08,
-							    2, buf);
+							    2, regs);
 			if (tmp != 2) {
 				dev_dbg(&client->dev, "read error %d\n", tmp);
 				return -EIO;
 			}
 
 			/* correct hour */
-			hour = bcd2bin(ds1307->regs[DS1307_REG_HOUR]);
+			hour = bcd2bin(regs[DS1307_REG_HOUR]);
 			if (hour == 12)
 				hour = 0;
-			if (ds1307->regs[DS1307_REG_HOUR] & DS1307_BIT_PM)
+			if (regs[DS1307_REG_HOUR] & DS1307_BIT_PM)
 				hour += 12;
 
 			i2c_smbus_write_byte_data(client,
@@ -1425,14 +1425,12 @@ static int ds1307_chip_configure(struct ds1307 *ds1307)
 static int ds1307_chip_sanity_check(struct ds1307 *ds1307)
 {
 	int tmp;
-	unsigned char *buf;
+	u8  regs[DS1307_REG_COUNT];
 	struct i2c_client *client = ds1307->client;
 
-	buf = ds1307->regs;
-
 read_rtc:
 	/* read RTC registers */
-	tmp = ds1307->read_block_data(ds1307->client, ds1307->offset, 8, buf);
+	tmp = ds1307->read_block_data(ds1307->client, ds1307->offset, 8, regs);
 	if (tmp != 8) {
 		dev_dbg(&client->dev, "read error %d\n", tmp);
 		return -EIO;
@@ -1443,7 +1441,7 @@ read_rtc:
 	 * specify the extra bits as must-be-zero, but there are
 	 * still a few values that are clearly out-of-range.
 	 */
-	tmp = ds1307->regs[DS1307_REG_SECS];
+	tmp = regs[DS1307_REG_SECS];
 	switch (ds1307->type) {
 	case ds_1307:
 	case m41t00:
@@ -1460,9 +1458,9 @@ read_rtc:
 			i2c_smbus_write_byte_data(client, DS1307_REG_SECS, 0);
 
 		/* oscillator fault?  clear flag, and warn */
-		if (ds1307->regs[DS1307_REG_CONTROL] & DS1338_BIT_OSF) {
+		if (regs[DS1307_REG_CONTROL] & DS1338_BIT_OSF) {
 			i2c_smbus_write_byte_data(client, DS1307_REG_CONTROL,
-					ds1307->regs[DS1307_REG_CONTROL]
+					regs[DS1307_REG_CONTROL]
 					& ~DS1338_BIT_OSF);
 			dev_warn(&client->dev, "SET TIME!\n");
 			goto read_rtc;
@@ -1487,9 +1485,9 @@ read_rtc:
 		break;
 	case mcp794xx:
 		/* make sure that the backup battery is enabled */
-		if (!(ds1307->regs[DS1307_REG_WDAY] & MCP794XX_BIT_VBATEN)) {
+		if (!(regs[DS1307_REG_WDAY] & MCP794XX_BIT_VBATEN)) {
 			i2c_smbus_write_byte_data(client, DS1307_REG_WDAY,
-					ds1307->regs[DS1307_REG_WDAY]
+					regs[DS1307_REG_WDAY]
 					| MCP794XX_BIT_VBATEN);
 		}
 
@@ -1514,10 +1512,10 @@ static int ds1307_probe(struct i2c_client *client,
 {
 	struct ds1307		*ds1307;
 	int			err = -ENODEV;
-	int			tmp;
+	int			reg;
+	u8			hour;
 	struct chip_desc	*chip = &chips[id->driver_data];
 	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
-	unsigned char		*buf;
 	struct ds1307_platform_data *pdata = dev_get_platdata(&client->dev);
 	irq_handler_t	irq_handler = ds1307_irq;
 
@@ -1550,7 +1548,6 @@ static int ds1307_probe(struct i2c_client *client,
 		    chip->trickle_charger_setup);
 	}
 
-	buf = ds1307->regs;
 	if (i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK)) {
 		ds1307->read_block_data = ds1307_native_smbus_read_block_data;
 		ds1307->write_block_data = ds1307_native_smbus_write_block_data;
@@ -1579,7 +1576,14 @@ static int ds1307_probe(struct i2c_client *client,
 	if (err < 0)
 		return err;
 
-	tmp = ds1307->regs[DS1307_REG_HOUR];
+	reg = i2c_smbus_read_byte_data(client,
+				       ds1307->offset + DS1307_REG_HOUR);
+	if (reg < 0) {
+		dev_err(&client->dev,
+			"failed to read HOUR register\n");
+		return reg;
+	}
+
 	switch (ds1307->type) {
 	case ds_1340:
 	case m41t00:
@@ -1591,21 +1595,21 @@ static int ds1307_probe(struct i2c_client *client,
 	case rx_8025:
 		break;
 	default:
-		if (!(tmp & DS1307_BIT_12HR))
+		if (!(reg & DS1307_BIT_12HR))
 			break;
 
 		/*
 		 * Be sure we're in 24 hour mode.  Multi-master systems
 		 * take note...
 		 */
-		tmp = bcd2bin(tmp & 0x1f);
-		if (tmp == 12)
-			tmp = 0;
-		if (ds1307->regs[DS1307_REG_HOUR] & DS1307_BIT_PM)
-			tmp += 12;
+		hour = bcd2bin(reg & 0x1f);
+		if (hour == 12)
+			hour = 0;
+		if (reg & DS1307_BIT_PM)
+			hour += 12;
 		i2c_smbus_write_byte_data(client,
 				ds1307->offset + DS1307_REG_HOUR,
-				bin2bcd(tmp));
+				bin2bcd(hour));
 	}
 
 	if (ds1307_want_irq(ds1307, chip)) {
@@ -1620,7 +1624,6 @@ static int ds1307_probe(struct i2c_client *client,
 
 	if (ds1307_can_wakeup_device(ds1307) &&
 	    ds1307->client->irq <= 0) {
-		/* Disable request for an IRQ */
 		dev_info(&client->dev,
 			 "'wakeup-source' is set, request for an IRQ is disabled!\n");
 		/* We cannot support UIE mode if we do not have an IRQ line */
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
