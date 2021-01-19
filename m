Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41DBC433E0
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Jan 2021 22:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C050230FE
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Jan 2021 22:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbhASWIL (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:08:11 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60909 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbhASWIH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 19 Jan 2021 17:08:07 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 26E811BF20A;
        Tue, 19 Jan 2021 22:06:57 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] rtc: asm9260: use rtc_lock/rtc_unlock
Date:   Tue, 19 Jan 2021 23:06:40 +0100
Message-Id: <20210119220653.677750-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119220653.677750-1-alexandre.belloni@bootlin.com>
References: <20210119220653.677750-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Avoid accessing directly rtc->ops_lock and use the RTC core helpers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-asm9260.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
index 3ab81cdec00b..de795e489f71 100644
--- a/drivers/rtc/rtc-asm9260.c
+++ b/drivers/rtc/rtc-asm9260.c
@@ -116,15 +116,15 @@ static irqreturn_t asm9260_rtc_irq(int irq, void *dev_id)
 	u32 isr;
 	unsigned long events = 0;
 
-	mutex_lock(&priv->rtc->ops_lock);
+	rtc_lock(priv->rtc);
 	isr = ioread32(priv->iobase + HW_CIIR);
 	if (!isr) {
-		mutex_unlock(&priv->rtc->ops_lock);
+		rtc_unlock(priv->rtc);
 		return IRQ_NONE;
 	}
 
 	iowrite32(0, priv->iobase + HW_CIIR);
-	mutex_unlock(&priv->rtc->ops_lock);
+	rtc_unlock(priv->rtc);
 
 	events |= RTC_AF | RTC_IRQF;
 
-- 
2.29.2

