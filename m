Return-Path: <rtc-linux+bncBDKNBMNKRMJRBIO2UPFAKGQE6QMBB5I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com. [2a00:1450:400c:c09::232])
        by gmr-mx.google.com with ESMTPS id p191si210061wmg.3.2017.06.20.02.38.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:41 -0700 (PDT)
Received: by mail-wm0-x232.google.com with SMTP id m125so16117479wmm.1
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:41 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 50/51] rtc: xgene stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:58 +0200
Message-Id: <1497951359-13334-51-git-send-email-benjamin.gaignard@linaro.org>
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

For the same reasons use set_mmss64 callback instead of set_mmss

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-xgene.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index 65b432a..c62b5b6 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -58,11 +58,11 @@ static int xgene_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(pdata->csr_base + RTC_CCVR), tm);
+	rtc_time64_to_tm(readl(pdata->csr_base + RTC_CCVR), tm);
 	return rtc_valid_tm(tm);
 }
 
-static int xgene_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int xgene_rtc_set_mmss64(struct device *dev, time64_t secs)
 {
 	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
 
@@ -80,7 +80,7 @@ static int xgene_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(pdata->alarm_time, &alrm->time);
+	rtc_time64_to_tm(pdata->alarm_time, &alrm->time);
 	alrm->enabled = readl(pdata->csr_base + RTC_CCR) & RTC_CCR_IE;
 
 	return 0;
@@ -108,10 +108,10 @@ static int xgene_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
 	unsigned long rtc_time;
-	unsigned long alarm_time;
+	unsigned long long alarm_time;
 
 	rtc_time = readl(pdata->csr_base + RTC_CCVR);
-	rtc_tm_to_time(&alrm->time, &alarm_time);
+	alarm_time = rtc_tm_to_time64(&alrm->time);
 
 	pdata->alarm_time = alarm_time;
 	writel((u32) pdata->alarm_time, pdata->csr_base + RTC_CMR);
@@ -123,7 +123,7 @@ static int xgene_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static const struct rtc_class_ops xgene_rtc_ops = {
 	.read_time	= xgene_rtc_read_time,
-	.set_mmss	= xgene_rtc_set_mmss,
+	.set_mmss64	= xgene_rtc_set_mmss64,
 	.read_alarm	= xgene_rtc_read_alarm,
 	.set_alarm	= xgene_rtc_set_alarm,
 	.alarm_irq_enable = xgene_rtc_alarm_irq_enable,
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
