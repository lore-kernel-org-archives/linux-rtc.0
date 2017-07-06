Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49157 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbdGFJmP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 05:42:15 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 04/11] rtc: at91rm9200: remove race condition
Date: Thu,  6 Jul 2017 11:42:01 +0200
Message-Id: <20170706094208.16240-5-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
References: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

While highly unlikely, it is possible to get an interrupt as soon as it is
requested. In that case, at91_rtc_interrupt() will be called with rtc ==
NULL.

Solve that by using devm_rtc_allocate_device/rtc_register_device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-at91rm9200.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index b60fd477778f..e221b78b6f10 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -409,6 +409,11 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+	platform_set_drvdata(pdev, rtc);
+
 	sclk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sclk))
 		return PTR_ERR(sclk);
@@ -441,13 +446,10 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 	if (!device_can_wakeup(&pdev->dev))
 		device_init_wakeup(&pdev->dev, 1);
 
-	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-				&at91_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc)) {
-		ret = PTR_ERR(rtc);
+	rtc->ops = &at91_rtc_ops;
+	ret = rtc_register_device(rtc);
+	if (ret)
 		goto err_clk;
-	}
-	platform_set_drvdata(pdev, rtc);
 
 	/* enable SECEV interrupt in order to initialize at91_rtc_upd_rdy
 	 * completion.
-- 
2.11.0
