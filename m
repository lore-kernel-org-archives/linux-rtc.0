Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38945 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeGOV4t (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 15 Jul 2018 17:56:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id w14-v6so28494635eds.6
        for <linux-rtc@vger.kernel.org>; Sun, 15 Jul 2018 14:32:31 -0700 (PDT)
From: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@airtame.com>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, rkhudolii@airtame.com,
        attila@airtame.com,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@airtame.com>
Subject: [PATCH] rtc: pcf85063: preserve control register value between stop and start
Date: Sun, 15 Jul 2018 23:31:53 +0200
Message-Id: <20180715213153.8606-1-alvin@airtame.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Fix a bug that caused the Control_1 register to get zeroed whenever the
RTC time is set. The problem occurred between stopping and starting the
RTC clock, wherein the return value of a successful I2C write function
would get written to the register.

Also update variables of the start and stop functions to be more
consistent with the rest of the driver.

Signed-off-by: Alvin Šipraga <alvin@airtame.com>
---
 drivers/rtc/rtc-pcf85063.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 49bcbb3d4a69..283c2335b01b 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -43,37 +43,38 @@ static struct i2c_driver pcf85063_driver;
 
 static int pcf85063_stop_clock(struct i2c_client *client, u8 *ctrl1)
 {
-	s32 ret;
+	int rc;
+	u8 reg;
 
-	ret = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
-	if (ret < 0) {
+	rc = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
+	if (rc < 0) {
 		dev_err(&client->dev, "Failing to stop the clock\n");
 		return -EIO;
 	}
 
 	/* stop the clock */
-	ret |= PCF85063_REG_CTRL1_STOP;
+	reg = rc | PCF85063_REG_CTRL1_STOP;
 
-	ret = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, ret);
-	if (ret < 0) {
+	rc = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, reg);
+	if (rc < 0) {
 		dev_err(&client->dev, "Failing to stop the clock\n");
 		return -EIO;
 	}
 
-	*ctrl1 = ret;
+	*ctrl1 = reg;
 
 	return 0;
 }
 
 static int pcf85063_start_clock(struct i2c_client *client, u8 ctrl1)
 {
-	s32 ret;
+	int rc;
 
 	/* start the clock */
 	ctrl1 &= ~PCF85063_REG_CTRL1_STOP;
 
-	ret = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, ctrl1);
-	if (ret < 0) {
+	rc = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, ctrl1);
+	if (rc < 0) {
 		dev_err(&client->dev, "Failing to start the clock\n");
 		return -EIO;
 	}
-- 
2.11.0
