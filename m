Return-Path: <xlpang@126.com>
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>,
	Carlo Caione <carlo.caione@gmail.com>
Subject: [PATCH v3 4/4] drivers/rtc/sunxi: Replace deprecated rtc_tm_to_time()
Date: Fri, 12 Jun 2015 10:04:12 +0800
Message-Id: <1434074652-16054-4-git-send-email-xlpang@126.com>
In-Reply-To: <1434074652-16054-1-git-send-email-xlpang@126.com>
References: <1434074652-16054-1-git-send-email-xlpang@126.com>
List-ID: <rtc-linux.googlegroups.com>

From: Xunlei Pang <pang.xunlei@linaro.org>

sunxi_rtc_setalarm() uses deprecated rtc_tm_to_time(),
which will overflow in year 2106 on 32-bit machines.

This patch solves this by:
- Replacing rtc_tm_to_time() with rtc_tm_sub()

Also remove the unnecessary initial zeroing of some
local variables in sunxi_rtc_setalarm().

Cc: Carlo Caione <carlo.caione@gmail.com>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
v2->v3:
Rename rtc_tm_subtract() to rtc_tm_sub().

 drivers/rtc/rtc-sunxi.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index 6e678fa..52543ae 100644
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
+	time64_t diff;
+	unsigned long time_gap;
+	unsigned long time_gap_day;
+	unsigned long time_gap_hour;
+	unsigned long time_gap_min;
+	int ret;
 
 	ret = sunxi_rtc_gettime(dev, &tm_now);
 	if (ret < 0) {
@@ -284,14 +283,18 @@ static int sunxi_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 		return -EINVAL;
 	}
 
-	rtc_tm_to_time(alrm_tm, &time_set);
-	rtc_tm_to_time(&tm_now, &time_now);
-	if (time_set <= time_now) {
+	diff = rtc_tm_sub(alrm_tm, &tm_now);
+	if (diff <= 0) {
 		dev_err(dev, "Date to set in the past\n");
 		return -EINVAL;
 	}
 
-	time_gap = time_set - time_now;
+	if (diff > 255 * SEC_IN_DAY) {
+		dev_err(dev, "Day must be in the range 0 - 255\n");
+		return -EINVAL;
+	}
+
+	time_gap = diff;
 	time_gap_day = time_gap / SEC_IN_DAY;
 	time_gap -= time_gap_day * SEC_IN_DAY;
 	time_gap_hour = time_gap / SEC_IN_HOUR;
@@ -299,11 +302,6 @@ static int sunxi_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
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
