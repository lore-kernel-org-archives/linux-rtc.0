Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from wsip-98-189-142-135.oc.oc.cox.net ([98.189.142.135]:61167 "EHLO
        office-server2" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934708AbdKCCTb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 2 Nov 2017 22:19:31 -0400
From: Troy Kisky <troy.kisky@boundarydevices.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: gary.bisson@boundarydevices.com, linux-rtc@vger.kernel.org,
        Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH v1 4/5] rtc: m41t80: avoid i2c read in m41t80_sqw_is_prepared
Date: Thu,  2 Nov 2017 18:58:15 -0700
Message-Id: <20171103015816.16972-4-troy.kisky@boundarydevices.com>
In-Reply-To: <20171103015816.16972-1-troy.kisky@boundarydevices.com>
References: <20171103015816.16972-1-troy.kisky@boundarydevices.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This is a little more efficient and avoids the warning

 WARNING: possible circular locking dependency detected
 4.14.0-rc7-00010 #16 Not tainted
 ------------------------------------------------------
 kworker/2:1/70 is trying to acquire lock:
  (prepare_lock){+.+.}, at: [<c049300c>] clk_prepare_lock+0x80/0xf4

 but task is already holding lock:
  (i2c_register_adapter){+.+.}, at: [<c0690b04>]
		i2c_adapter_lock_bus+0x14/0x18

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #1 (i2c_register_adapter){+.+.}:
        rt_mutex_lock+0x44/0x5c
        i2c_adapter_lock_bus+0x14/0x18
        i2c_transfer+0xa8/0xbc
        i2c_smbus_xfer+0x20c/0x5d8
        i2c_smbus_read_byte_data+0x38/0x48
        m41t80_sqw_is_prepared+0x18/0x28

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/rtc/rtc-m41t80.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index f44dcf628c87..96a606d5f6e6 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -155,6 +155,7 @@ struct m41t80_data {
 #ifdef CONFIG_COMMON_CLK
 	struct clk_hw sqw;
 	unsigned long freq;
+	unsigned int sqwe;
 #endif
 };
 
@@ -527,7 +528,10 @@ static int m41t80_sqw_control(struct clk_hw *hw, bool enable)
 	else
 		ret &= ~M41T80_ALMON_SQWE;
 
-	return i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON, ret);
+	ret = i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON, ret);
+	if (!ret)
+		m41t80->sqwe = enable;
+	return ret;
 }
 
 static int m41t80_sqw_prepare(struct clk_hw *hw)
@@ -542,14 +546,7 @@ static void m41t80_sqw_unprepare(struct clk_hw *hw)
 
 static int m41t80_sqw_is_prepared(struct clk_hw *hw)
 {
-	struct m41t80_data *m41t80 = sqw_to_m41t80_data(hw);
-	struct i2c_client *client = m41t80->client;
-	int ret = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
-
-	if (ret < 0)
-		return ret;
-
-	return !!(ret & M41T80_ALMON_SQWE);
+	return sqw_to_m41t80_data(hw)->sqwe;
 }
 
 static const struct clk_ops m41t80_sqw_ops = {
-- 
2.11.0
