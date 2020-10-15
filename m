Return-Path: <SRS0=Mu8h=DW=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1CDC433E7
	for <linux-rtc@archiver.kernel.org>; Thu, 15 Oct 2020 19:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DD322203
	for <linux-rtc@archiver.kernel.org>; Thu, 15 Oct 2020 19:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgJOTLo (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:11:44 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37935 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbgJOTLo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 15 Oct 2020 15:11:44 -0400
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id EB7091BF203;
        Thu, 15 Oct 2020 19:11:41 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] rtc: r9701: stop setting a default time
Date:   Thu, 15 Oct 2020 21:11:31 +0200
Message-Id: <20201015191135.471249-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015191135.471249-1-alexandre.belloni@bootlin.com>
References: <20201015191135.471249-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

It doesn't make sense to set the RTC to a default value at probe time. Let
the core handle invalid date and time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-r9701.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/rtc/rtc-r9701.c b/drivers/rtc/rtc-r9701.c
index eb00879f7c9a..f8f7044ff808 100644
--- a/drivers/rtc/rtc-r9701.c
+++ b/drivers/rtc/rtc-r9701.c
@@ -115,7 +115,6 @@ static const struct rtc_class_ops r9701_rtc_ops = {
 static int r9701_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
-	struct rtc_time dt;
 	unsigned char tmp;
 	int res;
 
@@ -126,27 +125,6 @@ static int r9701_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	/*
-	 * The device seems to be present. Now check if the registers
-	 * contain invalid values. If so, try to write a default date:
-	 * 2000/1/1 00:00:00
-	 */
-	if (r9701_get_datetime(&spi->dev, &dt)) {
-		dev_info(&spi->dev, "trying to repair invalid date/time\n");
-		dt.tm_sec  = 0;
-		dt.tm_min  = 0;
-		dt.tm_hour = 0;
-		dt.tm_mday = 1;
-		dt.tm_mon  = 0;
-		dt.tm_year = 100;
-
-		if (r9701_set_datetime(&spi->dev, &dt) ||
-				r9701_get_datetime(&spi->dev, &dt)) {
-			dev_err(&spi->dev, "cannot repair RTC register\n");
-			return -ENODEV;
-		}
-	}
-
 	rtc = devm_rtc_device_register(&spi->dev, "r9701",
 				&r9701_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc))
-- 
2.26.2

