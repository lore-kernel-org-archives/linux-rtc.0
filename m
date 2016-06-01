Return-Path: <rtc-linux+bncBDEKVJM7XAHRB6XKXO5AKGQE3CK75DY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.134])
        by gmr-mx.google.com with ESMTPS id f142si84891wmf.3.2016.06.01.07.47.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2016 07:47:21 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-am33-list@redhat.com,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 1/2] mn10300: use RTC_DRV_CMOS instead of CONFIG_RTC
Date: Wed,  1 Jun 2016 16:46:22 +0200
Message-Id: <1464792470-1565319-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

nn10300 has a dependency on mc146818_get_time/mc146818_set_time,
which we want to move from the mc146818rtc.h header into the
rtc subsystem, which in turn is not usable on mn10300.

This changes mn10300 to use the modern rtc-cmos driver instead
of the old RTC driver, and that in turn lets us completely
remove the read_persistent_clock/update_persistent_clock callbacks.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
We should probably get both these patches through the rtc tree, but
it would be nice to have some confirmation from the mn10300 maintainer
that this is a reasonable patch.

 arch/mn10300/Kconfig                    |   4 +-
 arch/mn10300/include/asm/rtc-regs.h     |   4 +-
 arch/mn10300/kernel/rtc.c               | 104 +++-----------------------------
 arch/mn10300/proc-mn103e010/proc-init.c |   1 +
 drivers/char/Kconfig                    |   2 +-
 drivers/rtc/Kconfig                     |   2 +-
 drivers/rtc/rtc-cmos.c                  |   2 +-
 7 files changed, 18 insertions(+), 101 deletions(-)

diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
index 9627e81a6cbb..38e3494bfb63 100644
--- a/arch/mn10300/Kconfig
+++ b/arch/mn10300/Kconfig
@@ -236,7 +236,9 @@ source "kernel/Kconfig.hz"
 config MN10300_RTC
 	bool "Using MN10300 RTC"
 	depends on MN10300_PROC_MN103E010 || MN10300_PROC_MN2WS0050
-	select GENERIC_CMOS_UPDATE
+	select RTC_CLASS
+	select RTC_DRV_CMOS
+	select RTC_SYSTOHC
 	default n
 	help
 	  This option enables support for the RTC, thus enabling time to be
diff --git a/arch/mn10300/include/asm/rtc-regs.h b/arch/mn10300/include/asm/rtc-regs.h
index c42deefaec11..c81cacecb6e3 100644
--- a/arch/mn10300/include/asm/rtc-regs.h
+++ b/arch/mn10300/include/asm/rtc-regs.h
@@ -75,9 +75,9 @@
 #define RTC_PORT(x)		0xd8600000
 #define RTC_ALWAYS_BCD		1	/* RTC operates in binary mode */
 
-#define CMOS_READ(addr)		__SYSREG(0xd8600000 + (addr), u8)
+#define CMOS_READ(addr)		__SYSREG(0xd8600000 + (u32)(addr), u8)
 #define CMOS_WRITE(val, addr)	\
-	do { __SYSREG(0xd8600000 + (addr), u8) = val; } while (0)
+	do { __SYSREG(0xd8600000 + (u32)(addr), u8) = val; } while (0)
 
 #define RTC_IRQ			RTIRQ
 
