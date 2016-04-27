Return-Path: <rtc-linux+bncBDEKVJM7XAHRBDX5QS4QKGQEC7RNDXY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [217.72.192.73])
        by gmr-mx.google.com with ESMTPS id a65si121520wma.0.2016.04.27.15.34.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 15:34:54 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	geert@linux-m68k.org,
	deller@gmx.de,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au,
	dalias@libc.org,
	dhowells@redhat.com,
	linux-alpha@vger.kernel.org,
	a.zummo@towertech.it,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	rtc-linux@googlegroups.com,
	linux-arch@vger.kernel.org
Subject: [rtc-linux] [PATCH v3 06/16] char/genrtc: remove mn10300 support
Date: Thu, 28 Apr 2016 00:34:20 +0200
Message-Id: <1461796470-1291527-7-git-send-email-arnd@arndb.de>
In-Reply-To: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The genrtc driver serves no purpose on mn10300 because it drives the
same hardware as the original rtc.c driver, and the newer rtc-generic.c
or rtc-cmos.c drivers on architectures that use the asm-generic/rtc.h
header.

I assume it was initially only added for completeness when the
mn10300 port was done, but the older rtc.c driver was always used
instead.

We can also stop include asm-generic/rtc.h now, because we
just call mc146818_set_time() directly.

It would be nice to change the architecture to use the rtc-cmos driver
next, and remove support for the old rtc driver as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mn10300/include/asm/rtc.h | 2 --
 arch/mn10300/kernel/rtc.c      | 2 +-
 drivers/char/Kconfig           | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mn10300/include/asm/rtc.h b/arch/mn10300/include/asm/rtc.h
index 6c14bb1d0d9b..07dc87656197 100644
--- a/arch/mn10300/include/asm/rtc.h
+++ b/arch/mn10300/include/asm/rtc.h
@@ -25,6 +25,4 @@ static inline void calibrate_clock(void)
 
 #endif /* !CONFIG_MN10300_RTC */
 
-#include <asm-generic/rtc.h>
-
 #endif /* _ASM_RTC_H */
diff --git a/arch/mn10300/kernel/rtc.c b/arch/mn10300/kernel/rtc.c
index 48d7058b3295..77e0be4d92ea 100644
--- a/arch/mn10300/kernel/rtc.c
+++ b/arch/mn10300/kernel/rtc.c
@@ -27,7 +27,7 @@ void read_persistent_clock(struct timespec *ts)
 {
 	struct rtc_time tm;
 
-	get_rtc_time(&tm);
+	mc146818_set_time(&tm);
 
 	ts->tv_nsec = 0;
 	ts->tv_sec = mktime(tm.tm_year, tm.tm_mon, tm.tm_mday,
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 697510325b1d..d17ed90ebc82 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -328,7 +328,7 @@ config JS_RTC
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y
-	depends on M68K || MN10300 || PARISC || PPC
+	depends on M68K || PARISC || PPC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- 
2.7.0

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
