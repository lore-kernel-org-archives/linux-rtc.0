Return-Path: <rtc-linux+bncBD7N3SEV2QCRBSE5RK4AKGQEFK4UIVI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from vk1046.megiteam.com.pl (2780.rev.megiteam.pl. [91.227.39.128])
        by gmr-mx.google.com with ESMTP id s141si305341wmd.1.2016.04.04.08.56.55
        for <rtc-linux@googlegroups.com>;
        Mon, 04 Apr 2016 08:56:55 -0700 (PDT)
From: Marcin Niestroj <m.niestroj@grinn-global.com>
To: rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Keerthy <j-keerthy@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [rtc-linux] [PATCH] rtc: omap: Support ext_wakeup configuration
Date: Mon,  4 Apr 2016 17:56:43 +0200
Message-Id: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Support configuration of ext_wakeup sources. This patch makes it
possible to enable ext_wakeup and set it's polarity, depending on board
configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup to
notify about power-button presses. Handling power-button presses enables
to recover from RTC-only power states correctly.

Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
---
 Documentation/devicetree/bindings/rtc/rtc-omap.txt | 24 ++++++++++-
 drivers/rtc/rtc-omap.c                             | 46 +++++++++++++++++++++-
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
index bf7d11a..1c05311b 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
@@ -18,8 +18,20 @@ Optional properties:
   through pmic_power_en
 - clocks: Any internal or external clocks feeding in to rtc
 - clock-names: Corresponding names of the clocks
+- ti,ext-wakeup-en: Enables ext_wakeup[n] sources. Value determines which
+		    ext_wakeup is enabled by bitwise OR of corresponding bits.
+		    Examples:
+		     <1> - enabled ext_wakeup[0],
+		     <2> - enabled ext_wakeup[1],
+		     <3> - enabled ext_wakeup[0] and enabled ext_wakeup[1],
+		     ...
+- ti,ext-wakeup-pol: Sets polarity of ext_wakeup[n] sources, similarly as
+		     above. Set bit means active-low, unset bit means
+		     active-high. Examples:
+		      <1> - only ext_wakeup0 is active-low
+		      <3> - only ext_wakeup0 and ext_wakeup1 are active-low
 
-Example:
+Examples:
 
 rtc@1c23000 {
 	compatible = "ti,da830-rtc";
@@ -31,3 +43,13 @@ rtc@1c23000 {
 	clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
 	clock-names = "ext-clk", "int-clk";
 };
+
+rtc@44e3e000 {
+	compatible = "ti,am3352-rtc", "ti,da830-rtc";
+	reg = <0x44e3e000 0x1000>;
+	interrupts = <75
+		      76>;
+	system-power-controller;
+	ti,ext-wakeup-en = <1>;
+	ti,ext-wakeup-pol = <1>;
+};
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index ec2e9c5..1a46f5d 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -114,7 +114,11 @@
 #define OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN	BIT(1)
 
 /* OMAP_RTC_PMIC bit fields: */
-#define OMAP_RTC_PMIC_POWER_EN_EN	BIT(16)
+#define OMAP_RTC_PMIC_POWER_EN_EN		BIT(16)
+#define OMAP_RTC_PMIC_EXT_WAKEUP_EN(x)		(x)
+#define OMAP_RTC_PMIC_EXT_WAKEUP_POL(x)		((x) << 4)
+#define OMAP_RTC_PMIC_EXT_WAKEUP_EN_MASK	0x0F
+#define OMAP_RTC_PMIC_EXT_WAKEUP_POL_MASK	0xF0
 
 /* OMAP_RTC_KICKER values */
 #define	KICK0_VALUE			0x83e70b13
@@ -533,6 +537,11 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	const struct platform_device_id *id_entry;
 	const struct of_device_id *of_id;
 	int ret;
+	u32 ext_wakeup_en;
+	u32 ext_wakeup_pol;
+	bool has_ext_wakeup_en;
+	bool has_ext_wakeup_pol;
+	u32 val;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
@@ -544,6 +553,30 @@ static int omap_rtc_probe(struct platform_device *pdev)
 		rtc->is_pmic_controller = rtc->type->has_pmic_mode &&
 				of_property_read_bool(pdev->dev.of_node,
 						"system-power-controller");
+		if (of_property_read_u32(pdev->dev.of_node,
+						"ti,ext-wakeup-en",
+						&ext_wakeup_en) >= 0) {
+			if (ext_wakeup_en < BIT(4))
+				has_ext_wakeup_en = true;
+			else
+				dev_err(&pdev->dev,
+					"wrong ext-wakeup-en value\n");
+		} else {
+			dev_err(&pdev->dev,
+				"no ext-wakeup-en\n");
+		}
+		if (of_property_read_u32(pdev->dev.of_node,
+						"ti,ext-wakeup-pol",
+						&ext_wakeup_pol) >= 0) {
+			if (ext_wakeup_pol < BIT(4))
+				has_ext_wakeup_pol = true;
+			else
+				dev_err(&pdev->dev,
+					"wrong ext-wakeup-pol value\n");
+		} else {
+			dev_err(&pdev->dev,
+				"no ext-wakeup-pol\n");
+		}
 	} else {
 		id_entry = platform_get_device_id(pdev);
 		rtc->type = (void *)id_entry->driver_data;
@@ -650,6 +683,17 @@ static int omap_rtc_probe(struct platform_device *pdev)
 			  reg | OMAP_RTC_OSC_SEL_32KCLK_SRC);
 	}
 
+	if (has_ext_wakeup_en || has_ext_wakeup_pol) {
+		val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
+		if (has_ext_wakeup_en)
+			val = (val & ~OMAP_RTC_PMIC_EXT_WAKEUP_EN_MASK)
+				| OMAP_RTC_PMIC_EXT_WAKEUP_EN(ext_wakeup_en);
+		if (has_ext_wakeup_pol)
+			val = (val & ~OMAP_RTC_PMIC_EXT_WAKEUP_POL_MASK)
+				| OMAP_RTC_PMIC_EXT_WAKEUP_POL(ext_wakeup_pol);
+		rtc_writel(rtc, OMAP_RTC_PMIC_REG, val);
+	}
+
 	rtc->type->lock(rtc);
 
 	device_init_wakeup(&pdev->dev, true);
-- 
2.8.0

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
