Return-Path: <rtc-linux+bncBDU7VC56WAFBBCVY463AKGQEES4YGQY@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id z75si13381wmz.2.2016.03.04.11.03.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 11:03:38 -0800 (PST)
Date: Fri, 4 Mar 2016 19:54:35 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 1/6] rtc-rv3029: Remove all 'C2' suffixes from identifiers
Message-ID: <20160304195435.0732ba43@wiggum>
In-Reply-To: <20160304195337.51439645@wiggum>
References: <20160301213322.661fe771@wiggum>
	<20160301213655.GG23985@piout.net>
	<20160301225401.3f0aeabb@wiggum>
	<20160301230745.GJ23985@piout.net>
	<20160302072627.14e53e94@wiggum>
	<20160302120045.GO23985@piout.net>
	<20160304195337.51439645@wiggum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DdbUrbqU9zJvjkdrJgOmVAG"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/DdbUrbqU9zJvjkdrJgOmVAG
Content-Type: text/plain; charset=UTF-8

The C2 suffix does not appear anymore in the latest device and
data sheet versions.

Signed-off-by: Michael Buesch <m@bues.ch>
---
 drivers/rtc/rtc-rv3029c2.c | 295 +++++++++++++++++++++++----------------------
 1 file changed, 148 insertions(+), 147 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index e9ac5a4..3083ace 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -1,5 +1,5 @@
 /*
- * Micro Crystal RV-3029C2 rtc class driver
+ * Micro Crystal RV-3029 rtc class driver
  *
  * Author: Gregory Hermant <gregory.hermant@calao-systems.com>
  *
@@ -21,77 +21,77 @@
 
 /* Register map */
 /* control section */
-#define RV3029C2_ONOFF_CTRL		0x00
-#define RV3029C2_IRQ_CTRL		0x01
-#define RV3029C2_IRQ_CTRL_AIE		(1 << 0)
-#define RV3029C2_IRQ_FLAGS		0x02
-#define RV3029C2_IRQ_FLAGS_AF		(1 << 0)
-#define RV3029C2_STATUS			0x03
-#define RV3029C2_STATUS_VLOW1		(1 << 2)
-#define RV3029C2_STATUS_VLOW2		(1 << 3)
-#define RV3029C2_STATUS_SR		(1 << 4)
-#define RV3029C2_STATUS_PON		(1 << 5)
-#define RV3029C2_STATUS_EEBUSY		(1 << 7)
-#define RV3029C2_RST_CTRL		0x04
-#define RV3029C2_CONTROL_SECTION_LEN	0x05
+#define RV3029_ONOFF_CTRL		0x00
+#define RV3029_IRQ_CTRL			0x01
+#define RV3029_IRQ_CTRL_AIE		(1 << 0)
+#define RV3029_IRQ_FLAGS		0x02
+#define RV3029_IRQ_FLAGS_AF		(1 << 0)
+#define RV3029_STATUS			0x03
+#define RV3029_STATUS_VLOW1		(1 << 2)
+#define RV3029_STATUS_VLOW2		(1 << 3)
+#define RV3029_STATUS_SR		(1 << 4)
+#define RV3029_STATUS_PON		(1 << 5)
+#define RV3029_STATUS_EEBUSY		(1 << 7)
+#define RV3029_RST_CTRL			0x04
+#define RV3029_CONTROL_SECTION_LEN	0x05
 
 /* watch section */
