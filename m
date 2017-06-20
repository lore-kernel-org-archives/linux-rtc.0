Return-Path: <rtc-linux+bncBDKNBMNKRMJRBIG2UPFAKGQEUCNOVCQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com. [2a00:1450:400c:c09::233])
        by gmr-mx.google.com with ESMTPS id o27si2850455wmi.4.2017.06.20.02.38.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:40 -0700 (PDT)
Received: by mail-wm0-x233.google.com with SMTP id x70so15789124wme.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:40 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	patches@opensource.wolfsonmicro.com
Subject: [rtc-linux] [PATCH 49/51] rtc: wm831x: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:57 +0200
Message-Id: <1497951359-13334-50-git-send-email-benjamin.gaignard@linaro.org>
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
CC: patches@opensource.wolfsonmicro.com
---
 drivers/rtc/rtc-wm831x.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-wm831x.c b/drivers/rtc/rtc-wm831x.c
index 75aea4c..e42b07c 100644
--- a/drivers/rtc/rtc-wm831x.c
+++ b/drivers/rtc/rtc-wm831x.c
@@ -153,9 +153,9 @@ static int wm831x_rtc_readtime(struct device *dev, struct rtc_time *tm)
 			continue;
 
 		if (memcmp(time1, time2, sizeof(time1)) == 0) {
-			u32 time = (time1[0] << 16) | time1[1];
+			u64 time = (time1[0] << 16) | time1[1];
 
-			rtc_time_to_tm(time, tm);
+			rtc_time64_to_tm(time, tm);
 			return rtc_valid_tm(tm);
 		}
 
@@ -169,12 +169,12 @@ static int wm831x_rtc_readtime(struct device *dev, struct rtc_time *tm)
 /*
  * Set current time and date in RTC
  */
-static int wm831x_rtc_set_mmss(struct device *dev, unsigned long time)
+static int wm831x_rtc_set_mmss64(struct device *dev, time64_t time)
 {
 	struct wm831x_rtc *wm831x_rtc = dev_get_drvdata(dev);
 	struct wm831x *wm831x = wm831x_rtc->wm831x;
 	struct rtc_time new_tm;
-	unsigned long new_time;
+	unsigned long long new_time;
 	int ret;
 	int count = 0;
 
@@ -215,11 +215,7 @@ static int wm831x_rtc_set_mmss(struct device *dev, unsigned long time)
 	if (ret < 0)
 		return ret;
 
-	ret = rtc_tm_to_time(&new_tm, &new_time);
-	if (ret < 0) {
-		dev_err(dev, "Failed to convert time: %d\n", ret);
-		return ret;
-	}
+	new_time = rtc_tm_to_time64(&new_tm);
 
 	/* Allow a second of change in case of tick */
 	if (new_time - time > 1) {
@@ -238,7 +234,7 @@ static int wm831x_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct wm831x_rtc *wm831x_rtc = dev_get_drvdata(dev);
 	int ret;
 	u16 data[2];
-	u32 time;
+	u64 time;
 
 	ret = wm831x_bulk_read(wm831x_rtc->wm831x, WM831X_RTC_ALARM_1,
 			       2, data);
@@ -249,7 +245,7 @@ static int wm831x_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	time = (data[0] << 16) | data[1];
 
-	rtc_time_to_tm(time, &alrm->time);
+	rtc_time64_to_tm(time, &alrm->time);
 
 	ret = wm831x_reg_read(wm831x_rtc->wm831x, WM831X_RTC_CONTROL);
 	if (ret < 0) {
@@ -286,13 +282,9 @@ static int wm831x_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct wm831x_rtc *wm831x_rtc = dev_get_drvdata(dev);
 	struct wm831x *wm831x = wm831x_rtc->wm831x;
 	int ret;
-	unsigned long time;
+	unsigned long long time;
 
-	ret = rtc_tm_to_time(&alrm->time, &time);
-	if (ret < 0) {
-		dev_err(dev, "Failed to convert time: %d\n", ret);
-		return ret;
-	}
+	time = rtc_tm_to_time64(&alrm->time);
 
 	ret = wm831x_rtc_stop_alarm(wm831x_rtc);
 	if (ret < 0) {
@@ -346,7 +338,7 @@ static irqreturn_t wm831x_alm_irq(int irq, void *data)
 
 static const struct rtc_class_ops wm831x_rtc_ops = {
 	.read_time = wm831x_rtc_readtime,
-	.set_mmss = wm831x_rtc_set_mmss,
+	.set_mmss64 = wm831x_rtc_set_mmss64,
 	.read_alarm = wm831x_rtc_readalarm,
 	.set_alarm = wm831x_rtc_setalarm,
 	.alarm_irq_enable = wm831x_rtc_alarm_irq_enable,
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
