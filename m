Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1947 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbeBTVoJ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 20 Feb 2018 16:44:09 -0500
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 08/21] rtc: pcf50633: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:47 +0200
Message-Id: <20180220214400.66749-9-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-pcf50633.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf50633.c b/drivers/rtc/rtc-pcf50633.c
index 00c31c91b245..ace2080daf10 100644
--- a/drivers/rtc/rtc-pcf50633.c
+++ b/drivers/rtc/rtc-pcf50633.c
@@ -131,9 +131,7 @@ static int pcf50633_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	pcf2rtc_time(tm, &pcf_tm);
 
-	dev_dbg(dev, "RTC_TIME: %u.%u.%u %u:%u:%u\n",
-		tm->tm_mday, tm->tm_mon, tm->tm_year,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "RTC_TIME: %ptRr\n", tm);
 
 	return rtc_valid_tm(tm);
 }
@@ -146,9 +144,7 @@ static int pcf50633_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	rtc = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "RTC_TIME: %u.%u.%u %u:%u:%u\n",
-		tm->tm_mday, tm->tm_mon, tm->tm_year,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "RTC_TIME: %ptRr\n", tm);
 
 	rtc2pcf_time(&pcf_tm, tm);
 
-- 
2.15.1