-#define RV3029C2_W_SEC			0x08
-#define RV3029C2_W_MINUTES		0x09
-#define RV3029C2_W_HOURS		0x0A
-#define RV3029C2_REG_HR_12_24		(1<<6)  /* 24h/12h mode */
-#define RV3029C2_REG_HR_PM		(1<<5)  /* PM/AM bit in 12h mode */
-#define RV3029C2_W_DATE			0x0B
-#define RV3029C2_W_DAYS			0x0C
-#define RV3029C2_W_MONTHS		0x0D
-#define RV3029C2_W_YEARS		0x0E
-#define RV3029C2_WATCH_SECTION_LEN	0x07
+#define RV3029_W_SEC			0x08
+#define RV3029_W_MINUTES		0x09
+#define RV3029_W_HOURS			0x0A
+#define RV3029_REG_HR_12_24		(1<<6)  /* 24h/12h mode */
+#define RV3029_REG_HR_PM		(1<<5)  /* PM/AM bit in 12h mode */
+#define RV3029_W_DATE			0x0B
+#define RV3029_W_DAYS			0x0C
+#define RV3029_W_MONTHS			0x0D
+#define RV3029_W_YEARS			0x0E
+#define RV3029_WATCH_SECTION_LEN	0x07
 
 /* alarm section */
-#define RV3029C2_A_SC			0x10
-#define RV3029C2_A_MN			0x11
-#define RV3029C2_A_HR			0x12
-#define RV3029C2_A_DT			0x13
-#define RV3029C2_A_DW			0x14
-#define RV3029C2_A_MO			0x15
-#define RV3029C2_A_YR			0x16
-#define RV3029C2_ALARM_SECTION_LEN	0x07
+#define RV3029_A_SC			0x10
+#define RV3029_A_MN			0x11
+#define RV3029_A_HR			0x12
+#define RV3029_A_DT			0x13
+#define RV3029_A_DW			0x14
+#define RV3029_A_MO			0x15
+#define RV3029_A_YR			0x16
+#define RV3029_ALARM_SECTION_LEN	0x07
 
 /* timer section */
-#define RV3029C2_TIMER_LOW		0x18
-#define RV3029C2_TIMER_HIGH		0x19
+#define RV3029_TIMER_LOW		0x18
+#define RV3029_TIMER_HIGH		0x19
 
 /* temperature section */
-#define RV3029C2_TEMP_PAGE		0x20
+#define RV3029_TEMP_PAGE		0x20
 
 /* eeprom data section */
-#define RV3029C2_E2P_EEDATA1		0x28
-#define RV3029C2_E2P_EEDATA2		0x29
+#define RV3029_E2P_EEDATA1		0x28
+#define RV3029_E2P_EEDATA2		0x29
 
 /* eeprom control section */
-#define RV3029C2_CONTROL_E2P_EECTRL	0x30
-#define RV3029C2_TRICKLE_1K		(1<<0)  /*  1K resistance */
-#define RV3029C2_TRICKLE_5K		(1<<1)  /*  5K resistance */
-#define RV3029C2_TRICKLE_20K		(1<<2)  /* 20K resistance */
-#define RV3029C2_TRICKLE_80K		(1<<3)  /* 80K resistance */
-#define RV3029C2_CONTROL_E2P_XTALOFFSET	0x31
-#define RV3029C2_CONTROL_E2P_QCOEF	0x32
-#define RV3029C2_CONTROL_E2P_TURNOVER	0x33
+#define RV3029_CONTROL_E2P_EECTRL	0x30
+#define RV3029_TRICKLE_1K		(1<<0)  /*  1K resistance */
+#define RV3029_TRICKLE_5K		(1<<1)  /*  5K resistance */
+#define RV3029_TRICKLE_20K		(1<<2)  /* 20K resistance */
+#define RV3029_TRICKLE_80K		(1<<3)  /* 80K resistance */
+#define RV3029_CONTROL_E2P_XTALOFFSET	0x31
+#define RV3029_CONTROL_E2P_QCOEF	0x32
+#define RV3029_CONTROL_E2P_TURNOVER	0x33
 
 /* user ram section */
-#define RV3029C2_USR1_RAM_PAGE		0x38
-#define RV3029C2_USR1_SECTION_LEN	0x04
-#define RV3029C2_USR2_RAM_PAGE		0x3C
-#define RV3029C2_USR2_SECTION_LEN	0x04
+#define RV3029_USR1_RAM_PAGE		0x38
+#define RV3029_USR1_SECTION_LEN		0x04
+#define RV3029_USR2_RAM_PAGE		0x3C
+#define RV3029_USR2_SECTION_LEN		0x04
 
 static int
