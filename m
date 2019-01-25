Return-Path: <SRS0=r6Xw=QB=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96583C282C6
	for <linux-rtc@archiver.kernel.org>; Fri, 25 Jan 2019 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62619218DE
	for <linux-rtc@archiver.kernel.org>; Fri, 25 Jan 2019 14:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfAYOgG (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:36:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34613 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfAYOgF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Jan 2019 09:36:05 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gn2aR-0001kf-IH; Fri, 25 Jan 2019 15:36:03 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ukl@pengutronix.de>)
        id 1gn2aQ-0007BH-4p; Fri, 25 Jan 2019 15:36:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Marek Vasut <marex@denx.de>, kernel@pengutronix.de,
        linux-rtc@vger.kernel.org
Subject: [PATCH 5/5] rtc: ds1307: rx8130: Fix alarm handling
Date:   Fri, 25 Jan 2019 15:35:58 +0100
Message-Id: <20190125143558.27450-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125143558.27450-1-u.kleine-koenig@pengutronix.de>
References: <20190125143558.27450-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rtc@vger.kernel.org
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

When the EXTENSION.WADA bit is set, register 0x19 contains a bitmap of
week days, not a day of month. As Linux only handles a single alarm
without repetition using day of month is more flexible, so clear this
bit. (Otherwise a value depending on time.tm_wday would have to be
written to register 0x19.)

Also optimize setting the AIE bit to use a single register write instead
of a bulk write of three registers.

Fixes: ee0981be7704 ("rtc: ds1307: Add support for Epson RX8130CE")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/rtc/rtc-ds1307.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 974eafda9de4..07530fe1da2a 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -554,8 +554,8 @@ static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	if (ret < 0)
 		return ret;
 
-	ctl[0] &= ~RX8130_REG_EXTENSION_WADA;
-	ctl[1] |= RX8130_REG_FLAG_AF;
+	ctl[0] &= RX8130_REG_EXTENSION_WADA;
+	ctl[1] &= ~RX8130_REG_FLAG_AF;
 	ctl[2] &= ~RX8130_REG_CONTROL0_AIE;
 
 	ret = regmap_bulk_write(ds1307->regmap, RX8130_REG_EXTENSION, ctl,
@@ -578,8 +578,7 @@ static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	ctl[2] |= RX8130_REG_CONTROL0_AIE;
 
-	return regmap_bulk_write(ds1307->regmap, RX8130_REG_EXTENSION, ctl,
-				 sizeof(ctl));
+	return regmap_write(ds1307->regmap, RX8130_REG_CONTROL0, ctl[2]);
 }
 
 static int rx8130_alarm_irq_enable(struct device *dev, unsigned int enabled)
-- 
2.20.1

