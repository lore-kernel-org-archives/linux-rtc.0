Return-Path: <SRS0=yQZy=PY=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0752C43387
	for <linux-rtc@archiver.kernel.org>; Wed, 16 Jan 2019 02:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C163B20859
	for <linux-rtc@archiver.kernel.org>; Wed, 16 Jan 2019 02:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfAPCze (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:55:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17554 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727883AbfAPCze (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 15 Jan 2019 21:55:34 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B8C05D94F53618E396D3;
        Wed, 16 Jan 2019 10:55:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Wed, 16 Jan 2019 10:55:14 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Dianlong Li <long17.cool@163.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-rtc@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] rtc: sd3078: make symbol 'sd3078_driver' static
Date:   Wed, 16 Jan 2019 03:01:21 +0000
Message-ID: <1547607681-5873-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Fixes the following sparse warning:

drivers/rtc/rtc-sd3078.c:218:19: warning:
 symbol 'sd3078_driver' was not declared. Should it be static?

Fixes: 1d67a232105b ("rtc: sd3078: new driver.")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/rtc/rtc-sd3078.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sd3078.c b/drivers/rtc/rtc-sd3078.c
index a70d7311..704844f 100644
--- a/drivers/rtc/rtc-sd3078.c
+++ b/drivers/rtc/rtc-sd3078.c
@@ -215,7 +215,7 @@ static int sd3078_probe(struct i2c_client *client,
 };
 MODULE_DEVICE_TABLE(of, rtc_dt_match);
 
-struct i2c_driver sd3078_driver = {
+static struct i2c_driver sd3078_driver = {
 	.driver     = {
 		.name   = "sd3078",
 		.owner  = THIS_MODULE,



