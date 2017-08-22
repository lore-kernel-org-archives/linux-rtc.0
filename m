Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46679 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752555AbdHVXRd (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 22 Aug 2017 19:17:33 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: m41t80: remove debug sysfs attribute
Date: Wed, 23 Aug 2017 01:17:28 +0200
Message-Id: <20170822231728.10795-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The last remaining sysfs attribute is undocumented and useless as it can
only be used to debug the driver. Remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-m41t80.c | 44 --------------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 3b6ef4b0f4ac..56fa6ca93c25 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -440,28 +440,6 @@ static int m41t80_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(m41t80_pm, m41t80_suspend, m41t80_resume);
 
-static ssize_t flags_show(struct device *dev,
-			  struct device_attribute *attr, char *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	int val;
-
-	val = i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
-	if (val < 0)
-		return val;
-	return sprintf(buf, "%#x\n", val);
-}
-static DEVICE_ATTR_RO(flags);
-
-static struct attribute *attrs[] = {
-	&dev_attr_flags.attr,
-	NULL,
-};
-
-static struct attribute_group attr_group = {
-	.attrs = attrs,
-};
-
 #ifdef CONFIG_COMMON_CLK
 #define sqw_to_m41t80_data(_hw) container_of(_hw, struct m41t80_data, sqw)
 
@@ -912,13 +890,6 @@ static struct notifier_block wdt_notifier = {
  *****************************************************************************
  */
 
-static void m41t80_remove_sysfs_group(void *_dev)
-{
-	struct device *dev = _dev;
-
-	sysfs_remove_group(&dev->kobj, &attr_group);
-}
-
 static int m41t80_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -1015,21 +986,6 @@ static int m41t80_probe(struct i2c_client *client,
 		return rc;
 	}
 
-	/* Export sysfs entries */
-	rc = sysfs_create_group(&(&client->dev)->kobj, &attr_group);
-	if (rc) {
-		dev_err(&client->dev, "Failed to create sysfs group: %d\n", rc);
-		return rc;
-	}
-
-	rc = devm_add_action_or_reset(&client->dev, m41t80_remove_sysfs_group,
-				      &client->dev);
-	if (rc) {
-		dev_err(&client->dev,
-			"Failed to add sysfs cleanup action: %d\n", rc);
-		return rc;
-	}
-
 #ifdef CONFIG_RTC_DRV_M41T80_WDT
 	if (m41t80_data->features & M41T80_FEATURE_HT) {
 		save_client = client;
-- 
2.14.1
