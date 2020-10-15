Return-Path: <SRS0=Mu8h=DW=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC949C43457
	for <linux-rtc@archiver.kernel.org>; Thu, 15 Oct 2020 19:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6196121D81
	for <linux-rtc@archiver.kernel.org>; Thu, 15 Oct 2020 19:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbgJOTLv (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:11:51 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:11449 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388294AbgJOTLp (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 15 Oct 2020 15:11:45 -0400
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id CE571240004;
        Thu, 15 Oct 2020 19:11:42 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] rtc: r9701: remove useless memset
Date:   Thu, 15 Oct 2020 21:11:32 +0200
Message-Id: <20201015191135.471249-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015191135.471249-1-alexandre.belloni@bootlin.com>
References: <20201015191135.471249-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The RTC core already sets to zero the struct rtc_tie it passes to the
driver, avoid doing it a second time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-r9701.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-r9701.c b/drivers/rtc/rtc-r9701.c
index f8f7044ff808..4b688e9c4192 100644
--- a/drivers/rtc/rtc-r9701.c
+++ b/drivers/rtc/rtc-r9701.c
@@ -75,8 +75,6 @@ static int r9701_get_datetime(struct device *dev, struct rtc_time *dt)
 	if (ret)
 		return ret;
 
-	memset(dt, 0, sizeof(*dt));
-
 	dt->tm_sec = bcd2bin(buf[0]); /* RSECCNT */
 	dt->tm_min = bcd2bin(buf[1]); /* RMINCNT */
 	dt->tm_hour = bcd2bin(buf[2]); /* RHRCNT */
-- 
2.26.2

