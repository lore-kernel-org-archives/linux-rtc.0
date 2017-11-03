Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from wsip-98-189-142-135.oc.oc.cox.net ([98.189.142.135]:35747 "EHLO
        office-server2" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934708AbdKCCTl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 2 Nov 2017 22:19:41 -0400
From: Troy Kisky <troy.kisky@boundarydevices.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: gary.bisson@boundarydevices.com, linux-rtc@vger.kernel.org,
        Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH v1 1/5] rtc: m41t80: m41t80_sqw_set_rate should return 0 on success
Date: Thu,  2 Nov 2017 18:58:12 -0700
Message-Id: <20171103015816.16972-1-troy.kisky@boundarydevices.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Previously it was returning -EINVAL upon success.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/rtc/rtc-m41t80.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index f4c070ea8384..8f5843169dc2 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -510,10 +510,7 @@ static int m41t80_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
 	reg = (reg & 0x0f) | (val << 4);
 
 	ret = i2c_smbus_write_byte_data(client, reg_sqw, reg);
-	if (ret < 0)
-		return ret;
-
-	return -EINVAL;
+	return ret;
 }
 
 static int m41t80_sqw_control(struct clk_hw *hw, bool enable)
-- 
2.11.0
