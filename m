Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:18076 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752266AbdFHNtd (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:49:33 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 16/25] rtc: rk808: Switch to use %pt
Date: Thu,  8 Jun 2017 16:48:02 +0300
Message-Id: <20170608134811.60786-17-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-rk808.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index 35c9aada07c8..711dca5707cd 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -138,9 +138,7 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
 	tm->tm_year = (bcd2bin(rtc_data[5] & YEARS_REG_MSK)) + 100;
 	tm->tm_wday = bcd2bin(rtc_data[6] & WEEKS_REG_MSK);
 	rockchip_to_gregorian(tm);
-	dev_dbg(dev, "RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_wday, tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "RTC date/time %ptd(%d) %ptt\n", tm, tm->tm_wday, tm);
 
 	return ret;
 }
@@ -153,9 +151,7 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	u8 rtc_data[NUM_TIME_REGS];
 	int ret;
 
-	dev_dbg(dev, "set RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_wday, tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "set RTC date/time %ptd(%d) %ptt\n", tm, tm->tm_wday, tm);
 	gregorian_to_rockchip(tm);
 	rtc_data[0] = bin2bcd(tm->tm_sec);
 	rtc_data[1] = bin2bcd(tm->tm_min);
@@ -216,10 +212,8 @@ static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return ret;
 	}
 
-	dev_dbg(dev, "alrm read RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + alrm->time.tm_year, alrm->time.tm_mon + 1,
-		alrm->time.tm_mday, alrm->time.tm_wday, alrm->time.tm_hour,
-		alrm->time.tm_min, alrm->time.tm_sec);
+	dev_dbg(dev, "alrm read RTC date/time %ptd(%d) %ptt\n",
+		&alrm->time, alrm->time.tm_wday, &alrm->time);
 
 	alrm->enabled = (int_reg & BIT_RTC_INTERRUPTS_REG_IT_ALARM_M) ? 1 : 0;
 
@@ -261,10 +255,8 @@ static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		dev_err(dev, "Failed to stop alarm: %d\n", ret);
 		return ret;
 	}
-	dev_dbg(dev, "alrm set RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
-		1900 + alrm->time.tm_year, alrm->time.tm_mon + 1,
-		alrm->time.tm_mday, alrm->time.tm_wday, alrm->time.tm_hour,
-		alrm->time.tm_min, alrm->time.tm_sec);
+	dev_dbg(dev, "alrm set RTC date/time %ptd(%d) %ptt\n",
+		&alrm->time, alrm->time.tm_wday, &alrm->time);
 
 	gregorian_to_rockchip(&alrm->time);
 	alrm_data[0] = bin2bcd(alrm->time.tm_sec);
-- 
2.11.0
