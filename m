Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52776 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754586AbdJLWGw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 18:06:52 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/2] rtc: omap: switch to rtc_register_device
Date: Fri, 13 Oct 2017 00:06:45 +0200
Message-Id: <20171012220645.8704-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20171012220645.8704-1-alexandre.belloni@free-electrons.com>
References: <20171012220645.8704-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This removes a possible race condition and crash and allows for further
improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-omap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 3bdc041fc2e9..d56d937966dc 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -797,13 +797,14 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, true);
 
-	rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-			&omap_rtc_ops, THIS_MODULE);
+	rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc)) {
 		ret = PTR_ERR(rtc->rtc);
 		goto err;
 	}
 
+	rtc->rtc->ops = &omap_rtc_ops;
+
 	/* handle periodic and alarm irqs */
 	ret = devm_request_irq(&pdev->dev, rtc->irq_timer, rtc_irq, 0,
 			dev_name(&rtc->rtc->dev), rtc);
@@ -834,6 +835,10 @@ static int omap_rtc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	ret = rtc_register_device(rtc->rtc);
+	if (ret)
+		goto err;
+
 	return 0;
 
 err:
-- 
2.14.2
