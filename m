Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35467 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbdEaVdg (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 31 May 2017 17:33:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id g15so6648145wmc.2
        for <linux-rtc@vger.kernel.org>; Wed, 31 May 2017 14:33:35 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/4] rtc: ds1307: make definition of ds1307_of_match more
 compact
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <85789383-af9c-fdbb-ff58-121d9fd432f5@gmail.com>
Message-ID: <503e3d30-7d57-1c52-7ede-1f3184e53f0f@gmail.com>
Date: Wed, 31 May 2017 23:32:43 +0200
MIME-Version: 1.0
In-Reply-To: <85789383-af9c-fdbb-ff58-121d9fd432f5@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Make the definition of ds1307_of_match more compact. This makes the
code better readable and more in line with the definition of
ds1307_id and ds1307_acpi_ids.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
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
