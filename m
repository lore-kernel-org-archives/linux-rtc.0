Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53804 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756203AbdGLK77 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 12 Jul 2017 06:59:59 -0400
From: Alexey Klimov <alexey.klimov@arm.com>
To: linux-rtc@vger.kernel.org
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        alexandre.belloni@free-electrons.com, alexey.klimov@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org
Subject: [PATCH 2/3] rtc: sun6i: fix memleaks and add error-path in sun6i_rtc_clk_init()
Date: Wed, 12 Jul 2017 11:59:49 +0100
Message-Id: <1499857190-30849-2-git-send-email-alexey.klimov@arm.com>
In-Reply-To: <1499857190-30849-1-git-send-email-alexey.klimov@arm.com>
References: <1499857190-30849-1-git-send-email-alexey.klimov@arm.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The memory allocated for rtc and clk_data will never be freed in
sun6i_rtc_clk_init() in case of error and return. This patch adds
required error path with memory freeing.

Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@arm.com>
---
 drivers/rtc/rtc-sun6i.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 7e7da60..77bc4d3 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -197,14 +197,14 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws),
 			   GFP_KERNEL);
 	if (!clk_data)
-		return;
+		goto out_rtc_free;
 
 	spin_lock_init(&rtc->lock);
 
 	rtc->base = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(rtc->base)) {
 		pr_crit("Can't map RTC registers");
-		return;
+		goto out_clk_data_free;
 	}
 
 	/* Switch to the external, more precise, oscillator */
@@ -216,7 +216,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 
 	/* Deal with old DTs */
 	if (!of_get_property(node, "clocks", NULL))
-		return;
+		goto out_clk_data_free;
 
 	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
 								"rtc-int-osc",
@@ -225,7 +225,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 								300000000);
 	if (IS_ERR(rtc->int_osc)) {
 		pr_crit("Couldn't register the internal oscillator\n");
-		return;
+		goto out_clk_data_free;
 	}
 
 	parents[0] = clk_hw_get_name(rtc->int_osc);
@@ -240,12 +240,19 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	rtc->losc = clk_register(NULL, &rtc->hw);
 	if (IS_ERR(rtc->losc)) {
 		pr_crit("Couldn't register the LOSC clock\n");
-		return;
+		goto out_clk_data_free;
 	}
 
 	clk_data->num = 1;
 	clk_data->hws[0] = &rtc->hw;
 	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	return;
+
+out_clk_data_free:
+	kfree(clk_data);
+out_rtc_free:
+	kfree(rtc);
 }
 CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
 		      sun6i_rtc_clk_init);
-- 
1.9.1
