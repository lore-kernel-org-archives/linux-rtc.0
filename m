Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35FBC433E6
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Feb 2021 11:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69CF64EC1
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Feb 2021 11:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBBLc0 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:32:26 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:60633 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhBBLXH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Feb 2021 06:23:07 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0622BFF807;
        Tue,  2 Feb 2021 11:22:23 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/21] rtc: class: remove bogus documentation
Date:   Tue,  2 Feb 2021 12:21:58 +0100
Message-Id: <20210202112219.3610853-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202112219.3610853-1-alexandre.belloni@bootlin.com>
References: <20210202112219.3610853-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

rtc_device_unregister is gone since commit fdcfd854333b ("rtc: rework
rtc_register_device() resource management"). Remove its documentation.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 03abd0aa229a..f77bc089eb6b 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -324,11 +324,6 @@ static void rtc_device_get_offset(struct rtc_device *rtc)
 		rtc->offset_secs = 0;
 }
 
-/**
- * rtc_device_unregister - removes the previously registered RTC class device
- *
- * @rtc: the RTC class device to destroy
- */
 static void devm_rtc_unregister_device(void *data)
 {
 	struct rtc_device *rtc = data;
-- 
2.29.2

