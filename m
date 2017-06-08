Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23856 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751973AbdFHNs1 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:27 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 15/25] rtc: puv3: Switch to use %pt
Date: Thu,  8 Jun 2017 16:48:01 +0300
Message-Id: <20170608134811.60786-16-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-puv3.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-puv3.c b/drivers/rtc/rtc-puv3.c
index c0a6e638c672..2b7bac8892f8 100644
--- a/drivers/rtc/rtc-puv3.c
+++ b/drivers/rtc/rtc-puv3.c
@@ -90,9 +90,7 @@ static int puv3_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 {
 	rtc_time_to_tm(readl(RTC_RCNR), rtc_tm);
 
-	dev_dbg(dev, "read time %02x.%02x.%02x %02x/%02x/%02x\n",
-		 rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
-		 rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
+	dev_dbg(dev, "read time %ptr\n", rtc_tm);
 
 	return 0;
 }
@@ -101,9 +99,7 @@ static int puv3_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long rtc_count = 0;
 
-	dev_dbg(dev, "set time %02d.%02d.%02d %02d/%02d/%02d\n",
-		 tm->tm_year, tm->tm_mon, tm->tm_mday,
-		 tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "set time %ptr\n", tm);
 
 	rtc_tm_to_time(tm, &rtc_count);
 	writel(rtc_count, RTC_RCNR);
@@ -119,10 +115,7 @@ static int puv3_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alrm->enabled = readl(RTC_RTSR) & RTC_RTSR_ALE;
 
-	dev_dbg(dev, "read alarm %02x %02x.%02x.%02x %02x/%02x/%02x\n",
-		 alrm->enabled,
-		 alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
-		 alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
+	dev_dbg(dev, "read alarm: %d, %ptr\n", alrm->enabled, alm_tm);
 
 	return 0;
 }
@@ -132,10 +125,7 @@ static int puv3_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rtc_time *tm = &alrm->time;
 	unsigned long rtcalarm_count = 0;
 
-	dev_dbg(dev, "puv3_rtc_setalarm: %d, %02x/%02x/%02x %02x.%02x.%02x\n",
-		 alrm->enabled,
-		 tm->tm_mday & 0xff, tm->tm_mon & 0xff, tm->tm_year & 0xff,
-		 tm->tm_hour & 0xff, tm->tm_min & 0xff, tm->tm_sec);
+	dev_dbg(dev, "set alarm: %d, %ptr\n", alrm->enabled, tm);
 
 	rtc_tm_to_time(tm, &rtcalarm_count);
 	writel(rtcalarm_count, RTC_RTAR);
-- 
2.11.0
