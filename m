Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36345 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeIUQAV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 21 Sep 2018 12:00:21 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, linux-rtc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: tegra: Propagate errors from platform_get_irq()
Date: Fri, 21 Sep 2018 12:12:09 +0200
Message-Id: <20180921101209.11895-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Instead of confusingly returning -EBUSY on failure to obtain an
interrupt, propagate the real error code. While at it, let the user know
why the interrupt could not be acquired.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/rtc/rtc-tegra.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index 8dc48fe7fc35..c9e77a83cd1b 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -322,9 +322,13 @@ static int __init tegra_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->rtc_base))
 		return PTR_ERR(info->rtc_base);
 
-	info->tegra_rtc_irq = platform_get_irq(pdev, 0);
-	if (info->tegra_rtc_irq <= 0)
-		return -EBUSY;
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0) {
+		dev_err(&pdev->dev, "failed to get platform IRQ: %d\n", ret);
+		return ret;
+	}
+
+	info->tegra_rtc_irq = ret;
 
 	info->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(info->clk))
-- 
2.19.0
