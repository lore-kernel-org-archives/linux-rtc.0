Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5263 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751985AbdFHNsc (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:32 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 13/25] rtc: pic32: Switch to use %pt
Date: Thu,  8 Jun 2017 16:47:59 +0300
Message-Id: <20170608134811.60786-14-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-pic32.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-pic32.c b/drivers/rtc/rtc-pic32.c
index 5cfb6df5c430..f82843774aad 100644
--- a/drivers/rtc/rtc-pic32.c
+++ b/drivers/rtc/rtc-pic32.c
@@ -170,9 +170,7 @@ static int pic32_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 
 	rtc_tm->tm_year += 100;
 
-	dev_dbg(dev, "read time %04d.%02d.%02d %02d:%02d:%02d\n",
-		1900 + rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
-		rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
+	dev_dbg(dev, "read time %pt\n", rtc_tm);
 
 	clk_disable(pdata->clk);
 	return rtc_valid_tm(rtc_tm);
@@ -184,9 +182,7 @@ static int pic32_rtc_settime(struct device *dev, struct rtc_time *tm)
 	void __iomem *base = pdata->reg_base;
 	int year = tm->tm_year - 100;
 
-	dev_dbg(dev, "set time %04d.%02d.%02d %02d:%02d:%02d\n",
-		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "set time %pt\n", tm);
 
 	if (year < 0 || year >= 100) {
 		dev_err(dev, "rtc only supports 100 years\n");
@@ -224,10 +220,7 @@ static int pic32_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alrm->enabled = (alm_en & PIC32_RTCALRM_ALRMEN) ? 1 : 0;
 
-	dev_dbg(dev, "getalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		alm_en,
-		1900 + alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
-		alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
+	dev_dbg(dev, "getalarm: %d, %pt\n", alm_en, alm_tm);
 
 	alm_tm->tm_sec = bcd2bin(alm_tm->tm_sec);
 	alm_tm->tm_min = bcd2bin(alm_tm->tm_min);
@@ -247,10 +240,7 @@ static int pic32_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	void __iomem *base = pdata->reg_base;
 
 	clk_enable(pdata->clk);
-	dev_dbg(dev, "setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
-		alrm->enabled,
-		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec);
+	dev_dbg(dev, "setalarm: %d, %pt\n", alrm->enabled, tm);
 
 	writel(0x00, base + PIC32_ALRMTIME);
 	writel(0x00, base + PIC32_ALRMDATE);
-- 
2.11.0
