Return-Path: <rtc-linux+bncBDKNBMNKRMJRBVOZUPFAKGQEMPFKFOQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x231.google.com (mail-wr0-x231.google.com. [2a00:1450:400c:c0c::231])
        by gmr-mx.google.com with ESMTPS id j75si2789094wmj.1.2017.06.20.02.37.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:25 -0700 (PDT)
Received: by mail-wr0-x231.google.com with SMTP id r103so88485270wrb.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:25 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Support Opensource <support.opensource@diasemi.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 15/51] rtc: da9063: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:23 +0200
Message-Id: <1497951359-13334-16-git-send-email-benjamin.gaignard@linaro.org>
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
CC: Support Opensource <support.opensource@diasemi.com>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-da9063.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index f85cae2..c0e140d 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -227,8 +227,8 @@ static int da9063_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct da9063_compatible_rtc *rtc = dev_get_drvdata(dev);
 	const struct da9063_compatible_rtc_regmap *config = rtc->config;
-	unsigned long tm_secs;
-	unsigned long al_secs;
+	unsigned long long tm_secs;
+	unsigned long long al_secs;
 	u8 data[RTC_DATA_LEN];
 	int ret;
 
@@ -247,8 +247,8 @@ static int da9063_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	da9063_data_to_tm(data, tm, rtc);
 
-	rtc_tm_to_time(tm, &tm_secs);
-	rtc_tm_to_time(&rtc->alarm_time, &al_secs);
+	tm_secs = rtc_tm_to_time64(tm);
+	al_secs = rtc_tm_to_time64(&rtc->alarm_time);
 
 	/* handle the rtc synchronisation delay */
 	if (rtc->rtc_sync == true && al_secs - tm_secs == 1)
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
