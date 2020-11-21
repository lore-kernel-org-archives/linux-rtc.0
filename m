Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E62C388F9
	for <linux-rtc@archiver.kernel.org>; Sat, 21 Nov 2020 23:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D084206F1
	for <linux-rtc@archiver.kernel.org>; Sat, 21 Nov 2020 23:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgKUXGu (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 21 Nov 2020 18:06:50 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:42665 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgKUXGu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 21 Nov 2020 18:06:50 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0A881200005;
        Sat, 21 Nov 2020 23:06:48 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: test: remove debug message
Date:   Sun, 22 Nov 2020 00:06:44 +0100
Message-Id: <20201121230644.572419-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Remove leftover debug message

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index b092a1648513..7e0d8fb26465 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -50,7 +50,6 @@ static int test_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (expires > U32_MAX)
 		expires = U32_MAX;
 
-	pr_err("ABE: %s +%d %s\n", __FILE__, __LINE__, __func__);
 	rtd->alarm.expires = expires;
 
 	if (alrm->enabled)
-- 
2.28.0

