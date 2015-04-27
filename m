Return-Path: <rtc-linux+bncBCC6ZWOPXENRBYMB7GUQKGQEKLXYBVA@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:6f8:1178:4:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id bc3si417936wib.2.2015.04.27.07.00.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Apr 2015 07:00:01 -0700 (PDT)
From: Juergen Borleis <jbe@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 1/6] RTC/i.MX/DryIce: avoid the __raw* register
 access functions
Date: Mon, 27 Apr 2015 15:59:47 +0200
Message-Id: <1430143192-20667-2-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
References: <1430143192-20667-1-git-send-email-jbe@pengutronix.de>
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

Be independent of the endianness of the kernel.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/rtc/rtc-imxdi.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index c666eab..0c2a064 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -137,7 +137,7 @@ static void di_int_enable(struct imxdi_dev *imxdi, u32 intr)
 	unsigned long flags;
 
 	spin_lock_irqsave(&imxdi->irq_lock, flags);
-	__raw_writel(__raw_readl(imxdi->ioaddr + DIER) | intr,
+	writel(readl(imxdi->ioaddr + DIER) | intr,
 			imxdi->ioaddr + DIER);
 	spin_unlock_irqrestore(&imxdi->irq_lock, flags);
 }
@@ -150,7 +150,7 @@ static void di_int_disable(struct imxdi_dev *imxdi, u32 intr)
 	unsigned long flags;
 
 	spin_lock_irqsave(&imxdi->irq_lock, flags);
-	__raw_writel(__raw_readl(imxdi->ioaddr + DIER) & ~intr,
+	writel(readl(imxdi->ioaddr + DIER) & ~intr,
 			imxdi->ioaddr + DIER);
 	spin_unlock_irqrestore(&imxdi->irq_lock, flags);
 }
@@ -169,11 +169,11 @@ static void clear_write_error(struct imxdi_dev *imxdi)
 	dev_warn(&imxdi->pdev->dev, "WARNING: Register write error!\n");
 
 	/* clear the write error flag */
-	__raw_writel(DSR_WEF, imxdi->ioaddr + DSR);
+	writel(DSR_WEF, imxdi->ioaddr + DSR);
 
 	/* wait for it to take effect */
 	for (cnt = 0; cnt < 1000; cnt++) {
-		if ((__raw_readl(imxdi->ioaddr + DSR) & DSR_WEF) == 0)
+		if ((readl(imxdi->ioaddr + DSR) & DSR_WEF) == 0)
 			return;
 		udelay(10);
 	}
@@ -201,7 +201,7 @@ static int di_write_wait(struct imxdi_dev *imxdi, u32 val, int reg)
 	imxdi->dsr = 0;
 
 	/* do the register write */
