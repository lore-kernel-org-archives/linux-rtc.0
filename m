Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752396AbdFPT2T (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 16 Jun 2017 15:28:19 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/6] rtc: s3c: Minor white-space cleanups
Date: Fri, 16 Jun 2017 21:28:03 +0200
Message-Id: <20170616192807.10347-2-krzk@kernel.org>
In-Reply-To: <20170616192807.10347-1-krzk@kernel.org>
References: <20170616192807.10347-1-krzk@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Minor cleanups to make the code easier to read. No functional changes.
1. Remove one space before labels as this is nowadays mostly preferred.
2. Fix indentation of arguments in function calls.
3. Split structure member declaration.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/rtc/rtc-s3c.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index c5aa7a35d07f..2b503dab7957 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -49,7 +49,8 @@ struct s3c_rtc {
 	spinlock_t pie_lock;
 	spinlock_t alarm_clk_lock;
 
-	int ticnt_save, ticnt_en_save;
+	int ticnt_save;
+	int ticnt_en_save;
 	bool wake_en;
 };
 
@@ -169,7 +170,7 @@ static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 
 	s3c_rtc_enable_clk(info);
 
- retry_get_time:
+retry_get_time:
 	rtc_tm->tm_min  = readb(info->base + S3C2410_RTCMIN);
 	rtc_tm->tm_hour = readb(info->base + S3C2410_RTCHOUR);
 	rtc_tm->tm_mday = readb(info->base + S3C2410_RTCDATE);
@@ -199,8 +200,8 @@ static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 	rtc_tm->tm_year += 100;
 
 	dev_dbg(dev, "read time %04d.%02d.%02d %02d:%02d:%02d\n",
-		 1900 + rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
-		 rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
+		1900 + rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
+		rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
 
 	rtc_tm->tm_mon -= 1;
 
@@ -213,8 +214,8 @@ static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
 	int year = tm->tm_year - 100;
 
 	dev_dbg(dev, "set time %04d.%02d.%02d %02d:%02d:%02d\n",
-		 1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		 tm->tm_hour, tm->tm_min, tm->tm_sec);
+		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec);
 
 	/* we get around y2k by simply not supporting it */
 
@@ -259,9 +260,9 @@ static int s3c_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	alrm->enabled = (alm_en & S3C2410_RTCALM_ALMEN) ? 1 : 0;
 
 	dev_dbg(dev, "read alarm %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		 alm_en,
-		 1900 + alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
-		 alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
+		alm_en,
+		1900 + alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
+		alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
 
 	/* decode the alarm enable field */
 	if (alm_en & S3C2410_RTCALM_SECEN)
@@ -295,9 +296,9 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	int year = tm->tm_year - 100;
 
 	dev_dbg(dev, "s3c_rtc_setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		 alrm->enabled,
-		 1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		 tm->tm_hour, tm->tm_min, tm->tm_sec);
+		alrm->enabled,
+		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec);
 
 	s3c_rtc_enable_clk(info);
 
@@ -378,8 +379,7 @@ static void s3c24xx_rtc_enable(struct s3c_rtc *info)
 		dev_info(info->dev, "rtc disabled, re-enabling\n");
 
 		tmp = readw(info->base + S3C2410_RTCCON);
-		writew(tmp | S3C2410_RTCCON_RTCEN,
-			info->base + S3C2410_RTCCON);
+		writew(tmp | S3C2410_RTCCON_RTCEN, info->base + S3C2410_RTCCON);
 	}
 
 	if (con & S3C2410_RTCCON_CNTSEL) {
@@ -387,7 +387,7 @@ static void s3c24xx_rtc_enable(struct s3c_rtc *info)
 
 		tmp = readw(info->base + S3C2410_RTCCON);
 		writew(tmp & ~S3C2410_RTCCON_CNTSEL,
-			info->base + S3C2410_RTCCON);
+		       info->base + S3C2410_RTCCON);
 	}
 
 	if (con & S3C2410_RTCCON_CLKRST) {
@@ -395,7 +395,7 @@ static void s3c24xx_rtc_enable(struct s3c_rtc *info)
 
 		tmp = readw(info->base + S3C2410_RTCCON);
 		writew(tmp & ~S3C2410_RTCCON_CLKRST,
-			info->base + S3C2410_RTCCON);
+		       info->base + S3C2410_RTCCON);
 	}
 }
 
@@ -481,7 +481,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 	}
 
 	dev_dbg(&pdev->dev, "s3c2410_rtc: tick irq %d, alarm irq %d\n",
-		 info->irq_tick, info->irq_alarm);
+		info->irq_tick, info->irq_alarm);
 
 	/* get the memory region */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -520,7 +520,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 		info->data->enable(info);
 
 	dev_dbg(&pdev->dev, "s3c2410_rtc: RTCCON=%02x\n",
-		 readw(info->base + S3C2410_RTCCON));
+		readw(info->base + S3C2410_RTCCON));
 
 	device_init_wakeup(&pdev->dev, 1);
 
@@ -540,7 +540,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 
 	/* register RTC and exit */
 	info->rtc = devm_rtc_device_register(&pdev->dev, "s3c", &s3c_rtcops,
-				  THIS_MODULE);
+					     THIS_MODULE);
 	if (IS_ERR(info->rtc)) {
 		dev_err(&pdev->dev, "cannot attach rtc\n");
 		ret = PTR_ERR(info->rtc);
@@ -548,14 +548,14 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, info->irq_alarm, s3c_rtc_alarmirq,
-			  0,  "s3c2410-rtc alarm", info);
+			       0, "s3c2410-rtc alarm", info);
 	if (ret) {
 		dev_err(&pdev->dev, "IRQ%d error %d\n", info->irq_alarm, ret);
 		goto err_nortc;
 	}
 
 	ret = devm_request_irq(&pdev->dev, info->irq_tick, s3c_rtc_tickirq,
-			  0,  "s3c2410-rtc tick", info);
+			       0, "s3c2410-rtc tick", info);
 	if (ret) {
 		dev_err(&pdev->dev, "IRQ%d error %d\n", info->irq_tick, ret);
 		goto err_nortc;
@@ -568,7 +568,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 
 	return 0;
 
- err_nortc:
+err_nortc:
 	if (info->data->disable)
 		info->data->disable(info);
 
@@ -747,8 +747,7 @@ static void s3c6410_rtc_restore_tick_cnt(struct s3c_rtc *info)
 	writel(info->ticnt_save, info->base + S3C2410_TICNT);
 	if (info->ticnt_en_save) {
 		con = readw(info->base + S3C2410_RTCCON);
-		writew(con | info->ticnt_en_save,
-				info->base + S3C2410_RTCCON);
+		writew(con | info->ticnt_en_save, info->base + S3C2410_RTCCON);
 	}
 }
 
-- 
2.9.3
