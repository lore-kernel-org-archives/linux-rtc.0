Return-Path: <rtc-linux+bncBDKNBMNKRMJRBTGZUPFAKGQELCR4KAI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x22f.google.com (mail-wr0-x22f.google.com. [2a00:1450:400c:c0c::22f])
        by gmr-mx.google.com with ESMTPS id m189si2689823wma.6.2017.06.20.02.37.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:16 -0700 (PDT)
Received: by mail-wr0-x22f.google.com with SMTP id y25so49021371wrd.2
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:16 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 10/51] rtc: at91sam9: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:18 +0200
Message-Id: <1497951359-13334-11-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-at91sam9.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 7418a76..be1f37e 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -122,7 +122,7 @@ static int at91_rtc_readtime(struct device *dev, struct rtc_time *tm)
 	if (secs != secs2)
 		secs = rtt_readl(rtc, VR);
 
-	rtc_time_to_tm(offset + secs, tm);
+	rtc_time64_to_tm((u64)(offset + secs), tm);
 
 	dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", "readtime",
 		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
@@ -137,17 +137,14 @@ static int at91_rtc_readtime(struct device *dev, struct rtc_time *tm)
 static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
 	struct sam9_rtc *rtc = dev_get_drvdata(dev);
-	int err;
 	u32 offset, alarm, mr;
-	unsigned long secs;
+	unsigned long long secs;
 
 	dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", "settime",
 		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
 		tm->tm_hour, tm->tm_min, tm->tm_sec);
 
-	err = rtc_tm_to_time(tm, &secs);
-	if (err != 0)
-		return err;
+	secs = rtc_tm_to_time64(tm);
 
 	mr = rtt_readl(rtc, MR);
 
@@ -197,7 +194,7 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	memset(alrm, 0, sizeof(*alrm));
 	if (alarm != ALARM_DISABLED && offset != 0) {
-		rtc_time_to_tm(offset + alarm, tm);
+		rtc_time64_to_tm((u64)(offset + alarm), tm);
 
 		dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", "readalarm",
 			1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
@@ -214,14 +211,11 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct sam9_rtc *rtc = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time;
-	unsigned long secs;
+	unsigned long long secs;
 	u32 offset;
 	u32 mr;
-	int err;
 
-	err = rtc_tm_to_time(tm, &secs);
-	if (err != 0)
-		return err;
+	secs = rtc_tm_to_time64(tm);
 
 	offset = gpbr_readl(rtc);
 	if (offset == 0) {
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
