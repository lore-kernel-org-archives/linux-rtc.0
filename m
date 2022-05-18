Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D89C433EF
	for <linux-rtc@archiver.kernel.org>; Wed, 18 May 2022 23:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiERXYw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 18 May 2022 19:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiERXYw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 May 2022 19:24:52 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B68F583;
        Wed, 18 May 2022 16:24:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VDhNW0k_1652916287;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VDhNW0k_1652916287)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 May 2022 07:24:47 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     miquel.raynal@bootlin.com
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] rtc: rzn1: fix platform_no_drv_owner.cocci warning
Date:   Thu, 19 May 2022 07:24:45 +0800
Message-Id: <20220518232445.79156-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Remove .owner field if calls are used which set it automatically.
./drivers/rtc/rtc-rzn1.c:411:3-8: No need to set .owner here. The core
will do it.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/rtc/rtc-rzn1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 980ade8c9601..f92d1398b0f1 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -408,7 +408,6 @@ static struct platform_driver rzn1_rtc_driver = {
 	.remove = rzn1_rtc_remove,
 	.driver = {
 		.name	= "rzn1-rtc",
-		.owner	= THIS_MODULE,
 		.of_match_table = rzn1_rtc_of_match,
 	},
 };
-- 
2.20.1.7.g153144c

