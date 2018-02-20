Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:32059 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751369AbeBTVoL (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 20 Feb 2018 16:44:11 -0500
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
Subject: [PATCH v2 13/21] rtc: rx6110: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:52 +0200
Message-Id: <20180220214400.66749-14-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-rx6110.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
index 7c9c08eab5e5..1705358fc706 100644
--- a/drivers/rtc/rtc-rx6110.c
+++ b/drivers/rtc/rtc-rx6110.c
@@ -114,9 +114,7 @@ struct rx6110_data {
  */
 static int rx6110_rtc_tm_to_data(struct rtc_time *tm, u8 *data)
 {
-	pr_debug("%s: date %ds %dm %dh %dmd %dm %dy\n", __func__,
-		 tm->tm_sec, tm->tm_min, tm->tm_hour,
-		 tm->tm_mday, tm->tm_mon, tm->tm_year);
+	pr_debug("%s: date %ptRr\n", __func__, tm);
 
 	/*
 	 * The year in the RTC is a value between 0 and 99.
@@ -154,9 +152,7 @@ static int rx6110_data_to_rtc_tm(u8 *data, struct rtc_time *tm)
 	tm->tm_mon = bcd2bin(data[RTC_MONTH] & 0x1f) - 1;
 	tm->tm_year = bcd2bin(data[RTC_YEAR]) + 100;
 
-	pr_debug("%s: date %ds %dm %dh %dmd %dm %dy\n", __func__,
-		 tm->tm_sec, tm->tm_min, tm->tm_hour,
-		 tm->tm_mday, tm->tm_mon, tm->tm_year);
+	pr_debug("%s: date %ptRr\n", __func__, tm);
 
 	/*
 	 * The year in the RTC is a value between 0 and 99.
@@ -248,9 +244,7 @@ static int rx6110_get_time(struct device *dev, struct rtc_time *tm)
 	if (ret)
 		return ret;
 
-	dev_dbg(dev, "%s: date %ds %dm %dh %dmd %dm %dy\n", __func__,
-		tm->tm_sec, tm->tm_min, tm->tm_hour,
-		tm->tm_mday, tm->tm_mon, tm->tm_year);
+	dev_dbg(dev, "%s: date %ptRr\n", __func__, tm);
 
 	return rtc_valid_tm(tm);
 }
-- 
2.15.1
