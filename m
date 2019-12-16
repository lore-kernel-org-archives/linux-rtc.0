Return-Path: <SRS0=jUkR=2G=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD4C43603
	for <linux-rtc@archiver.kernel.org>; Mon, 16 Dec 2019 03:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38132072A
	for <linux-rtc@archiver.kernel.org>; Mon, 16 Dec 2019 03:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLPDMA (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 15 Dec 2019 22:12:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbfLPDMA (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 15 Dec 2019 22:12:00 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5231D39241CDBF70FE50;
        Mon, 16 Dec 2019 11:11:58 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Dec 2019
 11:11:51 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <linux-rtc@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] rtc: omap: Remove unneeded semicolon
Date:   Mon, 16 Dec 2019 11:19:13 +0800
Message-ID: <1576466353-45384-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Fixes coccicheck warning:

drivers/rtc/rtc-omap.c:619:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/rtc/rtc-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 988a4df..d4ed20f 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -616,7 +616,7 @@ static int rtc_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 	default:
 		return -ENOTSUPP;
-	};
+	}

 	*config = pinconf_to_config_packed(param, arg);

--
2.7.4

