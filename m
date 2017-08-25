Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33536 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932711AbdHYUGe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Aug 2017 16:06:34 -0400
Received: by mail-wr0-f193.google.com with SMTP id z91so449440wrc.0
        for <linux-rtc@vger.kernel.org>; Fri, 25 Aug 2017 13:06:33 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/5] rtc: ds1307: factor out determining the chip type
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
Message-ID: <6096da22-92b7-ecac-382c-39dbb7f494db@gmail.com>
Date: Fri, 25 Aug 2017 22:06:05 +0200
MIME-Version: 1.0
In-Reply-To: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

ds1307_probe is very long and confusing, so let's factor out
functionalities. As a first step factor out determining the chip type.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 4f00cea2..2b5c6d60 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1329,6 +1329,21 @@ static void ds1307_clks_register(struct ds1307 *ds1307)
 
 #endif /* CONFIG_COMMON_CLK */
 
+static enum ds_type ds1307_get_type(struct device *dev,
+				    const struct i2c_device_id *id)
+{
+	const struct acpi_device_id *acpi_id;
+
+	if (dev->of_node)
+		return (enum ds_type) of_device_get_match_data(dev);
+
+	if (id)
+		return id->driver_data;
+
+	acpi_id = acpi_match_device(ACPI_PTR(ds1307_acpi_ids), dev);
+	return acpi_id ? acpi_id->driver_data : -ENODEV;
+}
+
 static const struct regmap_config regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -1365,23 +1380,11 @@ static int ds1307_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, ds1307);
 
-	if (client->dev.of_node) {
-		ds1307->type = (enum ds_type)
-			of_device_get_match_data(&client->dev);
-		chip = &chips[ds1307->type];
-	} else if (id) {
-		chip = &chips[id->driver_data];
-		ds1307->type = id->driver_data;
-	} else {
-		const struct acpi_device_id *acpi_id;
-
-		acpi_id = acpi_match_device(ACPI_PTR(ds1307_acpi_ids),
-					    ds1307->dev);
-		if (!acpi_id)
-			return -ENODEV;
-		chip = &chips[acpi_id->driver_data];
-		ds1307->type = acpi_id->driver_data;
-	}
+	ds1307->type = ds1307_get_type(&client->dev, id);
+	if (ds1307->type < 0)
+		return ds1307->type;
+
+	chip = &chips[ds1307->type];
 
 	want_irq = client->irq > 0 && chip->alarm;
 
-- 
2.14.1
