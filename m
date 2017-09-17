Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37715 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdIQMnR (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 17 Sep 2017 08:43:17 -0400
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] rtc: sun6i: fix memory leak
Date: Sun, 17 Sep 2017 13:43:10 +0100
Message-Id: <1505652190-4942-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

If 'clk_data' is not allocated we returned but we failed to free 'rtc'.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/rtc/rtc-sun6i.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 3d2216c..5bc28ee 100644
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
2.7.4
