Return-Path: <rtc-linux+bncBAABBDMS5TBAKGQEVQHTNJY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from botnar.kaiser.cx (botnar.kaiser.cx. [176.28.20.183])
        by gmr-mx.google.com with ESMTPS id f71si1653117wmf.2.2016.12.21.14.58.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 21 Dec 2016 14:58:20 -0800 (PST)
From: Martin Kaiser <martin@kaiser.cx>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Juergen Borleis <jbe@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [rtc-linux] [PATCH 1/2 v3] rtc: imxdi: use the security violation interrupt
Date: Wed, 21 Dec 2016 23:56:42 +0100
Message-Id: <1482361002-12390-1-git-send-email-martin@kaiser.cx>
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
triggered for security violations (if configured to do so).  According
to the publicly available imx258 reference manual, irq 56 is used for
this interrupt.

If an irq number is provided for the security violation interrupt,
install the same handler that we're already using for the "normal"
interrupt.

imxdi->irq is used only in the probe function, make it a local variable.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v3:
  - add the device tree changes to this patch series
  - install the same interrupt handler for normal and sec irq, rename 
    the handler function accordingly
  - make imxdi->irq and imxdi->sec_irq local variables in the probe 
    function

v2:
  - make sec_irq optional to avoid breaking the Device Tree ABI
  - removed the Device Tree bindings, I'll prepare a separate patch for them

 drivers/rtc/rtc-imxdi.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 67b56b8..73d6908 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -108,7 +108,6 @@
  * @pdev: pionter to platform dev
  * @rtc: pointer to rtc struct
  * @ioaddr: IO registers pointer
- * @irq: dryice normal interrupt
  * @clk: input reference clock
  * @dsr: copy of the DSR register
  * @irq_lock: interrupt enable register (DIER) lock
@@ -120,7 +119,6 @@ struct imxdi_dev {
 	struct platform_device *pdev;
 	struct rtc_device *rtc;
 	void __iomem *ioaddr;
-	int irq;
 	struct clk *clk;
 	u32 dsr;
 	spinlock_t irq_lock;
@@ -677,9 +675,9 @@ static int dryice_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 };
 
 /*
- * dryice "normal" interrupt handler
+ * interrupt handler for dryice "normal" and security violation interrupt
  */
-static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
+static irqreturn_t dryice_irq(int irq, void *dev_id)
 {
 	struct imxdi_dev *imxdi = dev_id;
 	u32 dsr, dier;
@@ -765,6 +763,7 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct imxdi_dev *imxdi;
+	int norm_irq, sec_irq;
 	int rc;
 
 	imxdi = devm_kzalloc(&pdev->dev, sizeof(*imxdi), GFP_KERNEL);
@@ -780,9 +779,15 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&imxdi->irq_lock);
 
-	imxdi->irq = platform_get_irq(pdev, 0);
-	if (imxdi->irq < 0)
-		return imxdi->irq;
+	norm_irq = platform_get_irq(pdev, 0);
+	if (norm_irq < 0)
+		return norm_irq;
+
+	/* the 2nd irq is the security violation irq
+	   make this optional, don't break the device tree ABI */
+	sec_irq = platform_get_irq(pdev, 1);
+	if (sec_irq <= 0)
+		sec_irq = IRQ_NOTCONNECTED;
 
 	init_waitqueue_head(&imxdi->write_wait);
 
@@ -808,13 +813,20 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 	if (rc != 0)
 		goto err;
 
-	rc = devm_request_irq(&pdev->dev, imxdi->irq, dryice_norm_irq,
+	rc = devm_request_irq(&pdev->dev, norm_irq, dryice_irq,
 			IRQF_SHARED, pdev->name, imxdi);
 	if (rc) {
 		dev_warn(&pdev->dev, "interrupt not available.\n");
 		goto err;
 	}
 
+	rc = devm_request_irq(&pdev->dev, sec_irq, dryice_irq,
+			IRQF_SHARED, pdev->name, imxdi);
+	if (rc) {
+		dev_warn(&pdev->dev, "security violation interrupt not available.\n");
+		/* this is not an error, see above */
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
