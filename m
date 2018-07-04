Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41094 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932835AbeGDJG3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 4 Jul 2018 05:06:29 -0400
From: Johan Hovold <johan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Marcin Niestroj <m.niestroj@grinn-global.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] rtc: omap: fix potential crash on power off
Date: Wed,  4 Jul 2018 11:05:55 +0200
Message-Id: <20180704090558.16647-2-johan@kernel.org>
In-Reply-To: <20180704090558.16647-1-johan@kernel.org>
References: <20180704090558.16647-1-johan@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Do not set the system power-off callback and omap power-off rtc pointer
until we're done setting up our device to avoid leaving stale pointers
around after a late probe error.

Fixes: 97ea1906b3c2 ("rtc: omap: Support ext_wakeup configuration")
Cc: stable <stable@vger.kernel.org>     # 4.9
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 39086398833e..c214b69a8787 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -861,13 +861,6 @@ static int omap_rtc_probe(struct platform_device *pdev)
 			goto err;
 	}
 
-	if (rtc->is_pmic_controller) {
-		if (!pm_power_off) {
-			omap_rtc_power_off_rtc = rtc;
-			pm_power_off = omap_rtc_power_off;
-		}
-	}
-
 	/* Support ext_wakeup pinconf */
 	rtc_pinctrl_desc.name = dev_name(&pdev->dev);
 
@@ -884,6 +877,13 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	rtc_nvmem_register(rtc->rtc, &omap_rtc_nvmem_config);
 
+	if (rtc->is_pmic_controller) {
+		if (!pm_power_off) {
+			omap_rtc_power_off_rtc = rtc;
+			pm_power_off = omap_rtc_power_off;
+		}
+	}
+
 	return 0;
 
 err:
-- 
2.18.0
