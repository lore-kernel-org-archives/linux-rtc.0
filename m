Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:45739 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751391AbeBTVoM (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 20 Feb 2018 16:44:12 -0500
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 16/21] rtc: s5m: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:55 +0200
Message-Id: <20180220214400.66749-17-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-s5m.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 0477678d968f..5c6916ee335c 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -403,9 +403,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + tm->tm_year, 1 + tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec, tm->tm_wday);
+	dev_dbg(dev, "%s: %ptR(%d)\n", __func__, tm, tm->tm_wday);
 
 	return rtc_valid_tm(tm);
 }
@@ -433,9 +431,7 @@ static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + tm->tm_year, 1 + tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec, tm->tm_wday);
+	dev_dbg(dev, "%s: %ptR(%d)\n", __func__, tm, tm->tm_wday);
 
 	ret = regmap_raw_write(info->regmap, info->regs->time, data,
 			info->regs->regs_count);
@@ -487,11 +483,7 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + alrm->time.tm_year, 1 + alrm->time.tm_mon,
-		alrm->time.tm_mday, alrm->time.tm_hour,
-		alrm->time.tm_min, alrm->time.tm_sec,
-		alrm->time.tm_wday);
+	dev_dbg(dev, "%s: %ptR(%d)\n", __func__, &alrm->time, alrm->time.tm_wday);
 
 	ret = s5m_check_peding_alarm_interrupt(info, alrm);
 
@@ -510,9 +502,7 @@ static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
 		return ret;
 
 	s5m8767_data_to_tm(data, &tm, info->rtc_24hr_mode);
-	dev_dbg(info->dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + tm.tm_year, 1 + tm.tm_mon, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec, tm.tm_wday);
+	dev_dbg(info->dev, "%s: %ptR(%d)\n", __func__, &tm, tm.tm_wday);
 
 	switch (info->device_type) {
 	case S5M8763X:
@@ -555,9 +545,7 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
 		return ret;
 
 	s5m8767_data_to_tm(data, &tm, info->rtc_24hr_mode);
-	dev_dbg(info->dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + tm.tm_year, 1 + tm.tm_mon, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec, tm.tm_wday);
+	dev_dbg(info->dev, "%s: %ptR(%d)\n", __func__, &tm, tm.tm_wday);
 
 	switch (info->device_type) {
 	case S5M8763X:
@@ -617,10 +605,7 @@ static int s5m_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "%s: %d/%d/%d %d:%d:%d(%d)\n", __func__,
-		1900 + alrm->time.tm_year, 1 + alrm->time.tm_mon,
-		alrm->time.tm_mday, alrm->time.tm_hour, alrm->time.tm_min,
-		alrm->time.tm_sec, alrm->time.tm_wday);
+	dev_dbg(dev, "%s: %ptR(%d)\n", __func__, &alrm->time, alrm->time.tm_wday);
 
 	ret = s5m_rtc_stop_alarm(info);
 	if (ret < 0)
-- 
2.15.1
