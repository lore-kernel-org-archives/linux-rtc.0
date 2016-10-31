Return-Path: <rtc-linux+bncBCGP7DNSRUMRB5NH33AAKGQEU6QIHCQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.windriver.com (mail.windriver.com. [147.11.1.11])
        by gmr-mx.google.com with ESMTPS id h11si4801235pfe.0.2016.10.31.11.56.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 11:56:53 -0700 (PDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        <rtc-linux@googlegroups.com>
Subject: [rtc-linux] [PATCH 1/3] rtc: make rtc-lib explicitly non-modular
Date: Mon, 31 Oct 2016 14:55:25 -0400
Message-ID: <20161031185527.20279-2-paul.gortmaker@windriver.com>
In-Reply-To: <20161031185527.20279-1-paul.gortmaker@windriver.com>
References: <20161031185527.20279-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The Kconfig currently controlling compilation of this code is:

drivers/rtc/Kconfig:config RTC_LIB
drivers/rtc/Kconfig:    bool

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We delete the MODULE_LICENSE tag since all that information
is already contained at the top of the file in the comments.

We don't replace module.h with init.h since the file doesn't need that.
However we do add export.h since the file uses EXPORT_SYMBOL.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/rtc/rtc-lib.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index e6bfb9c42a10..1ae7da5cfc60 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -11,7 +11,7 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/rtc.h>
 
 static const unsigned char rtc_days_in_month[] = {
@@ -148,5 +148,3 @@ struct rtc_time rtc_ktime_to_tm(ktime_t kt)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(rtc_ktime_to_tm);
-
-MODULE_LICENSE("GPL");
-- 
2.10.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
