Return-Path: <rtc-linux+bncBDKNBMNKRMJRBC62UPFAKGQEFHQHCEA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x230.google.com (mail-wr0-x230.google.com. [2a00:1450:400c:c0c::230])
        by gmr-mx.google.com with ESMTPS id 140si3846457wmr.2.2017.06.20.02.38.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:19 -0700 (PDT)
Received: by mail-wr0-x230.google.com with SMTP id 77so88340372wrb.1
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:19 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 37/51] rtc: sa1100: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:45 +0200
Message-Id: <1497951359-13334-38-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-sa1100.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index c2187bf..8645b9a 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -155,20 +155,19 @@ static int sa1100_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct sa1100_rtc *info = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl_relaxed(info->rcnr), tm);
+	rtc_time64_to_tm(readl_relaxed(info->rcnr), tm);
 	return 0;
 }
 
 static int sa1100_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct sa1100_rtc *info = dev_get_drvdata(dev);
-	unsigned long time;
-	int ret;
+	unsigned long long time;
 
-	ret = rtc_tm_to_time(tm, &time);
-	if (ret == 0)
-		writel_relaxed(time, info->rcnr);
-	return ret;
+	time = rtc_tm_to_time64(tm);
+	writel_relaxed(time, info->rcnr);
+
+	return 0;
 }
 
 static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -185,13 +184,11 @@ static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static int sa1100_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct sa1100_rtc *info = dev_get_drvdata(dev);
-	unsigned long time;
-	int ret;
+	unsigned long long time;
 
 	spin_lock_irq(&info->lock);
-	ret = rtc_tm_to_time(&alrm->time, &time);
-	if (ret != 0)
-		goto out;
+	time = rtc_tm_to_time64(&alrm->time);
+
 	writel_relaxed(readl_relaxed(info->rtsr) &
 		(RTSR_HZE | RTSR_ALE | RTSR_AL), info->rtsr);
 	writel_relaxed(time, info->rtar);
@@ -199,10 +196,10 @@ static int sa1100_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		writel_relaxed(readl_relaxed(info->rtsr) | RTSR_ALE, info->rtsr);
 	else
 		writel_relaxed(readl_relaxed(info->rtsr) & ~RTSR_ALE, info->rtsr);
-out:
+
 	spin_unlock_irq(&info->lock);
 
-	return ret;
+	return 0;
 }
 
 static int sa1100_rtc_proc(struct device *dev, struct seq_file *seq)
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
