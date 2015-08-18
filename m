Return-Path: <rtc-linux+bncBD66BCOYSQBBBU44ZOXAKGQEKTDG2JA@googlegroups.com>
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id i10si1001802igh.3.2015.08.17.23.18.59
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 23:18:59 -0700 (PDT)
From: Keerthy <j-keerthy@ti.com>
To: <alexandre.belloni@free-electrons.com>, <tony@atomide.com>
CC: <johan@kernel.org>, <linux-omap@vger.kernel.org>,
        <rtc-linux@googlegroups.com>, <grygorii.strashko@ti.com>,
        <j-keerthy@ti.com>
Subject: [rtc-linux] [PATCH v3 3/3] rtc: omap: Add external clock enabling support
Date: Tue, 18 Aug 2015 11:48:44 +0530
Message-ID: <1439878724-5828-4-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1439878724-5828-1-git-send-email-j-keerthy@ti.com>
References: <1439878724-5828-1-git-send-email-j-keerthy@ti.com>
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

Configure the clock source to external clock if available.
External clock is preferred as it can be ticking during suspend.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/rtc/rtc-omap.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index f31c012..255f7b7 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -108,6 +108,7 @@
 
 /* OMAP_RTC_OSC_REG bit fields: */
 #define OMAP_RTC_OSC_32KCLK_EN		BIT(6)
+#define OMAP_RTC_OSC_SEL_32KCLK_SRC	BIT(3)
 
 /* OMAP_RTC_IRQWAKEEN bit fields: */
 #define OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN	BIT(1)
@@ -138,6 +139,7 @@ struct omap_rtc {
 	int irq_timer;
 	u8 interrupts_reg;
 	bool is_pmic_controller;
+	bool has_ext_clk;
 	const struct omap_rtc_device_type *type;
 };
 
@@ -555,11 +557,19 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (rtc->irq_alarm <= 0)
 		return -ENOENT;
 
-	rtc->clk = devm_clk_get(&pdev->dev, "int-clk");
-
-	if (!IS_ERR(rtc->clk))
+	rtc->clk = devm_clk_get(&pdev->dev, "ext-clk");
+	if (!IS_ERR(rtc->clk)) {
+		rtc->has_ext_clk = true;
 		clk_prepare_enable(rtc->clk);
+	} else {
+		rtc->clk = devm_clk_get(&pdev->dev, "int-clk");
+		if (IS_ERR(rtc->clk))
+			goto no_clk;
+	}
 
+	clk_prepare_enable(rtc->clk);
+
+no_clk:
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rtc->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rtc->base))
@@ -634,6 +644,16 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (reg != new_ctrl)
 		rtc_write(rtc, OMAP_RTC_CTRL_REG, new_ctrl);
 
+	/*
+	 * If we have the external clock then switch to it so we can keep
+	 * ticking across suspend.
+	 */
+	if (rtc->has_ext_clk) {
+		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
+		rtc_write(rtc, OMAP_RTC_OSC_REG,
+			  reg | OMAP_RTC_OSC_SEL_32KCLK_SRC);
+	}
+
 	rtc->type->lock(rtc);
 
 	device_init_wakeup(&pdev->dev, true);
@@ -679,6 +699,7 @@ err:
 static int __exit omap_rtc_remove(struct platform_device *pdev)
 {
 	struct omap_rtc *rtc = platform_get_drvdata(pdev);
+	u8 reg;
 
 	if (pm_power_off == omap_rtc_power_off &&
 			omap_rtc_power_off_rtc == rtc) {
@@ -695,6 +716,12 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
 	/* leave rtc running, but disable irqs */
 	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
 
+	if (rtc->has_ext_clk) {
+		reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
+		reg &= ~OMAP_RTC_OSC_SEL_32KCLK_SRC;
+		rtc_write(rtc, OMAP_RTC_OSC_REG, reg);
+	}
+
 	rtc->type->lock(rtc);
 
 	/* Disable the clock/module */
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
