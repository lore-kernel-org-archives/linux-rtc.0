Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3453C433DB
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Jan 2021 22:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D10B230FE
	for <linux-rtc@archiver.kernel.org>; Tue, 19 Jan 2021 22:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbhASWIQ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:08:16 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48513 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbhASWIL (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 19 Jan 2021 17:08:11 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E6BCB40006;
        Tue, 19 Jan 2021 22:07:03 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] rtc: pcf2123: use rtc_lock/rtc_unlock
Date:   Tue, 19 Jan 2021 23:06:48 +0100
Message-Id: <20210119220653.677750-10-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-pcf2123.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 534ffc91eec1..0f58cac81d8c 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -307,11 +307,10 @@ static int pcf2123_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 static irqreturn_t pcf2123_rtc_irq(int irq, void *dev)
 {
 	struct pcf2123_data *pcf2123 = dev_get_drvdata(dev);
-	struct mutex *lock = &pcf2123->rtc->ops_lock;
 	unsigned int val = 0;
 	int ret = IRQ_NONE;
 
-	mutex_lock(lock);
+	rtc_lock(pcf2123->rtc);
 	regmap_read(pcf2123->map, PCF2123_REG_CTRL2, &val);
 
 	/* Alarm? */
@@ -324,7 +323,7 @@ static irqreturn_t pcf2123_rtc_irq(int irq, void *dev)
 		rtc_update_irq(pcf2123->rtc, 1, RTC_IRQF | RTC_AF);
 	}
 
-	mutex_unlock(lock);
+	rtc_unlock(pcf2123->rtc);
 
 	return ret;
 }
-- 
2.29.2

