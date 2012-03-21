Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: rtc: ep93xx: Use readl/writel for io
From: hartleys <hartleys@visionengravers.com>
Message-Id: <201203211055.31653.hartleys@visionengravers.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: <rtc-linux@googlegroups.com>, <a.zummo@towertech.it>
Date: Wed, 21 Mar 2012 10:55:31 -0700
List-ID: <rtc-linux.googlegroups.com>

Drivers should not be using the __raw_* io accessors.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index 14a42a1..60ea585 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -45,7 +45,7 @@ static int ep93xx_rtc_get_swcomp(struct device *dev, unsigned short *preload,
 	struct ep93xx_rtc *ep93xx_rtc = dev->platform_data;
 	unsigned long comp;
 
-	comp = __raw_readl(ep93xx_rtc->mmio_base + EP93XX_RTC_SWCOMP);
+	comp = readl(ep93xx_rtc->mmio_base + EP93XX_RTC_SWCOMP);
 
 	if (preload)
 		*preload = (comp & EP93XX_RTC_SWCOMP_INT_MASK)
@@ -63,7 +63,7 @@ static int ep93xx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct ep93xx_rtc *ep93xx_rtc = dev->platform_data;
 	unsigned long time;
 
-	 time = __raw_readl(ep93xx_rtc->mmio_base + EP93XX_RTC_DATA);
+	 time = readl(ep93xx_rtc->mmio_base + EP93XX_RTC_DATA);
 
 	rtc_time_to_tm(time, tm);
 	return 0;
@@ -73,7 +73,7 @@ static int ep93xx_rtc_set_mmss(struct device *dev, unsigned long secs)
 {
 	struct ep93xx_rtc *ep93xx_rtc = dev->platform_data;
 
-	__raw_writel(secs + 1, ep93xx_rtc->mmio_base + EP93XX_RTC_LOAD);
+	writel(secs + 1, ep93xx_rtc->mmio_base + EP93XX_RTC_LOAD);
 	return 0;
 }
 
