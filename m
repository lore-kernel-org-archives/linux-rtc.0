Return-Path: <SRS0=54M4=RH=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B3CC43381
	for <linux-rtc@archiver.kernel.org>; Mon,  4 Mar 2019 10:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D023820823
	for <linux-rtc@archiver.kernel.org>; Mon,  4 Mar 2019 10:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfCDKUV (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:20:21 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37699 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfCDKUV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 4 Mar 2019 05:20:21 -0500
X-Originating-IP: 82.246.155.60
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 499FFC0008;
        Mon,  4 Mar 2019 10:20:18 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: pic32: convert to devm_rtc_allocate_device
Date:   Mon,  4 Mar 2019 11:20:13 +0100
Message-Id: <20190304102014.529-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This allows further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pic32.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pic32.c b/drivers/rtc/rtc-pic32.c
index d7ef0a6f8931..43bd701daef2 100644
--- a/drivers/rtc/rtc-pic32.c
+++ b/drivers/rtc/rtc-pic32.c
@@ -348,13 +348,15 @@ static int pic32_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-						 &pic32_rtcops,
-						 THIS_MODULE);
-	if (IS_ERR(pdata->rtc)) {
-		ret = PTR_ERR(pdata->rtc);
+	pdata->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(pdata->rtc))
+		return PTR_ERR(pdata->rtc);
+
+	pdata->rtc->ops = &pic32_rtcops;
+
+	ret = rtc_register_device(pdata->rtc);
+	if (ret)
 		goto err_nortc;
-	}
 
 	pdata->rtc->max_user_freq = 128;
 
-- 
2.20.1

