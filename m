Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25356 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbdFHNs2 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:28 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 21/25] rtc: tegra: Switch to use %pt
Date: Thu,  8 Jun 2017 16:48:07 +0300
Message-Id: <20170608134811.60786-22-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-tegra.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index d30d57b048d3..cd0c60f1e1fb 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -124,15 +124,7 @@ static int tegra_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	rtc_time_to_tm(sec, tm);
 
-	dev_vdbg(dev, "time read as %lu. %d/%d/%d %d:%02u:%02u\n",
-		sec,
-		tm->tm_mon + 1,
-		tm->tm_mday,
-		tm->tm_year + 1900,
-		tm->tm_hour,
-		tm->tm_min,
-		tm->tm_sec
-	);
+	dev_vdbg(dev, "time read as %lu. %pt\n", sec, tm);
 
 	return 0;
 }
@@ -150,15 +142,7 @@ static int tegra_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	rtc_tm_to_time(tm, &sec);
 
-	dev_vdbg(dev, "time set to %lu. %d/%d/%d %d:%02u:%02u\n",
-		sec,
-		tm->tm_mon+1,
-		tm->tm_mday,
-		tm->tm_year+1900,
-		tm->tm_hour,
-		tm->tm_min,
-		tm->tm_sec
-	);
+	dev_vdbg(dev, "time set to %lu. %pt\n", sec, tm);
 
 	/* seconds only written if wait succeeded. */
 	ret = tegra_rtc_wait_while_busy(dev);
@@ -234,16 +218,8 @@ static int tegra_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 	/* if successfully written and alarm is enabled ... */
 	if (sec) {
+		dev_vdbg(dev, "alarm set as %lu. %pt\n", sec, &alarm->time);
 		tegra_rtc_alarm_irq_enable(dev, 1);
-
-		dev_vdbg(dev, "alarm set as %lu. %d/%d/%d %d:%02u:%02u\n",
-			sec,
-			alarm->time.tm_mon+1,
-			alarm->time.tm_mday,
-			alarm->time.tm_year+1900,
-			alarm->time.tm_hour,
-			alarm->time.tm_min,
-			alarm->time.tm_sec);
 	} else {
 		/* disable alarm if 0 or write error. */
 		dev_vdbg(dev, "alarm disabled\n");
-- 
2.11.0
