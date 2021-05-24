Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89023C04FF3
	for <linux-rtc@archiver.kernel.org>; Mon, 24 May 2021 09:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A859611EE
	for <linux-rtc@archiver.kernel.org>; Mon, 24 May 2021 09:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhEXJfe (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 24 May 2021 05:35:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5748 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbhEXJfd (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 24 May 2021 05:35:33 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpX4g290GzmkWg;
        Mon, 24 May 2021 17:30:27 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 17:34:02 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 17:34:01 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-rtc@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: efi: Remove the repeated module alias
Date:   Mon, 24 May 2021 17:33:54 +0800
Message-ID: <1621848834-20857-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

'MODULE_ALIAS' is declared twice, cleanup one.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com> 
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/rtc/rtc-efi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index edb64debd173..138c5e0046c8 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -280,7 +280,6 @@ static struct platform_driver efi_rtc_driver = {
 
 module_platform_driver_probe(efi_rtc_driver, efi_rtc_probe);
 
-MODULE_ALIAS("platform:rtc-efi");
 MODULE_AUTHOR("dann frazier <dannf@dannf.org>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("EFI RTC driver");
-- 
2.7.4

