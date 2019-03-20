Return-Path: <SRS0=1ScD=RX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D060C43381
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 12:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57436213F2
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 12:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCTMnp (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:43:45 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46467 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTMno (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Mar 2019 08:43:44 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 61C3CE000A;
        Wed, 20 Mar 2019 12:43:42 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/4] rtc: dm355evm: set range
Date:   Wed, 20 Mar 2019 13:43:33 +0100
Message-Id: <20190320124335.14330-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320124335.14330-1-alexandre.belloni@bootlin.com>
References: <20190320124335.14330-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The MSP430 has a 32bit second counter.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-dm355evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-dm355evm.c b/drivers/rtc/rtc-dm355evm.c
index d44bf3929898..cd80c89d9002 100644
--- a/drivers/rtc/rtc-dm355evm.c
+++ b/drivers/rtc/rtc-dm355evm.c
@@ -134,6 +134,7 @@ static int dm355evm_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtc);
 
 	rtc->ops = &dm355evm_rtc_ops;
+	rtc->range_max = U32_MAX;
 
 	return rtc_register_device(rtc);
 }
-- 
2.20.1