-	__raw_writel(val, imxdi->ioaddr + reg);
+	writel(val, imxdi->ioaddr + reg);
 
 	/* wait for the write to finish */
 	ret = wait_event_interruptible_timeout(imxdi->write_wait,
@@ -235,7 +235,7 @@ static int dryice_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
 	unsigned long now;
 
-	now = __raw_readl(imxdi->ioaddr + DTCMR);
+	now = readl(imxdi->ioaddr + DTCMR);
 	rtc_time_to_tm(now, tm);
 
 	return 0;
@@ -280,17 +280,17 @@ static int dryice_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
 	u32 dcamr;
 
-	dcamr = __raw_readl(imxdi->ioaddr + DCAMR);
+	dcamr = readl(imxdi->ioaddr + DCAMR);
 	rtc_time_to_tm(dcamr, &alarm->time);
 
 	/* alarm is enabled if the interrupt is enabled */
-	alarm->enabled = (__raw_readl(imxdi->ioaddr + DIER) & DIER_CAIE) != 0;
+	alarm->enabled = (readl(imxdi->ioaddr + DIER) & DIER_CAIE) != 0;
 
 	/* don't allow the DSR read to mess up DSR_WCF */
 	mutex_lock(&imxdi->write_mutex);
 
 	/* alarm is pending if the alarm flag is set */
-	alarm->pending = (__raw_readl(imxdi->ioaddr + DSR) & DSR_CAF) != 0;
+	alarm->pending = (readl(imxdi->ioaddr + DSR) & DSR_CAF) != 0;
 
 	mutex_unlock(&imxdi->write_mutex);
 
@@ -312,7 +312,7 @@ static int dryice_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		return rc;
 
 	/* don't allow setting alarm in the past */
-	now = __raw_readl(imxdi->ioaddr + DTCMR);
+	now = readl(imxdi->ioaddr + DTCMR);
 	if (alarm_time < now)
 		return -EINVAL;
 
@@ -346,7 +346,7 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 	u32 dsr, dier;
 	irqreturn_t rc = IRQ_NONE;
 
-	dier = __raw_readl(imxdi->ioaddr + DIER);
+	dier = readl(imxdi->ioaddr + DIER);
 
 	/* handle write complete and write error cases */
 	if (dier & DIER_WCIE) {
@@ -357,7 +357,7 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 			return rc;
 
 		/* DSR_WCF clears itself on DSR read */
-		dsr = __raw_readl(imxdi->ioaddr + DSR);
+		dsr = readl(imxdi->ioaddr + DSR);
 		if (dsr & (DSR_WCF | DSR_WEF)) {
 			/* mask the interrupt */
 			di_int_disable(imxdi, DIER_WCIE);
@@ -373,7 +373,7 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 	/* handle the alarm case */
 	if (dier & DIER_CAIE) {
 		/* DSR_WCF clears itself on DSR read */
-		dsr = __raw_readl(imxdi->ioaddr + DSR);
+		dsr = readl(imxdi->ioaddr + DSR);
 		if (dsr & DSR_CAF) {
 			/* mask the interrupt */
 			di_int_disable(imxdi, DIER_CAIE);
@@ -446,7 +446,7 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 	 */
 
 	/* mask all interrupts */
-	__raw_writel(0, imxdi->ioaddr + DIER);
+	writel(0, imxdi->ioaddr + DIER);
 
 	rc = devm_request_irq(&pdev->dev, imxdi->irq, dryice_norm_irq,
 			IRQF_SHARED, pdev->name, imxdi);
@@ -456,7 +456,7 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 	}
 
 	/* put dryice into valid state */
-	if (__raw_readl(imxdi->ioaddr + DSR) & DSR_NVF) {
+	if (readl(imxdi->ioaddr + DSR) & DSR_NVF) {
 		rc = di_write_wait(imxdi, DSR_NVF | DSR_SVF, DSR);
 		if (rc)
 			goto err;
@@ -471,23 +471,23 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 		goto err;
 
 	/* clear alarm flag */
-	if (__raw_readl(imxdi->ioaddr + DSR) & DSR_CAF) {
+	if (readl(imxdi->ioaddr + DSR) & DSR_CAF) {
 		rc = di_write_wait(imxdi, DSR_CAF, DSR);
 		if (rc)
 			goto err;
 	}
 
 	/* the timer won't count if it has never been written to */
-	if (__raw_readl(imxdi->ioaddr + DTCMR) == 0) {
+	if (readl(imxdi->ioaddr + DTCMR) == 0) {
 		rc = di_write_wait(imxdi, 0, DTCMR);
 		if (rc)
 			goto err;
 	}
 
 	/* start keeping time */
-	if (!(__raw_readl(imxdi->ioaddr + DCR) & DCR_TCE)) {
+	if (!(readl(imxdi->ioaddr + DCR) & DCR_TCE)) {
 		rc = di_write_wait(imxdi,
-				__raw_readl(imxdi->ioaddr + DCR) | DCR_TCE,
+				readl(imxdi->ioaddr + DCR) | DCR_TCE,
 				DCR);
 		if (rc)
 			goto err;
@@ -516,7 +516,7 @@ static int __exit dryice_rtc_remove(struct platform_device *pdev)
 	flush_work(&imxdi->work);
 
 	/* mask all interrupts */
-	__raw_writel(0, imxdi->ioaddr + DIER);
+	writel(0, imxdi->ioaddr + DIER);
 
 	clk_disable_unprepare(imxdi->clk);
 
-- 
2.1.4

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
