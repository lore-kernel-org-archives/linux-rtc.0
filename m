Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:44477 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728695AbeHMOZN (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 13 Aug 2018 10:25:13 -0400
From: zhong jiang <zhongjiang@huawei.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <baruch@tkos.co.il>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] rtc:rtc-ds1347: Use PTR_ERR_OR_ZERO to replace the open code
Date: Mon, 13 Aug 2018 19:31:25 +0800
Message-ID: <1534159885-25364-3-git-send-email-zhongjiang@huawei.com>
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
 drivers/rtc/rtc-ds1347.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1347.c b/drivers/rtc/rtc-ds1347.c
index 938512c..b97b67f 100644
--- a/drivers/rtc/rtc-ds1347.c
+++ b/drivers/rtc/rtc-ds1347.c
@@ -155,10 +155,7 @@ static int ds1347_probe(struct spi_device *spi)
 	rtc = devm_rtc_device_register(&spi->dev, "ds1347",
 				&ds1347_rtc_ops, THIS_MODULE);
 
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(rtc);
 }
 
 static struct spi_driver ds1347_driver = {
-- 
1.7.12.4
