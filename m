Return-Path: <rtc-linux+bncBDKNBMNKRMJRB66ZUPFAKGQEQO5ZI3Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x22a.google.com (mail-wr0-x22a.google.com. [2a00:1450:400c:c0c::22a])
        by gmr-mx.google.com with ESMTPS id w193si3485135wmf.3.2017.06.20.02.38.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:03 -0700 (PDT)
Received: by mail-wr0-x22a.google.com with SMTP id r103so88501981wrb.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:03 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 28/51] rtc: jz4740: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:36 +0200
Message-Id: <1497951359-13334-29-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-jz4740.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 64989af..7ce1f43 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -171,12 +171,12 @@ static int jz4740_rtc_read_time(struct device *dev, struct rtc_time *time)
 	if (timeout == 0)
 		return -EIO;
 
-	rtc_time_to_tm(secs, time);
+	rtc_time64_to_tm((u64)secs, time);
 
 	return rtc_valid_tm(time);
 }
 
-static int jz4740_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int jz4740_rtc_set_mmss64(struct device *dev, time64_t secs)
 {
 	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
 
@@ -196,7 +196,7 @@ static int jz4740_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	alrm->enabled = !!(ctrl & JZ_RTC_CTRL_AE);
 	alrm->pending = !!(ctrl & JZ_RTC_CTRL_AF);
 
-	rtc_time_to_tm(secs, &alrm->time);
+	rtc_time64_to_tm((u64)secs, &alrm->time);
 
 	return rtc_valid_tm(&alrm->time);
 }
@@ -205,9 +205,9 @@ static int jz4740_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	int ret;
 	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long secs;
+	unsigned long long secs;
 
-	rtc_tm_to_time(&alrm->time, &secs);
+	secs = rtc_tm_to_time64(&alrm->time);
 
 	ret = jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC_ALARM, secs);
 	if (!ret)
@@ -225,7 +225,7 @@ static int jz4740_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 
 static const struct rtc_class_ops jz4740_rtc_ops = {
 	.read_time	= jz4740_rtc_read_time,
-	.set_mmss	= jz4740_rtc_set_mmss,
+	.set_mmss64	= jz4740_rtc_set_mmss64,
 	.read_alarm	= jz4740_rtc_read_alarm,
 	.set_alarm	= jz4740_rtc_set_alarm,
 	.alarm_irq_enable = jz4740_rtc_alarm_irq_enable,
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
