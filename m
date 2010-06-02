Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [4/4] rtc: rtc-rs5c372: optionally return epoch if time may be
 unreliable
From: thomas.koeller@baslerweb.com
Message-Id: <1275486787-30406-5-git-send-email-thomas.koeller@baslerweb.com>
To: p_gortmaker@yahoo.com,
	rtc-linux@googlegroups.com
Cc: Thomas Koeller <thomas.koeller@baslerweb.com>
Date: Wed,  2 Jun 2010 15:53:07 +0200
List-ID: <rtc-linux.googlegroups.com>

From: Thomas Koeller <thomas.koeller@baslerweb.com>

The time stored in the chip may be wrong due to power outage,
oscillator stall etc. A boolean parameter named 'epoch_if_invalid'
has been added, controlling the behavior in response to the detection
of such a condition. If set, it causes the time to be reported as
the epoch. This is intended to make it obvious that the time value
returned may be invalid, which otherwise may be difficult to
detect.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
---
 drivers/rtc/rtc-rs5c372.c |  133 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 116 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 41518ef..376a943 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/moduleparam.h>
 
 #define DRV_VERSION "0.6"
 
@@ -51,18 +52,27 @@
 #	define RS5C_CTRL1_CT0		(0 << 0)	/* no periodic irq */
 #	define RS5C_CTRL1_CT4		(4 << 0)	/* 1 Hz level irq */
 #define RS5C_REG_CTRL2		15
+#	define R2025_CTRL2_VDET		(1 << 6)	/* VDD low */
 #	define RS5C372_CTRL2_24		(1 << 5)
-#	define R2025_CTRL2_XST		(1 << 5)
+#	define R2025_CTRL2_XST		(1 << 5)	/* OSC stopped */
 #	define RS5C_CTRL2_XSTP		(1 << 4)	/* only if !R2025S/D */
+#	define R2025_CTRL2_PON		(1 << 4)	/* power loss */
 #	define RS5C_CTRL2_CTFG		(1 << 2)
 #	define RS5C_CTRL2_AAFG		(1 << 1)	/* or WAFG */
 #	define RS5C_CTRL2_BAFG		(1 << 0)	/* or DAFG */
 
+#define R2025_TIME_VALIDMASK \
+	(R2025_CTRL2_VDET | R2025_CTRL2_XST | R2025_CTRL2_PON)
 
 /* to read (style 1) or write registers starting at R */
 #define RS5C_ADDR(R)		(((R) << 4) | 0)
 
 
