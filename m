Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52725 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdJLWFe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 18:05:34 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/3] rtc: ds1511: switch to rtc_register_device
Date: Fri, 13 Oct 2017 00:05:27 +0200
Message-Id: <20171012220529.8142-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This allows for future improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1511.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 1b2dcb58c0ab..d44635178771 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -477,11 +477,16 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 	spin_lock_init(&pdata->lock);
 	platform_set_drvdata(pdev, pdata);
 
-	pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					      &ds1511_rtc_ops, THIS_MODULE);
+	pdata->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(pdata->rtc))
 		return PTR_ERR(pdata->rtc);
 
+	pdata->rtc->ops = &ds1511_rtc_ops;
+
+	ret = rtc_register_device(pdata->rtc);
+	if (ret)
+		return ret;
+
 	/*
 	 * if the platform has an interrupt in mind for this device,
 	 * then by all means, set it
-- 
2.14.2
