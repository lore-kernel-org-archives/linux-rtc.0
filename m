Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8FFC433DB
	for <linux-rtc@archiver.kernel.org>; Sun, 10 Jan 2021 23:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4299D227C3
	for <linux-rtc@archiver.kernel.org>; Sun, 10 Jan 2021 23:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbhAJXS7 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 10 Jan 2021 18:18:59 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53969 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbhAJXS7 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 10 Jan 2021 18:18:59 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 91A7760005;
        Sun, 10 Jan 2021 23:18:15 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/17] rtc: mv: remove mv_rtc_alarm_ops
Date:   Mon, 11 Jan 2021 00:17:40 +0100
Message-Id: <20210110231752.1418816-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210110231752.1418816-1-alexandre.belloni@bootlin.com>
References: <20210110231752.1418816-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Move the alarm callbacks in mv_rtc_ops and clear RTC_FEATURE_ALARM to
signal that alarms are not available instead of having a supplementary
struct rtc_class_ops.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mv.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index f8e2ecea1d8d..6c526e2ec56d 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -200,11 +200,6 @@ static irqreturn_t mv_rtc_interrupt(int irq, void *data)
 static const struct rtc_class_ops mv_rtc_ops = {
 	.read_time	= mv_rtc_read_time,
 	.set_time	= mv_rtc_set_time,
-};
-
-static const struct rtc_class_ops mv_rtc_alarm_ops = {
-	.read_time	= mv_rtc_read_time,
-	.set_time	= mv_rtc_set_time,
 	.read_alarm	= mv_rtc_read_alarm,
 	.set_alarm	= mv_rtc_set_alarm,
 	.alarm_irq_enable = mv_rtc_alarm_irq_enable,
@@ -268,13 +263,12 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->irq >= 0) {
+	if (pdata->irq >= 0)
 		device_init_wakeup(&pdev->dev, 1);
-		pdata->rtc->ops = &mv_rtc_alarm_ops;
-	} else {
-		pdata->rtc->ops = &mv_rtc_ops;
-	}
+	else
+		clear_bit(RTC_FEATURE_ALARM, pdata->rtc->features);
 
+	pdata->rtc->ops = &mv_rtc_ops;
 	pdata->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pdata->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
-- 
2.29.2

