Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45553 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbeETPVv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 20 May 2018 11:21:51 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] rtc: ds1742: don't explicitly specify word_size and stride of nvmem
Date: Sun, 20 May 2018 17:21:45 +0200
Message-Id: <20180520152145.21177-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

nvmem_register() assumes these values to be 1 if unset, so they don't
need to be set explicitly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/rtc/rtc-ds1742.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index 2d781180e968..939c2506bcd5 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -154,8 +154,6 @@ static int ds1742_rtc_probe(struct platform_device *pdev)
 	int ret = 0;
 	struct nvmem_config nvmem_cfg = {
 		.name = "ds1742_nvram",
-		.word_size = 1,
-		.stride = 1,
 		.reg_read = ds1742_nvram_read,
 		.reg_write = ds1742_nvram_write,
 	};
-- 
2.17.0
