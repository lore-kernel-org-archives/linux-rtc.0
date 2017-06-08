Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25356 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751982AbdFHNs2 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:28 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 11/25] rtc: mcp795: Switch to use %pt
Date: Thu,  8 Jun 2017 16:47:57 +0300
Message-Id: <20170608134811.60786-12-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-mcp795.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 77f21331ae21..a04a3190ac04 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -233,9 +233,7 @@ static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 	if (ret)
 		return ret;
 
-	dev_dbg(dev, "Set mcp795: %04d-%02d-%02d(%d) %02d:%02d:%02d\n",
-			tim->tm_year + 1900, tim->tm_mon, tim->tm_mday,
-			tim->tm_wday, tim->tm_hour, tim->tm_min, tim->tm_sec);
+	dev_dbg(dev, "Set mcp795: %pt\n", tim);
 
 	return 0;
 }
@@ -258,9 +256,7 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 	tim->tm_mon	= bcd2bin(data[5] & 0x1F) - 1;
 	tim->tm_year	= bcd2bin(data[6]) + 100; /* Assume we are in 20xx */
 
-	dev_dbg(dev, "Read from mcp795: %04d-%02d-%02d(%d) %02d:%02d:%02d\n",
-			tim->tm_year + 1900, tim->tm_mon, tim->tm_mday,
-			tim->tm_wday, tim->tm_hour, tim->tm_min, tim->tm_sec);
+	dev_dbg(dev, "Read from mcp795: %pt\n", tim);
 
 	return rtc_valid_tm(tim);
 }
@@ -319,9 +315,8 @@ static int mcp795_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 			return ret;
 		dev_dbg(dev, "Alarm IRQ armed\n");
 	}
-	dev_dbg(dev, "Set alarm: %02d-%02d(%d) %02d:%02d:%02d\n",
-			alm->time.tm_mon, alm->time.tm_mday, alm->time.tm_wday,
-			alm->time.tm_hour, alm->time.tm_min, alm->time.tm_sec);
+	dev_dbg(dev, "Set alarm: %ptdr(%d) %ptt\n",
+		&alm->time, alm->time.tm_wday, &alm->time);
 	return 0;
 }
 
@@ -345,9 +340,8 @@ static int mcp795_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	alm->time.tm_isdst	= -1;
 	alm->time.tm_yday	= -1;
 
-	dev_dbg(dev, "Read alarm: %02d-%02d(%d) %02d:%02d:%02d\n",
-			alm->time.tm_mon, alm->time.tm_mday, alm->time.tm_wday,
-			alm->time.tm_hour, alm->time.tm_min, alm->time.tm_sec);
+	dev_dbg(dev, "Read alarm: %ptdr(%d) %ptt\n",
+		&alm->time, alm->time.tm_wday, &alm->time);
 	return 0;
 }
 
-- 
2.11.0
