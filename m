Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:58490 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731366AbeISXb0 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 19 Sep 2018 19:31:26 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: ds1685: use rtc_add_group
Date: Wed, 19 Sep 2018 19:52:11 +0200
Message-Id: <20180919175211.25150-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20180919175211.25150-1-alexandre.belloni@bootlin.com>
References: <20180919175211.25150-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use rtc_add_group to add the sysfs group in a race free manner.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1685.c | 40 +---------------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 1f85e46b7888..b0723025ac31 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -995,7 +995,6 @@ static int ds1685_nvram_write(void *priv, unsigned int pos, void *val,
 /* ----------------------------------------------------------------------- */
 /* SysFS interface */
 
-#ifdef CONFIG_SYSFS
 /**
  * ds1685_rtc_sysfs_battery_show - sysfs file for main battery status.
  * @dev: pointer to device structure.
@@ -1079,37 +1078,6 @@ ds1685_rtc_sysfs_misc_grp = {
 	.attrs = ds1685_rtc_sysfs_misc_attrs,
 };
 
-/**
- * ds1685_rtc_sysfs_register - register sysfs files.
- * @dev: pointer to device structure.
- */
-static int
-ds1685_rtc_sysfs_register(struct device *dev)
-{
-	int ret = 0;
-
-	ret = sysfs_create_group(&dev->kobj, &ds1685_rtc_sysfs_misc_grp);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-/**
- * ds1685_rtc_sysfs_unregister - unregister sysfs files.
- * @dev: pointer to device structure.
- */
-static int
-ds1685_rtc_sysfs_unregister(struct device *dev)
-{
-	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_misc_grp);
-
-	return 0;
-}
-#endif /* CONFIG_SYSFS */
-
-
-
 /* ----------------------------------------------------------------------- */
 /* Driver Probe/Removal */
 
@@ -1390,11 +1358,9 @@ ds1685_rtc_probe(struct platform_device *pdev)
 	/* Setup complete. */
 	ds1685_rtc_switch_to_bank0(rtc);
 
-#ifdef CONFIG_SYSFS
-	ret = ds1685_rtc_sysfs_register(&pdev->dev);
+	ret = rtc_add_group(rtc_dev, &ds1685_rtc_sysfs_misc_grp);
 	if (ret)
 		return ret;
-#endif
 
 	rtc_dev->nvram_old_abi = true;
 	nvmem_cfg.priv = rtc;
@@ -1414,10 +1380,6 @@ ds1685_rtc_remove(struct platform_device *pdev)
 {
 	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
 
-#ifdef CONFIG_SYSFS
-	ds1685_rtc_sysfs_unregister(&pdev->dev);
-#endif
-
 	/* Read Ctrl B and clear PIE/AIE/UIE. */
 	rtc->write(rtc, RTC_CTRL_B,
 		   (rtc->read(rtc, RTC_CTRL_B) &
-- 
2.19.0
