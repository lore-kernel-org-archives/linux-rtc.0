Return-Path: <rtc-linux+bncBDKNBMNKRMJRBEG2UPFAKGQEIL4GY7Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com. [2a00:1450:400c:c09::22f])
        by gmr-mx.google.com with ESMTPS id 197si3798305wmo.0.2017.06.20.02.38.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:24 -0700 (PDT)
Received: by mail-wm0-x22f.google.com with SMTP id d73so14530576wma.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:24 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 40/51] rtc: snvs: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:48 +0200
Message-Id: <1497951359-13334-41-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-snvs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index d8ef9e0..774048e 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -121,9 +121,9 @@ static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
 static int snvs_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
-	unsigned long time = rtc_read_lp_counter(data);
+	unsigned long long time = rtc_read_lp_counter(data);
 
-	rtc_time_to_tm(time, tm);
+	rtc_time64_to_tm(time, tm);
 
 	return 0;
 }
@@ -131,9 +131,9 @@ static int snvs_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int snvs_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
-	unsigned long time;
+	unsigned long long time;
 
-	rtc_tm_to_time(tm, &time);
+	time = rtc_tm_to_time64(tm);
 
 	/* Disable RTC first */
 	snvs_rtc_enable(data, false);
@@ -154,7 +154,7 @@ static int snvs_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	u32 lptar, lpsr;
 
 	regmap_read(data->regmap, data->offset + SNVS_LPTAR, &lptar);
-	rtc_time_to_tm(lptar, &alrm->time);
+	rtc_time64_to_tm((u64)lptar, &alrm->time);
 
 	regmap_read(data->regmap, data->offset + SNVS_LPSR, &lpsr);
 	alrm->pending = (lpsr & SNVS_LPSR_LPTA) ? 1 : 0;
@@ -179,9 +179,9 @@ static int snvs_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
 	struct rtc_time *alrm_tm = &alrm->time;
-	unsigned long time;
+	unsigned long long time;
 
-	rtc_tm_to_time(alrm_tm, &time);
+	time = rtc_tm_to_time64(alrm_tm);
 
 	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR, SNVS_LPCR_LPTA_EN, 0);
 	rtc_write_sync_lp(data);
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
