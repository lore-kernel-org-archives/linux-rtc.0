Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E859C433ED
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Apr 2021 01:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5B46124B
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Apr 2021 01:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhDGBJy (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 6 Apr 2021 21:09:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15499 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhDGBJy (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 6 Apr 2021 21:09:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFR863gtGzyNMC;
        Wed,  7 Apr 2021 09:07:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 09:09:37 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] rtc: vr41xx: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Wed, 7 Apr 2021 09:10:03 +0800
Message-ID: <1617757803-38695-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable because of requesting.

this patch is made base on "add IRQF_NO_AUTOEN for request_irq" which
is being merged: https://lore.kernel.org/patchwork/patch/1388765/

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/rtc/rtc-vr41xx.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index 5a9f9ad..1a02b52 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -312,8 +312,8 @@ static int rtc_probe(struct platform_device *pdev)
 		goto err_iounmap_all;
 	}
 
-	retval = devm_request_irq(&pdev->dev, aie_irq, elapsedtime_interrupt, 0,
-				"elapsed_time", pdev);
+	retval = devm_request_irq(&pdev->dev, aie_irq, elapsedtime_interrupt,
+				  IRQF_NO_AUTOEN, "elapsed_time", pdev);
 	if (retval < 0)
 		goto err_iounmap_all;
 
@@ -323,16 +323,13 @@ static int rtc_probe(struct platform_device *pdev)
 		goto err_iounmap_all;
 	}
 
-	retval = devm_request_irq(&pdev->dev, pie_irq, rtclong1_interrupt, 0,
-				"rtclong1", pdev);
+	retval = devm_request_irq(&pdev->dev, pie_irq, rtclong1_interrupt,
+				  IRQF_NO_AUTOEN, "rtclong1", pdev);
 	if (retval < 0)
 		goto err_iounmap_all;
 
 	platform_set_drvdata(pdev, rtc);
 
-	disable_irq(aie_irq);
-	disable_irq(pie_irq);
-
 	dev_info(&pdev->dev, "Real Time Clock of NEC VR4100 series\n");
 
 	retval = devm_rtc_register_device(rtc);
-- 
2.7.4

