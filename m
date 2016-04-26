Return-Path: <rtc-linux+bncBDEKVJM7XAHRBNGG764AKGQE5NS5LTQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.10])
        by gmr-mx.google.com with ESMTPS id e64si600669wmi.3.2016.04.26.14.52.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2016 14:52:51 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v2 4/6] rtc: parisc: provide rtc_class_ops directly
Date: Tue, 26 Apr 2016 23:52:29 +0200
Message-Id: <1461707551-1337971-5-git-send-email-arnd@arndb.de>
In-Reply-To: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
References: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The rtc-generic driver provides an architecture specific
wrapper on top of the generic rtc_class_ops abstraction,
and on pa-risc, that is implemented using an open-coded
version of rtc_time_to_tm/rtc_tm_to_time.

This changes the parisc rtc-generic device to provide its
rtc_class_ops directly, using the normal helper functions,
which makes this y2038 safe (on 32-bit) and simplifies
the implementation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/kernel/time.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
index 58dd6801f5be..1338d92fc87b 100644
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -12,6 +12,7 @@
  */
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/rtc.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/param.h>
@@ -248,14 +249,47 @@ void __init start_cpu_itimer(void)
 	per_cpu(cpu_data, cpu).it_value = next_tick;
 }
 
+#ifdef CONFIG_RTC_DRV_GENERIC
+static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pdc_tod tod_data;
+
+	memset(tm, 0, sizeof(*tm));
+	if (pdc_tod_read(&tod_data) < 0)
+		return -EOPNOTSUPP;
+
+	/* we treat tod_sec as unsigned, so this can work until year 2106 */
+	rtc_time64_to_tm(tod_data.tod_sec, &tm);
+	return rtc_valid_tm(tm);
+}
+
+static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
+{
+	time64_t secs = rtc_tm_to_time64(tm);
+
+	if (pdc_tod_set(secs, 0) < 0)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static const struct rtc_class_ops rtc_generic_ops = {
+	.read_time = rtc_generic_get_time,
+	.set_time = rtc_generic_set_time,
+};
+
 static int __init rtc_init(void)
 {
 	struct platform_device *pdev;
 
-	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
+	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
+					     &rtc_generic_ops,
+					     sizeof(rtc_generic_ops));
+
 	return PTR_ERR_OR_ZERO(pdev);
 }
 device_initcall(rtc_init);
+#endif
 
 void read_persistent_clock(struct timespec *ts)
 {
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
