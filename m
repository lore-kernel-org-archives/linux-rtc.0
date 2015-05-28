Return-Path: <rtc-linux+bncBCW6VIXX2AARBPX7TSVQKGQEGY2RYGQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-lb0-x235.google.com (mail-lb0-x235.google.com. [2a00:1450:4010:c04::235])
        by gmr-mx.google.com with ESMTPS id bm9si206368lbb.0.2015.05.28.09.18.06
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 09:18:06 -0700 (PDT)
Received: by mail-lb0-x235.google.com with SMTP id qq2so31762229lbb.3
        for <rtc-linux@googlegroups.com>; Thu, 28 May 2015 09:18:06 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Russell King <linux@arm.linux.org.uk>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] rtc: sa1100: drop mach/irqs.h include
Date: Thu, 28 May 2015 19:17:42 +0300
Message-Id: <1432829862-13614-1-git-send-email-dbaryshkov@gmail.com>
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

There is no reason to include <mach/irqs.h> anymore - the driver gets
IRQs via platform_get_irq_byname().

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/rtc/rtc-sa1100.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index b6e1ca0..c221527 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -36,7 +36,6 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <mach/irqs.h>
 
 #if defined(CONFIG_ARCH_PXA) || defined(CONFIG_ARCH_MMP)
 #include <mach/regs-rtc.h>
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
