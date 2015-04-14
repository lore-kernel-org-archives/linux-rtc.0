Return-Path: <rtc-linux+bncBCC6ZWOPXENRBHVSWOUQKGQELJDR3UA@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:6f8:1178:4:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id q10si62261wiz.0.2015.04.14.02.08.45
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Apr 2015 02:08:45 -0700 (PDT)
From: Juergen Borleis <jbe@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org,
	Robert Schwebel <rsc@pengutronix.de>
Subject: [rtc-linux] [PATCH 4/5] RTC/i.MX/DryIce: when locked, do not fail silently
Date: Tue, 14 Apr 2015 11:08:37 +0200
Message-Id: <1429002518-5015-5-git-send-email-jbe@pengutronix.de>
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

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
Signed-off-by: Robert Schwebel <rsc@pengutronix.de>
[rsc: got NDA clearance from Freescale]
---
 drivers/rtc/rtc-imxdi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index b04c64f..de1a2e4 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -581,14 +581,36 @@ static int dryice_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int dryice_rtc_set_mmss(struct device *dev, unsigned long secs)
 {
 	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
+	u32 dcr, dsr;
 	int rc;
 
+	dcr = __raw_readl(imxdi->ioaddr + DCR);
+	dsr = __raw_readl(imxdi->ioaddr + DSR);
+
+	if (!(dcr & DCR_TCE) || (dsr & DSR_SVF)) {
+		if (dcr & DCR_TCHL) {
+			/* we are even more out of luck */
+			di_what_is_to_be_done(imxdi, "battery");
+			return -EPERM;
+		}
+		if ((dcr & DCR_TCSL) || (dsr & DSR_SVF)) {
+			/* we are out of luck for now */
+			di_what_is_to_be_done(imxdi, "main");
+			return -EPERM;
+		}
+	}
+
 	/* zero the fractional part first */
 	rc = di_write_wait(imxdi, 0, DTCLR);
-	if (rc == 0)
-		rc = di_write_wait(imxdi, secs, DTCMR);
+	if (rc != 0)
+		return rc;
 
-	return rc;
+	rc = di_write_wait(imxdi, secs, DTCMR);
+	if (rc != 0)
+		return rc;
+
+	return di_write_wait(imxdi, __raw_readl(imxdi->ioaddr + DCR) |
+								DCR_TCE, DCR);
 }
 
 static int dryice_rtc_alarm_irq_enable(struct device *dev,
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
