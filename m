Return-Path: <rtc-linux+bncBCGP7DNSRUMRBU53QO3AKGQE326LYLI@googlegroups.com>
Received: from mail.windriver.com (mail.windriver.com. [147.11.1.11])
        by gmr-mx.google.com with ESMTPS id u66si2664002pfa.2.2016.02.14.12.04.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Feb 2016 12:04:35 -0800 (PST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        <rtc-linux@googlegroups.com>
Subject: [rtc-linux] [PATCH] drivers/rtc: make class.c explicitly non-modular
Date: Sun, 14 Feb 2016 15:04:19 -0500
Message-ID: <1455480259-13433-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The Makefile/Kconfig currently controlling compilation of this code is:

obj-$(CONFIG_RTC_CLASS)         += rtc-core.o
rtc-core-y                      := class.o interface.o

drivers/rtc/Kconfig:menuconfig RTC_CLASS
drivers/rtc/Kconfig:    bool "Real Time Clock"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the code there is no doubt it is builtin-only.

We don't replace module.h with init.h since the file does need
to know what a struct module is.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/rtc/class.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index de86578bcd6d..74fd9746aeca 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -361,17 +361,4 @@ static int __init rtc_init(void)
 	rtc_dev_init();
 	return 0;
 }
-
-static void __exit rtc_exit(void)
-{
-	rtc_dev_exit();
-	class_destroy(rtc_class);
-	ida_destroy(&rtc_ida);
-}
-
 subsys_initcall(rtc_init);
-module_exit(rtc_exit);
-
-MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
-MODULE_DESCRIPTION("RTC class support");
-MODULE_LICENSE("GPL");
-- 
2.5.0

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
