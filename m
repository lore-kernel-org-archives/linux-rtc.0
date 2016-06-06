Return-Path: <rtc-linux+bncBDEKVJM7XAHRBD4I225AKGQEBUFKQAI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.131])
        by gmr-mx.google.com with ESMTPS id f69si112550wmf.3.2016.06.06.07.09.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2016 07:09:19 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: [rtc-linux] [PATCH] x86: include linux/ratelimit.h in nmi.c
Date: Mon,  6 Jun 2016 16:09:52 +0200
Message-Id: <1465222212-2579966-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

When building random configurations, we now occasionally get a new
build error:

   In file included from include/linux/kernel.h:13:0,
                    from include/linux/list.h:8,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:50,
                    from arch/x86/kernel/nmi.c:13:
   arch/x86/kernel/nmi.c: In function 'nmi_max_handler':
   include/linux/printk.h:375:9: error: type defaults to 'int' in declaration of 'DEFINE_RATELIMIT_STATE' [-Werror=implicit-int]
     static DEFINE_RATELIMIT_STATE(_rs,    \
            ^
   arch/x86/kernel/nmi.c:110:2: note: in expansion of macro 'printk_ratelimited'
     printk_ratelimited(KERN_INFO
     ^~~~~~~~~~~~~~~~~~

This was working before the rtc rework series because linux/ratelimit.h
was included implictly through asm/mach_traps.h -> asm/mc146818rtc.h
-> linux/mc146818rtc.h -> linux/rtc.h -> linux/device.h.

We clearly shouldn't rely on this indirect inclusion, so this adds
an explicit #include in the file that needs it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: 5ab788d73832 ("rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h")
---
It's only broken in the linux-rtc git at the moment, so it makes sense
to fix it there.

 arch/x86/kernel/nmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 04b132a767f1..bfe4d6c96fbd 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/hardirq.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 
-- 
2.7.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
