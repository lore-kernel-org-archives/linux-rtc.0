Return-Path: <rtc-linux+bncBCZ3LK4RZYHRBIN26LFAKGQE2M6BTFI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id f140si6877678wme.4.2017.07.05.01.02.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 01:02:40 -0700 (PDT)
From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
To: alexandre.belloni@free-electrons.com
Cc: a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Subject: [rtc-linux] [PATCH v2 1/2] RTC: s35390a: handle invalid RTC time
Date: Wed,  5 Jul 2017 10:02:29 +0200
Message-Id: <0ee84ea918faab368ed36b73dfc7fdff07c4b4b8.1499240924.git.fabien.lahoudere@collabora.co.uk>
In-Reply-To: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
References: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
In-Reply-To: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
References: <cover.1499240924.git.fabien.lahoudere@collabora.co.uk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

If RTC time have been altered by low voltage, we notify users
that RTC time is invalid by returning -EINVAL.
The RTC time needs to be set correctly to clear the invalid flag.
If the RTC is not set before restarting, the information will be lost.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 drivers/rtc/rtc-s35390a.c | 72 +++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 5dab466..5ebb132 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -99,33 +99,12 @@ static int s35390a_get_reg(struct s35390a *s35390a, int reg, char *buf, int len)
 	return 0;
 }
 
-/*
- * Returns <0 on error, 0 if rtc is setup fine and 1 if the chip was reset.
- * To keep the information if an irq is pending, pass the value read from
- * STATUS1 to the caller.
- */
-static int s35390a_reset(struct s35390a *s35390a, char *status1)
+static int s35390a_init(struct s35390a *s35390a)
 {
 	char buf;
 	int ret;
 	unsigned initcount = 0;
 
-	ret = s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, status1, 1);
-	if (ret < 0)
-		return ret;
-
-	if (*status1 & S35390A_FLAG_POC)
-		/*
-		 * Do not communicate for 0.5 seconds since the power-on
-		 * detection circuit is in operation.
-		 */
-		msleep(500);
-	else if (!(*status1 & S35390A_FLAG_BLD))
-		/*
-		 * If both POC and BLD are unset everything is fine.
-		 */
-		return 0;
-
 	/*
 	 * At least one of POC and BLD are set, so reinitialise chip. Keeping
 	 * this information in the hardware to know later that the time isn't
@@ -135,7 +114,6 @@ static int s35390a_reset(struct s35390a *s35390a, char *status1)
 	 * The 24H bit is kept over reset, so set it already here.
 	 */
 initialize:
-	*status1 = S35390A_FLAG_24H;
 	buf = S35390A_FLAG_RESET | S35390A_FLAG_24H;
 	ret = s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &buf, 1);
 
@@ -158,6 +136,34 @@ static int s35390a_reset(struct s35390a *s35390a, char *status1)
 	return 1;
 }
 
+/*
+ * Returns <0 on error, 0 if rtc is setup fine and 1 if the chip was reset.
+ * To keep the information if an irq is pending, pass the value read from
+ * STATUS1 to the caller.
+ */
+static int s35390a_read_status(struct s35390a *s35390a, char *status1)
+{
+	int ret;
+
+	ret = s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, status1, 1);
+	if (ret < 0)
+		return ret;
+
+	if (*status1 & S35390A_FLAG_POC) {
+		/*
+		 * Do not communicate for 0.5 seconds since the power-on
+		 * detection circuit is in operation.
+		 */
+		msleep(500);
+		return 1;
+	} else if (*status1 & S35390A_FLAG_BLD)
+		return 1;
+	/*
+	 * If both POC and BLD are unset everything is fine.
+	 */
+	return 0;
+}
+
 static int s35390a_disable_test_mode(struct s35390a *s35390a)
 {
 	char buf[1];
@@ -201,13 +207,16 @@ static int s35390a_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
 	struct s35390a	*s35390a = i2c_get_clientdata(client);
 	int i, err;
-	char buf[7];
+	char buf[7], status;
 
 	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d mday=%d, "
 		"mon=%d, year=%d, wday=%d\n", __func__, tm->tm_sec,
 		tm->tm_min, tm->tm_hour, tm->tm_mday, tm->tm_mon, tm->tm_year,
 		tm->tm_wday);
 
+	if (s35390a_read_status(s35390a, &status) == 1)
+		s35390a_init(s35390a);
+
 	buf[S35390A_BYTE_YEAR] = bin2bcd(tm->tm_year - 100);
 	buf[S35390A_BYTE_MONTH] = bin2bcd(tm->tm_mon + 1);
 	buf[S35390A_BYTE_DAY] = bin2bcd(tm->tm_mday);
@@ -228,9 +237,12 @@ static int s35390a_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 static int s35390a_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
 	struct s35390a *s35390a = i2c_get_clientdata(client);
-	char buf[7];
+	char buf[7], status;
 	int i, err;
 
+	if (s35390a_read_status(s35390a, &status) == 1)
+		return -EINVAL;
+
 	err = s35390a_get_reg(s35390a, S35390A_CMD_TIME1, buf, sizeof(buf));
 	if (err < 0)
 		return err;
@@ -398,7 +410,7 @@ static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static int s35390a_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	int err, err_reset;
+	int err, err_read;
 	unsigned int i;
 	struct s35390a *s35390a;
 	struct rtc_time tm;
@@ -431,9 +443,9 @@ static int s35390a_probe(struct i2c_client *client,
 		}
 	}
 
-	err_reset = s35390a_reset(s35390a, &status1);
-	if (err_reset < 0) {
-		err = err_reset;
+	err_read = s35390a_read_status(s35390a, &status1);
+	if (err_read < 0) {
+		err = err_read;
 		dev_err(&client->dev, "error resetting chip\n");
 		goto exit_dummy;
 	}
@@ -459,7 +471,7 @@ static int s35390a_probe(struct i2c_client *client,
 		}
 	}
 
-	if (err_reset > 0 || s35390a_get_datetime(client, &tm) < 0)
+	if (err_read > 0 || s35390a_get_datetime(client, &tm) < 0)
 		dev_warn(&client->dev, "clock needs to be set\n");
 
 	device_set_wakeup_capable(&client->dev, 1);
-- 
1.8.3.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
