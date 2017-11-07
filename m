Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39521 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756059AbdKGMMY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 7 Nov 2017 07:12:24 -0500
From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-rtc@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] rtc: pcf8563: fix output clock rate
Date: Tue,  7 Nov 2017 13:12:17 +0100
Message-Id: <20171107121217.31309-1-p.zabel@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The pcf8563_clkout_recalc_rate function erroneously ignores the
frequency index read from the CLKO register and always returns
32768 Hz.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/rtc/rtc-pcf8563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index cea6ea4df970f..8c836c51a508f 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -419,13 +419,13 @@ static unsigned long pcf8563_clkout_recalc_rate(struct clk_hw *hw,
 	int ret = pcf8563_read_block_data(client, PCF8563_REG_CLKO, 1, &buf);
 
 	if (ret < 0)
 		return 0;
 
 	buf &= PCF8563_REG_CLKO_F_MASK;
-	return clkout_rates[ret];
+	return clkout_rates[buf];
 }
 
 static long pcf8563_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 				      unsigned long *prate)
 {
 	int i;
-- 
2.11.0
