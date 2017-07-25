Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36160 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbdGYQoN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 25 Jul 2017 12:44:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id 184so16894328wmo.3
        for <linux-rtc@vger.kernel.org>; Tue, 25 Jul 2017 09:44:12 -0700 (PDT)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] rtc: ds1307: fix regmap config
Message-ID: <2061233f-1187-d03c-51dc-8d7ad2faf90e@gmail.com>
Date: Tue, 25 Jul 2017 18:44:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Current max_register setting breaks reading nvram on certain chips and
also reading the standard registers on RX8130 where register map starts
at 0x10.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Fixes: 11e5890b5342 "rtc: ds1307: convert driver to regmap"
---
This fix should make it to 4.13.
---
 drivers/rtc/rtc-ds1307.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 4fac49e5..4b43aa62 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1301,7 +1301,6 @@ static void ds1307_clks_register(struct ds1307 *ds1307)
 static const struct regmap_config regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.max_register = 0x12,
 };
 
 static int ds1307_probe(struct i2c_client *client,
-- 
2.13.2
