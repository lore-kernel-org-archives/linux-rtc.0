Return-Path: <rtc-linux+bncBCQO3K444ANRBLGP5WWAKGQEO5ZZCWA@googlegroups.com>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com. [2607:f8b0:400e:c02::22d])
        by gmr-mx.google.com with ESMTPS id tq2si2128184pbc.0.2015.07.06.22.46.20
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 22:46:20 -0700 (PDT)
Received: by pdbep18 with SMTP id ep18so119177664pdb.1
        for <rtc-linux@googlegroups.com>; Mon, 06 Jul 2015 22:46:20 -0700 (PDT)
Date: Tue, 7 Jul 2015 11:16:14 +0530
From: Vaishali Thakkar <vthakkar1994@gmail.com>
To: Joshua Kinard <kumba@gentoo.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: rtc-ds1685: Use module_platform_driver
Message-ID: <20150707054614.GA9829@vaishali-Ideapad-Z570>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Use module_platform_driver for drivers whose init and exit functions
only register and unregister, respectively.

A simplified version of the Coccinelle semantic patch that performs
this transformation is as follows:

@a@
identifier f, x;
@@
-static f(...) { return platform_driver_register(&x); }

@b depends on a@
identifier e, a.x;
@@
-static e(...) { platform_driver_unregister(&x); }

@c depends on a && b@
identifier a.f;
declarer name module_init;
@@
-module_init(f);

@d depends on a && b && c@
identifier b.e, a.x;
declarer name module_exit;
declarer name module_platform_driver;
@@
-module_exit(e);
+module_platform_driver(x);

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/rtc/rtc-ds1685.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 818a363..05a51ef 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -2145,27 +2145,7 @@ static struct platform_driver ds1685_rtc_driver = {
 	.probe		= ds1685_rtc_probe,
 	.remove		= ds1685_rtc_remove,
 };
-
-/**
- * ds1685_rtc_init - rtc module init.
- */
-static int __init
-ds1685_rtc_init(void)
-{
-	return platform_driver_register(&ds1685_rtc_driver);
-}
-
-/**
- * ds1685_rtc_exit - rtc module exit.
- */
-static void __exit
-ds1685_rtc_exit(void)
-{
-	platform_driver_unregister(&ds1685_rtc_driver);
-}
-
-module_init(ds1685_rtc_init);
-module_exit(ds1685_rtc_exit);
+module_platform_driver(ds1685_rtc_driver);
 /* ----------------------------------------------------------------------- */
 
 
-- 
1.9.1

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
