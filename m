Return-Path: <rtc-linux+bncBDDJNTW5VUMBB66RTGZQKGQEDJFGD3Y@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com. [2607:f8b0:400e:c00::22a])
        by gmr-mx.google.com with ESMTPS id pe1si155509pac.2.2015.12.07.21.22.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2015 21:22:03 -0800 (PST)
Received: by mail-pf0-x22a.google.com with SMTP id d184so6060889pfd.3
        for <rtc-linux@googlegroups.com>; Mon, 07 Dec 2015 21:22:03 -0800 (PST)
From: Julius Werner <jwerner@chromium.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Doug Anderson <dianders@chromium.org>,
	Sonny Rao <sonnyrao@chromium.org>,
	Chris Zhong <zyw@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Julius Werner <jwerner@chromium.org>
Subject: [rtc-linux] [PATCH v2] RTC: RK808: Work around hardware bug on
 November 31st
Date: Mon,  7 Dec 2015 21:21:55 -0800
Message-Id: <1449552115-31256-1-git-send-email-jwerner@chromium.org>
In-Reply-To: <CAODwPW-ZJ2HwrQohmfMYv2-jH2Ofq-O2H_HPfqYLXXnueVYYnA@mail.gmail.com>
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
Therefore, we need to compensate for these extra days existing only in
the RTC's imagination when reading the time and dealing with alarms.

This patch is not a perfect workaround -- it only keeps the time stable
as long as the system is running or suspended. If the system is fully
shut down in November and only booted back up in December, the system
time may be incorrect and alarms that had been set before the shutdown
may fire on the wrong day. We're trying to catch and recover from this
by reading the RTC's last "shadow timestamp" (which only gets resynced
when transitioning the GET_TIME control bit) to figure out when the
system was shut down, but this is only reliable if no other code (e.g.
firmware) has read the RTC in-between.

Basic idea for the workaround:

- Whenever we set the time, we assume that timestamp to be correct
  (synced to the real world). We store a copy of it in memory as an
  anchor point (where we know our calendar matched the real world).
- Whenever we read the time, we can tell how many days of desync we have
  by counting November/December transitions between the anchor timestamp
  and the time read from the hardware. We adjust the hardware clock
  accordingly to get back in sync (which also resets the anchor time).
- Whenever we set an alarm, we adjust the alarm time backwards by the
  amount of days that we know we will lag behind at that point (by
  counting the November/December transitions between our anchor point
  and the alarm). This way, we will wake up on the right real world date
  even though we cannot make adjustments while suspended.
- Whenever we read an alarm, we do the opposite (forward) adjustment for
  the returned result to keep our outside interface free from this
  madness (callers expect to be able to read back the alarm they wrote).
- Whenever we set the system time (which adjusts the anchor point), we
  read out the (adjusted) alarm time beforehand and write it (newly
  adjusted) back afterwards. This way, system time and alarm time will
  always stay on the same calendar (as long as we're able to keep track
  of our anchor point, at least).

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 drivers/rtc/rtc-rk808.c | 282 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 190 insertions(+), 92 deletions(-)

diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index 91ca0bc..2a6cd6f 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -54,103 +54,30 @@ struct rk808_rtc {
 	struct rk808 *rk808;
 	struct rtc_device *rtc;
 	int irq;
+	struct rtc_time anchor_time;	/* Last sync point with real world */
 };
 
-/* Read current time and date in RTC */
-static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
+/*
+ * RK808 has a hardware bug causing it to count 31 days in November. This
+ * function can calculate the amount of days that code needs to adjust for
+ * between two timestamps to compensate for this.
+ */
+static int nov31st_transitions(struct rtc_time *from, struct rtc_time *to)
 {
-	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
-	struct rk808 *rk808 = rk808_rtc->rk808;
-	u8 rtc_data[NUM_TIME_REGS];
-	int ret;
-
-	/* Force an update of the shadowed registers right now */
-	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
-				 BIT_RTC_CTRL_REG_RTC_GET_TIME,
-				 BIT_RTC_CTRL_REG_RTC_GET_TIME);
-	if (ret) {
-		dev_err(dev, "Failed to update bits rtc_ctrl: %d\n", ret);
-		return ret;
-	}
-
-	/*
-	 * After we set the GET_TIME bit, the rtc time can't be read
-	 * immediately. So we should wait up to 31.25 us, about one cycle of
-	 * 32khz. If we clear the GET_TIME bit here, the time of i2c transfer
-	 * certainly more than 31.25us: 16 * 2.5us at 400kHz bus frequency.
-	 */
-	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
-				 BIT_RTC_CTRL_REG_RTC_GET_TIME,
-				 0);
-	if (ret) {
-		dev_err(dev, "Failed to update bits rtc_ctrl: %d\n", ret);
-		return ret;
-	}
+	int extra_days = to->tm_year - from->tm_year;
 
