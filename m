Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56010 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbdKHMIf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Nov 2017 07:08:35 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Loc Ho <lho@apm.com>,
        Mark Brown <broonie@linaro.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: x-gene: mark PM functions as __maybe_unused
Date: Wed,  8 Nov 2017 13:08:10 +0100
Message-Id: <20171108120815.3175571-1-arnd@arndb.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The new xgene_rtc_alarm_irq_enabled() function is only accessed
from PM code, which is inside of an #ifdef; this causes a harmless
build warning when CONFIG_PM is disabled:

drivers/rtc/rtc-xgene.c:108:12: error: 'xgene_rtc_alarm_irq_enabled' defined but not used [-Werror=unused-function]

Just remove the #ifdef and use __maybe_unused annotations instead,
to make the code more robust here.

Fixes: 9f8f1c8b727d ("rtc: Fix suspend/resume for APM X-Gene SoC RTC driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-xgene.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index 360eae24a8c8..0c34d3b81279 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -221,8 +221,7 @@ static int xgene_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int xgene_rtc_suspend(struct device *dev)
+static int __maybe_unused xgene_rtc_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct xgene_rtc_dev *pdata = platform_get_drvdata(pdev);
@@ -246,7 +245,7 @@ static int xgene_rtc_suspend(struct device *dev)
 	return 0;
 }
 
-static int xgene_rtc_resume(struct device *dev)
+static int __maybe_unused xgene_rtc_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct xgene_rtc_dev *pdata = platform_get_drvdata(pdev);
@@ -271,7 +270,6 @@ static int xgene_rtc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(xgene_rtc_pm_ops, xgene_rtc_suspend, xgene_rtc_resume);
 
-- 
2.9.0
