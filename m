Return-Path: <rtc-linux+bncBDKNBMNKRMJRBROZUPFAKGQE6DDHM3Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x230.google.com (mail-wr0-x230.google.com. [2a00:1450:400c:c0c::230])
        by gmr-mx.google.com with ESMTPS id 140si3846457wmr.2.2017.06.20.02.37.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:08 -0700 (PDT)
Received: by mail-wr0-x230.google.com with SMTP id 77so88340372wrb.1
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:08 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 06/51] rtc: ab-b5ze-s3: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:14 +0200
Message-Id: <1497951359-13334-7-git-send-email-benjamin.gaignard@linaro.org>
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
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 45 +++++++++++++-------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index a319bf1..ce37997 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -328,7 +328,7 @@ static int _abb5zes3_rtc_read_timer(struct device *dev,
 	struct abb5zes3_rtc_data *data = dev_get_drvdata(dev);
 	struct rtc_time rtc_tm, *alarm_tm = &alarm->time;
 	u8 regs[ABB5ZES3_TIMA_SEC_LEN + 1];
-	unsigned long rtc_secs;
+	unsigned long long rtc_secs;
 	unsigned int reg;
 	u8 timer_secs;
 	int ret;
@@ -352,9 +352,7 @@ static int _abb5zes3_rtc_read_timer(struct device *dev,
 		goto err;
 
 	/* ... convert to seconds ... */
-	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
-	if (ret)
-		goto err;
+	rtc_secs = rtc_tm_to_time64(&rtc_tm);
 
 	/* ... add remaining timer A time ... */
 	ret = sec_from_timer_a(&timer_secs, regs[1], regs[2]);
@@ -362,7 +360,7 @@ static int _abb5zes3_rtc_read_timer(struct device *dev,
 		goto err;
 
 	/* ... and convert back. */
-	rtc_time_to_tm(rtc_secs + timer_secs, alarm_tm);
+	rtc_time64_to_tm(rtc_secs + timer_secs, alarm_tm);
 
 	ret = regmap_read(data->regmap, ABB5ZES3_REG_CTRL2, &reg);
 	if (ret) {
@@ -383,7 +381,7 @@ static int _abb5zes3_rtc_read_alarm(struct device *dev,
 {
 	struct abb5zes3_rtc_data *data = dev_get_drvdata(dev);
 	struct rtc_time rtc_tm, *alarm_tm = &alarm->time;
-	unsigned long rtc_secs, alarm_secs;
+	unsigned long long rtc_secs, alarm_secs;
 	u8 regs[ABB5ZES3_ALRM_SEC_LEN];
 	unsigned int reg;
 	int ret;
@@ -414,13 +412,8 @@ static int _abb5zes3_rtc_read_alarm(struct device *dev,
 	alarm_tm->tm_year = rtc_tm.tm_year;
 	alarm_tm->tm_mon = rtc_tm.tm_mon;
 
-	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
-	if (ret)
-		goto err;
-
-	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
-	if (ret)
-		goto err;
+	rtc_secs = rtc_tm_to_time64(&rtc_tm);
+	alarm_secs = rtc_tm_to_time64(alarm_tm);
 
 	if (alarm_secs < rtc_secs) {
 		if (alarm_tm->tm_mon == 11) {
@@ -477,7 +470,7 @@ static int _abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct abb5zes3_rtc_data *data = dev_get_drvdata(dev);
 	struct rtc_time *alarm_tm = &alarm->time;
-	unsigned long rtc_secs, alarm_secs;
+	unsigned long long rtc_secs, alarm_secs;
 	u8 regs[ABB5ZES3_ALRM_SEC_LEN];
 	struct rtc_time rtc_tm;
 	int ret, enable = 1;
@@ -486,13 +479,8 @@ static int _abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	if (ret)
 		goto err;
 
-	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
-	if (ret)
-		goto err;
-
-	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
-	if (ret)
-		goto err;
+	rtc_secs = rtc_tm_to_time64(&rtc_tm);
+	alarm_secs = rtc_tm_to_time64(alarm_tm);
 
 	/* If alarm time is before current time, disable the alarm */
 	if (!alarm->enabled || alarm_secs <= rtc_secs) {
@@ -511,9 +499,7 @@ static int _abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 			rtc_tm.tm_mon += 1;
 		}
 
-		ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
-		if (ret)
-			goto err;
+		rtc_secs = rtc_tm_to_time64(&rtc_tm);
 
 		if (alarm_secs > rtc_secs) {
 			dev_err(dev, "%s: alarm maximum is one month in the "
@@ -597,7 +583,7 @@ static int abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct abb5zes3_rtc_data *data = dev_get_drvdata(dev);
 	struct rtc_time *alarm_tm = &alarm->time;
-	unsigned long rtc_secs, alarm_secs;
+	unsigned long long rtc_secs, alarm_secs;
 	struct rtc_time rtc_tm;
 	int ret;
 
@@ -606,13 +592,8 @@ static int abb5zes3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	if (ret)
 		goto err;
 
-	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
-	if (ret)
-		goto err;
-
-	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
-	if (ret)
-		goto err;
+	rtc_secs = rtc_tm_to_time64(&rtc_tm);
+	alarm_secs = rtc_tm_to_time64(alarm_tm);
 
 	/* Let's first disable both the alarm and the timer interrupts */
 	ret = _abb5zes3_rtc_update_alarm(dev, false);
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
