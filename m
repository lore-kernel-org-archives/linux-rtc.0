Return-Path: <rtc-linux+bncBDA7X7F2WUEBB4GVVWVAKGQEHRFH6GA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com. [209.85.212.173])
        by gmr-mx.google.com with ESMTPS id p9si258161wiz.3.2015.05.07.06.38.55
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 06:38:55 -0700 (PDT)
Received: by mail-wi0-f173.google.com with SMTP id n10so60237579wiu.1
        for <rtc-linux@googlegroups.com>; Thu, 07 May 2015 06:38:55 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	wim@iguana.be,
	a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux@roeck-us.net,
	Lee Jones <lee.jones@linaro.org>
Subject: [rtc-linux] [PATCH 03/12] clocksource: sti: Provide 'use timer as
 sched clock' capability
Date: Thu,  7 May 2015 14:38:35 +0100
Message-Id: <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
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

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clocksource/Kconfig         |  8 ++++++++
 drivers/clocksource/clksrc_st_lpc.c | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index ac424cf..218daf8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -258,4 +258,12 @@ config CLKSRC_ST_LPC
 	help
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
+
+config CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
+	bool
+	depends on CLKSRC_ST_LPC
+	default y
+	help
+	  Use Low Power controller timer clock source as sched_clock
+
 endmenu
diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksource/clksrc_st_lpc.c
index 18a7dcd0..3d92b26 100644
--- a/drivers/clocksource/clksrc_st_lpc.c
+++ b/drivers/clocksource/clksrc_st_lpc.c
@@ -16,6 +16,7 @@
 #include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/of_address.h>
+#include <linux/sched_clock.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/mfd/st-lpc.h>
@@ -38,6 +39,13 @@ static void st_clksrc_reset(void)
 	writel_relaxed(1, ddata.base + LPC_LPT_START_OFF);
 }
 
+#ifdef CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
+static u64 notrace st_clksrc_sched_clock_read(void)
+{
+	return (u64)readl_relaxed(ddata.base + LPC_LPT_LSB_OFF);
+}
+#endif
+
 static int __init st_clksrc_init(void)
 {
 	unsigned long rate;
@@ -47,6 +55,9 @@ static int __init st_clksrc_init(void)
 
 	rate = clk_get_rate(ddata.clk);
 
+#ifdef CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
+	sched_clock_register(st_clksrc_sched_clock_read, 32, rate);
+#endif
 	ret = clocksource_mmio_init(ddata.base + LPC_LPT_LSB_OFF,
 				    "clksrc-st-lpc", rate, 300, 32,
 				    clocksource_mmio_readl_up);
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
