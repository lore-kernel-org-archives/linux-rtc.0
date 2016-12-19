Return-Path: <rtc-linux+bncBAABBBWF4HBAKGQEYZLTH5I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from botnar.kaiser.cx (botnar.kaiser.cx. [176.28.20.183])
        by gmr-mx.google.com with ESMTPS id d199si1293074wmd.1.2016.12.19.14.43.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 14:43:18 -0800 (PST)
From: Martin Kaiser <martin@kaiser.cx>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Juergen Borleis <jbe@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [rtc-linux] [PATCH v2] rtc: imxdi: use the security violation interrupt
Date: Mon, 19 Dec 2016 23:41:29 +0100
Message-Id: <1482187289-19272-1-git-send-email-martin@kaiser.cx>
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

Install a handler for the security violation interrupt if an irq for
this is provided by platform data / device tree. Move the code for
handling security violations from the "normal" interrupt handler into
the security violation interrupt handler.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
  - make sec_irq optional to avoid breaking the Device Tree ABI
  - removed the Device Tree bindings, I'll prepare a separate patch for them

 drivers/rtc/rtc-imxdi.c |   68 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 67b56b8..ec6077a0 100644
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
@@ -783,6 +801,13 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 	imxdi->irq = platform_get_irq(pdev, 0);
 	if (imxdi->irq < 0)
 		return imxdi->irq;
+	/* the 2nd irq is the security violation irq
+	   make this optional, don't break the device tree ABI */
+	rc = platform_get_irq(pdev, 1);
+	if (rc > 0)
+		imxdi->sec_irq = rc;
+	else
+		imxdi->sec_irq = IRQ_NOTCONNECTED;
 
 	init_waitqueue_head(&imxdi->write_wait);
 
@@ -815,6 +840,13 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	rc = devm_request_irq(&pdev->dev, imxdi->sec_irq, dryice_sec_irq,
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
