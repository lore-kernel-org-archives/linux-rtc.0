Return-Path: <rtc-linux+bncBCC6ZWOPXENRBHEM462QKGQEDUABYWI@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id w128si525337wmd.0.2016.02.09.02.57.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 02:57:31 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [rtc-linux] [PATCH v2 3/3] RTC/PCF85063: fix time/date setting
Date: Tue,  9 Feb 2016 11:57:27 +0100
Message-Id: <1455015447-13886-4-git-send-email-jbe@pengutronix.de>
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

When setting a new time/date the RTC's clock must be stopped first, in
order to write the time/date registers in an atomic manner.
So, this change stops the clock first and then writes the time/date
registers and the clock control register (to re-enable the clock) in one
turn.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/rtc/rtc-pcf85063.c | 78 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index e0343e6..c5db231 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -19,6 +19,7 @@
 #define DRV_VERSION "0.0.1"
 
 #define PCF85063_REG_CTRL1		0x00 /* status */
+#define PCF85063_REG_CTRL1_STOP		BIT(5)
 #define PCF85063_REG_CTRL2		0x01
 
 #define PCF85063_REG_SC			0x04 /* datetime */
@@ -40,6 +41,30 @@ struct pcf85063 {
 	int voltage_low; /* indicates if a low_voltage was detected */
 };
 
+static int pcf85063_stop_clock(struct i2c_client *client, u8 *ctrl1)
+{
+	s32 ret;
+
+	ret = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failing to stop the clock\n");
+		return -EIO;
+	}
+
+	/* stop the clock */
+	ret |= PCF85063_REG_CTRL1_STOP;
+
+	ret = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, ret);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failing to stop the clock\n");
+		return -EIO;
+	}
+
+	*ctrl1 = ret;
+
+	return 0;
+}
+
 /*
  * In the routines that deal directly with the pcf85063 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
@@ -87,41 +112,48 @@ static int pcf85063_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 
 static int pcf85063_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
-	int i = 0, err = 0;
-	unsigned char buf[11];
+	int rc;
+	u8 regs[8];
 
-	/* Control & status */
-	buf[PCF85063_REG_CTRL1] = 0;
-	buf[PCF85063_REG_CTRL2] = 5;
+	/*
+	 * to accurately set the time, reset the divider chain and keep it in
+	 * reset state until all time/date registers are written
+	 */
+	rc = pcf85063_stop_clock(client, &regs[7]);
+	if (rc != 0)
+		return rc;
 
 	/* hours, minutes and seconds */
-	buf[PCF85063_REG_SC] = bin2bcd(tm->tm_sec) & 0x7F;
+	regs[0] = bin2bcd(tm->tm_sec) & 0x7F; /* clear OS flag */
 
-	buf[PCF85063_REG_MN] = bin2bcd(tm->tm_min);
-	buf[PCF85063_REG_HR] = bin2bcd(tm->tm_hour);
+	regs[1] = bin2bcd(tm->tm_min);
+	regs[2] = bin2bcd(tm->tm_hour);
 
 	/* Day of month, 1 - 31 */
-	buf[PCF85063_REG_DM] = bin2bcd(tm->tm_mday);
+	regs[3] = bin2bcd(tm->tm_mday);
 
 	/* Day, 0 - 6 */
-	buf[PCF85063_REG_DW] = tm->tm_wday & 0x07;
+	regs[4] = tm->tm_wday & 0x07;
 
 	/* month, 1 - 12 */
-	buf[PCF85063_REG_MO] = bin2bcd(tm->tm_mon + 1);
+	regs[5] = bin2bcd(tm->tm_mon + 1);
 
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
+	regs[6] = bin2bcd(tm->tm_year % 100);
+
+	/*
+	 * after all time/date registers are written, let the 'address auto
+	 * increment' feature wrap around and write register CTRL1 to re-enable
+	 * the clock divider chain again
+	 */
+	regs[7] &= ~PCF85063_REG_CTRL1_STOP;
+
+	/* write all registers at once */
+	rc = i2c_smbus_write_i2c_block_data(client, PCF85063_REG_SC,
+					    sizeof(regs), regs);
+	if (rc < 0) {
+		dev_err(&client->dev, "date/time register write error\n");
+		return rc;
 	}
 
 	return 0;
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
