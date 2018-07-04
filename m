Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36975 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934211AbeGDJGb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 4 Jul 2018 05:06:31 -0400
From: Johan Hovold <johan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/4] rtc: omap: add missing register lock in error path
Date: Wed,  4 Jul 2018 11:05:57 +0200
Message-Id: <20180704090558.16647-4-johan@kernel.org>
In-Reply-To: <20180704090558.16647-1-johan@kernel.org>
References: <20180704090558.16647-1-johan@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

For completeness re-lock the registers also in the power-off error path.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 6a7b804c3074..7f9ee559dd99 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -449,6 +449,7 @@ static void omap_rtc_power_off(void)
 
 	if (tm2bcd(&tm) < 0) {
 		dev_err(&rtc->rtc->dev, "power off failed\n");
+		rtc->type->lock(rtc);
 		return;
 	}
 
-- 
2.18.0
