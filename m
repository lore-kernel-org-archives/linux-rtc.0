Return-Path: <SRS0=1ScD=RX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1084BC43381
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 11:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D395B2175B
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 11:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfCTLaY (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:30:24 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:46243 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTLaY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Mar 2019 07:30:24 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 76946C0010;
        Wed, 20 Mar 2019 11:30:21 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: sh: fix possible race condition
Date:   Wed, 20 Mar 2019 12:30:09 +0100
Message-Id: <20190320113010.8955-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320113010.8955-1-alexandre.belloni@bootlin.com>
References: <20190320113010.8955-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
struct before requesting the IRQ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sh.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index f4ac9ec8fbb6..b582af10ddb5 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -531,6 +531,10 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 		rtc->clk = NULL;
 	}
 
+	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
 	clk_enable(rtc->clk);
 
 	rtc->capabilities = RTC_DEF_CAPABILITIES;
@@ -594,15 +598,13 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 	sh_rtc_setaie(&pdev->dev, 0);
 	sh_rtc_setcie(&pdev->dev, 0);
 
-	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, "sh",
-					   &sh_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtc_dev)) {
-		ret = PTR_ERR(rtc->rtc_dev);
-		goto err_unmap;
-	}
-
+	rtc->rtc_dev->ops = &sh_rtc_ops;
 	rtc->rtc_dev->max_user_freq = 256;
 
+	ret = rtc_register_device(rtc->rtc_dev);
+	if (ret)
+		goto err_unmap;
+
 	device_init_wakeup(&pdev->dev, 1);
 	return 0;
 
-- 
2.20.1

