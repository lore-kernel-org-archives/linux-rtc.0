Return-Path: <rtc-linux+bncBC7M5BFO7YCRBJUOY25AKGQEG3S5QBI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id x203si190730wme.0.2016.06.03.06.33.26
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Jun 2016 06:33:26 -0700 (PDT)
Received: from localhost (132.230.147.77.rev.sfr.net [77.147.230.132])
	by mail.free-electrons.com (Postfix) with ESMTPSA id 653E51C2
	for <rtc-linux@googlegroups.com>; Fri,  3 Jun 2016 15:33:21 +0200 (CEST)
Resent-Message-ID: <20160603133320.GC4594@piout.net>
From: Guenter Roeck <linux@roeck-us.net>
To: David Howells <dhowells@redhat.com>
Cc: linux-am33-list@redhat.com,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] mn10300: Add missing include file to proc-init.c
Date: Thu,  2 Jun 2016 17:38:28 -0700
Message-Id: <1464914308-10906-1-git-send-email-linux@roeck-us.net>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

mn10300:asb2303_defconfig fails to build as follows.

arch/mn10300/proc-mn103e010/proc-init.c: In function 'processor_init':
arch/mn10300/proc-mn103e010/proc-init.c:59:24: error: 'NR_IRQS' undeclared

Fixes: 4511118b5b44 ("char/genrtc: remove mn10300 support")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Applies to next-20160602. Feel free to merge into the original patch.

 arch/mn10300/proc-mn103e010/proc-init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mn10300/proc-mn103e010/proc-init.c b/arch/mn10300/proc-mn103e010/proc-init.c
index d4dcb0c56b35..94641c420b3f 100644
--- a/arch/mn10300/proc-mn103e010/proc-init.c
+++ b/arch/mn10300/proc-mn103e010/proc-init.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <asm/cacheflush.h>
 #include <asm/fpu.h>
+#include <asm/irq.h>
 #include <asm/rtc.h>
 #include <asm/busctl-regs.h>
 
-- 
2.5.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
