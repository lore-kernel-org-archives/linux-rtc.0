Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:33560 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbeISGua (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 19 Sep 2018 02:50:30 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: tx4939: fixup nvmem name and register size
Date: Wed, 19 Sep 2018 03:14:58 +0200
Message-Id: <20180919011458.4231-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The default word_size and stride of 1 are correct for the tx4939. Also fix
the nvmem folder name.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tx4939.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 08dbefc79520..61c110b2045f 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -253,9 +253,7 @@ static int __init tx4939_rtc_probe(struct platform_device *pdev)
 	struct resource *res;
 	int irq, ret;
 	struct nvmem_config nvmem_cfg = {
-		.name = "rv8803_nvram",
-		.word_size = 4,
-		.stride = 4,
+		.name = "tx4939_nvram",
 		.size = TX4939_RTC_REG_RAMSIZE,
 		.reg_read = tx4939_nvram_read,
 		.reg_write = tx4939_nvram_write,
-- 
2.19.0