-rv3029c2_i2c_read_regs(struct i2c_client *client, u8 reg, u8 *buf,
-	unsigned len)
+rv3029_i2c_read_regs(struct i2c_client *client, u8 reg, u8 *buf,
+		     unsigned len)
 {
 	int ret;
 
-	if ((reg > RV3029C2_USR1_RAM_PAGE + 7) ||
-		(reg + len > RV3029C2_USR1_RAM_PAGE + 8))
+	if ((reg > RV3029_USR1_RAM_PAGE + 7) ||
+		(reg + len > RV3029_USR1_RAM_PAGE + 8))
 		return -EINVAL;
 
 	ret = i2c_smbus_read_i2c_block_data(client, reg, len, buf);
@@ -103,20 +103,20 @@ rv3029c2_i2c_read_regs(struct i2c_client *client, u8 reg, u8 *buf,
 }
 
 static int
-rv3029c2_i2c_write_regs(struct i2c_client *client, u8 reg, u8 const buf[],
-			unsigned len)
+rv3029_i2c_write_regs(struct i2c_client *client, u8 reg, u8 const buf[],
+		      unsigned len)
 {
-	if ((reg > RV3029C2_USR1_RAM_PAGE + 7) ||
-		(reg + len > RV3029C2_USR1_RAM_PAGE + 8))
+	if ((reg > RV3029_USR1_RAM_PAGE + 7) ||
+		(reg + len > RV3029_USR1_RAM_PAGE + 8))
 		return -EINVAL;
 
 	return i2c_smbus_write_i2c_block_data(client, reg, len, buf);
 }
 
 static int
-rv3029c2_i2c_get_sr(struct i2c_client *client, u8 *buf)
+rv3029_i2c_get_sr(struct i2c_client *client, u8 *buf)
 {
-	int ret = rv3029c2_i2c_read_regs(client, RV3029C2_STATUS, buf, 1);
+	int ret = rv3029_i2c_read_regs(client, RV3029_STATUS, buf, 1);
 
 	if (ret < 0)
 		return -EIO;
@@ -125,13 +125,13 @@ rv3029c2_i2c_get_sr(struct i2c_client *client, u8 *buf)
 }
 
 static int
-rv3029c2_i2c_set_sr(struct i2c_client *client, u8 val)
+rv3029_i2c_set_sr(struct i2c_client *client, u8 val)
 {
 	u8 buf[1];
 	int sr;
 
 	buf[0] = val;
-	sr = rv3029c2_i2c_write_regs(client, RV3029C2_STATUS, buf, 1);
+	sr = rv3029_i2c_write_regs(client, RV3029_STATUS, buf, 1);
 	dev_dbg(&client->dev, "status = 0x%.2x (%d)\n", buf[0], buf[0]);
 	if (sr < 0)
 		return -EIO;
@@ -139,69 +139,70 @@ rv3029c2_i2c_set_sr(struct i2c_client *client, u8 val)
 }
 
 static int
-rv3029c2_i2c_read_time(struct i2c_client *client, struct rtc_time *tm)
+rv3029_i2c_read_time(struct i2c_client *client, struct rtc_time *tm)
 {
 	u8 buf[1];
 	int ret;
-	u8 regs[RV3029C2_WATCH_SECTION_LEN] = { 0, };
+	u8 regs[RV3029_WATCH_SECTION_LEN] = { 0, };
 
-	ret = rv3029c2_i2c_get_sr(client, buf);
+	ret = rv3029_i2c_get_sr(client, buf);
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
 		return -EIO;
 	}
 
-	ret = rv3029c2_i2c_read_regs(client, RV3029C2_W_SEC , regs,
-					RV3029C2_WATCH_SECTION_LEN);
+	ret = rv3029_i2c_read_regs(client, RV3029_W_SEC, regs,
+				   RV3029_WATCH_SECTION_LEN);
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading RTC section failed\n",
 			__func__);
 		return ret;
 	}
 
