Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:41714 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbeIXU2G (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 24 Sep 2018 16:28:06 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: armada38x: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date: Mon, 24 Sep 2018 16:25:36 +0200
Message-Id: <20180924142536.27801-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20180924142536.27801-1-alexandre.belloni@bootlin.com>
References: <20180924142536.27801-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Call the 64bit versions of rtc_time_to_tm and rtc_tm_to_time now that the
range is enforced by the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-armada38x.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index d0278ad0a7f9..9e78f004670b 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -224,7 +224,7 @@ static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	time = rtc->data->read_rtc_reg(rtc, RTC_TIME);
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-	rtc_time_to_tm(time, tm);
+	rtc_time64_to_tm(time, tm);
 
 	return 0;
 }
@@ -249,13 +249,9 @@ static void armada38x_rtc_reset(struct armada38x_rtc *rtc)
 static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	int ret = 0;
 	unsigned long time, flags;
 
-	ret = rtc_tm_to_time(tm, &time);
-
-	if (ret)
-		goto out;
+	time = rtc_tm_to_time64(tm);
 
 	if (!rtc->initialized)
 		armada38x_rtc_reset(rtc);
@@ -264,8 +260,7 @@ static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	rtc_delayed_write(time, rtc, RTC_TIME);
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int armada38x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -284,7 +279,7 @@ static int armada38x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
 	alrm->enabled = val ? 1 : 0;
-	rtc_time_to_tm(time,  &alrm->time);
+	rtc_time64_to_tm(time,  &alrm->time);
 
 	return 0;
 }
@@ -295,12 +290,8 @@ static int armada38x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	u32 reg = ALARM_REG(RTC_ALARM1, rtc->data->alarm);
 	u32 reg_irq = ALARM_REG(RTC_IRQ1_CONF, rtc->data->alarm);
 	unsigned long time, flags;
-	int ret = 0;
 
-	ret = rtc_tm_to_time(&alrm->time, &time);
-
-	if (ret)
-		goto out;
+	time = rtc_tm_to_time64(&alrm->time);
 
 	spin_lock_irqsave(&rtc->lock, flags);
 
@@ -313,8 +304,7 @@ static int armada38x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int armada38x_rtc_alarm_irq_enable(struct device *dev,
-- 
2.19.0
