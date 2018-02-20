Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7632 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbeBTVoN (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
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
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 19/21] Input: hp_sdc_rtc - Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:58 +0200
Message-Id: <20180220214400.66749-20-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/misc/Kconfig      | 1 +
 drivers/input/misc/hp_sdc_rtc.c | 8 +++-----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 62a1312a7387..f0f09ef79081 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -525,6 +525,7 @@ config HP_SDC_RTC
 	tristate "HP SDC Real Time Clock"
 	depends on (GSC || HP300) && SERIO
 	select HP_SDC
+	select PRINTK_PEXT_TIMEDATE
 	help
 	  Say Y here if you want to support the built-in real time clock
 	  of the HP SDC controller.
diff --git a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
index 49b34de0aed4..503ff518dfa2 100644
--- a/drivers/input/misc/hp_sdc_rtc.c
+++ b/drivers/input/misc/hp_sdc_rtc.c
@@ -441,12 +441,10 @@ static int hp_sdc_rtc_proc_show(struct seq_file *m, void *v)
 		seq_puts(m, "BBRTC\t\t: READ FAILED!\n");
 	} else {
 		seq_printf(m,
-			     "rtc_time\t: %02d:%02d:%02d\n"
-			     "rtc_date\t: %04d-%02d-%02d\n"
+			     "rtc_time\t: %ptRt\n"
+			     "rtc_date\t: %ptRd\n"
 			     "rtc_epoch\t: %04lu\n",
-			     tm.tm_hour, tm.tm_min, tm.tm_sec,
-			     tm.tm_year + 1900, tm.tm_mon + 1, 
-			     tm.tm_mday, epoch);
+			     &tm, &tm, epoch);
 	}
 
 	if (hp_sdc_rtc_read_rt(&tv)) {
-- 
2.15.1
