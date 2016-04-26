Return-Path: <rtc-linux+bncBDEKVJM7XAHRBMOG764AKGQERCZ3WXI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.24])
        by gmr-mx.google.com with ESMTPS id a124si185048wme.0.2016.04.26.14.52.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2016 14:52:48 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v2 1/6] rtc: m68k: provide rtc_class_ops directly
Date: Tue, 26 Apr 2016 23:52:26 +0200
Message-Id: <1461707551-1337971-2-git-send-email-arnd@arndb.de>
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
and m68k has another abstraction on top, which is a bit
silly.

This changes the m68k rtc-generic device to provide its
rtc_class_ops directly, to reduce the number of layers
by one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/kernel/time.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 3857737e3958..fe35890feede 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -86,7 +86,24 @@ void read_persistent_clock(struct timespec *ts)
 	}
 }
 
-#ifdef CONFIG_ARCH_USES_GETTIMEOFFSET
+#if defined(CONFIG_ARCH_USES_GETTIMEOFFSET) && defined(CONFIG_RTC_DRV_GENERIC)
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
@@ -95,7 +112,10 @@ static int __init rtc_init(void)
 	if (!mach_hwclk)
 		return -ENODEV;
 
-	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
+	/* or just call devm_rtc_device_register instead? */
+	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
+					     &generic_rtc_ops,
+					     sizeof(generic_rtc_ops));
 	return PTR_ERR_OR_ZERO(pdev);
 }
 
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
