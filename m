Return-Path: <rtc-linux+bncBDKNBMNKRMJRBQOZUPFAKGQEET5JH7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com. [2a00:1450:400c:c09::22f])
        by gmr-mx.google.com with ESMTPS id j75si2789114wmj.1.2017.06.20.02.37.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:05 -0700 (PDT)
Received: by mail-wm0-x22f.google.com with SMTP id d64so23687526wmf.1
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:05 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 04/51] rtc: 88pm80x: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:12 +0200
Message-Id: <1497951359-13334-5-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-88pm80x.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index 466bf7f..1898e9b 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -90,8 +90,8 @@ static int pm80x_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 static void rtc_next_alarm_time(struct rtc_time *next, struct rtc_time *now,
 				struct rtc_time *alrm)
 {
-	unsigned long next_time;
-	unsigned long now_time;
+	unsigned long long next_time;
+	unsigned long long now_time;
 
 	next->tm_year = now->tm_year;
 	next->tm_mon = now->tm_mon;
@@ -100,13 +100,13 @@ static void rtc_next_alarm_time(struct rtc_time *next, struct rtc_time *now,
 	next->tm_min = alrm->tm_min;
 	next->tm_sec = alrm->tm_sec;
 
-	rtc_tm_to_time(now, &now_time);
-	rtc_tm_to_time(next, &next_time);
+	now_time = rtc_tm_to_time64(now);
+	next_time = rtc_tm_to_time64(next);
 
 	if (next_time < now_time) {
 		/* Advance one day */
 		next_time += 60 * 60 * 24;
-		rtc_time_to_tm(next_time, next);
+		rtc_time64_to_tm(next_time, next);
 	}
 }
 
@@ -114,7 +114,7 @@ static int pm80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
 	unsigned char buf[4];
-	unsigned long ticks, base, data;
+	unsigned long long ticks, base, data;
 	regmap_raw_read(info->map, PM800_RTC_EXPIRE2_1, buf, 4);
 	base = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
 	dev_dbg(info->dev, "%x-%x-%x-%x\n", buf[0], buf[1], buf[2], buf[3]);
@@ -123,9 +123,9 @@ static int pm80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	regmap_raw_read(info->map, PM800_RTC_COUNTER1, buf, 4);
 	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
 	ticks = base + data;
-	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
+	dev_dbg(info->dev, "get base:0x%llx, RO count:0x%llx, ticks:0x%llx\n",
 		base, data, ticks);
-	rtc_time_to_tm(ticks, tm);
+	rtc_time64_to_tm(ticks, tm);
 	return 0;
 }
 
@@ -133,20 +133,20 @@ static int pm80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
 	unsigned char buf[4];
-	unsigned long ticks, base, data;
+	unsigned long long ticks, base, data;
 	if ((tm->tm_year < 70) || (tm->tm_year > 138)) {
 		dev_dbg(info->dev,
 			"Set time %d out of range. Please set time between 1970 to 2038.\n",
 			1900 + tm->tm_year);
 		return -EINVAL;
 	}
-	rtc_tm_to_time(tm, &ticks);
+	ticks = rtc_tm_to_time64(tm);
 
 	/* load 32-bit read-only counter */
 	regmap_raw_read(info->map, PM800_RTC_COUNTER1, buf, 4);
 	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
 	base = ticks - data;
-	dev_dbg(info->dev, "set base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
+	dev_dbg(info->dev, "set base:0x%llx, RO count:0x%llx, ticks:0x%llx\n",
 		base, data, ticks);
 	buf[0] = base & 0xFF;
 	buf[1] = (base >> 8) & 0xFF;
@@ -161,7 +161,7 @@ static int pm80x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
 	unsigned char buf[4];
-	unsigned long ticks, base, data;
+	unsigned long long ticks, base, data;
 	int ret;
 
 	regmap_raw_read(info->map, PM800_RTC_EXPIRE2_1, buf, 4);
@@ -171,10 +171,10 @@ static int pm80x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	regmap_raw_read(info->map, PM800_RTC_EXPIRE1_1, buf, 4);
 	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
 	ticks = base + data;
-	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
+	dev_dbg(info->dev, "get base:0x%llx, RO count:0x%llx, ticks:0x%llx\n",
 		base, data, ticks);
 
-	rtc_time_to_tm(ticks, &alrm->time);
+	rtc_time64_to_tm(ticks, &alrm->time);
 	regmap_read(info->map, PM800_RTC_CONTROL, &ret);
 	alrm->enabled = (ret & PM800_ALARM1_EN) ? 1 : 0;
 	alrm->pending = (ret & (PM800_ALARM | PM800_ALARM_WAKEUP)) ? 1 : 0;
@@ -185,7 +185,7 @@ static int pm80x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
 	struct rtc_time now_tm, alarm_tm;
-	unsigned long ticks, base, data;
+	unsigned long long ticks, base, data;
 	unsigned char buf[4];
 	int mask;
 
@@ -199,15 +199,15 @@ static int pm80x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	regmap_raw_read(info->map, PM800_RTC_COUNTER1, buf, 4);
 	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
 	ticks = base + data;
-	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
+	dev_dbg(info->dev, "get base:0x%llx, RO count:0x%llx, ticks:0x%llx\n",
 		base, data, ticks);
 
-	rtc_time_to_tm(ticks, &now_tm);
-	dev_dbg(info->dev, "%s, now time : %lu\n", __func__, ticks);
+	rtc_time64_to_tm(ticks, &now_tm);
+	dev_dbg(info->dev, "%s, now time : %llu\n", __func__, ticks);
 	rtc_next_alarm_time(&alarm_tm, &now_tm, &alrm->time);
 	/* get new ticks for alarm in 24 hours */
-	rtc_tm_to_time(&alarm_tm, &ticks);
-	dev_dbg(info->dev, "%s, alarm time: %lu\n", __func__, ticks);
+	ticks = rtc_tm_to_time64(&alarm_tm);
+	dev_dbg(info->dev, "%s, alarm time: %llu\n", __func__, ticks);
 	data = ticks - base;
 
 	buf[0] = data & 0xff;
@@ -255,7 +255,7 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
 	struct pm80x_rtc_info *info;
 	struct device_node *node = pdev->dev.of_node;
 	struct rtc_time tm;
-	unsigned long ticks = 0;
+	unsigned long long ticks = 0;
 	int ret;
 
 	if (!pdata && !node) {
@@ -320,7 +320,7 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
 			goto out_rtc;
 		}
 	}
-	rtc_tm_to_time(&tm, &ticks);
+	ticks = rtc_tm_to_time64(&tm);
 
 	info->rtc_dev = devm_rtc_device_register(&pdev->dev, "88pm80x-rtc",
 					    &pm80x_rtc_ops, THIS_MODULE);
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
