Return-Path: <rtc-linux+bncBDKNBMNKRMJRBHO2UPFAKGQEOHUEXUA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x231.google.com (mail-wr0-x231.google.com. [2a00:1450:400c:c0c::231])
        by gmr-mx.google.com with ESMTPS id j75si2789094wmj.1.2017.06.20.02.38.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:36 -0700 (PDT)
Received: by mail-wr0-x231.google.com with SMTP id r103so88485270wrb.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:36 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 47/51] rtc: tps6586: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:55 +0200
Message-Id: <1497951359-13334-48-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-tps6586x.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-tps6586x.c b/drivers/rtc/rtc-tps6586x.c
index a3418a8..2383636 100644
--- a/drivers/rtc/rtc-tps6586x.c
+++ b/drivers/rtc/rtc-tps6586x.c
@@ -71,7 +71,7 @@ static int tps6586x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct tps6586x_rtc *rtc = dev_get_drvdata(dev);
 	struct device *tps_dev = to_tps6586x_dev(dev);
 	unsigned long long ticks = 0;
-	unsigned long seconds;
+	unsigned long long seconds;
 	u8 buff[6];
 	int ret;
 	int i;
@@ -89,7 +89,7 @@ static int tps6586x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	seconds = ticks >> 10;
 	seconds += rtc->epoch_start;
-	rtc_time_to_tm(seconds, tm);
+	rtc_time64_to_tm(seconds, tm);
 	return rtc_valid_tm(tm);
 }
 
@@ -98,18 +98,18 @@ static int tps6586x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	struct tps6586x_rtc *rtc = dev_get_drvdata(dev);
 	struct device *tps_dev = to_tps6586x_dev(dev);
 	unsigned long long ticks;
-	unsigned long seconds;
+	unsigned long long seconds;
 	u8 buff[5];
 	int ret;
 
-	rtc_tm_to_time(tm, &seconds);
+	seconds = rtc_tm_to_time64(tm);
 	if (seconds < rtc->epoch_start) {
 		dev_err(dev, "requested time unsupported\n");
 		return -EINVAL;
 	}
 	seconds -= rtc->epoch_start;
 
-	ticks = (unsigned long long)seconds << 10;
+	ticks = seconds << 10;
 	buff[0] = (ticks >> 32) & 0xff;
 	buff[1] = (ticks >> 24) & 0xff;
 	buff[2] = (ticks >> 16) & 0xff;
@@ -157,16 +157,16 @@ static int tps6586x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct tps6586x_rtc *rtc = dev_get_drvdata(dev);
 	struct device *tps_dev = to_tps6586x_dev(dev);
-	unsigned long seconds;
-	unsigned long ticks;
-	unsigned long rtc_current_time;
+	unsigned long long seconds;
+	unsigned long long ticks;
+	unsigned long long rtc_current_time;
 	unsigned long long rticks = 0;
 	u8 buff[3];
 	u8 rbuff[6];
 	int ret;
 	int i;
 
-	rtc_tm_to_time(&alrm->time, &seconds);
+	seconds = rtc_tm_to_time64(&alrm->time);
 
 	if (alrm->enabled && (seconds < rtc->epoch_start)) {
 		dev_err(dev, "can't set alarm to requested time\n");
@@ -196,7 +196,7 @@ static int tps6586x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if ((seconds - rtc_current_time) > ALM1_VALID_RANGE_IN_SEC)
 		seconds = rtc_current_time - 1;
 
-	ticks = (unsigned long long)seconds << 10;
+	ticks = seconds << 10;
 	buff[0] = (ticks >> 16) & 0xff;
 	buff[1] = (ticks >> 8) & 0xff;
 	buff[2] = ticks & 0xff;
@@ -212,8 +212,8 @@ static int tps6586x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct tps6586x_rtc *rtc = dev_get_drvdata(dev);
 	struct device *tps_dev = to_tps6586x_dev(dev);
-	unsigned long ticks;
-	unsigned long seconds;
+	unsigned long long ticks;
+	unsigned long long seconds;
 	u8 buff[3];
 	int ret;
 
@@ -227,7 +227,7 @@ static int tps6586x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	seconds = ticks >> 10;
 	seconds += rtc->epoch_start;
 
-	rtc_time_to_tm(seconds, &alrm->time);
+	rtc_time64_to_tm(seconds, &alrm->time);
 	return 0;
 }
 
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
