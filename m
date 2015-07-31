Return-Path: <rtc-linux+bncBDS7HNEFSALRBAMF5WWQKGQEHQ763BI@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id cj6si124849wib.1.2015.07.31.02.40.16
        for <rtc-linux@googlegroups.com>;
        Fri, 31 Jul 2015 02:40:16 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 15/23] rtc: at91rm9200: get and use slow clock
Date: Fri, 31 Jul 2015 11:39:51 +0200
Message-Id: <1438335599-3301-16-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
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

Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
hang") added a workaround for the slow clock as it is not properly handled
by its users.

Get and use the slow clock as it is necessary for the at91rm9200 rtc.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com
 drivers/rtc/rtc-at91rm9200.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 35efd3f75b18..8093d9e50619 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -24,6 +24,7 @@
 #include <linux/time.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/ioctl.h>
@@ -59,6 +60,7 @@ static bool suspended;
 static DEFINE_SPINLOCK(suspended_lock);
 static unsigned long cached_events;
 static u32 at91_rtc_imr;
+static struct clk *sclk;
 
 static void at91_rtc_write_ier(u32 mask)
 {
@@ -407,6 +409,16 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	sclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sclk))
+		return PTR_ERR(sclk);
+
+	ret = clk_prepare_enable(sclk);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not enable slow clock\n");
+		return ret;
+	}
+
 	at91_rtc_write(AT91_RTC_CR, 0);
 	at91_rtc_write(AT91_RTC_MR, 0);		/* 24 hour mode */
 
@@ -420,7 +432,7 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 			       "at91_rtc", pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "IRQ %d already in use.\n", irq);
-		return ret;
+		goto err_clk;
 	}
 
 	/* cpu init code should really have flagged this device as
@@ -431,8 +443,10 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 
 	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 				&at91_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
+	if (IS_ERR(rtc)) {
+		ret = PTR_ERR(rtc);
+		goto err_clk;
+	}
 	platform_set_drvdata(pdev, rtc);
 
 	/* enable SECEV interrupt in order to initialize at91_rtc_upd_rdy
@@ -442,6 +456,11 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "AT91 Real Time Clock driver.\n");
 	return 0;
+
+err_clk:
+	clk_disable_unprepare(sclk);
+
+	return ret;
 }
 
 /*
@@ -454,6 +473,8 @@ static int __exit at91_rtc_remove(struct platform_device *pdev)
 					AT91_RTC_SECEV | AT91_RTC_TIMEV |
 					AT91_RTC_CALEV);
 
+	clk_disable_unprepare(sclk);
+
 	return 0;
 }
 
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
