Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7632 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbeBTVoM (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 15/21] rtc: s3c: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:54 +0200
Message-Id: <20180220214400.66749-16-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-s3c.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index a8992c227f61..4a18824a39b1 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -225,13 +225,10 @@ static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 	s3c_rtc_disable_clk(info);
 
 	rtc_tm->tm_year += 100;
-
-	dev_dbg(dev, "read time %04d.%02d.%02d %02d:%02d:%02d\n",
-		1900 + rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
-		rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
-
 	rtc_tm->tm_mon -= 1;
 
+	dev_dbg(dev, "read time %ptR\n", rtc_tm);
+
 	return rtc_valid_tm(rtc_tm);
 }
 
@@ -241,9 +238,7 @@ static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
 	int year = tm->tm_year - 100;
 	int ret;
 
-	dev_dbg(dev, "set time %04d.%02d.%02d %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "set time %ptR\n", tm);
 
 	/* we get around y2k by simply not supporting it */
 
@@ -292,10 +287,7 @@ static int s3c_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alrm->enabled = (alm_en & S3C2410_RTCALM_ALMEN) ? 1 : 0;
 
-	dev_dbg(dev, "read alarm %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		alm_en,
-		1900 + alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
-		alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
+	dev_dbg(dev, "read alarm %d, %ptR\n", alm_en, alm_tm);
 
 	/* decode the alarm enable field */
 	if (alm_en & S3C2410_RTCALM_SECEN)
@@ -329,10 +321,7 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	int ret;
 	int year = tm->tm_year - 100;
 
-	dev_dbg(dev, "s3c_rtc_setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		alrm->enabled,
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "s3c_rtc_setalarm: %d, %ptR\n", alrm->enabled, tm);
 
 	ret = s3c_rtc_enable_clk(info);
 	if (ret)
-- 
2.15.1