-	tm->tm_sec = bcd2bin(regs[RV3029C2_W_SEC-RV3029C2_W_SEC]);
-	tm->tm_min = bcd2bin(regs[RV3029C2_W_MINUTES-RV3029C2_W_SEC]);
+	tm->tm_sec = bcd2bin(regs[RV3029_W_SEC-RV3029_W_SEC]);
+	tm->tm_min = bcd2bin(regs[RV3029_W_MINUTES-RV3029_W_SEC]);
 
 	/* HR field has a more complex interpretation */
 	{
-		const u8 _hr = regs[RV3029C2_W_HOURS-RV3029C2_W_SEC];
-		if (_hr & RV3029C2_REG_HR_12_24) {
+		const u8 _hr = regs[RV3029_W_HOURS-RV3029_W_SEC];
+
+		if (_hr & RV3029_REG_HR_12_24) {
 			/* 12h format */
 			tm->tm_hour = bcd2bin(_hr & 0x1f);
-			if (_hr & RV3029C2_REG_HR_PM)	/* PM flag set */
+			if (_hr & RV3029_REG_HR_PM)	/* PM flag set */
 				tm->tm_hour += 12;
 		} else /* 24h format */
 			tm->tm_hour = bcd2bin(_hr & 0x3f);
 	}
 
-	tm->tm_mday = bcd2bin(regs[RV3029C2_W_DATE-RV3029C2_W_SEC]);
-	tm->tm_mon = bcd2bin(regs[RV3029C2_W_MONTHS-RV3029C2_W_SEC]) - 1;
-	tm->tm_year = bcd2bin(regs[RV3029C2_W_YEARS-RV3029C2_W_SEC]) + 100;
-	tm->tm_wday = bcd2bin(regs[RV3029C2_W_DAYS-RV3029C2_W_SEC]) - 1;
+	tm->tm_mday = bcd2bin(regs[RV3029_W_DATE-RV3029_W_SEC]);
+	tm->tm_mon = bcd2bin(regs[RV3029_W_MONTHS-RV3029_W_SEC]) - 1;
+	tm->tm_year = bcd2bin(regs[RV3029_W_YEARS-RV3029_W_SEC]) + 100;
+	tm->tm_wday = bcd2bin(regs[RV3029_W_DAYS-RV3029_W_SEC]) - 1;
 
 	return 0;
 }
 
-static int rv3029c2_rtc_read_time(struct device *dev, struct rtc_time *tm)
+static int rv3029_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	return rv3029c2_i2c_read_time(to_i2c_client(dev), tm);
+	return rv3029_i2c_read_time(to_i2c_client(dev), tm);
 }
 
 static int
-rv3029c2_i2c_read_alarm(struct i2c_client *client, struct rtc_wkalrm *alarm)
+rv3029_i2c_read_alarm(struct i2c_client *client, struct rtc_wkalrm *alarm)
 {
 	struct rtc_time *const tm = &alarm->time;
 	int ret;
 	u8 regs[8];
 
-	ret = rv3029c2_i2c_get_sr(client, regs);
+	ret = rv3029_i2c_get_sr(client, regs);
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
 		return -EIO;
 	}
 
-	ret = rv3029c2_i2c_read_regs(client, RV3029C2_A_SC, regs,
-					RV3029C2_ALARM_SECTION_LEN);
+	ret = rv3029_i2c_read_regs(client, RV3029_A_SC, regs,
+				   RV3029_ALARM_SECTION_LEN);
 
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading alarm section failed\n",
@@ -209,41 +210,41 @@ rv3029c2_i2c_read_alarm(struct i2c_client *client, struct rtc_wkalrm *alarm)
 		return ret;
 	}
 
