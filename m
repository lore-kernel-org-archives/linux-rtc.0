Return-Path: <rtc-linux+bncBCGP7DNSRUMRB6FH33AAKGQERA4EUMY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail5.wrs.com (mail5.windriver.com. [192.103.53.11])
        by gmr-mx.google.com with ESMTPS id l13si1822980itl.1.2016.10.31.11.56.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2016 11:56:56 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 3/3] rtc: sparc: make sun4v explicitly non-modular
Date: Mon, 31 Oct 2016 14:55:27 -0400
Message-ID: <20161031185527.20279-4-paul.gortmaker@windriver.com>
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

drivers/rtc/Kconfig:config RTC_DRV_SUN4V
drivers/rtc/Kconfig:    bool "SUN4V Hypervisor RTC"

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
 drivers/rtc/rtc-sun4v.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-sun4v.c b/drivers/rtc/rtc-sun4v.c
index 7c696c12f28f..11bc562eba5d 100644
--- a/drivers/rtc/rtc-sun4v.c
+++ b/drivers/rtc/rtc-sun4v.c
@@ -1,12 +1,14 @@
 /* rtc-sun4v.c: Hypervisor based RTC for SUN4V systems.
  *
+ * Author: David S. Miller
+ * License: GPL
+ *
  * Copyright (C) 2008 David S. Miller <davem@davemloft.net>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/rtc.h>
@@ -98,8 +100,4 @@ static struct platform_driver sun4v_rtc_driver = {
 	},
 };
 
-module_platform_driver_probe(sun4v_rtc_driver, sun4v_rtc_probe);
-
-MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
-MODULE_DESCRIPTION("SUN4V RTC driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver_probe(sun4v_rtc_driver, sun4v_rtc_probe);
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
