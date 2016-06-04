Return-Path: <rtc-linux+bncBDEKVJM7XAHRBMOCZK5AKGQEPIJXMJI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.130])
        by gmr-mx.google.com with ESMTPS id x203si78306wme.0.2016.06.04.02.36.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2016 02:36:49 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	rtc-linux@googlegroups.com,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Subject: [rtc-linux] [PATCH] sparc32: remove stale RTC_PORT definition
Date: Sat,  4 Jun 2016 11:36:44 +0200
Message-Id: <1465033041-2512569-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

sparc32:allmodconfig fails to build in next-20160602 as follows.

In file included from drivers/block/floppy.c:185:0:
include/linux/mc146818rtc.h: In function 'mc146818_is_updating':
include/linux/mc146818rtc.h:138:9: error: 'rtc_port' undeclared (first use in this function)
include/linux/mc146818rtc.h:138:9: note: each undeclared identifier is reported only once for each function it appears in
include/linux/mc146818rtc.h: In function 'mc146818_get_time':
include/linux/mc146818rtc.h:172:17: error: 'rtc_port' undeclared (first use in this function)
include/linux/mc146818rtc.h: In function 'mc146818_set_time':
include/linux/mc146818rtc.h:278:8: error: 'rtc_port' undeclared (first use in this function)
scripts/Makefile.build:295: recipe for target 'drivers/block/floppy.o' failed

The reason is a duplicate definition of the RTC_PORT macro. The
one in arch/sparc/include/asm/io_32.h was apparently used a long time
ago for the drivers/char/rtc.c driver that is not available on SPARC
any more, since we now select 'RTC_CLASS' unconditionally.

Removing the macro fixes the build problem, and for consistency,
this also removes the RTC_ALWAYS_BCD macro and the comment for both.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: fd09cc80165c ("rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h")
---
I thought I'd sent this out yesterday, but cannot find an indication of
that now, and Alexandre didn't seem to get it. This should probably
go through the rtc tree that introduced the build failure after my
earlier patches

 arch/sparc/include/asm/io_32.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 57f26c398dc9..4dd268a3a8b0 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -140,16 +140,6 @@ void ioport_unmap(void __iomem *);
 struct pci_dev;
 void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
-
-
-/*
- * At the moment, we do not use CMOS_READ anywhere outside of rtc.c,
- * so rtc_port is static in it. This should not change unless a new
- * hardware pops up.
- */
-#define RTC_PORT(x)   (rtc_port + (x))
-#define RTC_ALWAYS_BCD  0
-
 static inline int sbus_can_dma_64bit(void)
 {
 	return 0; /* actually, sparc_cpu_model==sun4d */
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
