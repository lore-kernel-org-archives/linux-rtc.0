Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:24357 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbdFHNsx (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:53 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v1 04/25] lib/vsprintf: Print time and date in human readable format via %pt
Date: Thu,  8 Jun 2017 16:47:50 +0300
Message-Id: <20170608134811.60786-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

There are users which print time and date represented by content of
struct rtc_time in human readable format.

Instead of open coding that each time introduce %pt[dt][rv] specifier.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/printk-formats.txt |  17 ++++++
 lib/vsprintf.c                   | 124 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/Documentation/printk-formats.txt b/Documentation/printk-formats.txt
index d8c40c30118a..fa5b718a5dcc 100644
--- a/Documentation/printk-formats.txt
+++ b/Documentation/printk-formats.txt
@@ -282,6 +282,23 @@ struct va_format:
 
 	Passed by reference.
 
+struct rtc_time:
+
+	%pt		YYYY-mm-dd HH:MM:SS
+	%ptd		YYYY-mm-dd
+	%ptt		HH:MM:SS
+	%pt[dt][rv]
+
+	For printing date and time as represented by struct rtc_time
+	structure in human readable format.
+
+	By default year will be incremented by 1900 and month by 1. Use
+	'r' (raw) to suppress this behaviour. On the other hand when
+	'v' is applied validation mechanism will be in use, i.e. numbers
+	out of range will be replaced by '**' or '****'.
+
+	Passed by reference.
+
 struct clk:
 
 	%pC	pll1
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 001303612b55..653d08b50850 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -30,6 +30,7 @@
 #include <linux/ioport.h>
 #include <linux/dcache.h>
 #include <linux/cred.h>
+#include <linux/rtc.h>
 #include <linux/uuid.h>
 #include <net/addrconf.h>
 #ifdef CONFIG_BLOCK
@@ -701,6 +702,20 @@ static const struct printf_spec default_dec_spec = {
 	.precision = -1,
 };
 
+static const struct printf_spec default_dec02_spec = {
+	.base = 10,
+	.field_width = 2,
+	.precision = -1,
+	.flags = ZEROPAD,
+};
+
+static const struct printf_spec default_dec04_spec = {
+	.base = 10,
+	.field_width = 4,
+	.precision = -1,
+	.flags = ZEROPAD,
+};
+
 static noinline_for_stack
 char *resource_string(char *buf, char *end, struct resource *res,
 		      struct printf_spec spec, const char *fmt)
@@ -1382,6 +1397,112 @@ char *address_val(char *buf, char *end, const void *addr, const char *fmt)
 }
 
 static noinline_for_stack
+char *date_string(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
+{
+	int year = tm->tm_year + (r ? 0 : 1900);
+	int mon = tm->tm_mon + (r ? 0 : 1);
+
+	if (unlikely(v && (unsigned int)tm->tm_year > 200))
+		buf = string(buf, end, "****", default_str_spec);
+	else
+		buf = number(buf, end, year, default_dec04_spec);
+
+	if (buf < end)
+		*buf = '-';
+	buf++;
+
+	if (unlikely(v && (unsigned int)tm->tm_mon > 11))
+		buf = string(buf, end, "**", default_str_spec);
+	else
+		buf = number(buf, end, mon, default_dec02_spec);
+
+	if (buf < end)
+		*buf = '-';
+	buf++;
+
+	if (unlikely(v && (unsigned int)tm->tm_mday > 31))
+		buf = string(buf, end, "**", default_str_spec);
+	else
+		buf = number(buf, end, tm->tm_mday, default_dec02_spec);
+
+	return buf;
+}
+
+static noinline_for_stack
+char *time_string(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
+{
+	if (unlikely(v && (unsigned int)tm->tm_hour > 24))
+		buf = string(buf, end, "**", default_str_spec);
+	else
+		buf = number(buf, end, tm->tm_hour, default_dec02_spec);
+
+	if (buf < end)
+		*buf = ':';
+	buf++;
+
+	if (unlikely(v && (unsigned int)tm->tm_min > 59))
+		buf = string(buf, end, "**", default_str_spec);
+	else
+		buf = number(buf, end, tm->tm_min, default_dec02_spec);
+
+	if (buf < end)
+		*buf = ':';
+	buf++;
+
+	if (unlikely(v && (unsigned int)tm->tm_sec > 59))
+		buf = string(buf, end, "**", default_str_spec);
+	else
+		buf = number(buf, end, tm->tm_sec, default_dec02_spec);
+
+	return buf;
+}
+
+static noinline_for_stack
+char *timeanddate(char *buf, char *end, const struct rtc_time *tm, const char *fmt)
+{
+	bool have_t = true, have_d = true;
+	bool validate = false;
+	bool raw = false;
+	int count = 0;
+	bool found;
+
+	switch (fmt[++count]) {
+	case 'd':
+		have_t = false;
+		break;
+	case 't':
+		have_d = false;
+		break;
+	}
+
+	/* No %pt[dt] supplied */
+	if (have_t && have_d)
+		--count;
+
+	found = true;
+	do {
+		switch (fmt[++count]) {
+		case 'r':
+			raw = true;
+			break;
+		case 'v':
+			validate = true;
+			break;
+		default:
+			found = false;
+			break;
+		}
+	} while (found);
+
+	if (have_d)
+		buf = date_string(buf, end, tm, validate, raw);
+	if (have_t)
+		buf = time_string(buf, end, tm, validate, raw);
+
+	return buf;
+}
+
+static noinline_for_stack
 char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	    const char *fmt)
 {
@@ -1550,6 +1671,7 @@ int kptr_restrict __read_mostly;
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
  * - 'D[234]' Same as 'd' but for a struct file
  * - 'g' For block_device name (gendisk + partition number)
+ * - 't[dt][rv]' For time and date as represented in struct rtc_time
  * - 'C' For a clock, it prints the name (Common Clock Framework) or address
  *       (legacy clock framework) of the clock
  * - 'Cn' For a clock, it prints the name (Common Clock Framework) or address
@@ -1702,6 +1824,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return address_val(buf, end, ptr, fmt);
 	case 'd':
 		return dentry_name(buf, end, ptr, spec, fmt);
+	case 't':
+		return timeanddate(buf, end, (const struct rtc_time *)ptr, fmt);
 	case 'C':
 		return clock(buf, end, ptr, spec, fmt);
 	case 'D':
-- 
2.11.0
