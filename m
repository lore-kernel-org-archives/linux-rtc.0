Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34085 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754795AbdGSQ5J (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 19 Jul 2017 12:57:09 -0400
From: Colin King <colin.king@canonical.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: sun6i: ensure clk_data is kfree'd on error
Date: Wed, 19 Jul 2017 17:57:02 +0100
Message-Id: <20170719165702.22220-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

There are two error return paths that do not kfree clk_data and
we end up with a memory leak. Fix these with a kfree error exit
path.

Detected by CoverityScan, CID#1402959 ("Resource Leak")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rtc/rtc-sun6i.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 39cbc1238b92..61502221ab6e 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -204,7 +204,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	rtc->base = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(rtc->base)) {
 		pr_crit("Can't map RTC registers");
-		return;
+		goto err;
 	}
 
 	/* Switch to the external, more precise, oscillator */
@@ -216,7 +216,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 
 	/* Deal with old DTs */
 	if (!of_get_property(node, "clocks", NULL))
-		return;
+		goto err;
 
 	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
 								"rtc-int-osc",
@@ -246,6 +246,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 	clk_data->num = 1;
 	clk_data->hws[0] = &rtc->hw;
 	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	return;
+
+err:
+	kfree(clk_data);
 }
 CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
 		      sun6i_rtc_clk_init);
-- 
2.11.0
