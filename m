Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABBBC433E6
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Jan 2021 22:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4644C22E01
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Jan 2021 22:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbhASWQp (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:16:45 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34323 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbhASWIL (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 19 Jan 2021 17:08:11 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 09F12C0005;
        Tue, 19 Jan 2021 22:07:02 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] rtc: mcp795: use rtc_lock/rtc_unlock
Date:   Tue, 19 Jan 2021 23:06:47 +0100
Message-Id: <20210119220653.677750-9-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-mcp795.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 21cbf7f892e8..bad7792b6ca5 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -350,10 +350,9 @@ static irqreturn_t mcp795_irq(int irq, void *data)
 {
 	struct spi_device *spi = data;
 	struct rtc_device *rtc = spi_get_drvdata(spi);
-	struct mutex *lock = &rtc->ops_lock;
 	int ret;
 
-	mutex_lock(lock);
+	rtc_lock(rtc);
 
 	/* Disable alarm.
 	 * There is no need to clear ALM0IF (Alarm 0 Interrupt Flag) bit,
@@ -365,7 +364,7 @@ static irqreturn_t mcp795_irq(int irq, void *data)
 			"Failed to disable alarm in IRQ (ret=%d)\n", ret);
 	rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
 
-	mutex_unlock(lock);
+	rtc_unlock(rtc);
 
 	return IRQ_HANDLED;
 }
-- 
2.29.2

