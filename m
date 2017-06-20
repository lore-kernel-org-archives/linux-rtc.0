Return-Path: <rtc-linux+bncBDKNBMNKRMJRB5WZUPFAKGQEU4XN7SI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com. [2a00:1450:400c:c09::22b])
        by gmr-mx.google.com with ESMTPS id y3si713742wmc.1.2017.06.20.02.37.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:58 -0700 (PDT)
Received: by mail-wm0-x22b.google.com with SMTP id d73so14630641wma.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:58 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 26/51] rtc: gemini: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:34 +0200
Message-Id: <1497951359-13334-27-git-send-email-benjamin.gaignard@linaro.org>
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
CC: Hans Ulli Kroll <ulli.kroll@googlemail.com>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/rtc/rtc-gemini.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index 5279390..222f144 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -71,7 +71,7 @@ static int gemini_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct gemini_rtc *rtc = dev_get_drvdata(dev);
 
 	unsigned int  days, hour, min, sec;
-	unsigned long offset, time;
+	unsigned long long offset, time;
 
 	sec  = readl(rtc->rtc_base + GEMINI_RTC_SECOND);
 	min  = readl(rtc->rtc_base + GEMINI_RTC_MINUTE);
@@ -81,7 +81,7 @@ static int gemini_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	time = offset + days * 86400 + hour * 3600 + min * 60 + sec;
 
-	rtc_time_to_tm(time, tm);
+	rtc_time64_to_tm(time, tm);
 
 	return 0;
 }
@@ -90,12 +90,12 @@ static int gemini_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct gemini_rtc *rtc = dev_get_drvdata(dev);
 	unsigned int sec, min, hour, day;
-	unsigned long offset, time;
+	unsigned long long offset, time;
 
 	if (tm->tm_year >= 2148)	/* EPOCH Year + 179 */
 		return -EINVAL;
 
-	rtc_tm_to_time(tm, &time);
+	time = rtc_tm_to_time64(tm);
 
 	sec = readl(rtc->rtc_base + GEMINI_RTC_SECOND);
 	min = readl(rtc->rtc_base + GEMINI_RTC_MINUTE);
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
