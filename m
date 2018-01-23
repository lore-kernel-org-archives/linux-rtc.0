Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33257 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeAWMSM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 23 Jan 2018 07:18:12 -0500
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        kernel@pengutronix.de, Denis.Osterland@diehl.com
Subject: [PATCH 1/4] rtc: isl1208: Fix unintended clear of SR bits
Date: Tue, 23 Jan 2018 13:17:58 +0100
Message-Id: <20180123121801.4214-2-m.grzeschik@pengutronix.de>
In-Reply-To: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Denis Osterland <Denis.Osterland@diehl.com>

After successful
sr = isl1208_i2c_set_regs(client, 0, regs, ISL1208_RTC_SECTION_LEN);
sr will be 0.
As a result
sr = i2c_smbus_write_byte_data(client, ISL1208_REG_SR,
			sr & ~ISL1208_REG_SR_WRTC);
is equal to
sr = i2c_smbus_write_byte_data(client, ISL1208_REG_SR, 0);
which clears all flags in SR.

Add an additional read of SR, to have value of SR in sr again.

Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/rtc/rtc-isl1208.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 8dd299c6a1f33..c8b4953482296 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -459,6 +459,11 @@ isl1208_i2c_set_time(struct i2c_client *client, struct rtc_time const *tm)
 	}
 
 	/* clear WRTC again */
+	sr = isl1208_i2c_get_sr(client);
+	if (sr < 0) {
+		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
+		return sr;
+	}
 	sr = i2c_smbus_write_byte_data(client, ISL1208_REG_SR,
 				       sr & ~ISL1208_REG_SR_WRTC);
 	if (sr < 0) {
-- 
2.11.0
