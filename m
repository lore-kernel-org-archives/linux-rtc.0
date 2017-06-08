Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:38640 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752144AbdFHNtD (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:49:03 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 18/25] rtc: rx8025: Switch to use %pt
Date: Thu,  8 Jun 2017 16:48:04 +0300
Message-Id: <20170608134811.60786-19-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-rx8025.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 91857d8d2df8..6385b1418c94 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -193,10 +193,7 @@ static int rx8025_get_time(struct device *dev, struct rtc_time *dt)
 	if (err)
 		return err;
 
-	dev_dbg(dev, "%s: read 0x%02x 0x%02x "
-		"0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n", __func__,
-		date[0], date[1], date[2], date[3], date[4],
-		date[5], date[6]);
+	dev_dbg(dev, "%s: read %7ph\n", __func__, date);
 
 	dt->tm_sec = bcd2bin(date[RX8025_REG_SEC] & 0x7f);
 	dt->tm_min = bcd2bin(date[RX8025_REG_MIN] & 0x7f);
@@ -210,9 +207,7 @@ static int rx8025_get_time(struct device *dev, struct rtc_time *dt)
 	dt->tm_mon = bcd2bin(date[RX8025_REG_MONTH] & 0x1f) - 1;
 	dt->tm_year = bcd2bin(date[RX8025_REG_YEAR]) + 100;
 
-	dev_dbg(dev, "%s: date %ds %dm %dh %dmd %dm %dy\n", __func__,
-		dt->tm_sec, dt->tm_min, dt->tm_hour,
-		dt->tm_mday, dt->tm_mon, dt->tm_year);
+	dev_dbg(dev, "%s: date %ptr\n", __func__, dt);
 
 	return rtc_valid_tm(dt);
 }
@@ -243,10 +238,7 @@ static int rx8025_set_time(struct device *dev, struct rtc_time *dt)
 	date[RX8025_REG_MONTH] = bin2bcd(dt->tm_mon + 1);
 	date[RX8025_REG_YEAR] = bin2bcd(dt->tm_year - 100);
 
-	dev_dbg(dev,
-		"%s: write 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
-		__func__,
-		date[0], date[1], date[2], date[3], date[4], date[5], date[6]);
+	dev_dbg(dev, "%s: write %7ph\n", __func__, date);
 
 	ret = rx8025_write_regs(rx8025->client, RX8025_REG_SEC, 7, date);
 	if (ret < 0)
@@ -319,10 +311,7 @@ static int rx8025_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 		t->time.tm_hour = bcd2bin(ald[1] & 0x1f) % 12
 			+ (ald[1] & 0x20 ? 12 : 0);
 
-	dev_dbg(dev, "%s: date: %ds %dm %dh %dmd %dm %dy\n",
-		__func__,
-		t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
-		t->time.tm_mday, t->time.tm_mon, t->time.tm_year);
+	dev_dbg(dev, "%s: date: %ptr\n", __func__, t);
 	t->enabled = !!(rx8025->ctrl1 & RX8025_BIT_CTRL1_DALE);
 	t->pending = (ctrl2 & RX8025_BIT_CTRL2_DAFG) && t->enabled;
 
-- 
2.11.0
