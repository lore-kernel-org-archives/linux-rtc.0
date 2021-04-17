Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C934C433B4
	for <linux-rtc@archiver.kernel.org>; Sat, 17 Apr 2021 23:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E10610CE
	for <linux-rtc@archiver.kernel.org>; Sat, 17 Apr 2021 23:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhDQXwl (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 17 Apr 2021 19:52:41 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:60585 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhDQXwl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 17 Apr 2021 19:52:41 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 61FAB240002;
        Sat, 17 Apr 2021 23:52:12 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] imx-sc: remove .read_alarm
Date:   Sun, 18 Apr 2021 01:52:05 +0200
Message-Id: <20210417235205.994119-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The RTC core properly handles RTC without .read_alarm and doesn't use it to
set alarms. .read_alarm can be safely dropped.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-imx-sc.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
index cc9fbab49999..814d516645e2 100644
--- a/drivers/rtc/rtc-imx-sc.c
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -80,16 +80,6 @@ static int imx_sc_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 	return imx_scu_irq_group_enable(SC_IRQ_GROUP_RTC, SC_IRQ_RTC, enable);
 }
 
-static int imx_sc_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
-{
-	/*
-	 * SCU firmware does NOT provide read alarm API, but .read_alarm
-	 * callback is required by RTC framework to support alarm function,
-	 * so just return here.
-	 */
-	return 0;
-}
-
 static int imx_sc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct imx_sc_msg_timer_rtc_set_alarm msg;
@@ -127,7 +117,6 @@ static int imx_sc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static const struct rtc_class_ops imx_sc_rtc_ops = {
 	.read_time = imx_sc_rtc_read_time,
 	.set_time = imx_sc_rtc_set_time,
-	.read_alarm = imx_sc_rtc_read_alarm,
 	.set_alarm = imx_sc_rtc_set_alarm,
 	.alarm_irq_enable = imx_sc_rtc_alarm_irq_enable,
 };
-- 
2.30.2

