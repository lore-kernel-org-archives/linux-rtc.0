Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26723 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752146AbdFHNtE (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:49:04 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 05/25] ds1302: Switch to use %pt
Date: Thu,  8 Jun 2017 16:47:51 +0300
Message-Id: <20170608134811.60786-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %pt instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ds1302.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/char/ds1302.c b/drivers/char/ds1302.c
index c614a56e68cc..7db23a336636 100644
--- a/drivers/char/ds1302.c
+++ b/drivers/char/ds1302.c
@@ -4,7 +4,7 @@
 *!
 *! DESCRIPTION: Implements an interface for the DS1302 RTC
 *!
-*! Functions exported: ds1302_readreg, ds1302_writereg, ds1302_init, get_rtc_status
+*! Functions exported: ds1302_readreg, ds1302_writereg, ds1302_init
 *!
 *! ---------------------------------------------------------------------------
 *!
@@ -257,31 +257,6 @@ static long rtc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 }
 
-int
-get_rtc_status(char *buf)
-{
-	char *p;
-	struct rtc_time tm;
-
-	p = buf;
-
-	get_rtc_time(&tm);
-
-	/*
-	 * There is no way to tell if the luser has the RTC set for local
-	 * time or for Universal Standard Time (GMT). Probably local though.
-	 */
-
-	p += sprintf(p,
-		"rtc_time\t: %02d:%02d:%02d\n"
-		"rtc_date\t: %04d-%02d-%02d\n",
-		tm.tm_hour, tm.tm_min, tm.tm_sec,
-		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
-
-	return  p - buf;
-}
-
-
 /* The various file operations we support. */
 
 static const struct file_operations rtc_fops = {
@@ -298,6 +273,7 @@ static int __init
 ds1302_probe(void)
 {
 	int retval, res, baur;
+	struct rtc_time tm;
 
 	baur=(boot_cpu_data.bus_clock/(2*1000*1000));
 
@@ -319,8 +295,14 @@ ds1302_probe(void)
 		char buf[100];
 		ds1302_wdisable();
 		printk("%s: RTC found.\n", ds1302_name);
-		get_rtc_status(buf);
-		printk(buf);
+		/*
+		 * There is no way to tell if the luser has the RTC set
+		 * for local time or for Universal Standard Time (GMT).
+		 * Probably local though.
+		 */
+		get_rtc_time(&tm);
+		printk("rtc_time\t: %ptt\n", &tm);
+		printk("rtc_date\t: %ptd\n", &tm);
 		retval = 1;
 	} else {
 		printk("%s: RTC not found.\n", ds1302_name);
-- 
2.11.0
