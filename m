Return-Path: <SRS0=XIIG=RG=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36302C43381
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 21:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0484B2070B
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 21:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCCVOv (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 3 Mar 2019 16:14:51 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:60339 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfCCVOv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 3 Mar 2019 16:14:51 -0500
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 31834200003;
        Sun,  3 Mar 2019 21:14:48 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: imx-sc: use rtc_time64_to_tm
Date:   Sun,  3 Mar 2019 22:14:45 +0100
Message-Id: <20190303211445.12712-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The imx-sc driver properly sets range_max, use rtc_time64_to_tm() instead
of the deprecated rtc_time_to_tm()

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-imx-sc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
index 60570a278bb0..19642bfd913a 100644
--- a/drivers/rtc/rtc-imx-sc.c
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -41,7 +41,7 @@ static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return ret;
 	}
 
-	rtc_time_to_tm(msg.time, tm);
+	rtc_time64_to_tm(msg.time, tm);
 
 	return 0;
 }
-- 
2.20.1

