Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23856 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbdFHNsZ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:25 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 08/25] rtc: at91sam9: Switch to use %pt
Date: Thu,  8 Jun 2017 16:47:54 +0300
Message-Id: <20170608134811.60786-9-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-at91sam9.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 7418a763ce52..d8b6c31942fe 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -124,9 +124,7 @@ static int at91_rtc_readtime(struct device *dev, struct rtc_time *tm)
 
 	rtc_time_to_tm(offset + secs, tm);
 
-	dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", "readtime",
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "%s: %pt\n", __func__, tm);
 
 	return 0;
 }
@@ -141,9 +139,7 @@ static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
 	u32 offset, alarm, mr;
 	unsigned long secs;
 
-	dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", "settime",
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "%s: %pt\n", __func__, tm);
 
 	err = rtc_tm_to_time(tm, &secs);
 	if (err != 0)
@@ -199,9 +195,7 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (alarm != ALARM_DISABLED && offset != 0) {
 		rtc_time_to_tm(offset + alarm, tm);
 
-		dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", "readalarm",
-			1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-			tm->tm_hour, tm->tm_min, tm->tm_sec);
+		dev_dbg(dev, "%s: %pt\n", __func__, tm);
 
 		if (rtt_readl(rtc, MR) & AT91_RTT_ALMIEN)
 			alrm->enabled = 1;
@@ -242,9 +236,7 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (alrm->enabled)
 		rtt_writel(rtc, MR, mr | AT91_RTT_ALMIEN);
 
-	dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", "setalarm",
-		tm->tm_year, tm->tm_mon, tm->tm_mday, tm->tm_hour,
-		tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "%s: %pt\n", __func__, tm);
 
 	return 0;
 }
-- 
2.11.0
