Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99534C433B4
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Apr 2021 02:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C0F613B8
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Apr 2021 02:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343988AbhDGCSr (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 6 Apr 2021 22:18:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15936 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbhDGCSr (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 6 Apr 2021 22:18:47 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFSgZ6LG6zyNLy;
        Wed,  7 Apr 2021 10:16:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 10:18:30 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <patrice.chotard@foss.st.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>, "Tian Tao" <tiantao6@hisilicon.com>
Subject: [PATCH] rtc: st-lpc: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Wed, 7 Apr 2021 10:18:57 +0800
Message-ID: <1617761937-58318-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/rtc/rtc-st-lpc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index bdb20f6..2df2179 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -218,15 +218,14 @@ static int st_rtc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = devm_request_irq(&pdev->dev, rtc->irq, st_rtc_handler, 0,
-			       pdev->name, rtc);
+	ret = devm_request_irq(&pdev->dev, rtc->irq, st_rtc_handler,
+			       IRQF_NO_AUTOEN, pdev->name, rtc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq %i\n", rtc->irq);
 		return ret;
 	}
 
 	enable_irq_wake(rtc->irq);
-	disable_irq(rtc->irq);
 
 	rtc->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(rtc->clk)) {
-- 
2.7.4