-	ret = regmap_bulk_read(rk808->regmap, RK808_SECONDS_REG,
-			       rtc_data, NUM_TIME_REGS);
-	if (ret) {
-		dev_err(dev, "Failed to bulk read rtc_data: %d\n", ret);
-		return ret;
-	}
+	/* Avoid adjusting anything for uninitialized timestamps */
+	if (from->tm_mday == 0 || to->tm_mday == 0)
+		return 0;
 
-	tm->tm_sec = bcd2bin(rtc_data[0] & SECONDS_REG_MSK);
-	tm->tm_min = bcd2bin(rtc_data[1] & MINUTES_REG_MAK);
-	tm->tm_hour = bcd2bin(rtc_data[2] & HOURS_REG_MSK);
-	tm->tm_mday = bcd2bin(rtc_data[3] & DAYS_REG_MSK);
-	tm->tm_mon = (bcd2bin(rtc_data[4] & MONTHS_REG_MSK)) - 1;
-	tm->tm_year = (bcd2bin(rtc_data[5] & YEARS_REG_MSK)) + 100;
-	tm->tm_wday = bcd2bin(rtc_data[6] & WEEKS_REG_MSK);
-	dev_dbg(dev, "RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_wday, tm->tm_hour , tm->tm_min, tm->tm_sec);
+	if (from->tm_mon > 10)
+		extra_days--;
 
-	return ret;
-}
+	if (to->tm_mon > 10)
+		extra_days++;
 
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
-	}
-
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
-}
+	return extra_days;
+};
 
 /* Read alarm time and date in RTC */
 static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -159,7 +86,7 @@ static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rk808 *rk808 = rk808_rtc->rk808;
 	u8 alrm_data[NUM_ALARM_REGS];
 	uint32_t int_reg;
-	int ret;
+	int ret, extra_days;
 
 	ret = regmap_bulk_read(rk808->regmap, RK808_ALARM_SECONDS_REG,
 			       alrm_data, NUM_ALARM_REGS);
@@ -171,6 +98,19 @@ static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	alrm->time.tm_mon = (bcd2bin(alrm_data[4] & MONTHS_REG_MSK)) - 1;
 	alrm->time.tm_year = (bcd2bin(alrm_data[5] & YEARS_REG_MSK)) + 100;
 
+	extra_days = nov31st_transitions(&rk808_rtc->anchor_time, &alrm->time);
+	if (alrm->time.tm_mon == 10 && alrm->time.tm_mday == 31) {
+		dev_warn(dev, "read HW alarm date as Nov 31, compensating\n");
+		alrm->time.tm_mon = 11;
+		alrm->time.tm_mday = 1 + extra_days;
+	} else if (extra_days) {
+		unsigned long time;
+		dev_warn(dev, "compensating for %d Nov31 until HW alarm date\n",
+			 extra_days);
+		rtc_tm_to_time(&alrm->time, &time);
+		rtc_time_to_tm(time + extra_days * 86400, &alrm->time);
+	}
+
 	ret = regmap_read(rk808->regmap, RK808_RTC_INT_REG, &int_reg);
 	if (ret) {
 		dev_err(dev, "Failed to read RTC INT REG: %d\n", ret);
@@ -215,7 +155,7 @@ static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
 	struct rk808 *rk808 = rk808_rtc->rk808;
 	u8 alrm_data[NUM_ALARM_REGS];
-	int ret;
+	int ret, extra_days;
 
 	ret = rk808_rtc_stop_alarm(rk808_rtc);
 	if (ret) {
@@ -227,6 +167,19 @@ static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		alrm->time.tm_mday, alrm->time.tm_wday, alrm->time.tm_hour,
 		alrm->time.tm_min, alrm->time.tm_sec);
 
+	extra_days = nov31st_transitions(&rk808_rtc->anchor_time, &alrm->time);
+	if (extra_days) {
+		unsigned long time;
+		dev_warn(dev, "writing HW alarm date adjusted for %d Nov31\n",
+			 extra_days);
+		rtc_tm_to_time(&alrm->time, &time);
+		rtc_time_to_tm(time - extra_days * 86400, &alrm->time);
+		/* Compensate in case the subtraction went back over Nov 31st */
+		if (alrm->time.tm_mon == 10 &&
+		    alrm->time.tm_mday == 31 - extra_days)
+			alrm->time.tm_mday++;	/* This can result in 31! */
+	}
+
 	alrm_data[0] = bin2bcd(alrm->time.tm_sec);
 	alrm_data[1] = bin2bcd(alrm->time.tm_min);
 	alrm_data[2] = bin2bcd(alrm->time.tm_hour);
@@ -250,6 +203,141 @@ static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	return 0;
 }
 