-	tm->tm_sec = bcd2bin(regs[RV3029C2_A_SC-RV3029C2_A_SC] & 0x7f);
-	tm->tm_min = bcd2bin(regs[RV3029C2_A_MN-RV3029C2_A_SC] & 0x7f);
-	tm->tm_hour = bcd2bin(regs[RV3029C2_A_HR-RV3029C2_A_SC] & 0x3f);
-	tm->tm_mday = bcd2bin(regs[RV3029C2_A_DT-RV3029C2_A_SC] & 0x3f);
-	tm->tm_mon = bcd2bin(regs[RV3029C2_A_MO-RV3029C2_A_SC] & 0x1f) - 1;
-	tm->tm_year = bcd2bin(regs[RV3029C2_A_YR-RV3029C2_A_SC] & 0x7f) + 100;
-	tm->tm_wday = bcd2bin(regs[RV3029C2_A_DW-RV3029C2_A_SC] & 0x07) - 1;
+	tm->tm_sec = bcd2bin(regs[RV3029_A_SC-RV3029_A_SC] & 0x7f);
+	tm->tm_min = bcd2bin(regs[RV3029_A_MN-RV3029_A_SC] & 0x7f);
+	tm->tm_hour = bcd2bin(regs[RV3029_A_HR-RV3029_A_SC] & 0x3f);
+	tm->tm_mday = bcd2bin(regs[RV3029_A_DT-RV3029_A_SC] & 0x3f);
+	tm->tm_mon = bcd2bin(regs[RV3029_A_MO-RV3029_A_SC] & 0x1f) - 1;
+	tm->tm_year = bcd2bin(regs[RV3029_A_YR-RV3029_A_SC] & 0x7f) + 100;
+	tm->tm_wday = bcd2bin(regs[RV3029_A_DW-RV3029_A_SC] & 0x07) - 1;
 
 	return 0;
 }
 
 static int
-rv3029c2_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+rv3029_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
-	return rv3029c2_i2c_read_alarm(to_i2c_client(dev), alarm);
+	return rv3029_i2c_read_alarm(to_i2c_client(dev), alarm);
 }
 
