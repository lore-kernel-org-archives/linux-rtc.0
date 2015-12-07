Return-Path: <rtc-linux+bncBCC6ZWOPXENRBZ44S2ZQKGQE466VE3Y@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id y203si623813wmc.2.2015.12.07.05.49.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Dec 2015 05:49:27 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [rtc-linux] [PATCH 3/3] RTC/PCF85063: fix time/date setting
Date: Mon,  7 Dec 2015 14:49:34 +0100
Message-Id: <1449496174-7813-4-git-send-email-jbe@pengutronix.de>
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

When setting a new time/date the RTC's clock must be stopped first, in
order to write the time/date registers in an atomic manner.
So, this change stops the clock first and then writes the time/date
registers and the clock control register (to re-enable the clock) in one
turn.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/rtc/rtc-pcf85063.c | 96 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index abed934..0150e93 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -19,6 +19,7 @@
 #define DRV_VERSION "0.0.1"
 
 #define PCF85063_REG_CTRL1		0x00 /* status */
+#define PCF85063_REG_CTRL1_STOP		BIT(5)
 #define PCF85063_REG_CTRL2		0x01
 
 #define PCF85063_REG_SC			0x04 /* datetime */
@@ -72,6 +73,47 @@ static int pcf85063_read_time(struct i2c_client *client, u8 *buf, u16 size)
 	return 0;
 }
 
+static int pcf85063_stop_clock(struct i2c_client *client, u8 *ctrl1)
+{
+	int rc;
+	u8 clk_ctrl[2] = { PCF85063_REG_CTRL1, };
+	struct i2c_msg msgs[] = {
+		{
+			.addr = client->addr,
+			.len = 1,
+			.buf = &clk_ctrl[0],
+		}, {
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = 1,
+			.buf = &clk_ctrl[1],
+		}, {
+			.addr = client->addr,
+			.len = sizeof(clk_ctrl),
+			.buf = &clk_ctrl[0],
+		},
+	};
+
+	rc = i2c_transfer(client->adapter, &msgs[0], 2);
+	if (rc != 2) {
+		dev_err(&client->dev, "Failing to stop the clock\n");
+		return -EIO;
+	}
+
+	/* stop the clock */
+	clk_ctrl[1] |= PCF85063_REG_CTRL1_STOP;
+
+	rc = i2c_transfer(client->adapter, &msgs[2], 1);
+	if (rc != 1) {
+		dev_err(&client->dev, "Failing to stop the clock\n");
+		return -EIO;
+	}
+
+	*ctrl1 = clk_ctrl[1];
+
+	return 0;
+}
+
 /*
  * In the routines that deal directly with the pcf85063 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
@@ -110,41 +152,49 @@ static int pcf85063_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 
 static int pcf85063_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
-	int i = 0, err = 0;
-	unsigned char buf[11];
+	int rc;
+	u8 regs[9];
 
-	/* Control & status */
-	buf[PCF85063_REG_CTRL1] = 0;
-	buf[PCF85063_REG_CTRL2] = 5;
+	/*
+	 * to accurately set the time, reset the divider chain and keep it in
+	 * reset state until all time/date registers are written
+	 */
+	rc = pcf85063_stop_clock(client, &regs[8]);
+	if (rc != 0)
+		return rc;
 
+	/* write start register */
+	regs[0] = PCF85063_REG_SC;
 	/* hours, minutes and seconds */
-	buf[PCF85063_REG_SC] = bin2bcd(tm->tm_sec) & 0x7F;
+	regs[1] = bin2bcd(tm->tm_sec) & 0x7F; /* clear OS flag */
 
-	buf[PCF85063_REG_MN] = bin2bcd(tm->tm_min);
-	buf[PCF85063_REG_HR] = bin2bcd(tm->tm_hour);
+	regs[2] = bin2bcd(tm->tm_min);
+	regs[3] = bin2bcd(tm->tm_hour);
 
 	/* Day of month, 1 - 31 */
-	buf[PCF85063_REG_DM] = bin2bcd(tm->tm_mday);
+	regs[4] = bin2bcd(tm->tm_mday);
 
 	/* Day, 0 - 6 */
-	buf[PCF85063_REG_DW] = tm->tm_wday & 0x07;
+	regs[5] = tm->tm_wday & 0x07;
 
 	/* month, 1 - 12 */
-	buf[PCF85063_REG_MO] = bin2bcd(tm->tm_mon + 1);
+	regs[6] = bin2bcd(tm->tm_mon + 1);
 
 	/* year and century */
-	buf[PCF85063_REG_YR] = bin2bcd(tm->tm_year % 100);
-
-	/* write register's data */
-	for (i = 0; i < sizeof(buf); i++) {
-		unsigned char data[2] = { i, buf[i] };
-
-		err = i2c_master_send(client, data, sizeof(data));
-		if (err != sizeof(data)) {
-			dev_err(&client->dev, "%s: err=%d addr=%02x, data=%02x\n",
-					__func__, err, data[0], data[1]);
-			return -EIO;
-		}
+	regs[7] = bin2bcd(tm->tm_year % 100);
+
+	/*
+	 * after all time/date registers are written, let the address auto
+	 * increment wrap around and write register CTRL1 to re-enable the
+	 * clock divider chain again
+	 */
+	regs[8] &= ~PCF85063_REG_CTRL1_STOP;
+
+	/* write all registers at once */
+	rc = i2c_master_send(client, regs, sizeof(regs));
+	if (rc != sizeof(regs)) {
+		dev_err(&client->dev, "date/time register write error\n");
+		return -EIO;
 	}
 
 	return 0;
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
