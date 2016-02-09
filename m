Return-Path: <rtc-linux+bncBCC6ZWOPXENRBHEM462QKGQEDUABYWI@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id w128si525334wmd.0.2016.02.09.02.57.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 02:57:31 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [rtc-linux] [PATCH v2 1/3] RTC/PCF85063: simplify code to read the
 current time
Date: Tue,  9 Feb 2016 11:57:25 +0100
Message-Id: <1455015447-13886-2-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1455015447-13886-1-git-send-email-jbe@pengutronix.de>
References: <1455015447-13886-1-git-send-email-jbe@pengutronix.de>
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

By using i2c_smbus_read_i2c_block_data() the code is now much simpler.

While at it: when reading the RTC's seconds register, all time/date registers
are frozen until the RTC's year register is read. So it is important to read
all time/date registers in one turn to not lose a second event. Make it more
clear why the read must happen in this way.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/rtc/rtc-pcf85063.c | 47 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 63334cb..7f9caee 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -45,39 +45,34 @@ struct pcf85063 {
  */
 static int pcf85063_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
+	int rc;
 	struct pcf85063 *pcf85063 = i2c_get_clientdata(client);
-	unsigned char buf[13] = { PCF85063_REG_CTRL1 };
-	struct i2c_msg msgs[] = {
-		{/* setup read ptr */
-			.addr = client->addr,
-			.len = 1,
-			.buf = buf
-		},
-		{/* read status + date */
-			.addr = client->addr,
-			.flags = I2C_M_RD,
-			.len = 13,
-			.buf = buf
-		},
-	};
-
-	/* read registers */
-	if ((i2c_transfer(client->adapter, msgs, 2)) != 2) {
-		dev_err(&client->dev, "%s: read error\n", __func__);
+	u8 regs[7];
+
+	/*
+	 * while reading, the time/date registers are blocked and not updated
+	 * anymore until the access is finished. To not lose a second
+	 * event, the access must be finished within one second. So, read all
+	 * time/date registers in one turn.
+	 */
+	rc = i2c_smbus_read_i2c_block_data(client, PCF85063_REG_SC,
+					   sizeof(regs), regs);
+	if (rc != sizeof(regs)) {
+		dev_err(&client->dev, "date/time register read error\n");
 		return -EIO;
 	}
 
-	tm->tm_sec = bcd2bin(buf[PCF85063_REG_SC] & 0x7F);
-	tm->tm_min = bcd2bin(buf[PCF85063_REG_MN] & 0x7F);
-	tm->tm_hour = bcd2bin(buf[PCF85063_REG_HR] & 0x3F); /* rtc hr 0-23 */
-	tm->tm_mday = bcd2bin(buf[PCF85063_REG_DM] & 0x3F);
-	tm->tm_wday = buf[PCF85063_REG_DW] & 0x07;
-	tm->tm_mon = bcd2bin(buf[PCF85063_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
-	tm->tm_year = bcd2bin(buf[PCF85063_REG_YR]);
+	tm->tm_sec = bcd2bin(regs[0] & 0x7F);
+	tm->tm_min = bcd2bin(regs[1] & 0x7F);
+	tm->tm_hour = bcd2bin(regs[2] & 0x3F); /* rtc hr 0-23 */
+	tm->tm_mday = bcd2bin(regs[3] & 0x3F);
+	tm->tm_wday = regs[4] & 0x07;
+	tm->tm_mon = bcd2bin(regs[5] & 0x1F) - 1; /* rtc mn 1-12 */
+	tm->tm_year = bcd2bin(regs[6]);
 	if (tm->tm_year < 70)
 		tm->tm_year += 100;	/* assume we are in 1970...2069 */
 	/* detect the polarity heuristically. see note above. */
-	pcf85063->c_polarity = (buf[PCF85063_REG_MO] & PCF85063_MO_C) ?
+	pcf85063->c_polarity = (regs[5] & PCF85063_MO_C) ?
 		(tm->tm_year >= 100) : (tm->tm_year < 100);
 
 	return rtc_valid_tm(tm);
-- 
2.7.0.rc3

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
