Return-Path: <rtc-linux+bncBCN6JTVP2IEBBIPYUGVQKGQEOD7BNUQ@googlegroups.com>
MIME-Version: 1.0
Received: from m50-111.126.com (m50-111.126.com. [123.125.50.111])
        by gmr-mx.google.com with ESMTP id ax9si174657igc.1.2015.05.29.07.47.55
        for <rtc-linux@googlegroups.com>;
        Fri, 29 May 2015 07:48:01 -0700 (PDT)
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	linux-cris-kernel@axis.com,
	Mikael Starvik <starvik@axis.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Xunlei Pang <pang.xunlei@linaro.org>
Subject: [rtc-linux] [PATCH v2 2/4] sparc: time: Replace update_persistent_clock()
 with CONFIG_RTC_SYSTOHC
Date: Fri, 29 May 2015 22:46:16 +0800
Message-Id: <1432910778-314-2-git-send-email-xlpang@126.com>
In-Reply-To: <1432910778-314-1-git-send-email-xlpang@126.com>
References: <1432910778-314-1-git-send-email-xlpang@126.com>
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

From: Xunlei Pang <pang.xunlei@linaro.org>

On Sparc systems, update_persistent_clock() uses RTC drivers to do
the job, it makes more sense to hand it over to CONFIG_RTC_SYSTOHC.

In the long run, all the update_persistent_clock() should migrate to
proper class RTC drivers if any and use CONFIG_RTC_SYSTOHC instead.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 arch/sparc/Kconfig          |  2 +-
 arch/sparc/kernel/time_32.c | 21 ---------------------
 arch/sparc/kernel/time_64.c | 14 --------------
 3 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e49502a..56442d2 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -25,6 +25,7 @@ config SPARC
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select RTC_CLASS
 	select RTC_DRV_M48T59
+	select RTC_SYSTOHC
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL if SPARC64
@@ -35,7 +36,6 @@ config SPARC
 	select HAVE_BPF_JIT
 	select HAVE_DEBUG_BUGVERBOSE
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_CMOS_UPDATE
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 8caf45e..c9692f3 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -23,7 +23,6 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/time.h>
-#include <linux/rtc.h>
 #include <linux/rtc/m48t59.h>
 #include <linux/timex.h>
 #include <linux/clocksource.h>
@@ -65,8 +64,6 @@ DEFINE_PER_CPU(struct clock_event_device, sparc32_clockevent);
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
-static int set_rtc_mmss(unsigned long);
-
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	extern char __copy_user_begin[], __copy_user_end[];
@@ -87,11 +84,6 @@ EXPORT_SYMBOL(profile_pc);
 
 volatile u32 __iomem *master_l10_counter;
 
-int update_persistent_clock(struct timespec now)
-{
-	return set_rtc_mmss(now.tv_sec);
-}
-
 irqreturn_t notrace timer_interrupt(int dummy, void *dev_id)
 {
 	if (timer_cs_enabled) {
@@ -362,16 +354,3 @@ void __init time_init(void)
 		sbus_time_init();
 }
 
-
-static int set_rtc_mmss(unsigned long secs)
-{
-	struct rtc_device *rtc = rtc_class_open("rtc0");
-	int err = -1;
-
-	if (rtc) {
-		err = rtc_set_mmss(rtc, secs);
-		rtc_class_close(rtc);
-	}
-
-	return err;
-}
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index edbbeb1..2e6035c 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -28,7 +28,6 @@
 #include <linux/cpufreq.h>
 #include <linux/percpu.h>
 #include <linux/miscdevice.h>
-#include <linux/rtc.h>
 #include <linux/rtc/m48t59.h>
 #include <linux/kernel_stat.h>
 #include <linux/clockchips.h>
@@ -394,19 +393,6 @@ static struct sparc64_tick_ops hbtick_operations __read_mostly = {
 
 static unsigned long timer_ticks_per_nsec_quotient __read_mostly;
 
-int update_persistent_clock(struct timespec now)
-{
-	struct rtc_device *rtc = rtc_class_open("rtc0");
-	int err = -1;
-
-	if (rtc) {
-		err = rtc_set_mmss(rtc, now.tv_sec);
-		rtc_class_close(rtc);
-	}
-
-	return err;
-}
-
 unsigned long cmos_regs;
 EXPORT_SYMBOL(cmos_regs);
 
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
