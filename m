Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10151 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbdFHNsj (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:39 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 07/25] rtc: at91rm9200: Switch to use %pt
Date: Thu,  8 Jun 2017 16:47:53 +0300
Message-Id: <20170608134811.60786-8-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-at91rm9200.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index b60fd477778f..6e29c25b34ce 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -151,9 +151,7 @@ static int at91_rtc_readtime(struct device *dev, struct rtc_time *tm)
 	tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
 	tm->tm_year = tm->tm_year - 1900;
 
-	dev_dbg(dev, "%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "%s(): %pt\n", __func__, tm);
 
 	return 0;
 }
@@ -165,9 +163,7 @@ static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long cr;
 
-	dev_dbg(dev, "%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "%s(): %pt\n", __func__, tm);
 
 	wait_for_completion(&at91_rtc_upd_rdy);
 
@@ -214,9 +210,7 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	alrm->enabled = (at91_rtc_read_imr() & AT91_RTC_ALARM)
 			? 1 : 0;
 
-	dev_dbg(dev, "%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "%s(): %pt\n", __func__, tm);
 
 	return 0;
 }
@@ -254,9 +248,7 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		at91_rtc_write_ier(AT91_RTC_ALARM);
 	}
 
-	dev_dbg(dev, "%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
-		at91_alarm_year, tm.tm_mon, tm.tm_mday, tm.tm_hour,
-		tm.tm_min, tm.tm_sec);
+	dev_dbg(dev, "%s(): %pt\n", __func__, &tm);
 
 	return 0;
 }
-- 
2.11.0
