Return-Path: <SRS0=5rMO=SE=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA10C43381
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 03:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FAD2084C
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 03:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qxXXY5SR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfDBDnO (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:43:14 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54162 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfDBDnO (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 1 Apr 2019 23:43:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x323goGI112621;
        Mon, 1 Apr 2019 22:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554176570;
        bh=XfABURG59tpXBM9Y0qDyDo+DkTiZdkbXVM837C2Z9/I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qxXXY5SRflXqxf0gZTMKQehXOJebjvzxgIIAEd8RJ2KnlyX0bcC57J8umMK7/xcmD
         WdU1oaguY3QxrEGIH9UjKJ8HmPUS6/v4We+XEvDjQKJhUKmLIWAAgMVZzp4zYy8sbs
         PIJtDrbjWify1YRfJpyYwVKSCuq/vrvZ+jCX05so=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x323goZe119415
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 22:42:50 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 22:42:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 22:42:50 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x323gb9H070613;
        Mon, 1 Apr 2019 22:42:47 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <tony@atomide.com>, <alexandre.belloni@bootlin.com>,
        <a.zummo@towertech.it>, <t-kristo@ti.com>
CC:     <ssantosh@kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>, <j-keerthy@ti.com>
Subject: [PATCH v2 3/5] arm: mach-omap2: pm33xx: Add support for rtc+ddr in self  refresh mode
Date:   Tue, 2 Apr 2019 09:12:51 +0530
Message-ID: <20190402034253.4928-4-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402034253.4928-1-j-keerthy@ti.com>
References: <20190402034253.4928-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Add support for rtc+ddr in self refresh mode. Add addtional
pm hooks for save/restore and rtc suspend/resume.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * White list check of the boards which have HW support got this mode

 arch/arm/mach-omap2/pm33xx-core.c    | 76 +++++++++++++++++++++++++++-
 include/linux/platform_data/pm33xx.h |  5 ++
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index 724cf5774a6c..cd8cb12a5003 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -10,6 +10,12 @@
 #include <asm/suspend.h>
 #include <linux/errno.h>
 #include <linux/platform_data/pm33xx.h>
+#include <linux/clk.h>
+#include <linux/platform_data/gpio-omap.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/wkup_m3_ipc.h>
+#include <linux/of.h>
+#include <linux/rtc.h>
 
 #include "cm33xx.h"
 #include "common.h"
@@ -38,6 +44,29 @@ static int am43xx_map_scu(void)
 	return 0;
 }
 
+static int am33xx_check_off_mode_enable(void)
+{
+	if (enable_off_mode)
+		pr_warn("WARNING: This platform does not support off-mode, entering DeepSleep suspend.\n");
+
+	/* off mode not supported on am335x so return 0 always */
+	return 0;
+}
+
+static int am43xx_check_off_mode_enable(void)
+{
+	/*
+	 * Check for am437x-gp-evm which has the right Hardware design to
+	 * support this mode reliably.
+	 */
+	if (of_machine_is_compatible("ti,am437x-gp-evm") && enable_off_mode) {
+		return enable_off_mode;
+	} else {
+		pr_warn("WARNING: This platform does not support off-mode, entering DeepSleep suspend.\n");
+		return 0;
+	}
+}
+
 static int amx3_common_init(void)
 {
 	gfx_pwrdm = pwrdm_lookup("gfx_pwrdm");
@@ -139,7 +168,9 @@ static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
 	scu_power_mode(scu_base, SCU_PM_POWEROFF);
 	ret = cpu_suspend(args, fn);
 	scu_power_mode(scu_base, SCU_PM_NORMAL);
-	amx3_post_suspend_common();
+
+	if (!am43xx_check_off_mode_enable())
+		amx3_post_suspend_common();
 
 	return ret;
 }
@@ -161,10 +192,48 @@ void __iomem *am43xx_get_rtc_base_addr(void)
 	return omap_hwmod_get_mpu_rt_va(rtc_oh);
 }
 
+static void am43xx_save_context(void)
+{
+}
+
+static void am33xx_save_context(void)
+{
+	omap_intc_save_context();
+}
+
+static void am33xx_restore_context(void)
+{
+	omap_intc_restore_context();
+}
+
+static void am43xx_restore_context(void)
+{
+	/*
+	 * HACK: restore dpll_per_clkdcoldo register contents, to avoid
+	 * breaking suspend-resume
+	 */
+	writel_relaxed(0x0, AM33XX_L4_WK_IO_ADDRESS(0x44df2e14));
+}
+
+static void am43xx_prepare_rtc_suspend(void)
+{
+	omap_hwmod_enable(rtc_oh);
+}
+
+static void am43xx_prepare_rtc_resume(void)
+{
+	omap_hwmod_idle(rtc_oh);
+}
+
 static struct am33xx_pm_platform_data am33xx_ops = {
 	.init = am33xx_suspend_init,
 	.soc_suspend = am33xx_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
+	.save_context = am33xx_save_context,
+	.restore_context = am33xx_restore_context,
+	.prepare_rtc_suspend = am43xx_prepare_rtc_suspend,
+	.prepare_rtc_resume = am43xx_prepare_rtc_resume,
+	.check_off_mode_enable = am33xx_check_off_mode_enable,
 	.get_rtc_base_addr = am43xx_get_rtc_base_addr,
 };
 
@@ -172,6 +241,11 @@ static struct am33xx_pm_platform_data am43xx_ops = {
 	.init = am43xx_suspend_init,
 	.soc_suspend = am43xx_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
+	.save_context = am43xx_save_context,
+	.restore_context = am43xx_restore_context,
+	.prepare_rtc_suspend = am43xx_prepare_rtc_suspend,
+	.prepare_rtc_resume = am43xx_prepare_rtc_resume,
+	.check_off_mode_enable = am43xx_check_off_mode_enable,
 	.get_rtc_base_addr = am43xx_get_rtc_base_addr,
 };
 
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
index fbf5ed73c7cc..dd5971937a64 100644
--- a/include/linux/platform_data/pm33xx.h
+++ b/include/linux/platform_data/pm33xx.h
@@ -51,6 +51,11 @@ struct am33xx_pm_platform_data {
 			       unsigned long args);
 	struct  am33xx_pm_sram_addr *(*get_sram_addrs)(void);
 	void __iomem *(*get_rtc_base_addr)(void);
+	void (*save_context)(void);
+	void (*restore_context)(void);
+	void (*prepare_rtc_suspend)(void);
+	void (*prepare_rtc_resume)(void);
+	int (*check_off_mode_enable)(void);
 };
 
 struct am33xx_pm_sram_data {
-- 
2.17.1

