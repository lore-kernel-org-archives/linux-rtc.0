Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [3/4] rtc: rtc-rs5c372: use century bit
From: thomas.koeller@baslerweb.com
Message-Id: <1275486787-30406-4-git-send-email-thomas.koeller@baslerweb.com>
To: p_gortmaker@yahoo.com,
	rtc-linux@googlegroups.com
Cc: Thomas Koeller <thomas.koeller@baslerweb.com>
Date: Wed,  2 Jun 2010 15:53:06 +0200
List-ID: <rtc-linux.googlegroups.com>

From: Thomas Koeller <thomas.koeller@baslerweb.com>

Use the century bit to mark the time as being int 20th or
21st century, resp. This makes it possible to represent all
valid unix dates past the epoch.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
---
 drivers/rtc/rtc-rs5c372.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index be80560..41518ef 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -83,8 +83,6 @@ static const struct i2c_device_id rs5c372_id[] = {
 MODULE_DEVICE_TABLE(i2c, rs5c372_id);
 
 /* REVISIT:  this assumes that:
- *  - we're in the 21st century, so it's safe to ignore the century
- *    bit for rv5c38[67] (REG_MONTH bit 7);
  *  - we should use ALARM_A not ALARM_B (may be wrong on some boards)
  */
 struct rs5c372 {
@@ -190,8 +188,8 @@ static int rs5c372_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	/* tm->tm_mon is zero-based */
 	tm->tm_mon = bcd2bin(rs5c->regs[RS5C372_REG_MONTH] & 0x1f) - 1;
 
-	/* year is 1900 + tm->tm_year */
-	tm->tm_year = bcd2bin(rs5c->regs[RS5C372_REG_YEAR]) + 100;
+	tm->tm_year = bcd2bin(rs5c->regs[RS5C372_REG_YEAR]) +
+		      ((rs5c->regs[RS5C372_REG_MONTH] & 0x80) ? 100 : 0);
 
 	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
@@ -221,8 +219,13 @@ static int rs5c372_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	buf[2] = rs5c_hr2reg(rs5c, tm->tm_hour);
 	buf[3] = bin2bcd(tm->tm_wday);
 	buf[4] = bin2bcd(tm->tm_mday);
-	buf[5] = bin2bcd(tm->tm_mon + 1);
-	buf[6] = bin2bcd(tm->tm_year - 100);
+	if (tm->tm_year >= 100) {
+		buf[5] = bin2bcd(tm->tm_mon + 1) | 0x80;
+		buf[6] = bin2bcd(tm->tm_year - 100);
+	} else {
+		buf[5] = bin2bcd(tm->tm_mon + 1);
+		buf[6] = bin2bcd(tm->tm_year);
+	}
 
 	if (i2c_smbus_write_i2c_block_data(client, addr, sizeof(buf), buf) < 0) {
 		dev_err(&client->dev, "%s: write error\n", __func__);
