Return-Path: <rtc-linux+bncBDFLXENW3AORBEFFQ3AQKGQE5UANSCA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTPS id ua1si8261884pac.0.2016.11.08.00.53.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 00:53:36 -0800 (PST)
From: Chen Yu <yu.c.chen@intel.com>
To: x86@kernel.org
Cc: Pavel Machek <pavel@ucw.cz>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-pm@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Xunlei Pang <xlpang@redhat.com>,
	Chen Yu <yu.c.chen@intel.com>
Subject: [rtc-linux] [PATCH 1/2][RFC v6] timekeeping: Ignore the bogus sleep
 time if pm_trace is enabled
Date: Tue,  8 Nov 2016 17:01:35 +0800
Message-Id: <e0ed3331627184f3da6243b00cfa69dd78e85514.1478589736.git.yu.c.chen@intel.com>
In-Reply-To: <cover.1478589736.git.yu.c.chen@intel.com>
References: <cover.1478589736.git.yu.c.chen@intel.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Thomas Gleixner <tglx@linutronix.de>

Previously we encountered some memory overflow issues due to
the bogus sleep time brought by inconsistent rtc, which is
triggered when pm_trace is enabled, and we have fixed it
in recent kernel. However it's improper in the first place
to call __timekeeping_inject_sleeptime() in case that pm_trace
is enabled simply because that "hash" time value will wreckage
the timekeeping subsystem.

This patch is to bypass the bogus rtc interval when pm_trace is enabled.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Xunlei Pang <xlpang@redhat.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/kernel/rtc.c       | 9 +++++++++
 drivers/base/power/trace.c  | 2 ++
 drivers/rtc/rtc-cmos.c      | 7 +++++++
 include/linux/mc146818rtc.h | 1 +
 include/linux/pm-trace.h    | 9 ++++++++-
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 79c6311c..898383c 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -64,6 +64,15 @@ void mach_get_cmos_time(struct timespec *now)
 	unsigned int status, year, mon, day, hour, min, sec, century = 0;
 	unsigned long flags;
 
+	/*
+	 * If pm trace abused the RTC as storage set the timespec to 0
+	 * which tells the caller that this RTC value is bogus.
+	 */
+	if (!pm_trace_rtc_valid()) {
+		now->tv_sec = now->tv_nsec = 0;
+		return;
+	}
+
 	spin_lock_irqsave(&rtc_lock, flags);
 
 	/*
diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index efec10b..aa9109a 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -74,6 +74,7 @@
 
 #define DEVSEED (7919)
 
+bool pm_trace_rtc_abused __read_mostly;
 static unsigned int dev_hash_value;
 
 static int set_magic_time(unsigned int user, unsigned int file, unsigned int device)
@@ -104,6 +105,7 @@ static int set_magic_time(unsigned int user, unsigned int file, unsigned int dev
 	time.tm_min = (n % 20) * 3;
 	n /= 20;
 	mc146818_set_time(&time);
+	pm_trace_rtc_abused = true;
 	return n ? -1 : 0;
 }
 
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index dd3d598..3d9aedc 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -191,6 +191,13 @@ static inline void cmos_write_bank2(unsigned char val, unsigned char addr)
 
 static int cmos_read_time(struct device *dev, struct rtc_time *t)
 {
+	/*
+	 * If pmtrace abused the RTC for storage tell the caller that it is
+	 * unusable.
+	 */
+	if (!pm_trace_rtc_valid())
+		return -EIO;
+
 	/* REVISIT:  if the clock has a "century" register, use
 	 * that instead of the heuristic in mc146818_get_time().
 	 * That'll make Y3K compatility (year > 2070) easy!
diff --git a/include/linux/mc146818rtc.h b/include/linux/mc146818rtc.h
index a585b4b..0661af1 100644
--- a/include/linux/mc146818rtc.h
+++ b/include/linux/mc146818rtc.h
@@ -16,6 +16,7 @@
 #include <asm/mc146818rtc.h>		/* register access macros */
 #include <linux/bcd.h>
 #include <linux/delay.h>
+#include <linux/pm-trace.h>
 
 #ifdef __KERNEL__
 #include <linux/spinlock.h>		/* spinlock_t */
diff --git a/include/linux/pm-trace.h b/include/linux/pm-trace.h
index ecbde7a..7b78793 100644
--- a/include/linux/pm-trace.h
+++ b/include/linux/pm-trace.h
@@ -1,11 +1,17 @@
 #ifndef PM_TRACE_H
 #define PM_TRACE_H
 
+#include <linux/types.h>
 #ifdef CONFIG_PM_TRACE
 #include <asm/pm-trace.h>
-#include <linux/types.h>
 
 extern int pm_trace_enabled;
+extern bool pm_trace_rtc_abused;
+
+static inline bool pm_trace_rtc_valid(void)
+{
+	return !pm_trace_rtc_abused;
+}
 
 static inline int pm_trace_is_enabled(void)
 {
@@ -24,6 +30,7 @@ extern int show_trace_dev_match(char *buf, size_t size);
 
 #else
 
+static inline bool pm_trace_rtc_valid(void) { return true; }
 static inline int pm_trace_is_enabled(void) { return 0; }
 
 #define TRACE_DEVICE(dev) do { } while (0)
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
