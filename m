Return-Path: <rtc-linux+bncBDEKVJM7XAHRBPM2WK5AKGQE3ON4ABA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [217.72.192.73])
        by gmr-mx.google.com with ESMTPS id l68si1161826wmd.3.2016.05.30.11.58.05
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
Subject: [rtc-linux] [PATCH v4 09/16] rtc: m68k: provide rtc_class_ops directly
Date: Mon, 30 May 2016 20:57:57 +0200
Message-Id: <1464634684-1248135-10-git-send-email-arnd@arndb.de>
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
and m68k has another abstraction on top, which is a bit
silly.

This changes the m68k rtc-generic device to provide its
rtc_class_ops directly, to reduce the number of layers
by one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/kernel/time.c   | 23 +++++++++++++++++++++--
 drivers/rtc/rtc-generic.c |  2 +-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 3857737e3958..bd6417d38d5a 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -86,7 +86,24 @@ void read_persistent_clock(struct timespec *ts)
 	}
 }
 
-#ifdef CONFIG_ARCH_USES_GETTIMEOFFSET
+#if defined(CONFIG_ARCH_USES_GETTIMEOFFSET) && IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
+static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
+{
+	mach_hwclk(0, tm);
+	return rtc_valid_tm(tm);
+}
+
+static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
+{
+	if (mach_hwclk(1, tm) < 0)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static const struct rtc_class_ops generic_rtc_ops = {
+	.read_time = rtc_generic_get_time,
+	.set_time = rtc_generic_set_time,
+};
 
 static int __init rtc_init(void)
 {
@@ -95,7 +112,9 @@ static int __init rtc_init(void)
 	if (!mach_hwclk)
 		return -ENODEV;
 
-	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
+	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
+					     &generic_rtc_ops,
+					     sizeof(generic_rtc_ops));
 	return PTR_ERR_OR_ZERO(pdev);
 }
 
diff --git a/drivers/rtc/rtc-generic.c b/drivers/rtc/rtc-generic.c
index 92b5e02a3750..5c82bae73b9c 100644
--- a/drivers/rtc/rtc-generic.c
+++ b/drivers/rtc/rtc-generic.c
@@ -9,7 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 
-#if defined(CONFIG_M68K) || defined(CONFIG_PPC)
+#if defined(CONFIG_PPC)
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
