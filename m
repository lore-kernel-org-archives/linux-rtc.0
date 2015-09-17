Return-Path: <rtc-linux+bncBC7LNKXBRUKBB35Q5KXQKGQEWIT2D3Q@googlegroups.com>
MIME-Version: 1.0
Received: from regular1.263xmail.com (regular1.263xmail.com. [211.150.99.132])
        by gmr-mx.google.com with ESMTPS id uv4si377850pac.0.2015.09.17.03.39.42
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 03:39:43 -0700 (PDT)
From: Xing Zheng <zhengxing@rock-chips.com>
To: heiko@sntech.de
Cc: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	zhengxing@rock-chips.com
Subject: [rtc-linux] [PATCH v2 9/9] rtc: hym8563: make sure hym8563 can be
 normal work
Date: Thu, 17 Sep 2015 18:39:28 +0800
Message-Id: <1442486368-1912-1-git-send-email-zhengxing@rock-chips.com>
In-Reply-To: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
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

The rtc hym8563 maybe failed to register if first startup or rtc
powerdown:
[    0.988540 ] rtc-hym8563 1-0051: no valid clock/calendar values available
[    0.995642 ] rtc-hym8563 1-0051: rtc core: registered hym8563 as rtc0
[    1.078985 ] rtc-hym8563 1-0051: no valid clock/calendar values available
[    1.085698 ] rtc-hym8563 1-0051: hctosys: unable to read the hardware clock

We can set initial time for rtc and register it:
[    0.995678 ] rtc-hym8563 1-0051: rtc core: registered hym8563 as rtc0
[    1.080313 ] rtc-hym8563 1-0051: setting system clock to 2000-01-01 00:02:00 UTC (946684920)

---

Changes in v2:
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

 drivers/rtc/rtc-hym8563.c |   93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 097325d..ea37fdf 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -83,6 +83,8 @@
 
 #define HYM8563_TMR_CNT		0x0f
 
+#define HYM8563_RTC_SECTION_LEN	0x07
+
 struct hym8563 {
 	struct i2c_client	*client;
 	struct rtc_device	*rtc;
@@ -527,9 +529,77 @@ static int hym8563_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(hym8563_pm_ops, hym8563_suspend, hym8563_resume);
 
+static int hym8563_set_time(struct i2c_client *client, struct rtc_time *tm)
+{
+	u8 regs[HYM8563_RTC_SECTION_LEN] = {0};
+	u8 mon_day;
+	int ret = 0;
+
+	dev_dbg(&client->dev, "%s -- %4d-%02d-%02d(%d) %02d:%02d:%02d\n", __func__,
+		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday, tm->tm_wday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+	mon_day = rtc_month_days((tm->tm_mon), tm->tm_year + 1900);
+
+	if (tm->tm_sec >= 60 || tm->tm_sec < 0)
+		regs[0x00] = bin2bcd(0x00);
+	else
+		regs[0x00] = bin2bcd(tm->tm_sec);
+
+	if (tm->tm_min >= 60 || tm->tm_min < 0)
+		regs[0x01] = bin2bcd(0x00);
+	else
+		regs[0x01] = bin2bcd(tm->tm_min);
+
+	if (tm->tm_hour >= 24 || tm->tm_hour < 0)
+		regs[0x02] = bin2bcd(0x00);
+	else
+		regs[0x02] = bin2bcd(tm->tm_hour);
+
+	if ((tm->tm_mday) > mon_day)
+		regs[0x03] = bin2bcd(mon_day);
+	else if ((tm->tm_mday) > 0)
+		regs[0x03] = bin2bcd(tm->tm_mday);
+	else if ((tm->tm_mday) <= 0)
+		regs[0x03] = bin2bcd(0x01);
+
+	if (tm->tm_year >= 200)
+		regs[0x06] = bin2bcd(99);
+	else if (tm->tm_year >= 100)
+		regs[0x06] = bin2bcd(tm->tm_year - 100);
+	else if (tm->tm_year >= 0) {
+		regs[0x06] = bin2bcd(tm->tm_year);
+		regs[0x05] |= 0x80;
+	} else {
+		regs[0x06] = bin2bcd(0);
+		regs[0x05] |= 0x80;
+	}
+
+	regs[0x04] = bin2bcd(tm->tm_wday);
+	regs[0x05] = (regs[0x05] & 0x80) | (bin2bcd(tm->tm_mon + 1) & 0x7F);
+
+	ret = i2c_smbus_write_byte_data(client, HYM8563_SEC, *regs);
+	if (ret < 0) {
+		dev_err(&client->dev, "%s: error writing i2c data %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int hym8563_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct rtc_time tm_read, tm = {
+		.tm_sec = 0,
+		.tm_min = 0,
+		.tm_hour = 12,
+		.tm_mday = 1,
+		.tm_mon = 0,
+		.tm_year = 111,
+		.tm_wday = 6,
+	};
 	struct hym8563 *hym8563;
 	int ret;
 
@@ -562,6 +632,7 @@ static int hym8563_probe(struct i2c_client *client,
 
 	/* check state of calendar information */
 	ret = i2c_smbus_read_byte_data(client, HYM8563_SEC);
+
 	if (ret < 0)
 		return ret;
 
@@ -569,6 +640,28 @@ static int hym8563_probe(struct i2c_client *client,
 	dev_dbg(&client->dev, "rtc information is %s\n",
 		hym8563->valid ? "valid" : "invalid");
 
+	if (!hym8563->valid) {
+		ret = hym8563_set_time(client, &tm);
+		if (ret < 0) {
+			dev_err(&client->dev, "rtc set time failed, %d\n", ret);
+			return ret;
+		}
+
+		hym8563->valid = true;
+	}
+
+	/* read current time */
+	ret = hym8563_rtc_read_time(&client->dev, &tm_read);
+	if (ret < 0) {
+		dev_err(&client->dev, "rtc read time failed, %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(&client->dev, "tm_sec = %d, tm_min = %d, tm_hour = %d,tm_mday = %d\n",
+		tm_read.tm_sec, tm_read.tm_min, tm_read.tm_hour, tm_read.tm_mday);
+	dev_dbg(&client->dev, "tm_mon = %d, tm_year = %d, tm_wday = %d\n",
+		tm_read.tm_mon, tm_read.tm_year, tm_read.tm_wday);
+
 	hym8563->rtc = devm_rtc_device_register(&client->dev, client->name,
 						&hym8563_rtc_ops, THIS_MODULE);
 	if (IS_ERR(hym8563->rtc))
-- 
1.7.9.5


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
