Return-Path: <SRS0=SXQY=SF=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEEBC4360F
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Apr 2019 04:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484CC21473
	for <linux-rtc@archiver.kernel.org>; Wed,  3 Apr 2019 04:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jNrZv3Qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfDCE6a (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:58:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52996 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfDCE63 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 3 Apr 2019 00:58:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x334vlbf114997;
        Tue, 2 Apr 2019 23:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554267467;
        bh=+7gFrQlDg9tX8OEjYzEMoJd58KMEWzyuO7vAbYecHcU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jNrZv3Qha8uK0SHWy+HOrEt6Qv6Gy5KHaj423G7Ubo9SeN+dHbPnYAiAT73W47THS
         GS5ErWkKJ0EIrgfusGqkTf3ephrIvZQNeb+fEG1u2PW9mXmC8ctQiSUbCbJ1VhP0mP
         K3VaQ7rGk40QnlDeQX5eNt+hOi95MB1r67xE5Wzk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x334vl02048000
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 23:57:47 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 23:57:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 23:57:47 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x334vXUK105381;
        Tue, 2 Apr 2019 23:57:44 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <tony@atomide.com>, <alexandre.belloni@bootlin.com>,
        <a.zummo@towertech.it>, <t-kristo@ti.com>
CC:     <ssantosh@kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>, <j-keerthy@ti.com>
Subject: [PATCH v3 3/4] soc: ti: pm33xx: Move the am33xx_push_sram_idle to the top
Date:   Wed, 3 Apr 2019 10:27:41 +0530
Message-ID: <20190403045742.2243-4-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403045742.2243-1-j-keerthy@ti.com>
References: <20190403045742.2243-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Move the am33xx_push_sram_idle function to the top as a preparation
for rtc+ddr mode as the function will be called by multiple functions
currently present before it.

No functional changes.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v3:

  * Enhanced commit description

 drivers/soc/ti/pm33xx.c | 100 ++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index d0dab323651f..69128993776d 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -49,6 +49,56 @@ static u32 sram_suspend_address(unsigned long addr)
 		AMX3_PM_SRAM_SYMBOL_OFFSET(addr));
 }
 
+static int am33xx_push_sram_idle(void)
+{
+	struct am33xx_pm_ro_sram_data ro_sram_data;
+	int ret;
+	u32 table_addr, ro_data_addr;
+	void *copy_addr;
+
+	ro_sram_data.amx3_pm_sram_data_virt = ocmcram_location_data;
+	ro_sram_data.amx3_pm_sram_data_phys =
+		gen_pool_virt_to_phys(sram_pool_data, ocmcram_location_data);
+	ro_sram_data.rtc_base_virt = pm_ops->get_rtc_base_addr();
+
+	/* Save physical address to calculate resume offset during pm init */
+	am33xx_do_wfi_sram_phys = gen_pool_virt_to_phys(sram_pool,
+							ocmcram_location);
+
+	am33xx_do_wfi_sram = sram_exec_copy(sram_pool, (void *)ocmcram_location,
+					    pm_sram->do_wfi,
+					    *pm_sram->do_wfi_sz);
+	if (!am33xx_do_wfi_sram) {
+		dev_err(pm33xx_dev,
+			"PM: %s: am33xx_do_wfi copy to sram failed\n",
+			__func__);
+		return -ENODEV;
+	}
+
+	table_addr =
+		sram_suspend_address((unsigned long)pm_sram->emif_sram_table);
+	ret = ti_emif_copy_pm_function_table(sram_pool, (void *)table_addr);
+	if (ret) {
+		dev_dbg(pm33xx_dev,
+			"PM: %s: EMIF function copy failed\n", __func__);
+		return -EPROBE_DEFER;
+	}
+
+	ro_data_addr =
+		sram_suspend_address((unsigned long)pm_sram->ro_sram_data);
+	copy_addr = sram_exec_copy(sram_pool, (void *)ro_data_addr,
+				   &ro_sram_data,
+				   sizeof(ro_sram_data));
+	if (!copy_addr) {
+		dev_err(pm33xx_dev,
+			"PM: %s: ro_sram_data copy to sram failed\n",
+			__func__);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_SUSPEND
 static int am33xx_pm_suspend(suspend_state_t suspend_state)
 {
@@ -219,56 +269,6 @@ static int am33xx_pm_alloc_sram(void)
 	return ret;
 }
 
-static int am33xx_push_sram_idle(void)
-{
-	struct am33xx_pm_ro_sram_data ro_sram_data;
-	int ret;
-	u32 table_addr, ro_data_addr;
-	void *copy_addr;
-
-	ro_sram_data.amx3_pm_sram_data_virt = ocmcram_location_data;
-	ro_sram_data.amx3_pm_sram_data_phys =
-		gen_pool_virt_to_phys(sram_pool_data, ocmcram_location_data);
-	ro_sram_data.rtc_base_virt = pm_ops->get_rtc_base_addr();
-
-	/* Save physical address to calculate resume offset during pm init */
-	am33xx_do_wfi_sram_phys = gen_pool_virt_to_phys(sram_pool,
-							ocmcram_location);
-
-	am33xx_do_wfi_sram = sram_exec_copy(sram_pool, (void *)ocmcram_location,
-					    pm_sram->do_wfi,
-					    *pm_sram->do_wfi_sz);
-	if (!am33xx_do_wfi_sram) {
-		dev_err(pm33xx_dev,
-			"PM: %s: am33xx_do_wfi copy to sram failed\n",
-			__func__);
-		return -ENODEV;
-	}
-
-	table_addr =
-		sram_suspend_address((unsigned long)pm_sram->emif_sram_table);
-	ret = ti_emif_copy_pm_function_table(sram_pool, (void *)table_addr);
-	if (ret) {
-		dev_dbg(pm33xx_dev,
-			"PM: %s: EMIF function copy failed\n", __func__);
-		return -EPROBE_DEFER;
-	}
-
-	ro_data_addr =
-		sram_suspend_address((unsigned long)pm_sram->ro_sram_data);
-	copy_addr = sram_exec_copy(sram_pool, (void *)ro_data_addr,
-				   &ro_sram_data,
-				   sizeof(ro_sram_data));
-	if (!copy_addr) {
-		dev_err(pm33xx_dev,
-			"PM: %s: ro_sram_data copy to sram failed\n",
-			__func__);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
 static int am33xx_pm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-- 
2.17.1

