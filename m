Return-Path: <rtc-linux+bncBDKNBMNKRMJRBSGZUPFAKGQEHSTNIQI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com. [2a00:1450:400c:c09::233])
        by gmr-mx.google.com with ESMTPS id o27si2850455wmi.4.2017.06.20.02.37.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:12 -0700 (PDT)
Received: by mail-wm0-x233.google.com with SMTP id x70so15789124wme.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:12 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 08/51] rtc: armada38x: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:16 +0200
Message-Id: <1497951359-13334-9-git-send-email-benjamin.gaignard@linaro.org>
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
CC: Jason Cooper <jason@lakedaemon.net>
CC: Gregory Clement <gregory.clement@free-electrons.com>
CC: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-armada38x.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 21f355c..752ebf4 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -213,13 +213,14 @@ static void armada8k_unmask_interrupt(struct armada38x_rtc *rtc)
 static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long time, flags;
+	unsigned long long time;
+	unsigned long flags;
 
 	spin_lock_irqsave(&rtc->lock, flags);
 	time = rtc->data->read_rtc_reg(rtc, RTC_TIME);
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-	rtc_time_to_tm(time, tm);
+	rtc_time64_to_tm(time, tm);
 
 	return 0;
 }
@@ -227,26 +228,23 @@ static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	int ret = 0;
-	unsigned long time, flags;
-
-	ret = rtc_tm_to_time(tm, &time);
+	unsigned long long time;
+	unsigned long flags;
 
-	if (ret)
-		goto out;
+	time = rtc_tm_to_time64(tm);
 
 	spin_lock_irqsave(&rtc->lock, flags);
 	rtc_delayed_write(time, rtc, RTC_TIME);
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int armada38x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long time, flags;
+	unsigned long long time;
+	unsigned long flags;
 	u32 reg = ALARM_REG(RTC_ALARM1, rtc->data->alarm);
 	u32 reg_irq = ALARM_REG(RTC_IRQ1_CONF, rtc->data->alarm);
 	u32 val;
@@ -259,7 +257,7 @@ static int armada38x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
 	alrm->enabled = val ? 1 : 0;
-	rtc_time_to_tm(time,  &alrm->time);
+	rtc_time64_to_tm(time,  &alrm->time);
 
 	return 0;
 }
@@ -269,13 +267,10 @@ static int armada38x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
 	u32 reg = ALARM_REG(RTC_ALARM1, rtc->data->alarm);
 	u32 reg_irq = ALARM_REG(RTC_IRQ1_CONF, rtc->data->alarm);
-	unsigned long time, flags;
-	int ret = 0;
-
-	ret = rtc_tm_to_time(&alrm->time, &time);
+	unsigned long long time;
+	unsigned long flags;
 
-	if (ret)
-		goto out;
+	time = rtc_tm_to_time64(&alrm->time);
 
 	spin_lock_irqsave(&rtc->lock, flags);
 
@@ -288,8 +283,7 @@ static int armada38x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int armada38x_rtc_alarm_irq_enable(struct device *dev,
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
