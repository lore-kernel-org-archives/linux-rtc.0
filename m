Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38409 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbeETP0r (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 20 May 2018 11:26:47 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] rtc: nvmem: don't use IS_ERR_OR_NULL
Date: Sun, 20 May 2018 17:26:40 +0200
Message-Id: <20180520152640.21489-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

nvmem_register() never returns NULL, so IS_ERR is good enough here.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Some people don't like IS_ERR_OR_NULL because it is a hint that an API
is badly designed or it it used in a wrong way. In this case it's the
latter. :-)

Best regards
Uwe

 drivers/rtc/nvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index 17ec4c8d0fad..36ab183c42f1 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -94,7 +94,7 @@ int rtc_nvmem_register(struct rtc_device *rtc,
 	nvmem_config->dev = rtc->dev.parent;
 	nvmem_config->owner = rtc->owner;
 	rtc->nvmem = nvmem_register(nvmem_config);
-	if (IS_ERR_OR_NULL(rtc->nvmem))
+	if (IS_ERR(rtc->nvmem))
 		return PTR_ERR(rtc->nvmem);
 
 	/* Register the old ABI */
-- 
2.17.0
