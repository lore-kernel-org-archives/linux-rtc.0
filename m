Return-Path: <rtc-linux+bncBAABBEGNXOYAKGQETKSLOVA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.cosmopool.net (mail.cosmopool.net. [2a01:4f8:160:20c1::10:107])
        by gmr-mx.google.com with ESMTP id o5si20170wib.0.2015.10.02.13.18.23
        for <rtc-linux@googlegroups.com>;
        Fri, 02 Oct 2015 13:18:24 -0700 (PDT)
From: Harald Geyer <harald@ccbib.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: rtc-linux@googlegroups.com,
	linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de,
	Harald Geyer <harald@ccbib.org>
Subject: [rtc-linux] [PATCH 1/2] rtc: stmp3xxx: unify register access macros
Date: Fri,  2 Oct 2015 20:18:01 +0000
Message-Id: <1443817082-24370-1-git-send-email-harald@ccbib.org>
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

Use STMP_OFFSET_REG_(SET|CLR) instead of defining _SET and _CLR for
STMP3XXX_RTC_CTRL and STMP3XXX_RTC_PERSISTENT0 - no functional changes.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 drivers/rtc/rtc-stmp3xxx.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index eb09edd..ca54d03 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -32,8 +32,6 @@
 #include <linux/stmp3xxx_rtc_wdt.h>
 
 #define STMP3XXX_RTC_CTRL			0x0
-#define STMP3XXX_RTC_CTRL_SET			0x4
-#define STMP3XXX_RTC_CTRL_CLR			0x8
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
 #define STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN	0x00000002
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ		0x00000004
@@ -52,8 +50,6 @@
 #define STMP3XXX_RTC_WATCHDOG			0x50
 
 #define STMP3XXX_RTC_PERSISTENT0		0x60
-#define STMP3XXX_RTC_PERSISTENT0_SET		0x64
-#define STMP3XXX_RTC_PERSISTENT0_CLR		0x68
 #define STMP3XXX_RTC_PERSISTENT0_CLOCKSOURCE		(1 << 0)
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN		(1 << 1)
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_EN		(1 << 2)
@@ -179,7 +175,7 @@ static irqreturn_t stmp3xxx_rtc_interrupt(int irq, void *dev_id)
 
 	if (status & STMP3XXX_RTC_CTRL_ALARM_IRQ) {
 		writel(STMP3XXX_RTC_CTRL_ALARM_IRQ,
-				rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
+			rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
 		rtc_update_irq(rtc_data->rtc, 1, RTC_AF | RTC_IRQF);
 		return IRQ_HANDLED;
 	}
@@ -194,15 +190,17 @@ static int stmp3xxx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	if (enabled) {
 		writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 				STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN,
-				rtc_data->io + STMP3XXX_RTC_PERSISTENT0_SET);
+			rtc_data->io + STMP3XXX_RTC_PERSISTENT0 +
+				STMP_OFFSET_REG_SET);
 		writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-				rtc_data->io + STMP3XXX_RTC_CTRL_SET);
+			rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_SET);
 	} else {
 		writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 				STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN,
-				rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
+			rtc_data->io + STMP3XXX_RTC_PERSISTENT0 +
+				STMP_OFFSET_REG_CLR);
 		writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-				rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
+			rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
 	}
 	return 0;
 }
@@ -245,7 +243,7 @@ static int stmp3xxx_rtc_remove(struct platform_device *pdev)
 		return 0;
 
 	writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-			rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
+		rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
 
 	return 0;
 }
@@ -334,16 +332,17 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 			STMP3XXX_RTC_PERSISTENT0_CLOCKSOURCE;
 	}
 
-	writel(pers0_set, rtc_data->io + STMP3XXX_RTC_PERSISTENT0_SET);
+	writel(pers0_set, rtc_data->io + STMP3XXX_RTC_PERSISTENT0 +
+			STMP_OFFSET_REG_SET);
 
 	writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE | pers0_clr,
-			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
+		rtc_data->io + STMP3XXX_RTC_PERSISTENT0 + STMP_OFFSET_REG_CLR);
 
 	writel(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN |
 			STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-			rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
+		rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
 
 	rtc_data->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 				&stmp3xxx_rtc_ops, THIS_MODULE);
@@ -376,7 +375,7 @@ static int stmp3xxx_rtc_resume(struct device *dev)
 	writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
-			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
+		rtc_data->io + STMP3XXX_RTC_PERSISTENT0 + STMP_OFFSET_REG_CLR);
 	return 0;
 }
 #endif
-- 
1.7.10.4

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
