Return-Path: <rtc-linux+bncBDEKVJM7XAHRBYOC764AKGQE5BKBRFY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.135])
        by gmr-mx.google.com with ESMTPS id a65si761243wma.0.2016.04.26.14.45.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2016 14:45:05 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	tony.luck@intel.com,
	geert@linux-m68k.org,
	jejb@parisc-linux.org,
	deller@gmx.de,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au,
	dalias@libc.org,
	dhowells@redhat.com,
	yasutake.koichi@jp.panasonic.com,
	rth@twiddle.net,
	ink@jurassic.park.msu.ru,
	linux-alpha@vger.kernel.org,
	x86@kernel.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-arch@vger.kernel.org
Subject: [rtc-linux] [PATCH 5/8] char/genrtc: powerpc: use asm-generic/rtc.h
Date: Tue, 26 Apr 2016 23:44:09 +0200
Message-Id: <1461707052-1337718-6-git-send-email-arnd@arndb.de>
In-Reply-To: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The asm-generic/rtc.h header can now be included by
architectures that provide their own set_rtc_time/get_rtc_time
macros, letting us remove most of the common contents in
the powerpc implementation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/rtc.h | 36 +++++-------------------------------
 1 file changed, 5 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/rtc.h b/arch/powerpc/include/asm/rtc.h
index f5802926b6c0..c6659582bd1e 100644
--- a/arch/powerpc/include/asm/rtc.h
+++ b/arch/powerpc/include/asm/rtc.h
@@ -26,23 +26,14 @@
 
 #ifdef __KERNEL__
 
-#include <linux/rtc.h>
+#define get_rtc_time powerpc_get_rtc_time
+#define set_rtc_time powerpc_set_rtc_time
+#include <asm-generic/rtc.h>
 
 #include <asm/machdep.h>
 #include <asm/time.h>
 
-#define RTC_PIE 0x40		/* periodic interrupt enable */
-#define RTC_AIE 0x20		/* alarm interrupt enable */
-#define RTC_UIE 0x10		/* update-finished interrupt enable */
-
-/* some dummy definitions */
-#define RTC_BATT_BAD 0x100	/* battery bad */
-#define RTC_SQWE 0x08		/* enable square-wave output */
-#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
-#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
-#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
-
-static inline unsigned int get_rtc_time(struct rtc_time *time)
+static inline unsigned int powerpc_get_rtc_time(struct rtc_time *time)
 {
 	if (ppc_md.get_rtc_time)
 		ppc_md.get_rtc_time(time);
@@ -50,29 +41,12 @@ static inline unsigned int get_rtc_time(struct rtc_time *time)
 }
 
 /* Set the current date and time in the real time clock. */
-static inline int set_rtc_time(struct rtc_time *time)
+static inline int powerpc_set_rtc_time(struct rtc_time *time)
 {
 	if (ppc_md.set_rtc_time)
 		return ppc_md.set_rtc_time(time);
 	return -EINVAL;
 }
 
-static inline unsigned int get_rtc_ss(void)
-{
-	struct rtc_time h;
-
-	get_rtc_time(&h);
-	return h.tm_sec;
-}
-
-static inline int get_rtc_pll(struct rtc_pll_info *pll)
-{
-	return -EINVAL;
-}
-static inline int set_rtc_pll(struct rtc_pll_info *pll)
-{
-	return -EINVAL;
-}
-
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_RTC_H__ */
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
