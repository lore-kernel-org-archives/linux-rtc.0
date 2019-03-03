Return-Path: <SRS0=XIIG=RG=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD8BC43381
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 22:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278CD20815
	for <linux-rtc@archiver.kernel.org>; Sun,  3 Mar 2019 22:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfCCWVl (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 3 Mar 2019 17:21:41 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:37851 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfCCWVl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 3 Mar 2019 17:21:41 -0500
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C242E240003;
        Sun,  3 Mar 2019 22:21:39 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/4] rtc: tx4939: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Sun,  3 Mar 2019 23:21:19 +0100
Message-Id: <20190303222120.22434-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303222120.22434-1-alexandre.belloni@bootlin.com>
References: <20190303222120.22434-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Call the 64bit versions of rtc_time_to_tm now that the range is enforced by
the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tx4939.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index b405818933fb..8acb8adc11d7 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -111,7 +111,7 @@ static int tx4939_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	spin_unlock_irq(&pdata->lock);
 	sec = ((unsigned long)buf[5] << 24) | (buf[4] << 16) |
 		(buf[3] << 8) | buf[2];
-	rtc_time_to_tm(sec, tm);
+	rtc_time64_to_tm(sec, tm);
 	return 0;
 }
 
@@ -123,7 +123,7 @@ static int tx4939_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	unsigned long sec;
 	unsigned char buf[6];
 
-	rtc_tm_to_time(&alrm->time, &sec);
+	sec = rtc_tm_to_time64(&alrm->time);
 	buf[0] = 0;
 	buf[1] = 0;
 	buf[2] = sec;
@@ -166,7 +166,7 @@ static int tx4939_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	spin_unlock_irq(&pdata->lock);
 	sec = ((unsigned long)buf[5] << 24) | (buf[4] << 16) |
 		(buf[3] << 8) | buf[2];
-	rtc_time_to_tm(sec, &alrm->time);
+	rtc_time64_to_tm(sec, &alrm->time);
 	return rtc_valid_tm(&alrm->time);
 }
 
-- 
2.20.1