+/* Set current time and date in RTC */
+static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
+	struct rk808 *rk808 = rk808_rtc->rk808;
+	struct rtc_wkalrm alrm;
+	u8 rtc_data[NUM_TIME_REGS];
+	int ret;
+
+	/* Read out wake alarm with old Nov 31st adjustment */
+	rk808_rtc_readalarm(dev, &alrm);
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
+
+	/* Assume a newly set time is always correct (regardless of source) */
+	rk808_rtc->anchor_time = *tm;
+
+	/* Write back wake alarm with new Nov 31st adjustment */
+	rk808_rtc_setalarm(dev, &alrm);
+
+	return 0;
+}
+
+/* Read time from static shadow registers (without updating) */
+static int rk808_rtc_raw_read(struct device *dev, struct rtc_time *tm)
+{
+	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
+	struct rk808 *rk808 = rk808_rtc->rk808;
+	u8 rtc_data[NUM_TIME_REGS];
+	int ret;
+
+	ret = regmap_bulk_read(rk808->regmap, RK808_SECONDS_REG,
+			       rtc_data, NUM_TIME_REGS);
+	if (ret) {
+		dev_err(dev, "Failed to bulk read rtc_data: %d\n", ret);
+		return ret;
+	}
+
+	tm->tm_sec = bcd2bin(rtc_data[0] & SECONDS_REG_MSK);
+	tm->tm_min = bcd2bin(rtc_data[1] & MINUTES_REG_MAK);
+	tm->tm_hour = bcd2bin(rtc_data[2] & HOURS_REG_MSK);
+	tm->tm_mday = bcd2bin(rtc_data[3] & DAYS_REG_MSK);
+	tm->tm_mon = (bcd2bin(rtc_data[4] & MONTHS_REG_MSK)) - 1;
+	tm->tm_year = (bcd2bin(rtc_data[5] & YEARS_REG_MSK)) + 100;
+	tm->tm_wday = bcd2bin(rtc_data[6] & WEEKS_REG_MSK);
+	dev_dbg(dev, "RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
+		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
+		tm->tm_wday, tm->tm_hour , tm->tm_min, tm->tm_sec);
+
+	return ret;
+}
+
+/* Read current time and date in RTC */
+static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
+{
+	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
+	struct rk808 *rk808 = rk808_rtc->rk808;
+	int ret, extra_days;
+
+	/* Force an update of the shadowed registers right now */
+	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
+				 BIT_RTC_CTRL_REG_RTC_GET_TIME,
+				 BIT_RTC_CTRL_REG_RTC_GET_TIME);
+	if (ret) {
+		dev_err(dev, "Failed to update bits rtc_ctrl: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * After we set the GET_TIME bit, the rtc time can't be read
+	 * immediately. So we should wait up to 31.25 us, about one cycle of
+	 * 32khz. If we clear the GET_TIME bit here, the time of i2c transfer
+	 * certainly more than 31.25us: 16 * 2.5us at 400kHz bus frequency.
+	 */
+	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
+				 BIT_RTC_CTRL_REG_RTC_GET_TIME,
+				 0);
+	if (ret) {
+		dev_err(dev, "Failed to update bits rtc_ctrl: %d\n", ret);
+		return ret;
+	}
+
+	ret = rk808_rtc_raw_read(dev, tm);
+	if (ret)
+		return ret;
+
+	extra_days = nov31st_transitions(&rk808_rtc->anchor_time, tm);
+	if (tm->tm_mon == 10 && tm->tm_mday == 31) {
+		dev_warn(dev, "read Nov 31, correcting to Dec 1 (HW bug)\n");
+		tm->tm_mon = 11;
+		tm->tm_mday = 1 + extra_days; /* don't S2R for over 30 years! */
+		rk808_rtc_set_time(dev, tm);
+	} else if (extra_days) {
+		unsigned long time;
+		dev_warn(dev, "compensating for %d skips over Nov 31\n",
+			 extra_days);
+		rtc_tm_to_time(tm, &time);
+		rtc_time_to_tm(time + extra_days * 86400, tm);
+		rk808_rtc_set_time(dev, tm);
+	}
+	return ret;
+}
+
 static int rk808_rtc_alarm_irq_enable(struct device *dev,
 				      unsigned int enabled)
 {
@@ -364,6 +452,16 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	/*
+	 * Try to initialize anchor point by reading "last read" shadow
+	 * timestamp, to catch Nov 31st transitions that happened while shut
+	 * down. This only works if no other code (e.g. firmware) has
+	 * transitioned GET_TIME before this point.
+	 */
+	ret = rk808_rtc_raw_read(&pdev->dev, &rk808_rtc->anchor_time);
+	if (ret || rtc_valid_tm(&rk808_rtc->anchor_time))
+		rk808_rtc->anchor_time.tm_mday = 0;	/* invalidate */
+
 	/* set init time */
 	ret = rk808_rtc_readtime(&pdev->dev, &tm);
 	if (ret) {
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
