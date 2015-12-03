Return-Path: <rtc-linux+bncBDDJNTW5VUMBBG6B72ZAKGQEGOTY5DA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com. [2607:f8b0:400e:c03::230])
        by gmr-mx.google.com with ESMTPS id fg10si943917pad.0.2015.12.02.17.53.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2015 17:53:31 -0800 (PST)
Received: by mail-pa0-x230.google.com with SMTP id fh17so58388015pab.0
        for <rtc-linux@googlegroups.com>; Wed, 02 Dec 2015 17:53:31 -0800 (PST)
From: Julius Werner <jwerner@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Doug Anderson <dianders@chromium.org>,
	Sonny Rao <sonnyrao@chromium.org>,
	Chris Zhong <zyw@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Julius Werner <jwerner@chromium.org>
Subject: [rtc-linux] [PATCH] RTC: RK808: Work around hardware bug on November 31st
Date: Wed,  2 Dec 2015 17:53:04 -0800
Message-Id: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
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

In Fuzhou, China, the month of November seems to be having 31 days.
That's nice and all (I'm sure you can get a lot more done in a year that
way), but back here in other parts of the world we are not so lucky.
Therefore, if we read that date from the RTC we should correct it to
December 1st.

This is not a full workaround. Since the RTC actually ticks all the way
through that imaginary day, there's no easy way to detect and correct
this issue if the device was offline the whole time and allowed it to
tick through to December 1st on the Rockchip calendar (which would be
December 2nd on the Gregorian one). Those edge cases can only really be
solved by regularly syncing to an external time source (e.g. NTP).

Signed-off-by: Julius Werner <jwerner@chromium.org>
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
---
 drivers/rtc/rtc-rk808.c | 93 ++++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index 91ca0bc..b605b35 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -56,6 +56,50 @@ struct rk808_rtc {
 	int irq;
 };
 
+/* Set current time and date in RTC */
+static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
+	struct rk808 *rk808 = rk808_rtc->rk808;
+	u8 rtc_data[NUM_TIME_REGS];
+	int ret;
+
+	rtc_data[0] = bin2bcd(tm->tm_sec);
+	rtc_data[1] = bin2bcd(tm->tm_min);
+	rtc_data[2] = bin2bcd(tm->tm_hour);
+	rtc_data[3] = bin2bcd(tm->tm_mday);
+	rtc_data[4] = bin2bcd(tm->tm_mon + 1);
+	rtc_data[5] = bin2bcd(tm->tm_year - 100);
+	rtc_data[6] = bin2bcd(tm->tm_wday);
+	dev_dbg(dev, "set RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
+		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
+		tm->tm_wday, tm->tm_hour , tm->tm_min, tm->tm_sec);
+
+	/* Stop RTC while updating the RTC registers */
+	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
+				 BIT_RTC_CTRL_REG_STOP_RTC_M,
+				 BIT_RTC_CTRL_REG_STOP_RTC_M);
+	if (ret) {
+		dev_err(dev, "Failed to update RTC control: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_bulk_write(rk808->regmap, RK808_SECONDS_REG,
+				rtc_data, NUM_TIME_REGS);
+	if (ret) {
+		dev_err(dev, "Failed to bull write rtc_data: %d\n", ret);
+		return ret;
+	}
+	/* Start RTC again */
+	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
+				 BIT_RTC_CTRL_REG_STOP_RTC_M, 0);
+	if (ret) {
+		dev_err(dev, "Failed to update RTC control: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
 /* Read current time and date in RTC */
 static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 {
@@ -105,51 +149,14 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
 		tm->tm_wday, tm->tm_hour , tm->tm_min, tm->tm_sec);
 
-	return ret;
-}
-
-/* Set current time and date in RTC */
-static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
-	struct rk808 *rk808 = rk808_rtc->rk808;
-	u8 rtc_data[NUM_TIME_REGS];
-	int ret;
-
-	rtc_data[0] = bin2bcd(tm->tm_sec);
-	rtc_data[1] = bin2bcd(tm->tm_min);
-	rtc_data[2] = bin2bcd(tm->tm_hour);
-	rtc_data[3] = bin2bcd(tm->tm_mday);
-	rtc_data[4] = bin2bcd(tm->tm_mon + 1);
-	rtc_data[5] = bin2bcd(tm->tm_year - 100);
-	rtc_data[6] = bin2bcd(tm->tm_wday);
-	dev_dbg(dev, "set RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_wday, tm->tm_hour , tm->tm_min, tm->tm_sec);
-
-	/* Stop RTC while updating the RTC registers */
-	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
-				 BIT_RTC_CTRL_REG_STOP_RTC_M,
-				 BIT_RTC_CTRL_REG_STOP_RTC_M);
-	if (ret) {
-		dev_err(dev, "Failed to update RTC control: %d\n", ret);
-		return ret;
+	if (tm->tm_mon == 10 && tm->tm_mday == 31) {
+		dev_warn(dev, "correcting Nov 31st to Dec 1st (HW bug)\n");
+		tm->tm_mon = 11;
+		tm->tm_mday = 1;
+		rk808_rtc_set_time(dev, tm);
 	}
 
-	ret = regmap_bulk_write(rk808->regmap, RK808_SECONDS_REG,
-				rtc_data, NUM_TIME_REGS);
-	if (ret) {
-		dev_err(dev, "Failed to bull write rtc_data: %d\n", ret);
-		return ret;
-	}
-	/* Start RTC again */
-	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
-				 BIT_RTC_CTRL_REG_STOP_RTC_M, 0);
-	if (ret) {
-		dev_err(dev, "Failed to update RTC control: %d\n", ret);
-		return ret;
-	}
-	return 0;
+	return ret;
 }
 
 /* Read alarm time and date in RTC */
-- 
2.1.2

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
