Return-Path: <SRS0=XIIG=RG=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7470C10F00
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 22:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A2C20835
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 22:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfCCWVe (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 3 Mar 2019 17:21:34 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:52305 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfCCWVe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 3 Mar 2019 17:21:34 -0500
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id BC022240003;
        Sun,  3 Mar 2019 22:21:31 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/4] rtc: tx4939: remove useless test
Date:   Sun,  3 Mar 2019 23:21:17 +0100
Message-Id: <20190303222120.22434-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The tested condition will never happen as the core always passes a fully
set struct tm (using rtc_ktime_to_tm) to the .set_alarm callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tx4939.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 61c110b2045f..8497fceea27f 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -123,13 +123,6 @@ static int tx4939_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	unsigned long sec;
 	unsigned char buf[6];
 
-	if (alrm->time.tm_sec < 0 ||
-	    alrm->time.tm_min < 0 ||
-	    alrm->time.tm_hour < 0 ||
-	    alrm->time.tm_mday < 0 ||
-	    alrm->time.tm_mon < 0 ||
-	    alrm->time.tm_year < 0)
-		return -EINVAL;
 	rtc_tm_to_time(&alrm->time, &sec);
 	buf[0] = 0;
 	buf[1] = 0;
-- 
2.20.1

