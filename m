Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52496 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeGLFQh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Jul 2018 01:16:37 -0400
From: Keerthy <j-keerthy@ti.com>
To: <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC: <t-kristo@ti.com>, <j-keerthy@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan@kernel.org>
Subject: [PATCH v4 3/4] rtc: omap: use of_device_is_system_power_controller function
Date: Thu, 12 Jul 2018 10:37:39 +0530
Message-ID: <1531372060-10532-4-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use of_device_is_system_power_controller instead of manually reading
the system-power-controller property from the device tree node.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/rtc/rtc-omap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index cb19ece..3610efd 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -753,8 +753,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (of_id) {
 		rtc->type = of_id->data;
 		rtc->is_pmic_controller = rtc->type->has_pmic_mode &&
-				of_property_read_bool(pdev->dev.of_node,
-						"system-power-controller");
+			of_device_is_system_power_controller(pdev->dev.of_node);
 	} else {
 		id_entry = platform_get_device_id(pdev);
 		rtc->type = (void *)id_entry->driver_data;
-- 
1.9.1
