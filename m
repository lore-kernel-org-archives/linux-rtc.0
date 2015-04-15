Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [4/5] drivers/rtc/pl030: Replace deprecated rtc_tm_to_time() and
 rtc_time_to_tm()
From: Xunlei Pang <xlpang@126.com>
Message-Id: <1429089611-29776-4-git-send-email-xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Xunlei Pang <pang.xunlei@linaro.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>
Date: Wed, 15 Apr 2015 17:20:10 +0800
List-ID: <rtc-linux.googlegroups.com>

From: Xunlei Pang <pang.xunlei@linaro.org>

The driver uses deprecated rtc_tm_to_time() and rtc_time_to_tm(),
which will overflow in year 2106 on 32-bit machines.

This patch solves this by:
 - Replacing rtc_tm_to_time() with rtc_tm_to_time64()
 - Replacing rtc_time_to_tm() with rtc_time64_to_tm()

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/rtc-pl030.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index f85a1a9..d874b6e 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -39,32 +39,34 @@ static int pl030_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct pl030_rtc *rtc = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(rtc->base + RTC_MR), &alrm->time);
+	rtc_time64_to_tm(readl(rtc->base + RTC_MR), &alrm->time);
 	return 0;
 }
 
 static int pl030_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct pl030_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long time;
+	time64_t time;
 	int ret;
 
 	/*
 	 * At the moment, we can only deal with non-wildcarded alarm times.
 	 */
 	ret = rtc_valid_tm(&alrm->time);
-	if (ret == 0)
-		ret = rtc_tm_to_time(&alrm->time, &time);
-	if (ret == 0)
-		writel(time, rtc->base + RTC_MR);
-	return ret;
+	if (ret)
+		return ret;
+
+	time = rtc_tm_to_time64(&alrm->time);
+	writel(time, rtc->base + RTC_MR);
+
+	return 0;
 }
 
 static int pl030_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pl030_rtc *rtc = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(rtc->base + RTC_DR), tm);
+	rtc_time64_to_tm(readl(rtc->base + RTC_DR), tm);
 
 	return 0;
 }
@@ -80,14 +82,12 @@ static int pl030_read_time(struct device *dev, struct rtc_time *tm)
 static int pl030_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pl030_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long time;
-	int ret;
+	time64_t time;
 
-	ret = rtc_tm_to_time(tm, &time);
-	if (ret == 0)
-		writel(time + 1, rtc->base + RTC_LR);
+	time = rtc_tm_to_time64(tm);
+	writel(time + 1, rtc->base + RTC_LR);
 
-	return ret;
+	return 0;
 }
 
 static const struct rtc_class_ops pl030_ops = {
