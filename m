Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from wsip-98-189-142-135.oc.oc.cox.net ([98.189.142.135]:64712 "EHLO
        office-server2" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934715AbdKCCTW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 2 Nov 2017 22:19:22 -0400
From: Troy Kisky <troy.kisky@boundarydevices.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: gary.bisson@boundarydevices.com, linux-rtc@vger.kernel.org,
        Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH v1 2/5] rtc: m41t80: fix m41t80_sqw_round_rate return value
Date: Thu,  2 Nov 2017 18:58:13 -0700
Message-Id: <20171103015816.16972-2-troy.kisky@boundarydevices.com>
In-Reply-To: <20171103015816.16972-1-troy.kisky@boundarydevices.com>
References: <20171103015816.16972-1-troy.kisky@boundarydevices.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Previously it was returning the best of
32768, 8192, 1024, 64, 2, 0

Now, best of
32768, 8192, 4096, 2048, 1024, 512, 256, 128,
64, 32, 16, 8, 4, 2, 1, 0

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/rtc/rtc-m41t80.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 8f5843169dc2..42fc735a5446 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -468,18 +468,13 @@ static unsigned long m41t80_sqw_recalc_rate(struct clk_hw *hw,
 static long m41t80_sqw_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *prate)
 {
-	int i, freq = M41T80_SQW_MAX_FREQ;
-
-	if (freq <= rate)
-		return freq;
-
-	for (i = 2; i <= ilog2(M41T80_SQW_MAX_FREQ); i++) {
-		freq /= 1 << i;
-		if (freq <= rate)
-			return freq;
-	}
-
-	return 0;
+	if (rate >= M41T80_SQW_MAX_FREQ)
+		return M41T80_SQW_MAX_FREQ;
+	if (rate >= M41T80_SQW_MAX_FREQ / 4)
+		return M41T80_SQW_MAX_FREQ / 4;
+	if (!rate)
+		return 0;
+	return 1 << ilog2(rate);
 }
 
 static int m41t80_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.11.0
