Return-Path: <rtc-linux+bncBDA7X7F2WUEBB5PRY6VAKGQERNOQOWA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com. [74.125.82.42])
        by gmr-mx.google.com with ESMTPS id ec7si92213wib.3.2015.05.12.05.58.29
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 05:58:29 -0700 (PDT)
Received: by mail-wg0-f42.google.com with SMTP id c8so8766444wgi.1
        for <rtc-linux@googlegroups.com>; Tue, 12 May 2015 05:58:29 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	wim@iguana.be,
	a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux@roeck-us.net
Cc: kernel@stlinux.com,
	Lee Jones <lee.jones@linaro.org>
Subject: [rtc-linux] [PATCH v2 03/12] clocksource: sti: Provide 'use timer as
 sched clock' capability
Date: Tue, 12 May 2015 13:58:11 +0100
Message-Id: <1431435500-22899-4-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
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
 drivers/clocksource/clksrc_st_lpc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksource/clksrc_st_lpc.c
index 1ad1714..90f5bb8 100644
--- a/drivers/clocksource/clksrc_st_lpc.c
+++ b/drivers/clocksource/clksrc_st_lpc.c
@@ -16,6 +16,7 @@
 #include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/of_address.h>
+#include <linux/sched_clock.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/mfd/st-lpc.h>
@@ -38,6 +39,11 @@ static void st_clksrc_reset(void)
 	writel_relaxed(1, ddata.base + LPC_LPT_START_OFF);
 }
 
+static u64 notrace st_clksrc_sched_clock_read(void)
+{
+	return (u64)readl_relaxed(ddata.base + LPC_LPT_LSB_OFF);
+}
+
 static int __init st_clksrc_init(void)
 {
 	unsigned long rate;
@@ -47,6 +53,8 @@ static int __init st_clksrc_init(void)
 
 	rate = clk_get_rate(ddata.clk);
 
+	sched_clock_register(st_clksrc_sched_clock_read, 32, rate);
+
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