diff --git a/arch/mn10300/kernel/rtc.c b/arch/mn10300/kernel/rtc.c
index 77e0be4d92ea..f81f37025072 100644
--- a/arch/mn10300/kernel/rtc.c
+++ b/arch/mn10300/kernel/rtc.c
@@ -12,107 +12,19 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mc146818rtc.h>
-#include <linux/bcd.h>
-#include <linux/timex.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+
 #include <asm/rtc-regs.h>
 #include <asm/rtc.h>
 
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
-/*
- * Read the current RTC time
- */
-void read_persistent_clock(struct timespec *ts)
-{
-	struct rtc_time tm;
-
-	mc146818_set_time(&tm);
-
-	ts->tv_nsec = 0;
-	ts->tv_sec = mktime(tm.tm_year, tm.tm_mon, tm.tm_mday,
-			    tm.tm_hour, tm.tm_min, tm.tm_sec);
-
-	/* if rtc is way off in the past, set something reasonable */
-	if (ts->tv_sec < 0)
-		ts->tv_sec = mktime(2009, 1, 1, 12, 0, 0);
-}
-
-/*
- * In order to set the CMOS clock precisely, set_rtc_mmss has to be called 500
- * ms after the second nowtime has started, because when nowtime is written
- * into the registers of the CMOS clock, it will jump to the next second
- * precisely 500 ms later.  Check the Motorola MC146818A or Dallas DS12887 data
- * sheet for details.
- *
- * BUG: This routine does not handle hour overflow properly; it just
- *      sets the minutes. Usually you'll only notice that after reboot!
- */
-static int set_rtc_mmss(unsigned long nowtime)
-{
-	unsigned char save_control, save_freq_select;
-	int retval = 0;
-	int real_seconds, real_minutes, cmos_minutes;
-
-	/* gets recalled with irq locally disabled */
-	spin_lock(&rtc_lock);
-	save_control = CMOS_READ(RTC_CONTROL); /* tell the clock it's being
-						* set */
-	CMOS_WRITE(save_control | RTC_SET, RTC_CONTROL);
-
-	save_freq_select = CMOS_READ(RTC_FREQ_SELECT); /* stop and reset
-							* prescaler */
-	CMOS_WRITE(save_freq_select | RTC_DIV_RESET2, RTC_FREQ_SELECT);
-
-	cmos_minutes = CMOS_READ(RTC_MINUTES);
-	if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-		cmos_minutes = bcd2bin(cmos_minutes);
-
-	/*
-	 * since we're only adjusting minutes and seconds,
-	 * don't interfere with hour overflow. This avoids
-	 * messing with unknown time zones but requires your
-	 * RTC not to be off by more than 15 minutes
-	 */
-	real_seconds = nowtime % 60;
-	real_minutes = nowtime / 60;
-	if (((abs(real_minutes - cmos_minutes) + 15) / 30) & 1)
-		/* correct for half hour time zone */
-		real_minutes += 30;
-	real_minutes %= 60;
-
-	if (abs(real_minutes - cmos_minutes) < 30) {
-		if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
-			real_seconds = bin2bcd(real_seconds);
-			real_minutes = bin2bcd(real_minutes);
-		}
-		CMOS_WRITE(real_seconds, RTC_SECONDS);
-		CMOS_WRITE(real_minutes, RTC_MINUTES);
-	} else {
-		printk_once(KERN_NOTICE
-		       "set_rtc_mmss: can't update from %d to %d\n",
-		       cmos_minutes, real_minutes);
-		retval = -1;
-	}
-
-	/* The following flags have to be released exactly in this order,
-	 * otherwise the DS12887 (popular MC146818A clone with integrated
-	 * battery and quartz) will not reset the oscillator and will not
-	 * update precisely 500 ms later. You won't find this mentioned in
-	 * the Dallas Semiconductor data sheets, but who believes data
-	 * sheets anyway ...                           -- Markus Kuhn
-	 */
-	CMOS_WRITE(save_control, RTC_CONTROL);
-	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
-	spin_unlock(&rtc_lock);
-
-	return retval;
-}
-
-int update_persistent_clock(struct timespec now)
-{
-	return set_rtc_mmss(now.tv_sec);
-}
+static const __initdata struct resource res[] = {
+	DEFINE_RES_IO(RTC_PORT(0), RTC_IO_EXTENT),
+	DEFINE_RES_IRQ(RTC_IRQ),
+};
 
 /*
  * calibrate the TSC clock against the RTC
@@ -129,4 +41,6 @@ void __init calibrate_clock(void)
 	RTCRA |= RTCRA_DVR;
 	RTCRA &= ~RTCRA_DVR;
 	RTCRB &= ~RTCRB_SET;
+
+	platform_device_register_simple("rtc_cmos", -1, res, ARRAY_SIZE(res));
 }
diff --git a/arch/mn10300/proc-mn103e010/proc-init.c b/arch/mn10300/proc-mn103e010/proc-init.c
index d4dcb0c56b35..f4990dffff94 100644
--- a/arch/mn10300/proc-mn103e010/proc-init.c
+++ b/arch/mn10300/proc-mn103e010/proc-init.c
@@ -9,6 +9,7 @@
  * 2 of the Licence, or (at your option) any later version.
  */
 #include <linux/kernel.h>
+#include <linux/irq.h>
 #include <asm/cacheflush.h>
 #include <asm/fpu.h>
 #include <asm/rtc.h>
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 0ec91cc6c2fb..273b5492fbcf 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -279,7 +279,7 @@ if RTC_LIB=n
 
 config RTC
 	tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
-	depends on ALPHA || (MIPS && MACH_LOONGSON64) || MN10300
+	depends on ALPHA || (MIPS && MACH_LOONGSON64)
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 18639e0cb6e2..e8ef709f3945 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -795,7 +795,7 @@ comment "Platform RTC drivers"
 
 config RTC_DRV_CMOS
 	tristate "PC-style 'CMOS'"
-	depends on X86 || ARM || M32R || PPC || MIPS || SPARC64
+	depends on X86 || ARM || M32R || PPC || MIPS || SPARC64 || MN10300
 	default y if X86
 	help
 	  Say "yes" here to get direct support for the real time clock
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index cf8eb98382ce..f9fdb6fc641c 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -630,7 +630,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	address_space = 64;
 #elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) \
 			|| defined(__sparc__) || defined(__mips__) \
-			|| defined(__powerpc__)
+			|| defined(__powerpc__) || defined(CONFIG_MN10300)
 	address_space = 128;
 #else
 #warning Assuming 128 bytes of RTC+NVRAM address space, not 64 bytes.
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
