Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D3C4320E
	for <linux-rtc@archiver.kernel.org>; Wed,  4 Aug 2021 10:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD86E60FC3
	for <linux-rtc@archiver.kernel.org>; Wed,  4 Aug 2021 10:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbhHDKmx (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:42:53 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:46251 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbhHDKme (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 4 Aug 2021 06:42:34 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B5522200004;
        Wed,  4 Aug 2021 10:41:50 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/4] rtc: s5m: switch to devm_rtc_allocate_device
Date:   Wed,  4 Aug 2021 12:41:29 +0200
Message-Id: <20210804104133.5158-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Switch to devm_rtc_allocate_device/devm_rtc_register_device, this allows
for further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-s5m.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 6b56f8eacba6..4c1596c55de8 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -788,12 +788,16 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	info->rtc_dev = devm_rtc_device_register(&pdev->dev, "s5m-rtc",
-						 &s5m_rtc_ops, THIS_MODULE);
-
+	info->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(info->rtc_dev))
 		return PTR_ERR(info->rtc_dev);
 
+	info->rtc_dev->ops = &s5m_rtc_ops;
+
+	err = devm_rtc_register_device(info->rtc_dev);
+	if (err)
+		return err;
+
 	if (!info->irq) {
 		dev_info(&pdev->dev, "Alarm IRQ not available\n");
 		return 0;
-- 
2.31.1

