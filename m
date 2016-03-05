Return-Path: <rtc-linux+bncBC433LF43MBBBLOA5W3AKGQEUAITV7A@googlegroups.com>
MIME-Version: 1.0
Received: from outils.crapouillou.net (rev33.vpn.fdn.fr. [80.67.179.33])
        by gmr-mx.google.com with ESMTPS id w128si146468wmd.0.2016.03.05.14.39.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Mar 2016 14:39:41 -0800 (PST)
From: Paul Cercueil <paul@crapouillou.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Paul Cercueil <paul@crapouillou.net>,
	Paul Burton <paul.burton@imgtec.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 5/5] MIPS: jz4740: Use the jz4740-rtc driver as
 the power controller
Date: Sat,  5 Mar 2016 23:38:51 +0100
Message-Id: <1457217531-26064-5-git-send-email-paul@crapouillou.net>
In-Reply-To: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi |  2 ++
 arch/mips/jz4740/reset.c               | 64 ----------------------------------
 2 files changed, 2 insertions(+), 64 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 8b2437c..f2ddacb 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -32,6 +32,8 @@
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
+
+		system-power-controller;
 	};
 
 	cgu: jz4740-cgu@10000000 {
diff --git a/arch/mips/jz4740/reset.c b/arch/mips/jz4740/reset.c
index 954e669..0a88b17 100644
--- a/arch/mips/jz4740/reset.c
+++ b/arch/mips/jz4740/reset.c
@@ -12,7 +12,6 @@
  *
  */
 
-#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/pm.h>
@@ -57,71 +56,8 @@ static void jz4740_restart(char *command)
 	jz4740_halt();
 }
 
-#define JZ_REG_RTC_CTRL			0x00
-#define JZ_REG_RTC_HIBERNATE		0x20
-#define JZ_REG_RTC_WAKEUP_FILTER	0x24
-#define JZ_REG_RTC_RESET_COUNTER	0x28
-
-#define JZ_RTC_CTRL_WRDY		BIT(7)
-#define JZ_RTC_WAKEUP_FILTER_MASK	0x0000FFE0
-#define JZ_RTC_RESET_COUNTER_MASK	0x00000FE0
-
-static inline void jz4740_rtc_wait_ready(void __iomem *rtc_base)
-{
-	uint32_t ctrl;
-
-	do {
-		ctrl = readl(rtc_base + JZ_REG_RTC_CTRL);
-	} while (!(ctrl & JZ_RTC_CTRL_WRDY));
-}
-
-static void jz4740_power_off(void)
-{
-	void __iomem *rtc_base = ioremap(JZ4740_RTC_BASE_ADDR, 0x38);
-	unsigned long wakeup_filter_ticks;
-	unsigned long reset_counter_ticks;
-	struct clk *rtc_clk;
-	unsigned long rtc_rate;
-
-	rtc_clk = clk_get(NULL, "rtc");
-	if (IS_ERR(rtc_clk))
-		panic("unable to get RTC clock");
-	rtc_rate = clk_get_rate(rtc_clk);
-	clk_put(rtc_clk);
-
-	/*
-	 * Set minimum wakeup pin assertion time: 100 ms.
-	 * Range is 0 to 2 sec if RTC is clocked at 32 kHz.
-	 */
-	wakeup_filter_ticks = (100 * rtc_rate) / 1000;
-	if (wakeup_filter_ticks < JZ_RTC_WAKEUP_FILTER_MASK)
-		wakeup_filter_ticks &= JZ_RTC_WAKEUP_FILTER_MASK;
-	else
-		wakeup_filter_ticks = JZ_RTC_WAKEUP_FILTER_MASK;
-	jz4740_rtc_wait_ready(rtc_base);
-	writel(wakeup_filter_ticks, rtc_base + JZ_REG_RTC_WAKEUP_FILTER);
-
-	/*
-	 * Set reset pin low-level assertion time after wakeup: 60 ms.
-	 * Range is 0 to 125 ms if RTC is clocked at 32 kHz.
-	 */
-	reset_counter_ticks = (60 * rtc_rate) / 1000;
-	if (reset_counter_ticks < JZ_RTC_RESET_COUNTER_MASK)
-		reset_counter_ticks &= JZ_RTC_RESET_COUNTER_MASK;
-	else
-		reset_counter_ticks = JZ_RTC_RESET_COUNTER_MASK;
-	jz4740_rtc_wait_ready(rtc_base);
-	writel(reset_counter_ticks, rtc_base + JZ_REG_RTC_RESET_COUNTER);
-
-	jz4740_rtc_wait_ready(rtc_base);
-	writel(1, rtc_base + JZ_REG_RTC_HIBERNATE);
-
-	jz4740_halt();
-}
-
 void jz4740_reset_init(void)
 {
 	_machine_restart = jz4740_restart;
 	_machine_halt = jz4740_halt;
-	pm_power_off = jz4740_power_off;
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
