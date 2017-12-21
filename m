Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0070.outbound.protection.outlook.com ([104.47.32.70]:51040
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752700AbdLULnK (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 21 Dec 2017 06:43:10 -0500
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <alexandre.belloni@free-electrons.com>
CC: <p.bruenn@beckhoff.com>, <linux-rtc@vger.kernel.org>,
        <festevam@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] rtc: mxc_v2: Remove unnecessary platform_get_resource() error check
Date: Thu, 21 Dec 2017 09:43:24 -0200
Message-ID: <20171221114324.6935-1-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

devm_ioremap_resource() already checks if the resource is NULL, so
remove the unnecessary platform_get_resource() error check.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/rtc/rtc-mxc_v2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
index b637095b0716..eecc0cf9ee95 100644
--- a/drivers/rtc/rtc-mxc_v2.c
+++ b/drivers/rtc/rtc-mxc_v2.c
@@ -296,9 +296,6 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
 	pdata->ioaddr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pdata->ioaddr))
 		return PTR_ERR(pdata->ioaddr);
-- 
2.14.1
