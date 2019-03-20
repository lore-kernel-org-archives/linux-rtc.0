Return-Path: <SRS0=1ScD=RX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CED1C4360F
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 12:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC25E213F2
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 12:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfCTMlA (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:41:00 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53889 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfCTMlA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Mar 2019 08:41:00 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 22B9EC0009;
        Wed, 20 Mar 2019 12:40:56 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/6] rtc: at91sam9: set range
Date:   Wed, 20 Mar 2019 13:40:39 +0100
Message-Id: <20190320124042.14141-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320124042.14141-1-alexandre.belloni@bootlin.com>
References: <20190320124042.14141-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The AT91 RTT is a 32bit second counter that is saved in a 32bit global
purpose register.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-at91sam9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index cbbf8121dca0..5ab13fe56164 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -425,6 +425,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
 	}
 
 	rtc->rtcdev->ops = &at91_rtc_ops;
+	rtc->rtcdev->range_max = U32_MAX;
 
 	/* register irq handler after we know what name we'll use */
 	ret = devm_request_irq(&pdev->dev, rtc->irq, at91_rtc_interrupt,
-- 
2.20.1

