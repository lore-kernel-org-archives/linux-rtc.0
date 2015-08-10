Return-Path: <rtc-linux+bncBD66BCOYSQBBBVG5UGXAKGQENSQTA3Y@googlegroups.com>
Received: from bear.ext.ti.com (bear.ext.ti.com. [192.94.94.41])
        by gmr-mx.google.com with ESMTPS id 4si389994igl.1.2015.08.10.02.28.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 02:28:51 -0700 (PDT)
From: Keerthy <j-keerthy@ti.com>
To: <tony@atomide.com>, <linux-omap@vger.kernel.org>, <pawel.moll@arm.com>
CC: <galak@codeaurora.org>, <paul@pwsan.com>,
        <alexandre.belloni@free-electrons.com>, <akpm@linux-foundation.org>,
        <johan@kernel.org>, <grygorii.strashko@ti.com>,
        <rtc-linux@googlegroups.com>, <bcousson@baylibre.com>, <nm@ti.com>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [rtc-linux] [PATCH v2 2/6] rtc: omap: Add external clock enabling support
Date: Mon, 10 Aug 2015 14:58:22 +0530
Message-ID: <1439198906-31189-3-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Switch to external clock source during suspend and switch back
to internal source on resume. This helps rtc ticking across suspend.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |  2 ++
 drivers/rtc/rtc-omap.c        | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d99b2ee..756819f 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -336,6 +336,8 @@
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
 				      GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "rtc";
+			clocks = <&clk_32768_ck>, <&clk_32k_rtc>;
+			clock-names = "int-clk", "ext-clk";
 			status = "disabled";
 		};
 
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 8b6355f..cfc8558 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 /*
  * The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
@@ -107,6 +108,7 @@
 
 /* OMAP_RTC_OSC_REG bit fields: */
 #define OMAP_RTC_OSC_32KCLK_EN		BIT(6)
+#define OMAP_RTC_OSC_SEL_32KCLK_SRC	BIT(3)
 
 /* OMAP_RTC_IRQWAKEEN bit fields: */
 #define OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN	BIT(1)
@@ -136,6 +138,7 @@ struct omap_rtc {
 	int irq_timer;
 	u8 interrupts_reg;
 	bool is_pmic_controller;
+	bool has_ext_clk;
 	const struct omap_rtc_device_type *type;
 };
 
@@ -525,6 +528,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 {
 	struct omap_rtc	*rtc;
 	struct resource	*res;
+	struct clk *ext_clk;
 	u8 reg, mask, new_ctrl;
 	const struct platform_device_id *id_entry;
 	const struct of_device_id *of_id;
@@ -553,6 +557,10 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (rtc->irq_alarm <= 0)
 		return -ENOENT;
 
+	ext_clk = devm_clk_get(&pdev->dev, "ext-clk");
+	if (!IS_ERR(ext_clk))
+		rtc->has_ext_clk = true;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rtc->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rtc->base))
@@ -698,6 +706,7 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
 static int omap_rtc_suspend(struct device *dev)
 {
 	struct omap_rtc *rtc = dev_get_drvdata(dev);
+	u8 reg;
 
 	rtc->interrupts_reg = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
 
@@ -711,6 +720,18 @@ static int omap_rtc_suspend(struct device *dev)
 		enable_irq_wake(rtc->irq_alarm);
 	else
 		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
+
+	/*
+	 * If we have the luxury of external clock then
+	 * Switch to external clock so we can keep ticking
+	 * acorss suspend
+	 */
+	if (rtc->has_ext_clk) {
+		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
+		rtc_write(rtc, OMAP_RTC_OSC_REG, reg |
+			  OMAP_RTC_OSC_SEL_32KCLK_SRC);
+	}
+
 	rtc->type->lock(rtc);
 
 	/* Disable the clock/module */
@@ -722,6 +743,7 @@ static int omap_rtc_suspend(struct device *dev)
 static int omap_rtc_resume(struct device *dev)
 {
 	struct omap_rtc *rtc = dev_get_drvdata(dev);
+	u8 reg;
 
 	/* Enable the clock/module so that we can access the registers */
 	pm_runtime_get_sync(dev);
@@ -731,6 +753,15 @@ static int omap_rtc_resume(struct device *dev)
 		disable_irq_wake(rtc->irq_alarm);
 	else
 		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, rtc->interrupts_reg);
+	/*
+	 * Switch back to internal source
+	 */
+	if (rtc->has_ext_clk) {
+		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
+		reg &= ~OMAP_RTC_OSC_SEL_32KCLK_SRC;
+		rtc_write(rtc, OMAP_RTC_OSC_REG, reg);
+	}
+
 	rtc->type->lock(rtc);
 
 	return 0;
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
