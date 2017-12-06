Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:54094 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbdLFTtl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 6 Dec 2017 14:49:41 -0500
From: Andreas Platschek <andreas.platschek@opentech.at>
To: linux-kernel@vger.kernel.org
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        linux-rtc@vger.kernel.org,
        Andreas Platschek <andreas.platschek@opentech.at>
Subject: [PATCH 1/2] rtc: omap: check for clk_prepare_enable() error
Date: Wed,  6 Dec 2017 20:42:37 +0100
Message-Id: <20171206194238.12824-2-andreas.platschek@opentech.at>
In-Reply-To: <20171206194238.12824-1-andreas.platschek@opentech.at>
References: <20171206194238.12824-1-andreas.platschek@opentech.at>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

clk_prepare_enable() returns an error -> check it.

Signed-off-by: Andreas Platschek <andreas.platschek@opentech.at>
---
 drivers/rtc/rtc-omap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 1d666ac9ef70..ad309feb7d11 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -748,8 +748,15 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	else
 		rtc->clk = devm_clk_get(&pdev->dev, "int-clk");
 
-	if (!IS_ERR(rtc->clk))
-		clk_prepare_enable(rtc->clk);
+	if (!IS_ERR(rtc->clk)) {
+		ret = clk_prepare_enable(rtc->clk);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to enable rtc clk (%u)\n", ret);
+			return ret;
+		}
+	}
+
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rtc->base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.11.0
