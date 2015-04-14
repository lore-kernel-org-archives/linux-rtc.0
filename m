Return-Path: <rtc-linux+bncBCC6ZWOPXENRBHVSWOUQKGQELJDR3UA@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:6f8:1178:4:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id k2si544094wif.0.2015.04.14.02.08.45
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Apr 2015 02:08:45 -0700 (PDT)
From: Juergen Borleis <jbe@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org,
	Robert Schwebel <rsc@pengutronix.de>
Subject: [rtc-linux] [PATCH 3/5] RTC/i.MX/DryIce: monitor a security violation
 at runtime
Date: Tue, 14 Apr 2015 11:08:36 +0200
Message-Id: <1429002518-5015-4-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1429002518-5015-2-git-send-email-jbe@pengutronix.de>
References: <1429002518-5015-2-git-send-email-jbe@pengutronix.de>
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

Maybe the unit enters the hardware related state at runtime and not at
system boot time (after a power cycle).

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
Signed-off-by: Robert Schwebel <rsc@pengutronix.de>
[rsc: got NDA clearance from Freescale]
---
 drivers/rtc/rtc-imxdi.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index f8abf2b..b04c64f 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -680,6 +680,25 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 	irqreturn_t rc = IRQ_NONE;
 
 	dier = __raw_readl(imxdi->ioaddr + DIER);
+	dsr = __raw_readl(imxdi->ioaddr + DSR);
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
 
 	/* handle write complete and write error cases */
 	if (dier & DIER_WCIE) {
@@ -690,7 +709,6 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 			return rc;
 
 		/* DSR_WCF clears itself on DSR read */
-		dsr = __raw_readl(imxdi->ioaddr + DSR);
 		if (dsr & (DSR_WCF | DSR_WEF)) {
 			/* mask the interrupt */
 			di_int_disable(imxdi, DIER_WCIE);
@@ -706,7 +724,6 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
 	/* handle the alarm case */
 	if (dier & DIER_CAIE) {
 		/* DSR_WCF clears itself on DSR read */
-		dsr = __raw_readl(imxdi->ioaddr + DSR);
 		if (dsr & DSR_CAF) {
 			/* mask the interrupt */
 			di_int_disable(imxdi, DIER_CAIE);
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
