Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21625 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752033AbdFHNsd (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:33 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 19/25] rtc: s3c: Switch to use %pt
Date: Thu,  8 Jun 2017 16:48:05 +0300
Message-Id: <20170608134811.60786-20-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-s3c.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index d44fb34df8fe..4fa734f7e184 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -197,13 +197,10 @@ static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 	s3c_rtc_disable_clk(info);
 
 	rtc_tm->tm_year += 100;
-
-	dev_dbg(dev, "read time %04d.%02d.%02d %02d:%02d:%02d\n",
-		 1900 + rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
-		 rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
-
 	rtc_tm->tm_mon -= 1;
 
+	dev_dbg(dev, "read time %pt\n", rtc_tm);
+
 	return rtc_valid_tm(rtc_tm);
 }
 
@@ -212,9 +209,7 @@ static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
 	struct s3c_rtc *info = dev_get_drvdata(dev);
 	int year = tm->tm_year - 100;
 
-	dev_dbg(dev, "set time %04d.%02d.%02d %02d:%02d:%02d\n",
-		 1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		 tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "set time %pt\n", tm);
 
 	/* we get around y2k by simply not supporting it */
 
@@ -258,10 +253,7 @@ static int s3c_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alrm->enabled = (alm_en & S3C2410_RTCALM_ALMEN) ? 1 : 0;
 
-	dev_dbg(dev, "read alarm %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		 alm_en,
-		 1900 + alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
-		 alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
+	dev_dbg(dev, "read alarm %d, %pt\n", alm_en, alm_tm);
 
 	/* decode the alarm enable field */
 	if (alm_en & S3C2410_RTCALM_SECEN)
@@ -294,10 +286,7 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	unsigned int alrm_en;
 	int year = tm->tm_year - 100;
 
-	dev_dbg(dev, "s3c_rtc_setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		 alrm->enabled,
-		 1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		 tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "s3c_rtc_setalarm: %d, %pt\n", alrm->enabled, tm);
 
 	s3c_rtc_enable_clk(info);
 
-- 
2.11.0
