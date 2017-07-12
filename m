Return-Path: <rtc-linux+bncBDKNBMNKRMJRBTFQS7FQKGQEDU4RF5A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x236.google.com (mail-wr0-x236.google.com. [2a00:1450:400c:c0c::236])
        by gmr-mx.google.com with ESMTPS id k68si395891wmg.4.2017.07.12.01.05.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2017 01:05:32 -0700 (PDT)
Received: by mail-wr0-x236.google.com with SMTP id c11so22201995wrc.3
        for <rtc-linux@googlegroups.com>; Wed, 12 Jul 2017 01:05:32 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v2 14/22] rtc: pcap: stop using rtc deprecated functions
Date: Wed, 12 Jul 2017 10:04:34 +0200
Message-Id: <1499846682-14093-15-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org>
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

version 2:
- fix compilation issues by using do_div()
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-pcap.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-pcap.c b/drivers/rtc/rtc-pcap.c
index c443324..65aa6e2 100644
--- a/drivers/rtc/rtc-pcap.c
+++ b/drivers/rtc/rtc-pcap.c
@@ -46,7 +46,7 @@ static int pcap_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pcap_rtc *pcap_rtc = platform_get_drvdata(pdev);
 	struct rtc_time *tm = &alrm->time;
-	unsigned long secs;
+	unsigned long long secs;
 	u32 tod;	/* time of day, seconds since midnight */
 	u32 days;	/* days since 1/1/1970 */
 
@@ -56,7 +56,7 @@ static int pcap_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	ezx_pcap_read(pcap_rtc->pcap, PCAP_REG_RTC_DAYA, &days);
 	secs += (days & PCAP_RTC_DAY_MASK) * SEC_PER_DAY;
 
-	rtc_time_to_tm(secs, tm);
+	rtc_time64_to_tm(secs, tm);
 
 	return 0;
 }
@@ -66,16 +66,14 @@ static int pcap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pcap_rtc *pcap_rtc = platform_get_drvdata(pdev);
 	struct rtc_time *tm = &alrm->time;
-	unsigned long secs;
-	u32 tod, days;
+	unsigned long long secs;
+	u32 tod;
 
-	rtc_tm_to_time(tm, &secs);
+	secs = rtc_tm_to_time64(tm);
 
-	tod = secs % SEC_PER_DAY;
+	tod = do_div(secs, SEC_PER_DAY);
 	ezx_pcap_write(pcap_rtc->pcap, PCAP_REG_RTC_TODA, tod);
-
-	days = secs / SEC_PER_DAY;
-	ezx_pcap_write(pcap_rtc->pcap, PCAP_REG_RTC_DAYA, days);
+	ezx_pcap_write(pcap_rtc->pcap, PCAP_REG_RTC_DAYA, secs);
 
 	return 0;
 }
@@ -84,7 +82,7 @@ static int pcap_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pcap_rtc *pcap_rtc = platform_get_drvdata(pdev);
-	unsigned long secs;
+	unsigned long long secs;
 	u32 tod, days;
 
 	ezx_pcap_read(pcap_rtc->pcap, PCAP_REG_RTC_TOD, &tod);
@@ -93,21 +91,19 @@ static int pcap_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	ezx_pcap_read(pcap_rtc->pcap, PCAP_REG_RTC_DAY, &days);
 	secs += (days & PCAP_RTC_DAY_MASK) * SEC_PER_DAY;
 
-	rtc_time_to_tm(secs, tm);
+	rtc_time64_to_tm(secs, tm);
 
 	return rtc_valid_tm(tm);
 }
 
-static int pcap_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int pcap_rtc_set_mmss64(struct device *dev, time64_t secs)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pcap_rtc *pcap_rtc = platform_get_drvdata(pdev);
 	u32 tod, days;
 
-	tod = secs % SEC_PER_DAY;
+	days = div_s64_rem(secs, SEC_PER_DAY, &tod);
 	ezx_pcap_write(pcap_rtc->pcap, PCAP_REG_RTC_TOD, tod);
-
-	days = secs / SEC_PER_DAY;
 	ezx_pcap_write(pcap_rtc->pcap, PCAP_REG_RTC_DAY, days);
 
 	return 0;
@@ -135,7 +131,7 @@ static int pcap_rtc_alarm_irq_enable(struct device *dev, unsigned int en)
 	.read_time = pcap_rtc_read_time,
 	.read_alarm = pcap_rtc_read_alarm,
 	.set_alarm = pcap_rtc_set_alarm,
-	.set_mmss = pcap_rtc_set_mmss,
+	.set_mmss64 = pcap_rtc_set_mmss64,
 	.alarm_irq_enable = pcap_rtc_alarm_irq_enable,
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
