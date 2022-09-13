Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFB1C54EE9
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Sep 2022 17:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiIMRbZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 13 Sep 2022 13:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiIMRay (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 13 Sep 2022 13:30:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C495F625B
        for <linux-rtc@vger.kernel.org>; Tue, 13 Sep 2022 09:19:35 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MRmMX3lJlzHnkt;
        Tue, 13 Sep 2022 22:39:52 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 22:41:53 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 13 Sep
 2022 22:41:53 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-rtc@vger.kernel.org>
CC:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
Subject: [PATCH -next] rtc: ds1302: remove unnecessary spi_set_drvdata()
Date:   Tue, 13 Sep 2022 22:49:05 +0800
Message-ID: <20220913144905.2004924-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Remove unnecessary spi_set_drvdata() in ds1302_remove(), the driver_data
will be set to NULL in device_unbind_cleanup() after calling ->remove().
After this, ds1302_remove() is an empty function, so remove it too.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/rtc/rtc-ds1302.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index 6d66ab5a8b17..ecc7d0307932 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -185,11 +185,6 @@ static int ds1302_probe(struct spi_device *spi)
 	return 0;
 }
 
-static void ds1302_remove(struct spi_device *spi)
-{
-	spi_set_drvdata(spi, NULL);
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id ds1302_dt_ids[] = {
 	{ .compatible = "maxim,ds1302", },
@@ -208,7 +203,6 @@ static struct spi_driver ds1302_driver = {
 	.driver.name	= "rtc-ds1302",
 	.driver.of_match_table = of_match_ptr(ds1302_dt_ids),
 	.probe		= ds1302_probe,
-	.remove		= ds1302_remove,
 	.id_table	= ds1302_spi_ids,
 };
 
-- 
2.25.1

