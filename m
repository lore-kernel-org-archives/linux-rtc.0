Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C3CC433ED
	for <linux-rtc@archiver.kernel.org>; Tue,  6 Apr 2021 12:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329A3613C4
	for <linux-rtc@archiver.kernel.org>; Tue,  6 Apr 2021 12:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbhDFMe1 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 6 Apr 2021 08:34:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15498 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbhDFMe0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 6 Apr 2021 08:34:26 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF6NQ2qgczwR1S;
        Tue,  6 Apr 2021 20:32:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 20:34:09 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] rtc: as3722: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Tue, 6 Apr 2021 20:34:35 +0800
Message-ID: <1617712475-32543-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/rtc/rtc-as3722.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-as3722.c b/drivers/rtc/rtc-as3722.c
index 0f21af2..3a0db97 100644
--- a/drivers/rtc/rtc-as3722.c
+++ b/drivers/rtc/rtc-as3722.c
@@ -201,14 +201,13 @@ static int as3722_rtc_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "RTC interrupt %d\n", as3722_rtc->alarm_irq);
 
 	ret = devm_request_threaded_irq(&pdev->dev, as3722_rtc->alarm_irq, NULL,
-			as3722_alarm_irq, IRQF_ONESHOT,
+			as3722_alarm_irq, IRQF_ONESHOT | IRQF_NO_AUTOEN,
 			"rtc-alarm", as3722_rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ %d: %d\n",
 				as3722_rtc->alarm_irq, ret);
 		return ret;
 	}
-	disable_irq(as3722_rtc->alarm_irq);
 	return 0;
 }
 
-- 
2.7.4

