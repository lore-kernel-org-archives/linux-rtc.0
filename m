Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81FBC433E0
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Feb 2021 11:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924A864EEB
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Feb 2021 11:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBBLcT (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:32:19 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39329 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhBBLXH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Feb 2021 06:23:07 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 89638C000C;
        Tue,  2 Feb 2021 11:22:25 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 03/21] rtc: bq32k: quiet maybe-unused variable warning
Date:   Tue,  2 Feb 2021 12:22:00 +0100
Message-Id: <20210202112219.3610853-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202112219.3610853-1-alexandre.belloni@bootlin.com>
References: <20210202112219.3610853-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

When CONFIG_OF is disabled then the matching table is not referenced.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-bq32k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 933e4237237d..2235c968842d 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -311,7 +311,7 @@ static const struct i2c_device_id bq32k_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bq32k_id);
 
-static const struct of_device_id bq32k_of_match[] = {
+static const __maybe_unused struct of_device_id bq32k_of_match[] = {
 	{ .compatible = "ti,bq32000" },
 	{ }
 };
-- 
2.29.2

