Return-Path: <rtc-linux+bncBDEKVJM7XAHRBPU2WK5AKGQEYDMY6AY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [217.72.192.75])
        by gmr-mx.google.com with ESMTPS id l68si1161828wmd.3.2016.05.30.11.58.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2016 11:58:05 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
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
Subject: [rtc-linux] [PATCH v4 12/16] rtc: powerpc: provide rtc_class_ops directly
Date: Mon, 30 May 2016 20:58:00 +0200
Message-Id: <1464634684-1248135-13-git-send-email-arnd@arndb.de>
In-Reply-To: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
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
and powerpc has another abstraction on top, which is a bit
silly.

This changes the powerpc rtc-generic device to provide its
rtc_class_ops directly, to reduce the number of layers
by one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/time.c | 29 ++++++++++++++++++++++++++++-
 drivers/rtc/rtc-generic.c  |  2 +-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3ed9a5a21d77..7a482a7f4d8d 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -56,6 +56,7 @@
 #include <linux/irq_work.h>
 #include <linux/clk-provider.h>
 #include <linux/suspend.h>
+#include <linux/rtc.h>
 #include <asm/trace.h>
 
 #include <asm/io.h>
@@ -1081,6 +1082,29 @@ void calibrate_delay(void)
 	loops_per_jiffy = tb_ticks_per_jiffy;
 }
 
+#if IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
+static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
+{
+	ppc_md.get_rtc_time(tm);
+	return rtc_valid_tm(tm);
+}
+
+static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
+{
+	if (!ppc_md.set_rtc_time)
+		return -EOPNOTSUPP;
+
+	if (ppc_md.set_rtc_time(tm) < 0)
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
@@ -1088,9 +1112,12 @@ static int __init rtc_init(void)
 	if (!ppc_md.get_rtc_time)
 		return -ENODEV;
 
-	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
+	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
+					     &rtc_generic_ops,
+					     sizeof(rtc_generic_ops));
 
 	return PTR_ERR_OR_ZERO(pdev);
 }
 
 device_initcall(rtc_init);
+#endif
diff --git a/drivers/rtc/rtc-generic.c b/drivers/rtc/rtc-generic.c
index 5c82bae73b9c..efcb9833cac8 100644
--- a/drivers/rtc/rtc-generic.c
+++ b/drivers/rtc/rtc-generic.c
@@ -9,7 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 
-#if defined(CONFIG_PPC)
+#if 0
 #include <asm/rtc.h>
 
 static int generic_get_time(struct device *dev, struct rtc_time *tm)
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
