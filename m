Return-Path: <rtc-linux+bncBDKNBMNKRMJRBB62UPFAKGQE7RVAA2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com. [2a00:1450:400c:c09::22f])
        by gmr-mx.google.com with ESMTPS id w193si3483598wmf.3.2017.06.20.02.38.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:15 -0700 (PDT)
Received: by mail-wm0-x22f.google.com with SMTP id d73so14472917wma.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:15 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 34/51] rtc: pl031: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:42 +0200
Message-Id: <1497951359-13334-35-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-pl031.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index e1687e1..07f72b3 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -127,11 +127,11 @@ static int pl031_stv2_tm_to_time(struct device *dev,
 		return -EINVAL;
 	} else if (wday == -1) {
 		/* wday is not provided, calculate it here */
-		unsigned long time;
+		unsigned long long time;
 		struct rtc_time calc_tm;
 
-		rtc_tm_to_time(tm, &time);
-		rtc_time_to_tm(time, &calc_tm);
+		time = rtc_tm_to_time64(tm);
+		rtc_time64_to_tm(time, &calc_tm);
 		wday = calc_tm.tm_wday;
 	}
 
@@ -252,30 +252,27 @@ static int pl031_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(ldata->base + RTC_DR), tm);
+	rtc_time64_to_tm(readl(ldata->base + RTC_DR), tm);
 
 	return 0;
 }
 
 static int pl031_set_time(struct device *dev, struct rtc_time *tm)
 {
-	unsigned long time;
+	unsigned long long time;
 	struct pl031_local *ldata = dev_get_drvdata(dev);
-	int ret;
-
-	ret = rtc_tm_to_time(tm, &time);
 
-	if (ret == 0)
-		writel(time, ldata->base + RTC_LR);
+	time = rtc_tm_to_time64(tm);
+	writel(time, ldata->base + RTC_LR);
 
-	return ret;
+	return 0;
 }
 
 static int pl031_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(ldata->base + RTC_MR), &alarm->time);
+	rtc_time64_to_tm(readl(ldata->base + RTC_MR), &alarm->time);
 
 	alarm->pending = readl(ldata->base + RTC_RIS) & RTC_BIT_AI;
 	alarm->enabled = readl(ldata->base + RTC_IMSC) & RTC_BIT_AI;
@@ -286,17 +283,15 @@ static int pl031_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 static int pl031_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
-	unsigned long time;
+	unsigned long long time;
 	int ret;
 
 	/* At the moment, we can only deal with non-wildcarded alarm times. */
 	ret = rtc_valid_tm(&alarm->time);
 	if (ret == 0) {
-		ret = rtc_tm_to_time(&alarm->time, &time);
-		if (ret == 0) {
-			writel(time, ldata->base + RTC_MR);
-			pl031_alarm_irq_enable(dev, alarm->enabled);
-		}
+		time = rtc_tm_to_time64(&alarm->time);
+		writel(time, ldata->base + RTC_MR);
+		pl031_alarm_irq_enable(dev, alarm->enabled);
 	}
 
 	return ret;
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
