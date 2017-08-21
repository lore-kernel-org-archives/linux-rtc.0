Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55785 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbdHUP5p (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 Aug 2017 11:57:45 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: pxa: fix possible race condition
Date: Mon, 21 Aug 2017 17:57:42 +0200
Message-Id: <20170821155742.22290-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

pxa_rtc_open() registers the interrupt handler which will access the RTC
registers. However, pxa_rtc_open() is called before the register range is
ioremapped. Instead, call it after devm_ioremap().

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-pxa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index fe4985b54608..47304f5664d8 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -348,7 +348,7 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 		dev_err(dev, "No alarm IRQ resource defined\n");
 		return -ENXIO;
 	}
-	pxa_rtc_open(dev);
+
 	pxa_rtc->base = devm_ioremap(dev, pxa_rtc->ress->start,
 				resource_size(pxa_rtc->ress));
 	if (!pxa_rtc->base) {
@@ -356,6 +356,8 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	pxa_rtc_open(dev);
+
 	sa1100_rtc->rcnr = pxa_rtc->base + 0x0;
 	sa1100_rtc->rtsr = pxa_rtc->base + 0x8;
 	sa1100_rtc->rtar = pxa_rtc->base + 0x4;
-- 
2.14.1
