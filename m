Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7636 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeBTVoN (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 20 Feb 2018 16:44:13 -0500
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 17/21] rtc: tegra: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:56 +0200
Message-Id: <20180220214400.66749-18-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-tegra.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index d30d57b048d3..e9adfaa851f5 100644
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
+	dev_vdbg(dev, "time read as %lu. %ptR\n", sec, tm);
 
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
+	dev_vdbg(dev, "time set to %lu. %ptR\n", sec, tm);
 
 	/* seconds only written if wait succeeded. */
 	ret = tegra_rtc_wait_while_busy(dev);
@@ -235,15 +219,7 @@ static int tegra_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	/* if successfully written and alarm is enabled ... */
 	if (sec) {
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
+		dev_vdbg(dev, "alarm set as %lu. %ptR\n", sec, &alarm->time);
 	} else {
 		/* disable alarm if 0 or write error. */
 		dev_vdbg(dev, "alarm disabled\n");
-- 
2.15.1
