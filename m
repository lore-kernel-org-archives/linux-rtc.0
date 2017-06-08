Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10151 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751689AbdFHNsX (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:23 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 10/25] rtc: m48t59: Switch to use %pt
Date: Thu,  8 Jun 2017 16:47:56 +0300
Message-Id: <20170608134811.60786-11-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-m48t59.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index d99a705bec07..1583584becb8 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -102,9 +102,7 @@ static int m48t59_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	M48T59_CLEAR_BITS(M48T59_CNTL_READ, M48T59_CNTL);
 	spin_unlock_irqrestore(&m48t59->lock, flags);
 
-	dev_dbg(dev, "RTC read time %04d-%02d-%02d %02d/%02d/%02d\n",
-		tm->tm_year + 1900, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "RTC read time %pt\n", tm);
 	return rtc_valid_tm(tm);
 }
 
@@ -193,9 +191,7 @@ static int m48t59_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	M48T59_CLEAR_BITS(M48T59_CNTL_READ, M48T59_CNTL);
 	spin_unlock_irqrestore(&m48t59->lock, flags);
 
-	dev_dbg(dev, "RTC read alarm time %04d-%02d-%02d %02d/%02d/%02d\n",
-		tm->tm_year + 1900, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "RTC read alarm time %pt\n", tm);
 	return rtc_valid_tm(tm);
 }
 
-- 
2.11.0
