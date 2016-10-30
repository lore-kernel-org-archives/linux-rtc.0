Return-Path: <rtc-linux+bncBC433LF43MBBBL7Y3HAAKGQELWV3L6I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from outils.crapouillou.net (outils.crapouillou.net. [89.234.176.41])
        by gmr-mx.google.com with ESMTPS id w64si1899461wmf.1.2016.10.30.16.03.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2016 16:03:11 -0700 (PDT)
From: Paul Cercueil <paul@crapouillou.net>
To: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Maarten ter Huurne <maarten@treewalker.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Cc: Paul Cercueil <paul@crapouillou.net>
Subject: [rtc-linux] [PATCH v2 7/7] MIPS: jz4740: Remove obsolete code
Date: Mon, 31 Oct 2016 00:02:47 +0100
Message-Id: <20161030230247.20538-8-paul@crapouillou.net>
In-Reply-To: <20161030230247.20538-1-paul@crapouillou.net>
References: <20161030230247.20538-1-paul@crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This commit removes two things:
- The platform_device that corresponds to the RTC driver, since we now
  probe this driver from devicetree;
- The platform power-off code, since all the jz4740-based platforms are
  now using the jz4740-rtc driver as the system power controller.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Maarten ter Huurne <maarten@treewalker.org>
---
 arch/mips/include/asm/mach-jz4740/platform.h |  1 -
 arch/mips/jz4740/platform.c                  | 21 ----------
 arch/mips/jz4740/reset.c                     | 63 ----------------------------
 3 files changed, 85 deletions(-)

v2: New patch in this series

diff --git a/arch/mips/include/asm/mach-jz4740/platform.h b/arch/mips/include/asm/mach-jz4740/platform.h
index 073b8bf..3645974 100644
--- a/arch/mips/include/asm/mach-jz4740/platform.h
+++ b/arch/mips/include/asm/mach-jz4740/platform.h
@@ -22,7 +22,6 @@
 extern struct platform_device jz4740_udc_device;
 extern struct platform_device jz4740_udc_xceiv_device;
 extern struct platform_device jz4740_mmc_device;
-extern struct platform_device jz4740_rtc_device;
 extern struct platform_device jz4740_i2c_device;
 extern struct platform_device jz4740_nand_device;
 extern struct platform_device jz4740_framebuffer_device;
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index 2f1dab3..5b7cdd6 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -88,27 +88,6 @@ struct platform_device jz4740_mmc_device = {
 	.resource	= jz4740_mmc_resources,
 };
 
-/* RTC controller */
-static struct resource jz4740_rtc_resources[] = {
-	{
-		.start	= JZ4740_RTC_BASE_ADDR,
-		.end	= JZ4740_RTC_BASE_ADDR + 0x38 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= JZ4740_IRQ_RTC,
-		.end	= JZ4740_IRQ_RTC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device jz4740_rtc_device = {
-	.name		= "jz4740-rtc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(jz4740_rtc_resources),
-	.resource	= jz4740_rtc_resources,
-};
-
 /* I2C controller */
 static struct resource jz4740_i2c_resources[] = {
 	{
diff --git a/arch/mips/jz4740/reset.c b/arch/mips/jz4740/reset.c
index 954e669..67780c4 100644
--- a/arch/mips/jz4740/reset.c
+++ b/arch/mips/jz4740/reset.c
@@ -57,71 +57,8 @@ static void jz4740_restart(char *command)
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
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
