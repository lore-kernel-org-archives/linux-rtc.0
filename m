Return-Path: <rtc-linux+bncBDKNBMNKRMJRBPVQS7FQKGQEUWES2QQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x229.google.com (mail-wr0-x229.google.com. [2a00:1450:400c:c0c::229])
        by gmr-mx.google.com with ESMTPS id 2si383618wms.6.2017.07.12.01.05.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2017 01:05:18 -0700 (PDT)
Received: by mail-wr0-x229.google.com with SMTP id r103so22428407wrb.0
        for <rtc-linux@googlegroups.com>; Wed, 12 Jul 2017 01:05:18 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v2 06/22] rtc: cpcap: stop using rtc deprecated functions
Date: Wed, 12 Jul 2017 10:04:26 +0200
Message-Id: <1499846682-14093-7-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-cpcap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-cpcap.c b/drivers/rtc/rtc-cpcap.c
index 3a0333e..e92b346 100644
--- a/drivers/rtc/rtc-cpcap.c
+++ b/drivers/rtc/rtc-cpcap.c
@@ -58,24 +58,23 @@ struct cpcap_rtc {
 static void cpcap2rtc_time(struct rtc_time *rtc, struct cpcap_time *cpcap)
 {
 	unsigned long int tod;
-	unsigned long int time;
+	unsigned long long time;
 
 	tod = (cpcap->tod1 & TOD1_MASK) | ((cpcap->tod2 & TOD2_MASK) << 8);
 	time = tod + ((cpcap->day & DAY_MASK) * SECS_PER_DAY);
 
-	rtc_time_to_tm(time, rtc);
+	rtc_time64_to_tm(time, rtc);
 }
 
 static void rtc2cpcap_time(struct cpcap_time *cpcap, struct rtc_time *rtc)
 {
-	unsigned long time;
+	unsigned long long time, tod;
 
-	rtc_tm_to_time(rtc, &time);
-
-	cpcap->day = time / SECS_PER_DAY;
-	time %= SECS_PER_DAY;
-	cpcap->tod2 = (time >> 8) & TOD2_MASK;
-	cpcap->tod1 = time & TOD1_MASK;
+	time = rtc_tm_to_time64(rtc);
+	tod = do_div(time, SECS_PER_DAY);
+	cpcap->day = time;
+	cpcap->tod2 = (tod >> 8) & TOD2_MASK;
+	cpcap->tod1 = tod & TOD1_MASK;
 }
 
 static int cpcap_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
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
