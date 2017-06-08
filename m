Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5263 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752028AbdFHNsd (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:33 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v1 22/25] mk68/mac: Switch to use %pt
Date: Thu,  8 Jun 2017 16:48:08 +0300
Message-Id: <20170608134811.60786-23-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/m68k/mac/misc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 8aa8792e3174..beb23a5000a1 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -660,13 +660,9 @@ int mac_hwclk(int op, struct rtc_time *t)
 		unmktime(now, 0,
 			 &t->tm_year, &t->tm_mon, &t->tm_mday,
 			 &t->tm_hour, &t->tm_min, &t->tm_sec);
-		pr_debug("%s: read %04d-%02d-%-2d %02d:%02d:%02d\n",
-		         __func__, t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
-		         t->tm_hour, t->tm_min, t->tm_sec);
+		pr_debug("%s: read %pt\n", __func__, t);
 	} else { /* write */
-		pr_debug("%s: tried to write %04d-%02d-%-2d %02d:%02d:%02d\n",
-		         __func__, t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
-		         t->tm_hour, t->tm_min, t->tm_sec);
+		pr_debug("%s: tried to write %pt\n", __func__, t);
 
 		now = mktime(t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
 			     t->tm_hour, t->tm_min, t->tm_sec);
-- 
2.11.0
