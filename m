Return-Path: <rtc-linux+bncBCGP7DNSRUMRB55H33AAKGQEIR36GGY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail1.windriver.com (mail1.windriver.com. [147.11.146.13])
        by gmr-mx.google.com with ESMTPS id n18si2080741pfb.2.2016.10.31.11.56.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 11:56:55 -0700 (PDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        "David S. Miller"
	<davem@davemloft.net>, <sparclinux@vger.kernel.org>,
        <rtc-linux@googlegroups.com>
Subject: [rtc-linux] [PATCH 2/3] rtc: sparc: make starfire explicitly non-modular
Date: Mon, 31 Oct 2016 14:55:26 -0400
Message-ID: <20161031185527.20279-3-paul.gortmaker@windriver.com>
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

drivers/rtc/Kconfig:config RTC_DRV_STARFIRE
drivers/rtc/Kconfig:    bool "Starfire RTC"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: rtc-linux@googlegroups.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/rtc/rtc-starfire.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-starfire.c b/drivers/rtc/rtc-starfire.c
index 83a057a03060..7fc36973fa33 100644
--- a/drivers/rtc/rtc-starfire.c
+++ b/drivers/rtc/rtc-starfire.c
@@ -1,20 +1,18 @@
 /* rtc-starfire.c: Starfire platform RTC driver.
  *
+ * Author: David S. Miller
+ * License: GPL
+ *
  * Copyright (C) 2008 David S. Miller <davem@davemloft.net>
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 
 #include <asm/oplib.h>
 
-MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
-MODULE_DESCRIPTION("Starfire RTC driver");
-MODULE_LICENSE("GPL");
-
 static u32 starfire_get_time(void)
 {
 	static char obp_gettod[32];
@@ -57,4 +55,4 @@ static struct platform_driver starfire_rtc_driver = {
 	},
 };
 
-module_platform_driver_probe(starfire_rtc_driver, starfire_rtc_probe);
+builtin_platform_driver_probe(starfire_rtc_driver, starfire_rtc_probe);
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
