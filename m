Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED87BC433E0
	for <linux-rtc@archiver.kernel.org>; Sun, 10 Jan 2021 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADACF229EF
	for <linux-rtc@archiver.kernel.org>; Sun, 10 Jan 2021 22:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbhAJWrC (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 10 Jan 2021 17:47:02 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52323 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbhAJWrB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 10 Jan 2021 17:47:01 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1D1D7C0003;
        Sun, 10 Jan 2021 22:46:18 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: opal: set range
Date:   Sun, 10 Jan 2021 23:46:06 +0100
Message-Id: <20210110224606.1414307-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

It is a BCD RTC with 4 digits for the year.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-opal.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 7b9f8bcf86fe..c586f695bdc9 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -233,6 +233,10 @@ static int opal_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
 	if (pdev->dev.of_node &&
 	    (of_property_read_bool(pdev->dev.of_node, "wakeup-source") ||
 	     of_property_read_bool(pdev->dev.of_node, "has-tpo")/* legacy */)) {
@@ -242,14 +246,12 @@ static int opal_rtc_probe(struct platform_device *pdev)
 		opal_rtc_ops.alarm_irq_enable = opal_tpo_alarm_irq_enable;
 	}
 
-	rtc = devm_rtc_device_register(&pdev->dev, DRVNAME, &opal_rtc_ops,
-				       THIS_MODULE);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
+	rtc->ops = &opal_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
+	rtc->range_max = RTC_TIMESTAMP_END_9999;
 	rtc->uie_unsupported = 1;
 
-	return 0;
+	return devm_rtc_register_device(rtc);
 }
 
 static const struct of_device_id opal_rtc_match[] = {
-- 
2.29.2

