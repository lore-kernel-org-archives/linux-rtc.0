Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-sy3aus01on0124.outbound.protection.outlook.com ([104.47.117.124]:17248
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751425AbeBUW3h (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 21 Feb 2018 17:29:37 -0500
Date: Thu, 22 Feb 2018 11:29:24 +1300
From: Michael McCormick <michael.mccormick@enatel.net>
To: <a.zummo@towertech.it>
CC: <alexandre.belloni@free-electrons.com>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michael.mccormick@enatel.net>
Subject: [PATCH] pcf85063 was not clearing bits correctly in
 pcf85063_start_clock
Message-ID: <20180221222924.GA11756@michael-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Bit clear operation was missing ~

Signed-off-by: Michael McCormick <michael.mccormick@enatel.net>
---
 drivers/rtc/rtc-pcf85063.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index a06dff9..67bc763 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -70,7 +70,7 @@ static int pcf85063_start_clock(struct i2c_client *client, u8 ctrl1)
 	s32 ret;
 
 	/* start the clock */
-	ctrl1 &= PCF85063_REG_CTRL1_STOP;
+	ctrl1 &= ~PCF85063_REG_CTRL1_STOP;
 
 	ret = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, ctrl1);
 	if (ret < 0) {
-- 
2.7.4
