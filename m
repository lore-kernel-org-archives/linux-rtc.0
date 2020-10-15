Return-Path: <SRS0=Mu8h=DW=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BCEC4363A
	for <linux-rtc@archiver.kernel.org>; Thu, 15 Oct 2020 19:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81CC21D81
	for <linux-rtc@archiver.kernel.org>; Thu, 15 Oct 2020 19:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388714AbgJOTLu (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:11:50 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:42785 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388553AbgJOTLr (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 15 Oct 2020 15:11:47 -0400
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7C786200005;
        Thu, 15 Oct 2020 19:11:44 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] rtc: r9701: convert to devm_rtc_allocate_device
Date:   Thu, 15 Oct 2020 21:11:34 +0200
Message-Id: <20201015191135.471249-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015191135.471249-1-alexandre.belloni@bootlin.com>
References: <20201015191135.471249-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This allows further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-r9701.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-r9701.c b/drivers/rtc/rtc-r9701.c
index 183c5a0fe78c..9165c180b0e6 100644
--- a/drivers/rtc/rtc-r9701.c
+++ b/drivers/rtc/rtc-r9701.c
@@ -122,14 +122,14 @@ static int r9701_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	rtc = devm_rtc_device_register(&spi->dev, "r9701",
-				&r9701_rtc_ops, THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&spi->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
 	spi_set_drvdata(spi, rtc);
+	rtc->ops = &r9701_rtc_ops;
 
-	return 0;
+	return rtc_register_device(rtc);
 }
 
 static struct spi_driver r9701_driver = {
-- 
2.26.2

