Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD6C433E6
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Jan 2021 22:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DADE22E01
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Jan 2021 22:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbhASWWL (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:22:11 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:28901 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbhASWIH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 19 Jan 2021 17:08:07 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BF75D240009;
        Tue, 19 Jan 2021 22:06:59 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] rtc: ds1685: use rtc_lock/rtc_unlock
Date:   Tue, 19 Jan 2021 23:06:43 +0100
Message-Id: <20210119220653.677750-5-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ds1685.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index d69c807af29b..75db7ab654a5 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -658,7 +658,6 @@ ds1685_rtc_irq_handler(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
 	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
-	struct mutex *rtc_mutex;
 	u8 ctrlb, ctrlc;
 	unsigned long events = 0;
 	u8 num_irqs = 0;
@@ -667,8 +666,7 @@ ds1685_rtc_irq_handler(int irq, void *dev_id)
 	if (unlikely(!rtc))
 		return IRQ_HANDLED;
 
-	rtc_mutex = &rtc->dev->ops_lock;
-	mutex_lock(rtc_mutex);
+	rtc_lock(rtc->dev);
 
 	/* Ctrlb holds the interrupt-enable bits and ctrlc the flag bits. */
 	ctrlb = rtc->read(rtc, RTC_CTRL_B);
@@ -713,7 +711,7 @@ ds1685_rtc_irq_handler(int irq, void *dev_id)
 		}
 	}
 	rtc_update_irq(rtc->dev, num_irqs, events);
-	mutex_unlock(rtc_mutex);
+	rtc_unlock(rtc->dev);
 
 	return events ? IRQ_HANDLED : IRQ_NONE;
 }
-- 
2.29.2

