Return-Path: <SRS0=1ScD=RX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADA4C43381
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 11:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C302175B
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 11:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfCTLaU (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:30:20 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:49521 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTLaU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Mar 2019 07:30:20 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 33476240011;
        Wed, 20 Mar 2019 11:30:16 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: sh: stop resetting time to epoch
Date:   Wed, 20 Mar 2019 12:30:08 +0100
Message-Id: <20190320113010.8955-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

There is no point in resetting the time to epoch as this means that
userspace will never get the valuable information that time is actually
invalid.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sh.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index d417b203cbc5..f4ac9ec8fbb6 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -276,6 +276,9 @@ static int sh_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct sh_rtc *rtc = dev_get_drvdata(dev);
 	unsigned int sec128, sec2, yr, yr100, cf_bit;
 
+	if (!(readb(rtc->regbase + RCR2) & RCR2_RTCEN))
+		return -EINVAL;
+
 	do {
 		unsigned int tmp;
 
@@ -600,12 +603,6 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtc_dev->max_user_freq = 256;
 
-	/* reset rtc to epoch 0 if time is invalid */
-	if (rtc_read_time(rtc->rtc_dev, &r) < 0) {
-		rtc_time_to_tm(0, &r);
-		rtc_set_time(rtc->rtc_dev, &r);
-	}
-
 	device_init_wakeup(&pdev->dev, 1);
 	return 0;
 
-- 
2.20.1