-static int rv3029c2_rtc_i2c_alarm_set_irq(struct i2c_client *client,
+static int rv3029_rtc_i2c_alarm_set_irq(struct i2c_client *client,
 					int enable)
 {
 	int ret;
 	u8 buf[1];
 
 	/* enable AIE irq */
-	ret = rv3029c2_i2c_read_regs(client, RV3029C2_IRQ_CTRL,	buf, 1);
+	ret = rv3029_i2c_read_regs(client, RV3029_IRQ_CTRL, buf, 1);
 	if (ret < 0) {
 		dev_err(&client->dev, "can't read INT reg\n");
 		return ret;
 	}
 	if (enable)
-		buf[0] |= RV3029C2_IRQ_CTRL_AIE;
+		buf[0] |= RV3029_IRQ_CTRL_AIE;
 	else
-		buf[0] &= ~RV3029C2_IRQ_CTRL_AIE;
+		buf[0] &= ~RV3029_IRQ_CTRL_AIE;
 
-	ret = rv3029c2_i2c_write_regs(client, RV3029C2_IRQ_CTRL, buf, 1);
+	ret = rv3029_i2c_write_regs(client, RV3029_IRQ_CTRL, buf, 1);
 	if (ret < 0) {
 		dev_err(&client->dev, "can't set INT reg\n");
 		return ret;
@@ -252,8 +253,8 @@ static int rv3029c2_rtc_i2c_alarm_set_irq(struct i2c_client *client,
 	return 0;
 }
 
-static int rv3029c2_rtc_i2c_set_alarm(struct i2c_client *client,
-					struct rtc_wkalrm *alarm)
+static int rv3029_rtc_i2c_set_alarm(struct i2c_client *client,
+				    struct rtc_wkalrm *alarm)
 {
 	struct rtc_time *const tm = &alarm->time;
 	int ret;
@@ -267,21 +268,21 @@ static int rv3029c2_rtc_i2c_set_alarm(struct i2c_client *client,
 	if (tm->tm_year < 100)
 		return -EINVAL;
 
-	ret = rv3029c2_i2c_get_sr(client, regs);
+	ret = rv3029_i2c_get_sr(client, regs);
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
 		return -EIO;
 	}
-	regs[RV3029C2_A_SC-RV3029C2_A_SC] = bin2bcd(tm->tm_sec & 0x7f);
-	regs[RV3029C2_A_MN-RV3029C2_A_SC] = bin2bcd(tm->tm_min & 0x7f);
-	regs[RV3029C2_A_HR-RV3029C2_A_SC] = bin2bcd(tm->tm_hour & 0x3f);
-	regs[RV3029C2_A_DT-RV3029C2_A_SC] = bin2bcd(tm->tm_mday & 0x3f);
-	regs[RV3029C2_A_MO-RV3029C2_A_SC] = bin2bcd((tm->tm_mon & 0x1f) - 1);
-	regs[RV3029C2_A_DW-RV3029C2_A_SC] = bin2bcd((tm->tm_wday & 7) - 1);
-	regs[RV3029C2_A_YR-RV3029C2_A_SC] = bin2bcd((tm->tm_year & 0x7f) - 100);
-
-	ret = rv3029c2_i2c_write_regs(client, RV3029C2_A_SC, regs,
-					RV3029C2_ALARM_SECTION_LEN);
+	regs[RV3029_A_SC-RV3029_A_SC] = bin2bcd(tm->tm_sec & 0x7f);
+	regs[RV3029_A_MN-RV3029_A_SC] = bin2bcd(tm->tm_min & 0x7f);
+	regs[RV3029_A_HR-RV3029_A_SC] = bin2bcd(tm->tm_hour & 0x3f);
+	regs[RV3029_A_DT-RV3029_A_SC] = bin2bcd(tm->tm_mday & 0x3f);
+	regs[RV3029_A_MO-RV3029_A_SC] = bin2bcd((tm->tm_mon & 0x1f) - 1);
+	regs[RV3029_A_DW-RV3029_A_SC] = bin2bcd((tm->tm_wday & 7) - 1);
+	regs[RV3029_A_YR-RV3029_A_SC] = bin2bcd((tm->tm_year & 0x7f) - 100);
+
+	ret = rv3029_i2c_write_regs(client, RV3029_A_SC, regs,
+				    RV3029_ALARM_SECTION_LEN);
 	if (ret < 0)
 		return ret;
 
@@ -289,28 +290,28 @@ static int rv3029c2_rtc_i2c_set_alarm(struct i2c_client *client,
 		u8 buf[1];
 
 		/* clear AF flag */
-		ret = rv3029c2_i2c_read_regs(client, RV3029C2_IRQ_FLAGS,
-						buf, 1);
+		ret = rv3029_i2c_read_regs(client, RV3029_IRQ_FLAGS,
+					   buf, 1);
 		if (ret < 0) {
 			dev_err(&client->dev, "can't read alarm flag\n");
 			return ret;
 		}
-		buf[0] &= ~RV3029C2_IRQ_FLAGS_AF;
-		ret = rv3029c2_i2c_write_regs(client, RV3029C2_IRQ_FLAGS,
-						buf, 1);
+		buf[0] &= ~RV3029_IRQ_FLAGS_AF;
+		ret = rv3029_i2c_write_regs(client, RV3029_IRQ_FLAGS,
+					    buf, 1);
 		if (ret < 0) {
 			dev_err(&client->dev, "can't set alarm flag\n");
 			return ret;
 		}
 		/* enable AIE irq */
-		ret = rv3029c2_rtc_i2c_alarm_set_irq(client, 1);
+		ret = rv3029_rtc_i2c_alarm_set_irq(client, 1);
 		if (ret)
 			return ret;
 
 		dev_dbg(&client->dev, "alarm IRQ armed\n");
 	} else {
 		/* disable AIE irq */
-		ret = rv3029c2_rtc_i2c_alarm_set_irq(client, 0);
+		ret = rv3029_rtc_i2c_alarm_set_irq(client, 0);
 		if (ret)
 			return ret;
 
@@ -320,13 +321,13 @@ static int rv3029c2_rtc_i2c_set_alarm(struct i2c_client *client,
 	return 0;
 }
 
-static int rv3029c2_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+static int rv3029_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
-	return rv3029c2_rtc_i2c_set_alarm(to_i2c_client(dev), alarm);
+	return rv3029_rtc_i2c_set_alarm(to_i2c_client(dev), alarm);
 }
 
 static int
-rv3029c2_i2c_set_time(struct i2c_client *client, struct rtc_time const *tm)
+rv3029_i2c_set_time(struct i2c_client *client, struct rtc_time const *tm)
 {
 	u8 regs[8];
 	int ret;
@@ -339,26 +340,26 @@ rv3029c2_i2c_set_time(struct i2c_client *client, struct rtc_time const *tm)
 	if (tm->tm_year < 100)
 		return -EINVAL;
 
-	regs[RV3029C2_W_SEC-RV3029C2_W_SEC] = bin2bcd(tm->tm_sec);
-	regs[RV3029C2_W_MINUTES-RV3029C2_W_SEC] = bin2bcd(tm->tm_min);
-	regs[RV3029C2_W_HOURS-RV3029C2_W_SEC] = bin2bcd(tm->tm_hour);
-	regs[RV3029C2_W_DATE-RV3029C2_W_SEC] = bin2bcd(tm->tm_mday);
-	regs[RV3029C2_W_MONTHS-RV3029C2_W_SEC] = bin2bcd(tm->tm_mon+1);
-	regs[RV3029C2_W_DAYS-RV3029C2_W_SEC] = bin2bcd((tm->tm_wday & 7)+1);
-	regs[RV3029C2_W_YEARS-RV3029C2_W_SEC] = bin2bcd(tm->tm_year - 100);
+	regs[RV3029_W_SEC-RV3029_W_SEC] = bin2bcd(tm->tm_sec);
+	regs[RV3029_W_MINUTES-RV3029_W_SEC] = bin2bcd(tm->tm_min);
+	regs[RV3029_W_HOURS-RV3029_W_SEC] = bin2bcd(tm->tm_hour);
+	regs[RV3029_W_DATE-RV3029_W_SEC] = bin2bcd(tm->tm_mday);
+	regs[RV3029_W_MONTHS-RV3029_W_SEC] = bin2bcd(tm->tm_mon+1);
+	regs[RV3029_W_DAYS-RV3029_W_SEC] = bin2bcd((tm->tm_wday & 7)+1);
+	regs[RV3029_W_YEARS-RV3029_W_SEC] = bin2bcd(tm->tm_year - 100);
 
-	ret = rv3029c2_i2c_write_regs(client, RV3029C2_W_SEC, regs,
-					RV3029C2_WATCH_SECTION_LEN);
+	ret = rv3029_i2c_write_regs(client, RV3029_W_SEC, regs,
+				    RV3029_WATCH_SECTION_LEN);
 	if (ret < 0)
 		return ret;
 
-	ret = rv3029c2_i2c_get_sr(client, regs);
+	ret = rv3029_i2c_get_sr(client, regs);
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
 		return ret;
 	}
 	/* clear PON bit */
-	ret = rv3029c2_i2c_set_sr(client, (regs[0] & ~RV3029C2_STATUS_PON));
+	ret = rv3029_i2c_set_sr(client, (regs[0] & ~RV3029_STATUS_PON));
 	if (ret < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
 		return ret;
@@ -367,26 +368,26 @@ rv3029c2_i2c_set_time(struct i2c_client *client, struct rtc_time const *tm)
 	return 0;
 }
 
-static int rv3029c2_rtc_set_time(struct device *dev, struct rtc_time *tm)
+static int rv3029_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	return rv3029c2_i2c_set_time(to_i2c_client(dev), tm);
+	return rv3029_i2c_set_time(to_i2c_client(dev), tm);
 }
 
-static const struct rtc_class_ops rv3029c2_rtc_ops = {
-	.read_time	= rv3029c2_rtc_read_time,
-	.set_time	= rv3029c2_rtc_set_time,
-	.read_alarm	= rv3029c2_rtc_read_alarm,
-	.set_alarm	= rv3029c2_rtc_set_alarm,
+static const struct rtc_class_ops rv3029_rtc_ops = {
+	.read_time	= rv3029_rtc_read_time,
+	.set_time	= rv3029_rtc_set_time,
+	.read_alarm	= rv3029_rtc_read_alarm,
+	.set_alarm	= rv3029_rtc_set_alarm,
 };
 
-static struct i2c_device_id rv3029c2_id[] = {
+static struct i2c_device_id rv3029_id[] = {
 	{ "rv3029c2", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(i2c, rv3029c2_id);
+MODULE_DEVICE_TABLE(i2c, rv3029_id);
 
-static int rv3029c2_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+static int rv3029_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	struct rtc_device *rtc;
 	int rc = 0;
@@ -395,14 +396,14 @@ static int rv3029c2_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL))
 		return -ENODEV;
 
-	rc = rv3029c2_i2c_get_sr(client, buf);
+	rc = rv3029_i2c_get_sr(client, buf);
 	if (rc < 0) {
 		dev_err(&client->dev, "reading status failed\n");
 		return rc;
 	}
 
 	rtc = devm_rtc_device_register(&client->dev, client->name,
-					&rv3029c2_rtc_ops, THIS_MODULE);
+				       &rv3029_rtc_ops, THIS_MODULE);
 
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
@@ -412,16 +413,16 @@ static int rv3029c2_probe(struct i2c_client *client,
 	return 0;
 }
 
-static struct i2c_driver rv3029c2_driver = {
+static struct i2c_driver rv3029_driver = {
 	.driver = {
 		.name = "rtc-rv3029c2",
 	},
-	.probe = rv3029c2_probe,
-	.id_table = rv3029c2_id,
+	.probe		= rv3029_probe,
+	.id_table	= rv3029_id,
 };
 
-module_i2c_driver(rv3029c2_driver);
+module_i2c_driver(rv3029_driver);
 
 MODULE_AUTHOR("Gregory Hermant <gregory.hermant@calao-systems.com>");
-MODULE_DESCRIPTION("Micro Crystal RV3029C2 RTC driver");
+MODULE_DESCRIPTION("Micro Crystal RV3029 RTC driver");
 MODULE_LICENSE("GPL");
-- 
2.7.0

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

--Sig_/DdbUrbqU9zJvjkdrJgOmVAG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2dnrAAoJEPUyvh2QjYsOKCEP/1p1K4Jx8/JobUB8ZwV5AOGw
NPnlLCfsnhxyicgsoVR6LjHXeQxd3fC3nsP+NedjmMFccjztDnB5hN21xqDfl5vG
ix9qTbjhrp28zyqmTYhO56AQ2DYRYtDnU+xcSlaSrRvshjiODCosHuL5tCw2ozC3
T+mOJOOH1qP2zG9D8BHQ/UX8AmM6IFd+3qRHwzT1jjvKQha8sSd2ClhrWxC651yG
TyNcx4Pg1dpchh37kp+oM++62U4W8oCdSmgJwn6ExNE16nPklyEBvYM1y9x+Vqw/
hpwbni6qhFyd1hIQHMShWt+KftL9icu2KQOYFSHgBn3fwaQgz+vFZlc+YJi7afRH
idc0zu2nz+tv2l6Z/vWGC6BovnnvI0hbR4kkTGblYVmnpFYO15VuNUlxGsErBcLz
/oPcFnqVJvsY/yWgQ9JiU0wbk4ETcowuqI7egZZ7lR5s0DuE921RC3R7FjpxdJcJ
LnAjLX9NU79WYrwr05hD8CPW5U/8MRPrPTTFLJZs76guHfJKndm805yd6nBn3/Nc
V0T5Jah2qSgWSETHVVNQnxMFm8nZlgUOpLhtaMnUhy2PrkZVbDmvsBGLOZn69dby
6QO1SdpXgwGzbM1k79YrHzALkwu8wBnsrcoTTl+NZz3xk23W8edysQDkf7VQQgtv
flknBUlD3qk+WJRYvMAj
=cF1d
-----END PGP SIGNATURE-----

--Sig_/DdbUrbqU9zJvjkdrJgOmVAG--