+static int epoch_if_invalid;
+module_param(epoch_if_invalid, bool, 0644);
+MODULE_PARM_DESC(reset_if_invalid, "If invalid time, return the epoch");
+
+
 enum rtc_type {
 	rtc_undef = 0,
 	rtc_r2025sd,
@@ -89,6 +99,8 @@ struct rs5c372 {
 	struct i2c_client	*client;
 	struct rtc_device	*rtc;
 	enum rtc_type		type;
+	int			(*is_valid_time)(const struct rs5c372 *rs5c);
+	int			(*clear_invalid)(const struct rs5c372 *rs5c);
 	unsigned		time24:1;
 	unsigned		has_irq:1;
 	unsigned		smbus:1;
@@ -96,6 +108,40 @@ struct rs5c372 {
 	char			*regs;
 };
 
+static int rs5c372_is_valid_time(const struct rs5c372 *rs5c)
+{
+	return (rs5c->regs[RS5C_REG_CTRL2] | RS5C_CTRL2_XSTP) ? 1 : 0;
+}
+
+static int rs5c372_clear_invalid(const struct rs5c372 *rs5c)
+{
+	int ret = 0, addr = RS5C_ADDR(RS5C_REG_CTRL2);
+
+	ret = i2c_smbus_read_byte_data(rs5c->client, addr);
+	return (0 <= ret) ?
+	       i2c_smbus_write_byte_data(
+			rs5c->client, addr, (u8) ret | RS5C_CTRL2_XSTP) :
+	       ret;
+}
+
+static int r2025_is_valid_time(const struct rs5c372 *rs5c)
+{
+	return	(rs5c->regs[RS5C_REG_CTRL2] & R2025_TIME_VALIDMASK) ==
+		R2025_CTRL2_XST;
+}
+
+static int r2025_clear_invalid(const struct rs5c372 *rs5c)
+{
+	int ret, addr = RS5C_ADDR(RS5C_REG_CTRL2);
+
+	ret = i2c_smbus_read_byte_data(rs5c->client, addr);
+	return (0 <= ret) ?
+	       i2c_smbus_write_byte_data(
+			rs5c->client, addr,
+			(u8) (ret & ~R2025_TIME_VALIDMASK) | R2025_CTRL2_XST) :
+	       ret;
+}
+
 static int rs5c_get_regs(struct rs5c372 *rs5c)
 {
 	struct i2c_client	*client = rs5c->client;
@@ -178,6 +224,11 @@ static int rs5c372_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	if (status < 0)
 		return status;
 
+	if (epoch_if_invalid && !rs5c->is_valid_time(rs5c)) {
+		rtc_time_to_tm(0, tm);
+		return 0;
+	};
+
 	tm->tm_sec = bcd2bin(rs5c->regs[RS5C372_REG_SECS] & 0x7f);
 	tm->tm_min = bcd2bin(rs5c->regs[RS5C372_REG_MINS] & 0x7f);
 	tm->tm_hour = rs5c_reg2hr(rs5c, rs5c->regs[RS5C372_REG_HOURS]);
@@ -227,7 +278,9 @@ static int rs5c372_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 		buf[6] = bin2bcd(tm->tm_year);
 	}
 
-	if (i2c_smbus_write_i2c_block_data(client, addr, sizeof(buf), buf) < 0) {
+	if ((i2c_smbus_write_i2c_block_data(client, addr,
+					    sizeof(buf), buf) < 0) ||
+	    (rs5c->clear_invalid(rs5c) < 0)) {
 		dev_err(&client->dev, "%s: write error\n", __func__);
 		return -EIO;
 	}
@@ -532,20 +585,41 @@ static void rs5c_sysfs_unregister(struct device *dev)
 
 static struct i2c_driver rs5c372_driver;
 
-static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
+static int rs5c_oscillator_setup_pon(struct rs5c372 *rs5c372)
+{
+	u8 buf, invalid;
+	int ret;
+
+	invalid = (rs5c372->regs[RS5C_REG_CTRL2] & R2025_TIME_VALIDMASK) ^
+		R2025_CTRL2_XST;
+
+	if	(invalid & R2025_CTRL2_PON)
+		dev_warn(&rs5c372->client->dev, "Time invalid: power lost\n");
+	else if	(invalid & R2025_CTRL2_VDET)
+		dev_warn(&rs5c372->client->dev, "Time invalid: VDD low\n");
+	else if	(invalid & R2025_CTRL2_XST)
+		dev_warn(&rs5c372->client->dev, "Time invalid: osc. stalled\n");
+	else
+		return 0;
+
+	buf = rs5c372->regs[RS5C_REG_CTRL1] | RV5C387_CTRL1_24;
+	ret = i2c_smbus_write_byte_data(rs5c372->client,
+					RS5C_ADDR(RS5C_REG_CTRL1), buf);
+	if (unlikely(ret < 0))
+		return ret;
+	rs5c372->regs[RS5C_REG_CTRL1] = buf;
+	rs5c372->time24 = 1;
+
+	return 0;
+}
+
+static int rs5c_oscillator_setup_xstp(struct rs5c372 *rs5c372)
 {
 	unsigned char buf[2];
 	int addr, i, ret = 0;
 
-	if (rs5c372->type == rtc_r2025sd) {
-		if (rs5c372->regs[RS5C_REG_CTRL2] & R2025_CTRL2_XST)
-			return ret;
-		rs5c372->regs[RS5C_REG_CTRL2] |= R2025_CTRL2_XST;
-	} else {
-		if (!(rs5c372->regs[RS5C_REG_CTRL2] & RS5C_CTRL2_XSTP))
-			return ret;
-		rs5c372->regs[RS5C_REG_CTRL2] &= ~RS5C_CTRL2_XSTP;
-	}
+	if (!(rs5c372->regs[RS5C_REG_CTRL2] & RS5C_CTRL2_XSTP))
+		return ret;
 
 	addr   = RS5C_ADDR(RS5C_REG_CTRL1);
 	buf[0] = rs5c372->regs[RS5C_REG_CTRL1];
@@ -558,7 +632,6 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
 		buf[1] |= RS5C372_CTRL2_24;
 		rs5c372->time24 = 1;
 		break;
-	case rtc_r2025sd:
 	case rtc_rv5c386:
 	case rtc_rv5c387a:
 		buf[0] |= RV5C387_CTRL1_24;
@@ -582,6 +655,32 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
 	return 0;
 }
 
+static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
+{
+	int res;
+
+	switch (rs5c372->type) {
+	case rtc_r2025sd:
+		rs5c372->is_valid_time = r2025_is_valid_time;
+		rs5c372->clear_invalid = r2025_clear_invalid;
+		res = rs5c_oscillator_setup_pon(rs5c372);
+		break;
+	case rtc_rs5c372a:
+	case rtc_rs5c372b:
+	case rtc_rv5c386:
+	case rtc_rv5c387a:
+		rs5c372->is_valid_time = rs5c372_is_valid_time;
+		rs5c372->clear_invalid = rs5c372_clear_invalid;
+		res = rs5c_oscillator_setup_xstp(rs5c372);
+		break;
+	default:
+		res = -EINVAL;
+		break;
+	}
+
+	return res;
+}
+
 static int rs5c372_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -633,14 +732,14 @@ static int rs5c372_probe(struct i2c_client *client,
 		/* alarm uses ALARM_A; and nINTRA on 372a, nINTR on 372b.
 		 * so does periodic irq, except some 327a modes.
 		 */
-		if (rs5c372->regs[RS5C_REG_CTRL2] & RS5C372_CTRL2_24)
-			rs5c372->time24 = 1;
+		rs5c372->time24 =
+			(rs5c372->regs[RS5C_REG_CTRL2] & RS5C372_CTRL2_24) != 0;
 		break;
 	case rtc_r2025sd:
 	case rtc_rv5c386:
 	case rtc_rv5c387a:
-		if (rs5c372->regs[RS5C_REG_CTRL1] & RV5C387_CTRL1_24)
-			rs5c372->time24 = 1;
+		rs5c372->time24 =
+			(rs5c372->regs[RS5C_REG_CTRL1] & RV5C387_CTRL1_24) != 0;
 		/* alarm uses ALARM_W; and nINTRB for alarm and periodic
 		 * irq, on both 386 and 387
 		 */
