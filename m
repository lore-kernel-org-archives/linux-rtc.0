Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7634 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751385AbeBTVoM (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
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
Subject: [PATCH v2 18/21] ds1302: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:57 +0200
Message-Id: <20180220214400.66749-19-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/Kconfig  |  1 +
 drivers/char/ds1302.c | 39 ++++++++++-----------------------------
 2 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c96e00ebeae9..2bd83d3951c1 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -350,6 +350,7 @@ config EFI_RTC
 config DS1302
 	tristate "DS1302 RTC support"
 	depends on M32R && (PLAT_M32700UT || PLAT_OPSPUT)
+	select PRINTK_PEXT_TIMEDATE
 	help
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 121 and minor number 0 using mknod ("man mknod"), you
diff --git a/drivers/char/ds1302.c b/drivers/char/ds1302.c
index 8e16ad5d6d89..1e8bd9bf4bc9 100644
--- a/drivers/char/ds1302.c
+++ b/drivers/char/ds1302.c
@@ -5,7 +5,7 @@
 *!
 *! DESCRIPTION: Implements an interface for the DS1302 RTC
 *!
-*! Functions exported: ds1302_readreg, ds1302_writereg, ds1302_init, get_rtc_status
+*! Functions exported: ds1302_readreg, ds1302_writereg, ds1302_init
 *!
 *! ---------------------------------------------------------------------------
 *!
@@ -258,31 +258,6 @@ static long rtc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
@@ -299,6 +274,7 @@ static int __init
 ds1302_probe(void)
 {
 	int retval, res, baur;
+	struct rtc_time tm;
 
 	baur=(boot_cpu_data.bus_clock/(2*1000*1000));
 
@@ -317,11 +293,16 @@ ds1302_probe(void)
 
 	/* read RAM byte 0 */
 	if((res = in_byte_rtc(0xc1)) == MAGIC_PATTERN) {
-		char buf[100];
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
+		printk("rtc_time\t: %ptRt\n", &tm);
+		printk("rtc_date\t: %ptRd\n", &tm);
 		retval = 1;
 	} else {
 		printk("%s: RTC not found.\n", ds1302_name);
-- 
2.15.1
