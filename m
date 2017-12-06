Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:54096 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdLFTtl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 6 Dec 2017 14:49:41 -0500
From: Andreas Platschek <andreas.platschek@opentech.at>
To: linux-kernel@vger.kernel.org
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        linux-rtc@vger.kernel.org,
        Andreas Platschek <andreas.platschek@opentech.at>
Subject: [PATCH 2/2] rtc: omap: fix unbalanced clk_prepare_enable/clk_disable_unprepare
Date: Wed,  6 Dec 2017 20:42:38 +0100
Message-Id: <20171206194238.12824-3-andreas.platschek@opentech.at>
In-Reply-To: <20171206194238.12824-1-andreas.platschek@opentech.at>
References: <20171206194238.12824-1-andreas.platschek@opentech.at>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

There are 2 error paths after clk_prepare_enable() was called, where
clk_disable_unprepare() is missing.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Andreas Platschek <andreas.platschek@opentech.at>
---
 drivers/rtc/rtc-omap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index ad309feb7d11..c6aa8f94bb3c 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -760,8 +760,10 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rtc->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(rtc->base))
+	if (IS_ERR(rtc->base)) {
+		clk_disable_unprepare(rtc->clk);
 		return PTR_ERR(rtc->base);
+	}
 
 	platform_set_drvdata(pdev, rtc);
 
@@ -894,6 +896,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	return 0;
 
 err:
+	clk_disable_unprepare(rtc->clk);
 	device_init_wakeup(&pdev->dev, false);
 	rtc->type->lock(rtc);
 	pm_runtime_put_sync(&pdev->dev);
-- 
2.11.0
