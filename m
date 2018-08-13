Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:44475 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728661AbeHMOZN (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 13 Aug 2018 10:25:13 -0400
From: zhong jiang <zhongjiang@huawei.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <baruch@tkos.co.il>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] rtc:rtc-digicolor: Use PTR_ERR_OR_ZERO to replace the open code
Date: Mon, 13 Aug 2018 19:31:24 +0800
Message-ID: <1534159885-25364-2-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534159885-25364-1-git-send-email-zhongjiang@huawei.com>
References: <1534159885-25364-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
just replace them rather than duplicating its implement.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/rtc/rtc-digicolor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-digicolor.c b/drivers/rtc/rtc-digicolor.c
index b253bf1..fd6850c 100644
--- a/drivers/rtc/rtc-digicolor.c
+++ b/drivers/rtc/rtc-digicolor.c
@@ -202,10 +202,8 @@ static int __init dc_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtc);
 	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
 						&dc_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtc_dev))
-		return PTR_ERR(rtc->rtc_dev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
 }
 
 static const struct of_device_id dc_dt_ids[] = {
-- 
1.7.12.4
