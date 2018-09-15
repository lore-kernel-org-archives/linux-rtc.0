Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:34135 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIORC2 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 15 Sep 2018 13:02:28 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: isl1208: avoid possible sysfs race
Date: Sat, 15 Sep 2018 13:43:43 +0200
Message-Id: <20180915114343.31935-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Use rtc_add_group to add the common sysfs group to avoid a possible race
condition.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-isl1208.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index ea18a8f4bce0..e1e9434c9972 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -804,7 +804,7 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		evdet_irq = of_irq_get_byname(np, "evdet");
 	}
 
-	rc = sysfs_create_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
+	rc = rtc_add_group(rtc, &isl1208_rtc_sysfs_files);
 	if (rc)
 		return rc;
 
@@ -821,14 +821,6 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	return rtc_register_device(rtc);
 }
 
-static int
-isl1208_remove(struct i2c_client *client)
-{
-	sysfs_remove_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
-
-	return 0;
-}
-
 static const struct i2c_device_id isl1208_id[] = {
 	{ "isl1208", TYPE_ISL1208 },
 	{ "isl1218", TYPE_ISL1218 },
@@ -851,7 +843,6 @@ static struct i2c_driver isl1208_driver = {
 		.of_match_table = of_match_ptr(isl1208_of_match),
 	},
 	.probe = isl1208_probe,
-	.remove = isl1208_remove,
 	.id_table = isl1208_id,
 };
 
-- 
2.19.0
