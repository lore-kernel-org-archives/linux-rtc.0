Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from gateway23.websitewelcome.com ([192.185.50.104]:18036 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751904AbdHIQRG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 9 Aug 2017 12:17:06 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 8B1721F300
        for <linux-rtc@vger.kernel.org>; Wed,  9 Aug 2017 10:52:45 -0500 (CDT)
Date: Wed, 9 Aug 2017 10:52:44 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] rtc: at91rm9200: fix error return code in at91_rtc_probe()
Message-ID: <20170809155244.GA25987@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

platform_get_irq() returns an error code, but the at91rm9200 driver
ignores it and always returns -ENXIO. This is not correct and,
prevents -EPROBE_DEFER from being propagated properly.

Print and propagate the return value of platform_get_irq on failure.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/rtc/rtc-at91rm9200.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index e221b78..09bc2e0 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -398,8 +398,8 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource defined\n");
-		return -ENXIO;
+		dev_err(&pdev->dev, "no irq resource defined: %d\n", irq);
+		return irq;
 	}
 
 	at91_rtc_regs = devm_ioremap(&pdev->dev, regs->start,
-- 
2.5.0
