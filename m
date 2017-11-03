Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from wsip-98-189-142-135.oc.oc.cox.net ([98.189.142.135]:38811 "EHLO
        office-server2" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934715AbdKCCTB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 2 Nov 2017 22:19:01 -0400
From: Troy Kisky <troy.kisky@boundarydevices.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: gary.bisson@boundarydevices.com, linux-rtc@vger.kernel.org,
        Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH v1 5/5] rtc: m41t80: remove unneeded checks from m41t80_sqw_set_rate
Date: Thu,  2 Nov 2017 18:58:16 -0700
Message-Id: <20171103015816.16972-5-troy.kisky@boundarydevices.com>
In-Reply-To: <20171103015816.16972-1-troy.kisky@boundarydevices.com>
References: <20171103015816.16972-1-troy.kisky@boundarydevices.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

m41t80_sqw_set_rate will be called with the result from
m41t80_sqw_round_rate, so might as well make
m41t80_sqw_set_rate(n) same as
m41t80_sqw_set_rate(m41t80_sqw_round_rate(n))

As Russell King wrote[1],
"clk_round_rate() is supposed to tell you what you end up with if you
ask clk_set_rate() to set the exact same value you passed in - but
clk_round_rate() won't modify the hardware."

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/080175.html

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/rtc/rtc-m41t80.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 96a606d5f6e6..c90fba3ed861 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -490,17 +490,12 @@ static int m41t80_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
 		M41T80_REG_WDAY : M41T80_REG_SQW;
 	int reg, ret, val = 0;
 
-	if (rate) {
-		if (!is_power_of_2(rate))
-			return -EINVAL;
-		val = ilog2(rate);
-		if (val == ilog2(M41T80_SQW_MAX_FREQ))
-			val = 1;
-		else if (val < (ilog2(M41T80_SQW_MAX_FREQ) - 1))
-			val = ilog2(M41T80_SQW_MAX_FREQ) - val;
-		else
-			return -EINVAL;
-	}
+	if (rate >= M41T80_SQW_MAX_FREQ)
+		val = 1;
+	else if (rate >= M41T80_SQW_MAX_FREQ / 4)
+		val = 2;
+	else if (rate)
+		val = 15 - ilog2(rate);
 
 	reg = i2c_smbus_read_byte_data(client, reg_sqw);
 	if (reg < 0)
-- 
2.11.0
