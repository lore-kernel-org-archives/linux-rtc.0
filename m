Return-Path: <rtc-linux+bncBCN6JTVP2IEBBO7IWWVQKGQE2WGTPFA@googlegroups.com>
MIME-Version: 1.0
Received: from m50-110.126.com (m50-110.126.com. [123.125.50.110])
        by gmr-mx.google.com with ESMTP id g4si1085464igc.3.2015.06.02.02.15.38
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Jun 2015 02:15:39 -0700 (PDT)
From: Xunlei Pang <xlpang@126.com>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Xunlei Pang <pang.xunlei@linaro.org>
Subject: [rtc-linux] [PATCH v2 4/4] cris: time: Cleanup of persistent clock stuff
Date: Tue,  2 Jun 2015 17:14:37 +0800
Message-Id: <1433236477-1724-4-git-send-email-xlpang@126.com>
In-Reply-To: <1433236477-1724-1-git-send-email-xlpang@126.com>
References: <1433236477-1724-1-git-send-email-xlpang@126.com>
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

- Remove update_persistent_clock(), as it does nothing now.
- Remove read_persistent_clock(), let it fall back to the weak version.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 arch/cris/Kconfig       |  1 -
 arch/cris/kernel/time.c | 25 -------------------------
 2 files changed, 26 deletions(-)

diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index 0314e32..982d562 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -46,7 +46,6 @@ config CRIS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IOMAP
-	select GENERIC_CMOS_UPDATE
 	select MODULES_USE_ELF_RELA
 	select CLONE_BACKWARDS2
 	select OLD_SIGSUSPEND
diff --git a/arch/cris/kernel/time.c b/arch/cris/kernel/time.c
index 7780d37..2dda6da 100644
--- a/arch/cris/kernel/time.c
+++ b/arch/cris/kernel/time.c
@@ -39,31 +39,6 @@
 extern unsigned long loops_per_jiffy; /* init/main.c */
 unsigned long loops_per_usec;
 
-int set_rtc_mmss(unsigned long nowtime)
-{
-	D(printk(KERN_DEBUG "set_rtc_mmss(%lu)\n", nowtime));
-	return 0;
-}
-
-/* grab the time from the RTC chip */
-unsigned long get_cmos_time(void)
-{
-	return 0;
-}
-
-
-int update_persistent_clock(struct timespec now)
-{
-	return set_rtc_mmss(now.tv_sec);
-}
-
-void read_persistent_clock(struct timespec *ts)
-{
-	ts->tv_sec = 0;
-	ts->tv_nsec = 0;
-}
-
-
 extern void cris_profile_sample(struct pt_regs* regs);
 
 void
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
