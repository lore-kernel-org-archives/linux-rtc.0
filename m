Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4E0C4361B
	for <linux-rtc@archiver.kernel.org>; Sat,  5 Dec 2020 23:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128992310B
	for <linux-rtc@archiver.kernel.org>; Sat,  5 Dec 2020 23:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgLEXPd (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 5 Dec 2020 18:15:33 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38935 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLEXPd (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 5 Dec 2020 18:15:33 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 3D7DCFF802;
        Sat,  5 Dec 2020 23:14:51 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: fix RTC removal
Date:   Sun,  6 Dec 2020 00:14:48 +0100
Message-Id: <20201205231449.610980-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Since the rtc_register_device, removing an RTC device will end with a
refcount_t: underflow; use-after-free warning since put_device is called
twice in the device tear down path.

Fixes: fdcfd854333b ("rtc: rework rtc_register_device() resource management")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index e6b44b7c4ad3..5c6748dfa55d 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -335,7 +335,6 @@ static void devm_rtc_unregister_device(void *data)
 	cdev_device_del(&rtc->char_dev, &rtc->dev);
 	rtc->ops = NULL;
 	mutex_unlock(&rtc->ops_lock);
-	put_device(&rtc->dev);
 }
 
 static void devm_rtc_release_device(void *res)
-- 
2.28.0

