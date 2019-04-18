Return-Path: <SRS0=cxb4=SU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EA7C10F14
	for <linux-rtc@archiver.kernel.org>; Thu, 18 Apr 2019 10:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5502321479
	for <linux-rtc@archiver.kernel.org>; Thu, 18 Apr 2019 10:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbfDRKBD (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:01:03 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:52783 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388577AbfDRKBC (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 18 Apr 2019 06:01:02 -0400
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 05B7C20001D;
        Thu, 18 Apr 2019 10:00:56 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/7] rtc: jz4740: remove useless check
Date:   Thu, 18 Apr 2019 12:00:41 +0200
Message-Id: <20190418100045.29288-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418100045.29288-1-alexandre.belloni@bootlin.com>
References: <20190418100045.29288-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

rtc_time64_to_tm always returns a valid tm, it is not necessary to validate
it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-jz4740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 15b6832f3931..a7e1a382cac5 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -198,7 +198,7 @@ static int jz4740_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	rtc_time64_to_tm(secs, &alrm->time);
 
-	return rtc_valid_tm(&alrm->time);
+	return 0;
 }
 
 static int jz4740_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
-- 
2.20.1

