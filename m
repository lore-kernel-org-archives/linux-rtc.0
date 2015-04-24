Return-Path: <rtc-linux+bncBCEIBNMGTIJBBXUG5KUQKGQEPWA25JA@googlegroups.com>
MIME-Version: 1.0
Received: from complete.lackof.org (complete.lackof.org. [198.49.126.79])
        by gmr-mx.google.com with ESMTPS id x12si10526igx.1.2015.04.24.10.54.37
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2015 10:54:37 -0700 (PDT)
Received: from localhost (c-107-2-141-92.hsd1.co.comcast.net [107.2.141.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by complete.lackof.org (Postfix) with ESMTPSA id 14D9133E016F
	for <rtc-linux@googlegroups.com>; Fri, 24 Apr 2015 11:54:37 -0600 (MDT)
From: dann frazier <dannf@dannf.org>
To: rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] drivers/rtc/rtc-efi.c: Update author email address
Date: Fri, 24 Apr 2015 11:54:20 -0600
Message-Id: <1429898060-11360-1-git-send-email-dannf@dannf.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

I'm no longer employed by HP.

Signed-off-by: dann frazier <dannf@dannf.org>
---
 drivers/rtc/rtc-efi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index cb989cd..c5fbabb 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2009 Hewlett-Packard Development Company, L.P.
  *
- * Author: dann frazier <dannf@hp.com>
+ * Author: dann frazier <dannf@dannf.org>
  * Based on efirtc.c by Stephane Eranian
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -233,7 +233,7 @@ static struct platform_driver efi_rtc_driver = {
 module_platform_driver_probe(efi_rtc_driver, efi_rtc_probe);
 
 MODULE_ALIAS("platform:rtc-efi");
-MODULE_AUTHOR("dann frazier <dannf@hp.com>");
+MODULE_AUTHOR("dann frazier <dannf@dannf.org>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("EFI RTC driver");
 MODULE_ALIAS("platform:rtc-efi");
-- 
2.1.4

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
