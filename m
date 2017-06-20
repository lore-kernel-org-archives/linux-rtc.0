Return-Path: <rtc-linux+bncBDKNBMNKRMJRBR6ZUPFAKGQEAXP2DPQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x22f.google.com (mail-wr0-x22f.google.com. [2a00:1450:400c:c0c::22f])
        by gmr-mx.google.com with ESMTPS id m189si2689823wma.6.2017.06.20.02.37.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:10 -0700 (PDT)
Received: by mail-wr0-x22f.google.com with SMTP id y25so49021371wrd.2
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:10 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 07/51] rtc: ab8500: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:15 +0200
Message-Id: <1497951359-13334-8-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Linus Walleij <linus.walleij@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/rtc/rtc-ab8500.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 24a0af6..ac131bd 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -71,7 +71,7 @@
 /* Calculate the seconds from 1970 to 01-01-2000 00:00:00 */
 static unsigned long get_elapsed_seconds(int year)
 {
-	unsigned long secs;
+	unsigned long long secs;
 	struct rtc_time tm = {
 		.tm_year = year - 1900,
 		.tm_mday = 1,
@@ -81,7 +81,7 @@ static unsigned long get_elapsed_seconds(int year)
 	 * This function calculates secs from 1970 and not from
 	 * 1900, even if we supply the offset from year 1900.
 	 */
-	rtc_tm_to_time(&tm, &secs);
+	secs = rtc_tm_to_time64(&tm);
 	return secs;
 }
 
@@ -89,7 +89,7 @@ static int ab8500_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long timeout = jiffies + HZ;
 	int retval, i;
-	unsigned long mins, secs;
+	unsigned long long mins, secs;
 	unsigned char buf[ARRAY_SIZE(ab8500_rtc_time_regs)];
 	u8 value;
 
@@ -130,7 +130,7 @@ static int ab8500_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	/* Add back the initially subtracted number of seconds */
 	secs += get_elapsed_seconds(AB8500_RTC_EPOCH);
 
-	rtc_time_to_tm(secs, tm);
+	rtc_time64_to_tm(secs, tm);
 	return rtc_valid_tm(tm);
 }
 
@@ -138,7 +138,7 @@ static int ab8500_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	int retval, i;
 	unsigned char buf[ARRAY_SIZE(ab8500_rtc_time_regs)];
-	unsigned long no_secs, no_mins, secs = 0;
+	unsigned long long no_secs, no_mins, secs = 0;
 
 	if (tm->tm_year < (AB8500_RTC_EPOCH - 1900)) {
 		dev_dbg(dev, "year should be equal to or greater than %d\n",
@@ -147,7 +147,7 @@ static int ab8500_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	}
 
 	/* Get the number of seconds since 1970 */
-	rtc_tm_to_time(tm, &secs);
+	secs = rtc_tm_to_time64(tm);
 
 	/*
 	 * Convert it to the number of seconds since 01-01-2000 00:00:00, since
@@ -185,7 +185,7 @@ static int ab8500_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	int retval, i;
 	u8 rtc_ctrl, value;
 	unsigned char buf[ARRAY_SIZE(ab8500_rtc_alarm_regs)];
-	unsigned long secs, mins;
+	unsigned long long secs, mins;
 
 	/* Check if the alarm is enabled or not */
 	retval = abx500_get_register_interruptible(dev, AB8500_RTC,
@@ -214,7 +214,7 @@ static int ab8500_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	/* Add back the initially subtracted number of seconds */
 	secs += get_elapsed_seconds(AB8500_RTC_EPOCH);
 
-	rtc_time_to_tm(secs, &alarm->time);
+	rtc_time64_to_tm(secs, &alarm->time);
 
 	return rtc_valid_tm(&alarm->time);
 }
@@ -230,7 +230,7 @@ static int ab8500_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	int retval, i;
 	unsigned char buf[ARRAY_SIZE(ab8500_rtc_alarm_regs)];
-	unsigned long mins, secs = 0, cursec = 0;
+	unsigned long long mins, secs = 0, cursec = 0;
 	struct rtc_time curtm;
 
 	if (alarm->time.tm_year < (AB8500_RTC_EPOCH - 1900)) {
@@ -240,7 +240,7 @@ static int ab8500_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	}
 
 	/* Get the number of seconds since 1970 */
-	rtc_tm_to_time(&alarm->time, &secs);
+	secs = rtc_tm_to_time64(&alarm->time);
 
 	/*
 	 * Check whether alarm is set less than 1min.
@@ -248,7 +248,7 @@ static int ab8500_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	 * return -EINVAL, so UIE EMUL can take it up, incase of UIE_ON
 	 */
 	ab8500_rtc_read_time(dev, &curtm); /* Read current time */
-	rtc_tm_to_time(&curtm, &cursec);
+	cursec = rtc_tm_to_time64(&curtm);
 	if ((secs - cursec) < 59) {
 		dev_dbg(dev, "Alarm less than 1 minute not supported\r\n");
 		return -EINVAL;
@@ -281,7 +281,7 @@ static int ab8540_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	int retval, i;
 	unsigned char buf[ARRAY_SIZE(ab8540_rtc_alarm_regs)];
-	unsigned long mins, secs = 0;
+	unsigned long long mins, secs = 0;
 
 	if (alarm->time.tm_year < (AB8500_RTC_EPOCH - 1900)) {
 		dev_dbg(dev, "year should be equal to or greater than %d\n",
@@ -290,7 +290,7 @@ static int ab8540_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	}
 
 	/* Get the number of seconds since 1970 */
-	rtc_tm_to_time(&alarm->time, &secs);
+	secs = rtc_tm_to_time64(&alarm->time);
 
 	/*
 	 * Convert it to the number of seconds since 01-01-2000 00:00:00
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
