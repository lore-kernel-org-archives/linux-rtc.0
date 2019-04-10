Return-Path: <SRS0=qdFt=SM=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748DCC10F14
	for <linux-rtc@archiver.kernel.org>; Wed, 10 Apr 2019 13:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7A820850
	for <linux-rtc@archiver.kernel.org>; Wed, 10 Apr 2019 13:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfDJNoq (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:44:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52542 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731561AbfDJNop (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 10 Apr 2019 09:44:45 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7E5D26ECBA5B08FECE2F;
        Wed, 10 Apr 2019 21:44:41 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 10 Apr 2019
 21:44:32 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <baohua@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] rtc: sirfsoc: Make sysrtc_regmap_config static
Date:   Wed, 10 Apr 2019 21:43:36 +0800
Message-ID: <20190410134336.23556-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

drivers/rtc/rtc-sirfsoc.c:282:28: warning:
 symbol 'sysrtc_regmap_config' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-sirfsoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sirfsoc.c b/drivers/rtc/rtc-sirfsoc.c
index 2a9e151..9ba28d1 100644
--- a/drivers/rtc/rtc-sirfsoc.c
+++ b/drivers/rtc/rtc-sirfsoc.c
@@ -279,7 +279,7 @@ static const struct of_device_id sirfsoc_rtc_of_match[] = {
 	{},
 };
 
-const struct regmap_config sysrtc_regmap_config = {
+static const struct regmap_config sysrtc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.fast_io = true,
-- 
2.7.4


