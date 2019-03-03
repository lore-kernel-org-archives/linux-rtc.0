Return-Path: <SRS0=XIIG=RG=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A285FC43381
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 22:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4AF20815
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 22:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbfCCWVi (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 3 Mar 2019 17:21:38 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:33683 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfCCWVi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 3 Mar 2019 17:21:38 -0500
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B3389200003;
        Sun,  3 Mar 2019 22:21:35 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/4] rtc: tx4939: set range
Date:   Sun,  3 Mar 2019 23:21:18 +0100
Message-Id: <20190303222120.22434-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303222120.22434-1-alexandre.belloni@bootlin.com>
References: <20190303222120.22434-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The TX4939 RTC is a 48bit counter that counts two on every clock edge of
32.768 KHz oscillator clock so it counts 32bit seconds.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tx4939.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 8497fceea27f..b405818933fb 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -276,6 +276,7 @@ static int __init tx4939_rtc_probe(struct platform_device *pdev)
 
 	rtc->ops = &tx4939_rtc_ops;
 	rtc->nvram_old_abi = true;
+	rtc->range_max = U32_MAX;
 
 	pdata->rtc = rtc;
 
-- 
2.20.1

