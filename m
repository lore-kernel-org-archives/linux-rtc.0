Return-Path: <rtc-linux+bncBCN6JTVP2IEBBNUAUKVQKGQECH2EIBY@googlegroups.com>
MIME-Version: 1.0
Received: from m50-111.126.com (m50-111.126.com. [123.125.50.111])
        by gmr-mx.google.com with ESMTP id ei3si627057pdb.1.2015.05.29.08.05.24
        for <rtc-linux@googlegroups.com>;
        Fri, 29 May 2015 08:05:26 -0700 (PDT)
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>,
	Carlo Caione <carlo.caione@gmail.com>
Subject: [rtc-linux] [PATCH RESEND 3/3] drivers/rtc/sunxi: Replace deprecated rtc_tm_to_time()
Date: Fri, 29 May 2015 23:04:37 +0800
Message-Id: <1432911877-607-3-git-send-email-xlpang@126.com>
In-Reply-To: <1432911877-607-1-git-send-email-xlpang@126.com>
References: <1432911877-607-1-git-send-email-xlpang@126.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

From: Xunlei Pang <pang.xunlei@linaro.org>

sunxi_rtc_setalarm() uses deprecated rtc_tm_to_time(),
which will overflow in year 2106 on 32-bit machines.

This patch solves this by:
- Replacing rtc_tm_to_time() with rtc_tm_to_time64()

Also remove the unnecessary initial zeroing of some
local variables in sunxi_rtc_setalarm().

Cc: Carlo Caione <carlo.caione@gmail.com>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/rtc-sunxi.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index 6e678fa..7f22753 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -269,14 +269,13 @@ static int sunxi_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 	struct sunxi_rtc_dev *chip = dev_get_drvdata(dev);
 	struct rtc_time *alrm_tm = &wkalrm->time;
 	struct rtc_time tm_now;
-	u32 alrm = 0;
-	unsigned long time_now = 0;
-	unsigned long time_set = 0;
-	unsigned long time_gap = 0;
-	unsigned long time_gap_day = 0;
-	unsigned long time_gap_hour = 0;
-	unsigned long time_gap_min = 0;
-	int ret = 0;
+	u32 alrm;
+	time64_t time_set, time_now;
+	unsigned long time_gap;
+	unsigned long time_gap_day;
+	unsigned long time_gap_hour;
+	unsigned long time_gap_min;
+	int ret;
 
 	ret = sunxi_rtc_gettime(dev, &tm_now);
 	if (ret < 0) {
@@ -284,13 +283,18 @@ static int sunxi_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 		return -EINVAL;
 	}
 
-	rtc_tm_to_time(alrm_tm, &time_set);
-	rtc_tm_to_time(&tm_now, &time_now);
+	time_set = rtc_tm_to_time64(alrm_tm);
+	time_now = rtc_tm_to_time64(&tm_now);
 	if (time_set <= time_now) {
 		dev_err(dev, "Date to set in the past\n");
 		return -EINVAL;
 	}
 
+	if (time_set > time_now + 255 * SEC_IN_DAY) {
+		dev_err(dev, "Day must be in the range 0 - 255\n");
+		return -EINVAL;
+	}
+
 	time_gap = time_set - time_now;
 	time_gap_day = time_gap / SEC_IN_DAY;
 	time_gap -= time_gap_day * SEC_IN_DAY;
@@ -299,11 +303,6 @@ static int sunxi_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 	time_gap_min = time_gap / SEC_IN_MIN;
 	time_gap -= time_gap_min * SEC_IN_MIN;
 
-	if (time_gap_day > 255) {
-		dev_err(dev, "Day must be in the range 0 - 255\n");
-		return -EINVAL;
-	}
-
 	sunxi_rtc_setaie(0, chip);
 	writel(0, chip->base + SUNXI_ALRM_DHMS);
 	usleep_range(100, 300);
-- 
1.9.1


-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
