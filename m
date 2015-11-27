Return-Path: <rtc-linux+bncBDSYZY5FQMCBBFMN4GZAKGQEPGWEOYA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.cvg.de (mail.cvg.de. [62.153.82.30])
        by gmr-mx.google.com with ESMTPS id d185si219743wmf.0.2015.11.27.04.03.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Nov 2015 04:03:33 -0800 (PST)
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Support Opensource <support.opensource@diasemi.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [rtc-linux] [PATCH] rtc-da9063: avoid writing undefined data to rtc
Date: Fri, 27 Nov 2015 13:02:55 +0100
Message-Id: <1448625775-15531-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
Sender: rtc-linux@googlegroups.com
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

driver did

| static void da9063_tm_to_data(struct rtc_time *tm, u8 *data,
| {
|  	const struct da9063_compatible_rtc_regmap *config = rtc->config;
|
| 	data[RTC_SEC] &= ~config->rtc_count_sec_mask;
| 	data[RTC_SEC] |= tm->tm_sec & config->rtc_count_sec_mask;
| ...
| }
| ...
| static int da9063_rtc_set_time(struct device *dev, struct rtc_time *tm)
| {
|       ...
|	u8 data[RTC_DATA_LEN];
|	int ret;
|
|	da9063_tm_to_data(tm, data, rtc);

which means that some bits of stack content (in 'data[]') was masked out
and written to the RTC.

Because da9063_tm_to_data() is used only by da9063_rtc_set_time() and
da9063_rtc_set_alarm(), we can write fields directly.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 drivers/rtc/rtc-da9063.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index 00a8f7f..8d5b9be 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -191,24 +191,13 @@ static void da9063_tm_to_data(struct rtc_time *tm, u8 *data,
 {
 	const struct da9063_compatible_rtc_regmap *config = rtc->config;
 
-	data[RTC_SEC] &= ~config->rtc_count_sec_mask;
-	data[RTC_SEC] |= tm->tm_sec & config->rtc_count_sec_mask;
-
-	data[RTC_MIN] &= ~config->rtc_count_min_mask;
-	data[RTC_MIN] |= tm->tm_min & config->rtc_count_min_mask;
-
-	data[RTC_HOUR] &= ~config->rtc_count_hour_mask;
-	data[RTC_HOUR] |= tm->tm_hour & config->rtc_count_hour_mask;
-
-	data[RTC_DAY] &= ~config->rtc_count_day_mask;
-	data[RTC_DAY] |= tm->tm_mday & config->rtc_count_day_mask;
-
-	data[RTC_MONTH] &= ~config->rtc_count_month_mask;
-	data[RTC_MONTH] |= MONTHS_TO_DA9063(tm->tm_mon) &
+	data[RTC_SEC]   = tm->tm_sec & config->rtc_count_sec_mask;
+	data[RTC_MIN]   = tm->tm_min & config->rtc_count_min_mask;
+	data[RTC_HOUR]  = tm->tm_hour & config->rtc_count_hour_mask;
+	data[RTC_DAY]   = tm->tm_mday & config->rtc_count_day_mask;
+	data[RTC_MONTH] = MONTHS_TO_DA9063(tm->tm_mon) &
 				config->rtc_count_month_mask;
-
-	data[RTC_YEAR] &= ~config->rtc_count_year_mask;
-	data[RTC_YEAR] |= YEARS_TO_DA9063(tm->tm_year) &
+	data[RTC_YEAR]  = YEARS_TO_DA9063(tm->tm_year) &
 				config->rtc_count_year_mask;
 }
 
-- 
2.4.3

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
