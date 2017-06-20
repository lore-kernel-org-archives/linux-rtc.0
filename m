Return-Path: <rtc-linux+bncBDKNBMNKRMJRBQ6ZUPFAKGQENPWTASY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x230.google.com (mail-wr0-x230.google.com. [2a00:1450:400c:c0c::230])
        by gmr-mx.google.com with ESMTPS id 140si3846457wmr.2.2017.06.20.02.37.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:07 -0700 (PDT)
Received: by mail-wr0-x230.google.com with SMTP id 77so88340372wrb.1
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:07 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 05/51] rtc: 88pm860x: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:13 +0200
Message-Id: <1497951359-13334-6-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-88pm860x.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
index 19e53b3..0d20ede 100644
--- a/drivers/rtc/rtc-88pm860x.c
+++ b/drivers/rtc/rtc-88pm860x.c
@@ -86,8 +86,8 @@ static int pm860x_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 static void rtc_next_alarm_time(struct rtc_time *next, struct rtc_time *now,
 				struct rtc_time *alrm)
 {
-	unsigned long next_time;
-	unsigned long now_time;
+	unsigned long long next_time;
+	unsigned long long now_time;
 
 	next->tm_year = now->tm_year;
 	next->tm_mon = now->tm_mon;
@@ -96,13 +96,13 @@ static void rtc_next_alarm_time(struct rtc_time *next, struct rtc_time *now,
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
 
@@ -110,7 +110,7 @@ static int pm860x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pm860x_rtc_info *info = dev_get_drvdata(dev);
 	unsigned char buf[8];
-	unsigned long ticks, base, data;
+	unsigned long long ticks, base, data;
 
 	pm860x_page_bulk_read(info->i2c, REG0_ADDR, 8, buf);
 	dev_dbg(info->dev, "%x-%x-%x-%x-%x-%x-%x-%x\n", buf[0], buf[1],
@@ -121,10 +121,10 @@ static int pm860x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	pm860x_bulk_read(info->i2c, PM8607_RTC_COUNTER1, 4, buf);
 	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
 	ticks = base + data;
-	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
+	dev_dbg(info->dev, "get base:0x%llx, RO count:0x%llx, ticks:0x%llx\n",
 		base, data, ticks);
 
-	rtc_time_to_tm(ticks, tm);
+	rtc_time64_to_tm(ticks, tm);
 
 	return 0;
 }
@@ -133,7 +133,7 @@ static int pm860x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pm860x_rtc_info *info = dev_get_drvdata(dev);
 	unsigned char buf[4];
-	unsigned long ticks, base, data;
+	unsigned long long ticks, base, data;
 
 	if ((tm->tm_year < 70) || (tm->tm_year > 138)) {
 		dev_dbg(info->dev, "Set time %d out of range. "
@@ -141,13 +141,13 @@ static int pm860x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 			1900 + tm->tm_year);
 		return -EINVAL;
 	}
-	rtc_tm_to_time(tm, &ticks);
+	ticks = rtc_tm_to_time64(tm);
 
 	/* load 32-bit read-only counter */
 	pm860x_bulk_read(info->i2c, PM8607_RTC_COUNTER1, 4, buf);
 	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
 	base = ticks - data;
-	dev_dbg(info->dev, "set base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
+	dev_dbg(info->dev, "set base:0x%llx, RO count:0x%llx, ticks:0x%llx\n",
 		base, data, ticks);
 
 	pm860x_page_reg_write(info->i2c, REG0_DATA, (base >> 24) & 0xFF);
@@ -164,7 +164,7 @@ static int pm860x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct pm860x_rtc_info *info = dev_get_drvdata(dev);
 	unsigned char buf[8];
-	unsigned long ticks, base, data;
+	unsigned long long ticks, base, data;
 	int ret;
 
 	pm860x_page_bulk_read(info->i2c, REG0_ADDR, 8, buf);
@@ -175,10 +175,10 @@ static int pm860x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	pm860x_bulk_read(info->i2c, PM8607_RTC_EXPIRE1, 4, buf);
 	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
 	ticks = base + data;
-	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
+	dev_dbg(info->dev, "get base:0x%llx, RO count:0x%llx, ticks:0x%llx\n",
 		base, data, ticks);
 
-	rtc_time_to_tm(ticks, &alrm->time);
+	rtc_time64_to_tm(ticks, &alrm->time);
 	ret = pm860x_reg_read(info->i2c, PM8607_RTC1);
 	alrm->enabled = (ret & ALARM_EN) ? 1 : 0;
 	alrm->pending = (ret & (ALARM | ALARM_WAKEUP)) ? 1 : 0;
@@ -189,7 +189,7 @@ static int pm860x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct pm860x_rtc_info *info = dev_get_drvdata(dev);
 	struct rtc_time now_tm, alarm_tm;
-	unsigned long ticks, base, data;
+	unsigned long long ticks, base, data;
 	unsigned char buf[8];
 	int mask;
 
@@ -204,13 +204,13 @@ static int pm860x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	pm860x_bulk_read(info->i2c, PM8607_RTC_COUNTER1, 4, buf);
 	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
 	ticks = base + data;
-	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
+	dev_dbg(info->dev, "get base:0x%llx, RO count:0x%llx, ticks:0x%llx\n",
 		base, data, ticks);
 
-	rtc_time_to_tm(ticks, &now_tm);
+	rtc_time64_to_tm(ticks, &now_tm);
 	rtc_next_alarm_time(&alarm_tm, &now_tm, &alrm->time);
 	/* get new ticks for alarm in 24 hours */
-	rtc_tm_to_time(&alarm_tm, &ticks);
+	ticks = rtc_tm_to_time64(&alarm_tm);
 	data = ticks - base;
 
 	buf[0] = data & 0xff;
@@ -314,7 +314,7 @@ static int pm860x_rtc_probe(struct platform_device *pdev)
 	struct pm860x_rtc_pdata *pdata = NULL;
 	struct pm860x_rtc_info *info;
 	struct rtc_time tm;
-	unsigned long ticks = 0;
+	unsigned long long ticks = 0;
 	int ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -367,7 +367,7 @@ static int pm860x_rtc_probe(struct platform_device *pdev)
 			return ret;
 		}
 	}
-	rtc_tm_to_time(&tm, &ticks);
+	ticks = rtc_tm_to_time64(&tm);
 	if (pm860x_rtc_dt_init(pdev, info)) {
 		if (pdata && pdata->sync) {
 			pdata->sync(ticks);
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
