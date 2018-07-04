Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44627 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933889AbeGDJGa (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 4 Jul 2018 05:06:30 -0400
From: Johan Hovold <johan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/4] rtc: omap: fix resource leak in registration error path
Date: Wed,  4 Jul 2018 11:05:56 +0200
Message-Id: <20180704090558.16647-3-johan@kernel.org>
In-Reply-To: <20180704090558.16647-1-johan@kernel.org>
References: <20180704090558.16647-1-johan@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Make sure to deregister the pin controller in case rtc registration
fails.

Fixes: 57072758623f ("rtc: omap: switch to rtc_register_device")
Cc: stable <stable@vger.kernel.org>     # 4.14
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index c214b69a8787..6a7b804c3074 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -873,7 +873,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	ret = rtc_register_device(rtc->rtc);
 	if (ret)
-		goto err;
+		goto err_deregister_pinctrl;
 
 	rtc_nvmem_register(rtc->rtc, &omap_rtc_nvmem_config);
 
@@ -886,6 +886,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_deregister_pinctrl:
+	pinctrl_unregister(rtc->pctldev);
 err:
 	clk_disable_unprepare(rtc->clk);
 	device_init_wakeup(&pdev->dev, false);
-- 
2.18.0
