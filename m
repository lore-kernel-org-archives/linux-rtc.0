Return-Path: <rtc-linux+bncBDKNBMNKRMJRBBO2UPFAKGQEOMDFNIY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x22e.google.com (mail-wr0-x22e.google.com. [2a00:1450:400c:c0c::22e])
        by gmr-mx.google.com with ESMTPS id f136si2017996wmf.6.2017.06.20.02.38.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:12 -0700 (PDT)
Received: by mail-wr0-x22e.google.com with SMTP id c11so32926708wrc.3
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:12 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 33/51] rtc: pl030: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:41 +0200
Message-Id: <1497951359-13334-34-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-pl030.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index f85a1a9..c917051 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -39,24 +39,26 @@ static int pl030_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct pl030_rtc *rtc = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(rtc->base + RTC_MR), &alrm->time);
+	rtc_time64_to_tm(readl(rtc->base + RTC_MR), &alrm->time);
 	return 0;
 }
 
 static int pl030_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct pl030_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long time;
+	unsigned long long time;
 	int ret;
 
 	/*
 	 * At the moment, we can only deal with non-wildcarded alarm times.
 	 */
 	ret = rtc_valid_tm(&alrm->time);
-	if (ret == 0)
-		ret = rtc_tm_to_time(&alrm->time, &time);
-	if (ret == 0)
-		writel(time, rtc->base + RTC_MR);
+	if (ret)
+		return ret;
+
+	time = rtc_tm_to_time64(&alrm->time);
+	writel(time, rtc->base + RTC_MR);
+
 	return ret;
 }
 
@@ -64,7 +66,7 @@ static int pl030_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pl030_rtc *rtc = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(rtc->base + RTC_DR), tm);
+	rtc_time64_to_tm(readl(rtc->base + RTC_DR), tm);
 
 	return 0;
 }
@@ -81,13 +83,11 @@ static int pl030_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pl030_rtc *rtc = dev_get_drvdata(dev);
 	unsigned long time;
-	int ret;
 
-	ret = rtc_tm_to_time(tm, &time);
-	if (ret == 0)
-		writel(time + 1, rtc->base + RTC_LR);
+	time = rtc_tm_to_time64(tm);
+	writel(time + 1, rtc->base + RTC_LR);
 
-	return ret;
+	return 0;
 }
 
 static const struct rtc_class_ops pl030_ops = {
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
