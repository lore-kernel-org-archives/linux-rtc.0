Return-Path: <rtc-linux+bncBDKNBMNKRMJRBE62UPFAKGQEWPRBM5Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x230.google.com (mail-wr0-x230.google.com. [2a00:1450:400c:c0c::230])
        by gmr-mx.google.com with ESMTPS id 140si3846457wmr.2.2017.06.20.02.38.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:27 -0700 (PDT)
Received: by mail-wr0-x230.google.com with SMTP id 77so88340372wrb.1
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:27 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 42/51] rtc: stmp3xxx: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:50 +0200
Message-Id: <1497951359-13334-43-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-stmp3xxx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index d578e40..0f7cedc 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -160,11 +160,11 @@ static int stmp3xxx_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 	if (ret)
 		return ret;
 
-	rtc_time_to_tm(readl(rtc_data->io + STMP3XXX_RTC_SECONDS), rtc_tm);
+	rtc_time64_to_tm(readl(rtc_data->io + STMP3XXX_RTC_SECONDS), rtc_tm);
 	return 0;
 }
 
-static int stmp3xxx_rtc_set_mmss(struct device *dev, unsigned long t)
+static int stmp3xxx_rtc_set_mmss64(struct device *dev, time64_t t)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
@@ -214,16 +214,16 @@ static int stmp3xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(rtc_data->io + STMP3XXX_RTC_ALARM), &alm->time);
+	rtc_time64_to_tm(readl(rtc_data->io + STMP3XXX_RTC_ALARM), &alm->time);
 	return 0;
 }
 
 static int stmp3xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
-	unsigned long t;
+	unsigned long long t;
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
-	rtc_tm_to_time(&alm->time, &t);
+	t = rtc_tm_to_time64(&alm->time);
 	writel(t, rtc_data->io + STMP3XXX_RTC_ALARM);
 
 	stmp3xxx_alarm_irq_enable(dev, alm->enabled);
@@ -235,7 +235,7 @@ static int stmp3xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	.alarm_irq_enable =
 			  stmp3xxx_alarm_irq_enable,
 	.read_time	= stmp3xxx_rtc_gettime,
-	.set_mmss	= stmp3xxx_rtc_set_mmss,
+	.set_mmss64	= stmp3xxx_rtc_set_mmss64,
 	.read_alarm	= stmp3xxx_rtc_read_alarm,
 	.set_alarm	= stmp3xxx_rtc_set_alarm,
 };
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
