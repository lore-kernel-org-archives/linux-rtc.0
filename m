Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756203AbdGLK76 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 12 Jul 2017 06:59:58 -0400
From: Alexey Klimov <alexey.klimov@arm.com>
To: linux-rtc@vger.kernel.org
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        alexandre.belloni@free-electrons.com, alexey.klimov@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org
Subject: [PATCH 1/3] rtc: sun6i: Remove double init of spinlock in sun6i_rtc_clk_init()
Date: Wed, 12 Jul 2017 11:59:48 +0100
Message-Id: <1499857190-30849-1-git-send-email-alexey.klimov@arm.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@arm.com>
---
 drivers/rtc/rtc-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 39cbc12..7e7da60 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -193,12 +193,12 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	rtc = kzalloc(sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return;
-	spin_lock_init(&rtc->lock);
 
 	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws),
 			   GFP_KERNEL);
 	if (!clk_data)
 		return;
+
 	spin_lock_init(&rtc->lock);
 
 	rtc->base = of_io_request_and_map(node, 0, of_node_full_name(node));
-- 
1.9.1
