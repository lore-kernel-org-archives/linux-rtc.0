Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35118 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFATJi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 1 Jun 2017 15:09:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id g15so13625100wmc.2
        for <linux-rtc@vger.kernel.org>; Thu, 01 Jun 2017 12:09:38 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 1/4] rtc: ds1307: make definition of ds1307_of_match more
 compact
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <22e48dc3-5d08-681c-5eed-d7c0e4552267@gmail.com>
Message-ID: <bbccfbd0-3890-4eff-be88-094a8006dc9d@gmail.com>
Date: Thu, 1 Jun 2017 21:09:17 +0200
MIME-Version: 1.0
In-Reply-To: <22e48dc3-5d08-681c-5eed-d7c0e4552267@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Make the definition of ds1307_of_match more compact. This makes the
code better readable and more in line with the definition of
ds1307_id and ds1307_acpi_ids.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- no changes
---
 drivers/rtc/rtc-ds1307.c | 70 ++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 56 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index a2649385..b960ec3f 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -198,62 +198,20 @@ MODULE_DEVICE_TABLE(i2c, ds1307_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id ds1307_of_match[] = {
-	{
-		.compatible = "dallas,ds1307",
-		.data = (void *)ds_1307
-	},
-	{
-		.compatible = "dallas,ds1337",
-		.data = (void *)ds_1337
-	},
-	{
-		.compatible = "dallas,ds1338",
-		.data = (void *)ds_1338
-	},
-	{
-		.compatible = "dallas,ds1339",
-		.data = (void *)ds_1339
-	},
-	{
-		.compatible = "dallas,ds1388",
-		.data = (void *)ds_1388
-	},
-	{
-		.compatible = "dallas,ds1340",
-		.data = (void *)ds_1340
-	},
-	{
-		.compatible = "maxim,ds3231",
-		.data = (void *)ds_3231
-	},
-	{
-		.compatible = "st,m41t0",
-		.data = (void *)m41t00
-	},
-	{
-		.compatible = "st,m41t00",
-		.data = (void *)m41t00
-	},
-	{
-		.compatible = "microchip,mcp7940x",
-		.data = (void *)mcp794xx
-	},
-	{
-		.compatible = "microchip,mcp7941x",
-		.data = (void *)mcp794xx
-	},
-	{
-		.compatible = "pericom,pt7c4338",
-		.data = (void *)ds_1307
-	},
-	{
-		.compatible = "epson,rx8025",
-		.data = (void *)rx_8025
-	},
-	{
-		.compatible = "isil,isl12057",
-		.data = (void *)ds_1337
-	},
+	{ .compatible = "dallas,ds1307",	.data = (void *)ds_1307 },
+	{ .compatible = "dallas,ds1337",	.data = (void *)ds_1337 },
+	{ .compatible = "dallas,ds1338",	.data = (void *)ds_1338 },
+	{ .compatible = "dallas,ds1339",	.data = (void *)ds_1339 },
+	{ .compatible = "dallas,ds1388",	.data = (void *)ds_1388 },
+	{ .compatible = "dallas,ds1340",	.data = (void *)ds_1340 },
+	{ .compatible = "maxim,ds3231",		.data = (void *)ds_3231 },
+	{ .compatible = "st,m41t0",		.data = (void *)m41t00 },
+	{ .compatible = "st,m41t00",		.data = (void *)m41t00 },
+	{ .compatible = "microchip,mcp7940x",	.data = (void *)mcp794xx },
+	{ .compatible = "microchip,mcp7941x",	.data = (void *)mcp794xx },
+	{ .compatible = "pericom,pt7c4338",	.data = (void *)ds_1307 },
+	{ .compatible = "epson,rx8025",		.data = (void *)rx_8025 },
+	{ .compatible = "isil,isl12057",	.data = (void *)ds_1337 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ds1307_of_match);
-- 
2.13.0
