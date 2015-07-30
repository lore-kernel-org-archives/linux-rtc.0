Return-Path: <rtc-linux+bncBDS7HNEFSALRBUO54WWQKGQEESALLZA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c3si776923wiz.2.2015.07.29.17.24.49
        for <rtc-linux@googlegroups.com>;
        Wed, 29 Jul 2015 17:24:49 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 1/5] rtc: at91sam9: properly handle error case
Date: Thu, 30 Jul 2015 02:24:28 +0200
Message-Id: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
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

In case of a probe error, it is possible to abort after issuing
clk_prepare_enable(). Ensure the clock is disabled and unprepared in that
case.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 5ccaee32df72..152cd816cc43 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -451,8 +451,10 @@ static int at91_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtcdev = devm_rtc_device_register(&pdev->dev, pdev->name,
 					&at91_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtcdev))
-		return PTR_ERR(rtc->rtcdev);
+	if (IS_ERR(rtc->rtcdev)) {
+		ret = PTR_ERR(rtc->rtcdev);
+		goto err_clk;
+	}
 
 	/* register irq handler after we know what name we'll use */
 	ret = devm_request_irq(&pdev->dev, rtc->irq, at91_rtc_interrupt,
@@ -460,7 +462,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
 			       dev_name(&rtc->rtcdev->dev), rtc);
 	if (ret) {
 		dev_dbg(&pdev->dev, "can't share IRQ %d?\n", rtc->irq);
-		return ret;
+		goto err_clk;
 	}
 
 	/* NOTE:  sam9260 rev A silicon has a ROM bug which resets the
@@ -474,6 +476,11 @@ static int at91_rtc_probe(struct platform_device *pdev)
 				dev_name(&rtc->rtcdev->dev));
 
 	return 0;
+
+err_clk:
+	clk_disable_unprepare(rtc->sclk);
+
+	return ret;
 }
 
 /*
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
