Return-Path: <rtc-linux+bncBCC6ZWOPXENRBZ44S2ZQKGQE466VE3Y@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id g21si710806wmd.3.2015.12.07.05.49.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Dec 2015 05:49:27 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [rtc-linux] [PATCH 2/3] RTC/PCF85063: fix time/date reading (part II)
Date: Mon,  7 Dec 2015 14:49:33 +0100
Message-Id: <1449496174-7813-3-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1449496174-7813-1-git-send-email-jbe@pengutronix.de>
References: <1449496174-7813-1-git-send-email-jbe@pengutronix.de>
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

Use the function to read the whole time/date register in one turn and now
check if the RTC signals an invalid time/date (due to a battery power loss
for example). In this case ignore the time/date until it is really set
again.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/rtc/rtc-pcf85063.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 75f2866..abed934 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -22,6 +22,7 @@
 #define PCF85063_REG_CTRL2		0x01
 
 #define PCF85063_REG_SC			0x04 /* datetime */
+#define PCF85063_REG_SC_OS		0x80
 #define PCF85063_REG_MN			0x05
 #define PCF85063_REG_HR			0x06
 #define PCF85063_REG_DM			0x07
@@ -77,39 +78,31 @@ static int pcf85063_read_time(struct i2c_client *client, u8 *buf, u16 size)
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
+	u8 regs[7];
 
-	/* read registers */
-	if ((i2c_transfer(client->adapter, msgs, 2)) != 2) {
-		dev_err(&client->dev, "%s: read error\n", __func__);
-		return -EIO;
+	rc = pcf85063_read_time(client, regs, sizeof(regs));
+	if (rc < 0)
+		return rc;
+
+	/* if the clock has lost its power it makes no sense to use its time */
+	if (regs[0] & PCF85063_REG_SC_OS) {
+		dev_warn(&client->dev, "Power loss detected, invalid time\n");
+		return -EINVAL;
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
2.6.2

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
