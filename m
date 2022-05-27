Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4EDC433F5
	for <linux-rtc@archiver.kernel.org>; Fri, 27 May 2022 07:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbiE0HPu (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 27 May 2022 03:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346442AbiE0HPL (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 27 May 2022 03:15:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593C340A1D;
        Fri, 27 May 2022 00:15:10 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L8bcv2V0rzbbtL;
        Fri, 27 May 2022 15:13:35 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 15:15:08 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 15:15:08 +0800
From:   keliu <liuke94@huawei.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] rtc: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 07:36:36 +0000
Message-ID: <20220527073636.2474546-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/rtc/class.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 3c8eec2218df..e48223c00c67 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -36,7 +36,7 @@ static void rtc_device_release(struct device *dev)
 
 	cancel_work_sync(&rtc->irqwork);
 
-	ida_simple_remove(&rtc_ida, rtc->id);
+	ida_free(&rtc_ida, rtc->id);
 	mutex_destroy(&rtc->ops_lock);
 	kfree(rtc);
 }
@@ -262,7 +262,7 @@ static int rtc_device_get_id(struct device *dev)
 	}
 
 	if (id < 0)
-		id = ida_simple_get(&rtc_ida, 0, 0, GFP_KERNEL);
+		id = ida_alloc(&rtc_ida, GFP_KERNEL);
 
 	return id;
 }
@@ -368,7 +368,7 @@ struct rtc_device *devm_rtc_allocate_device(struct device *dev)
 
 	rtc = rtc_allocate_device();
 	if (!rtc) {
-		ida_simple_remove(&rtc_ida, id);
+		ida_free(&rtc_ida, id);
 		return ERR_PTR(-ENOMEM);
 	}
 
-- 
2.25.1

