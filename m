Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDC7C433DB
	for <linux-rtc@archiver.kernel.org>; Sat, 13 Mar 2021 06:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D272364F1A
	for <linux-rtc@archiver.kernel.org>; Sat, 13 Mar 2021 06:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhCMGgI (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 13 Mar 2021 01:36:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13917 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhCMGfw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 13 Mar 2021 01:35:52 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DyCZf716szjVp5;
        Sat, 13 Mar 2021 14:34:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Sat, 13 Mar 2021 14:35:42 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>
Subject: [PATCH] rtc: tps6586x: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Sat, 13 Mar 2021 14:36:25 +0800
Message-ID: <1615617385-3774-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

request_irq() with IRQF_NO_AUTOEN flag will disable IRQ auto-enable
because of requesting.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/rtc/rtc-tps6586x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-tps6586x.c b/drivers/rtc/rtc-tps6586x.c
index a980337..85203a7 100644
--- a/drivers/rtc/rtc-tps6586x.c
+++ b/drivers/rtc/rtc-tps6586x.c
@@ -268,11 +268,9 @@ static int tps6586x_rtc_probe(struct platform_device *pdev)
 	rtc->rtc->start_secs = mktime64(2009, 1, 1, 0, 0, 0);
 	rtc->rtc->set_start_time = true;
 
-	irq_set_status_flags(rtc->irq, IRQ_NOAUTOEN);
-
 	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
 				tps6586x_rtc_irq,
-				IRQF_ONESHOT,
+				IRQF_ONESHOT | IRQ_NOAUTOEN,
 				dev_name(&pdev->dev), rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "request IRQ(%d) failed with ret %d\n",
-- 
2.7.4

