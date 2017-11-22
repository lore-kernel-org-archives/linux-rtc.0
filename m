Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52967 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbdKVRQZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 22 Nov 2017 12:16:25 -0500
From: Colin King <colin.king@canonical.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: sun6i: ensure rtc is kfree'd on error
Date: Wed, 22 Nov 2017 17:16:18 +0000
Message-Id: <20171122171618.2460-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The error return path on clk_data allocation failure does not kfree
the allocated rtc object. Fix this with a kfree of rtc on the error
exit path.

Detected by CoverityScan, CID#1452264 ("Resource Leak")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rtc/rtc-sun6i.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 3d2216ccd860..5bc28eed1adf 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -201,8 +201,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
 
 	clk_data = kzalloc(sizeof(*clk_data) + (sizeof(*clk_data->hws) * 2),
 			   GFP_KERNEL);
-	if (!clk_data)
+	if (!clk_data) {
+		kfree(rtc);
 		return;
+	}
 
 	spin_lock_init(&rtc->lock);
 
-- 
2.14.1
