Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13919 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbdFHNsW (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Jun 2017 09:48:22 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 01/25] lib/vsprintf: Remove useless NULL checks
Date: Thu,  8 Jun 2017 16:47:47 +0300
Message-Id: <20170608134811.60786-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
References: <20170608134811.60786-1-andriy.shevchenko@linux.intel.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The pointer can't be NULL since it's first what has been done in the
pointer().

Remove useless checks.

Note when we print clock name or rate it is safe in case !CONFIG_HAVE_CLK.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 9f16406288c0..031c2cc5c1c0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -811,10 +811,6 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		/* nothing to print */
 		return buf;
 
-	if (ZERO_OR_NULL_PTR(addr))
-		/* NULL pointer */
-		return string(buf, end, NULL, spec);
-
 	switch (fmt[1]) {
 	case 'C':
 		separator = ':';
@@ -1253,10 +1249,6 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	if (spec.field_width == 0)
 		return buf;				/* nothing to print */
 
-	if (ZERO_OR_NULL_PTR(addr))
-		return string(buf, end, NULL, spec);	/* NULL pointer */
-
-
 	do {
 		switch (fmt[count++]) {
 		case 'a':
@@ -1391,9 +1383,6 @@ static noinline_for_stack
 char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	    const char *fmt)
 {
-	if (!IS_ENABLED(CONFIG_HAVE_CLK) || !clk)
-		return string(buf, end, NULL, spec);
-
 	switch (fmt[1]) {
 	case 'r':
 		return number(buf, end, clk_get_rate(clk), spec);
-- 
2.11.0
