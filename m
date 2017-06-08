Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42109 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752020AbdFHNsc (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
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
Subject: [PATCH v1 03/25] lib/vsprintf: Make strspec global
Date: Thu,  8 Jun 2017 16:47:49 +0300
Message-Id: <20170608134811.60786-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

There is at least one new user is coming where default specification to print
strings is in use.

Make it global.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d43dbf6b862e..001303612b55 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -691,6 +691,11 @@ char *symbol_string(char *buf, char *end, void *ptr,
 #endif
 }
 
+static const struct printf_spec default_str_spec = {
+	.field_width = -1,
+	.precision = -1,
+};
+
 static const struct printf_spec default_dec_spec = {
 	.base = 10,
 	.precision = -1,
@@ -1399,10 +1404,6 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 					const struct trace_print_flags *names)
 {
 	unsigned long mask;
-	const struct printf_spec strspec = {
-		.field_width = -1,
-		.precision = -1,
-	};
 	const struct printf_spec numspec = {
 		.flags = SPECIAL|SMALL,
 		.field_width = -1,
@@ -1415,7 +1416,7 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 		if ((flags & mask) != mask)
 			continue;
 
-		buf = string(buf, end, names->name, strspec);
+		buf = string(buf, end, names->name, default_str_spec);
 
 		flags &= ~mask;
 		if (flags) {
-- 
2.11.0
