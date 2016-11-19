Return-Path: <rtc-linux+bncBAABBR44YHAQKGQELJMRY3Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from botnar.kaiser.cx (botnar.kaiser.cx. [176.28.20.183])
        by gmr-mx.google.com with ESMTPS id h23si376031wmi.1.2016.11.19.05.06.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 19 Nov 2016 05:06:14 -0800 (PST)
From: Martin Kaiser <martin@kaiser.cx>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Juergen Borleis <jbe@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 2/2] rtc: imxdi: use the security violation interrupt
Date: Sat, 19 Nov 2016 14:03:34 +0100
Message-Id: <1479560614-19293-2-git-send-email-martin@kaiser.cx>
In-Reply-To: <1479560614-19293-1-git-send-email-martin@kaiser.cx>
References: <1479560614-19293-1-git-send-email-martin@kaiser.cx>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The DryIce chipset has a dedicated security violation interrupt that is
triggered for security violations (if configured to do so). According to
the publicly available imx258 reference manual, irq 56 is used for this
interrupt.

Install a handler for the security violation interrupt. Move the code
for handling security violations from the "normal" interrupt handler
into the security violation interrupt handler.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../devicetree/bindings/rtc/imxdi-rtc.txt          |    4 +-
 arch/arm/boot/dts/imx25.dtsi                       |    2 +-
 drivers/rtc/rtc-imxdi.c                            |   64 ++++++++++++++------
 3 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt b/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
index c9d80d7..c53c7d8 100644
--- a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
@@ -6,12 +6,12 @@ Required properties:
 - compatible: should be: "fsl,imx25-rtc"
 - reg: physical base address of the controller and length of memory mapped
   region.
-- interrupts: rtc alarm interrupt
+- interrupts: rtc alarm interrupt, dryice security violation interrupt
 
 Example:
 
 rtc@80056000 {
 	compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
 	reg = <0x80056000 2000>;
-	interrupts = <29>;
+	interrupts = <29>, <56>;
 };
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 831d09a..3b754e3 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -560,7 +560,7 @@
 				reg = <0x53ffc000 0x4000>;
 				clocks = <&clks 81>;
 				clock-names = "ipg";
-				interrupts = <25>;
+				interrupts = <25>, <56>;
 			};
 		};
 
diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 67b56b8..9e1cf49 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -109,6 +109,7 @@
  * @rtc: pointer to rtc struct
  * @ioaddr: IO registers pointer
  * @irq: dryice normal interrupt
+ * @sec_irq: dryice security violation interrupt
  * @clk: input reference clock
  * @dsr: copy of the DSR register
  * @irq_lock: interrupt enable register (DIER) lock
@@ -121,6 +122,7 @@ struct imxdi_dev {
 	struct rtc_device *rtc;
 	void __iomem *ioaddr;
 	int irq;
+	int sec_irq;
 	struct clk *clk;
 	u32 dsr;
 	spinlock_t irq_lock;
@@ -688,24 +690,6 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 	dier = readl(imxdi->ioaddr + DIER);
 	dsr = readl(imxdi->ioaddr + DSR);
 
-	/* handle the security violation event */
-	if (dier & DIER_SVIE) {
-		if (dsr & DSR_SVF) {
-			/*
-			 * Disable the interrupt when this kind of event has
-			 * happened.
-			 * There cannot be more than one event of this type,
-			 * because it needs a complex state change
-			 * including a main power cycle to get again out of
-			 * this state.
-			 */
-			di_int_disable(imxdi, DIER_SVIE);
-			/* report the violation */
-			di_report_tamper_info(imxdi, dsr);
-			rc = IRQ_HANDLED;
-		}
-	}
-
 	/* handle write complete and write error cases */
 	if (dier & DIER_WCIE) {
 		/*If the write wait queue is empty then there is no pending
@@ -743,6 +727,40 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 }
 
 /*
+ * dryice security violation interrupt handler
+ */
+static irqreturn_t dryice_sec_irq(int irq, void *dev_id)
+{
+	struct imxdi_dev *imxdi = dev_id;
+	u32 dsr, dier;
+	irqreturn_t rc = IRQ_NONE;
+
+	dier = readl(imxdi->ioaddr + DIER);
+	dsr = readl(imxdi->ioaddr + DSR);
+
+	/* handle the security violation event */
+	if (dier & DIER_SVIE) {
+		if (dsr & DSR_SVF) {
+			/*
+			 * Disable the interrupt when this kind of event has
+			 * happened.
+			 * There cannot be more than one event of this type,
+			 * because it needs a complex state change
+			 * including a main power cycle to get again out of
+			 * this state.
+			 */
+			di_int_disable(imxdi, DIER_SVIE);
+			/* report the violation */
+			di_report_tamper_info(imxdi, dsr);
+			rc = IRQ_HANDLED;
+		}
+	}
+
+	return rc;
+}
+
+
+/*
  * post the alarm event from user context so it can sleep
  * on the write completion.
  */
@@ -783,6 +801,9 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 	imxdi->irq = platform_get_irq(pdev, 0);
 	if (imxdi->irq < 0)
 		return imxdi->irq;
+	imxdi->sec_irq = platform_get_irq(pdev, 1);
+	if (imxdi->sec_irq < 0)
+		return imxdi->sec_irq;
 
 	init_waitqueue_head(&imxdi->write_wait);
 
@@ -815,6 +836,13 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	rc = devm_request_irq(&pdev->dev, imxdi->sec_irq, dryice_sec_irq,
+			IRQF_SHARED, pdev->name, imxdi);
+	if (rc) {
+		dev_warn(&pdev->dev, "security violation interrupt not available.\n");
+		goto err;
+	}
+
 	platform_set_drvdata(pdev, imxdi);
 	imxdi->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 				  &dryice_rtc_ops, THIS_MODULE);
-- 
1.7.10.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
