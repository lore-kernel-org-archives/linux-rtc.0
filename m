Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6203 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbdFHNtB (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:49:01 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 02/25] lib/vsprintf: Make decspec global
Date: Thu,  8 Jun 2017 16:47:48 +0300
Message-Id: <20170608134811.60786-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

There are places where default specification to print decimal numbers
is in use.

Make it global and convert existing users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 031c2cc5c1c0..d43dbf6b862e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -691,6 +691,11 @@ char *symbol_string(char *buf, char *end, void *ptr,
 #endif
 }
 
+static const struct printf_spec default_dec_spec = {
+	.base = 10,
+	.precision = -1,
+};
+
 static noinline_for_stack
 char *resource_string(char *buf, char *end, struct resource *res,
 		      struct printf_spec spec, const char *fmt)
@@ -720,11 +725,6 @@ char *resource_string(char *buf, char *end, struct resource *res,
 		.precision = -1,
 		.flags = SMALL | ZEROPAD,
 	};
-	static const struct printf_spec dec_spec = {
-		.base = 10,
-		.precision = -1,
-		.flags = 0,
-	};
 	static const struct printf_spec str_spec = {
 		.field_width = -1,
 		.precision = 10,
@@ -758,10 +758,10 @@ char *resource_string(char *buf, char *end, struct resource *res,
 		specp = &mem_spec;
 	} else if (res->flags & IORESOURCE_IRQ) {
 		p = string(p, pend, "irq ", str_spec);
-		specp = &dec_spec;
+		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_DMA) {
 		p = string(p, pend, "dma ", str_spec);
-		specp = &dec_spec;
+		specp = &default_dec_spec;
 	} else if (res->flags & IORESOURCE_BUS) {
 		p = string(p, pend, "bus ", str_spec);
 		specp = &bus_spec;
@@ -897,9 +897,6 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 	int cur, rbot, rtop;
 	bool first = true;
 
-	/* reused to print numbers */
-	spec = (struct printf_spec){ .base = 10 };
-
 	rbot = cur = find_first_bit(bitmap, nr_bits);
 	while (cur < nr_bits) {
 		rtop = cur;
@@ -914,13 +911,13 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
 		}
 		first = false;
 
-		buf = number(buf, end, rbot, spec);
+		buf = number(buf, end, rbot, default_dec_spec);
 		if (rbot < rtop) {
 			if (buf < end)
 				*buf = '-';
 			buf++;
 
-			buf = number(buf, end, rtop, spec);
+			buf = number(buf, end, rtop, default_dec_spec);
 		}
 
 		rbot = cur;
-- 
2.11.0
