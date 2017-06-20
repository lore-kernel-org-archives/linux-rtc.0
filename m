Return-Path: <rtc-linux+bncBDKNBMNKRMJRBD62UPFAKGQECOLXOTI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com. [2a00:1450:400c:c09::22b])
        by gmr-mx.google.com with ESMTPS id y3si713742wmc.1.2017.06.20.02.38.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:23 -0700 (PDT)
Received: by mail-wm0-x22b.google.com with SMTP id d73so14630641wma.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:23 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Barry Song <baohua@kernel.org>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 39/51] rtc: sirfsoc: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:47 +0200
Message-Id: <1497951359-13334-40-git-send-email-benjamin.gaignard@linaro.org>
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
CC: Barry Song <baohua@kernel.org>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/rtc/rtc-sirfsoc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-sirfsoc.c b/drivers/rtc/rtc-sirfsoc.c
index 7367f61..972ede9 100644
--- a/drivers/rtc/rtc-sirfsoc.c
+++ b/drivers/rtc/rtc-sirfsoc.c
@@ -91,11 +91,11 @@ static int sirfsoc_rtc_read_alarm(struct device *dev,
 	 */
 	/* if alarm is in next overflow cycle */
 	if (rtc_count > rtc_alarm)
-		rtc_time_to_tm((rtcdrv->overflow_rtc + 1)
-				<< (BITS_PER_LONG - RTC_SHIFT)
-				| rtc_alarm >> RTC_SHIFT, &(alrm->time));
+		rtc_time64_to_tm((rtcdrv->overflow_rtc + 1)
+				  << (BITS_PER_LONG - RTC_SHIFT)
+				  | rtc_alarm >> RTC_SHIFT, &(alrm->time));
 	else
-		rtc_time_to_tm(rtcdrv->overflow_rtc
+		rtc_time64_to_tm(rtcdrv->overflow_rtc
 				<< (BITS_PER_LONG - RTC_SHIFT)
 				| rtc_alarm >> RTC_SHIFT, &(alrm->time));
 	if (sirfsoc_rtc_readl(rtcdrv, RTC_STATUS) & SIRFSOC_RTC_AL0E)
@@ -109,12 +109,12 @@ static int sirfsoc_rtc_read_alarm(struct device *dev,
 static int sirfsoc_rtc_set_alarm(struct device *dev,
 		struct rtc_wkalrm *alrm)
 {
-	unsigned long rtc_status_reg, rtc_alarm;
+	unsigned long long rtc_status_reg, rtc_alarm;
 	struct sirfsoc_rtc_drv *rtcdrv;
 	rtcdrv = dev_get_drvdata(dev);
 
 	if (alrm->enabled) {
-		rtc_tm_to_time(&(alrm->time), &rtc_alarm);
+		rtc_alarm = rtc_tm_to_time64(&alrm->time);
 
 		spin_lock_irq(&rtcdrv->lock);
 
@@ -182,7 +182,7 @@ static int sirfsoc_rtc_read_time(struct device *dev,
 		cpu_relax();
 	} while (tmp_rtc != sirfsoc_rtc_readl(rtcdrv, RTC_CN));
 
-	rtc_time_to_tm(rtcdrv->overflow_rtc << (BITS_PER_LONG - RTC_SHIFT) |
+	rtc_time64_to_tm(rtcdrv->overflow_rtc << (BITS_PER_LONG - RTC_SHIFT) |
 					tmp_rtc >> RTC_SHIFT, tm);
 	return 0;
 }
@@ -190,11 +190,11 @@ static int sirfsoc_rtc_read_time(struct device *dev,
 static int sirfsoc_rtc_set_time(struct device *dev,
 		struct rtc_time *tm)
 {
-	unsigned long rtc_time;
+	unsigned long long rtc_time;
 	struct sirfsoc_rtc_drv *rtcdrv;
 	rtcdrv = dev_get_drvdata(dev);
 
-	rtc_tm_to_time(tm, &rtc_time);
+	rtc_time = rtc_tm_to_time64(tm);
 
 	rtcdrv->overflow_rtc = rtc_time >> (BITS_PER_LONG - RTC_SHIFT);
 
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
