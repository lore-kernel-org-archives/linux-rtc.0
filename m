Return-Path: <rtc-linux+bncBDKNBMNKRMJRBTWZUPFAKGQEVLSKOBQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x22f.google.com (mail-wr0-x22f.google.com. [2a00:1450:400c:c0c::22f])
        by gmr-mx.google.com with ESMTPS id m189si2689823wma.6.2017.06.20.02.37.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:18 -0700 (PDT)
Received: by mail-wr0-x22f.google.com with SMTP id y25so49021371wrd.2
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:18 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	adi-buildroot-devel@lists.sourceforge.net
Subject: [rtc-linux] [PATCH 11/51] rtc: bfin: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:19 +0200
Message-Id: <1497951359-13334-12-git-send-email-benjamin.gaignard@linaro.org>
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
CC: adi-buildroot-devel@lists.sourceforge.net
---
 drivers/rtc/rtc-bfin.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-bfin.c b/drivers/rtc/rtc-bfin.c
index 15344b7..4c79bd0 100644
--- a/drivers/rtc/rtc-bfin.c
+++ b/drivers/rtc/rtc-bfin.c
@@ -103,7 +103,7 @@ static inline unsigned long rtc_bfin_to_time(u32 rtc_bfin)
 }
 static inline void rtc_bfin_to_tm(u32 rtc_bfin, struct rtc_time *tm)
 {
-	rtc_time_to_tm(rtc_bfin_to_time(rtc_bfin), tm);
+	rtc_time64_to_tm(rtc_bfin_to_time(rtc_bfin), tm);
 }
 
 /**
@@ -271,20 +271,17 @@ static int bfin_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int bfin_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct bfin_rtc *rtc = dev_get_drvdata(dev);
-	int ret;
-	unsigned long now;
+	unsigned long long now;
 
 	dev_dbg_stamp(dev);
 
-	ret = rtc_tm_to_time(tm, &now);
-	if (ret == 0) {
-		if (rtc->rtc_wrote_regs & 0x1)
-			bfin_rtc_sync_pending(dev);
-		bfin_write_RTC_STAT(rtc_time_to_bfin(now));
-		rtc->rtc_wrote_regs = 0x1;
-	}
+	now = rtc_tm_to_time64(tm);
+	if (rtc->rtc_wrote_regs & 0x1)
+		bfin_rtc_sync_pending(dev);
+	bfin_write_RTC_STAT(rtc_time_to_bfin(now));
+	rtc->rtc_wrote_regs = 0x1;
 
-	return ret;
+	return 0;
 }
 
 static int bfin_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -300,12 +297,11 @@ static int bfin_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static int bfin_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct bfin_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long rtc_alarm;
+	unsigned long long rtc_alarm;
 
 	dev_dbg_stamp(dev);
 
-	if (rtc_tm_to_time(&alrm->time, &rtc_alarm))
-		return -EINVAL;
+	rtc_alarm = rtc_tm_to_time64(&alrm->time);
 
 	rtc->rtc_alarm = alrm->time;
 
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
