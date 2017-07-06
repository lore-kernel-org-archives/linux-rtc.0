Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49170 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbdGFJmS (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 05:42:18 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 10/11] rtc: ds1307: use generic nvmem
Date: Thu,  6 Jul 2017 11:42:07 +0200
Message-Id: <20170706094208.16240-11-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
References: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Instead of adding a binary sysfs attribute from the driver (which suffers
from a race condition as the attribute appears after the device), use the
core to register an nvmem device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1307.c | 88 ++++++++++++------------------------------------
 1 file changed, 22 insertions(+), 66 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index bac920a50ece..6f91c11a5f03 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -117,7 +117,7 @@ struct ds1307 {
 	u8			offset; /* register's offset */
 	u8			regs[11];
 	u16			nvram_offset;
-	struct bin_attribute	*nvram;
+	struct nvmem_config	nvmem_cfg;
 	enum ds_type		type;
 	unsigned long		flags;
 #define HAS_NVRAM	0		/* bit 0 == sysfs file active */
@@ -885,43 +885,24 @@ static const struct rtc_class_ops mcp794xx_rtc_ops = {
 
 /*----------------------------------------------------------------------*/
 
-static ssize_t
-ds1307_nvram_read(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr,
-		char *buf, loff_t off, size_t count)
+static int ds1307_nvram_read(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
 {
-	struct ds1307		*ds1307;
-	int			result;
-
-	ds1307 = dev_get_drvdata(kobj_to_dev(kobj));
+	struct ds1307 *ds1307 = priv;
 
-	result = regmap_bulk_read(ds1307->regmap, ds1307->nvram_offset + off,
-				  buf, count);
-	if (result)
-		dev_err(ds1307->dev, "%s error %d\n", "nvram read", result);
-	return result;
+	return regmap_bulk_read(ds1307->regmap, ds1307->nvram_offset + offset,
+				val, bytes);
 }
 
-static ssize_t
-ds1307_nvram_write(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr,
-		char *buf, loff_t off, size_t count)
+static int ds1307_nvram_write(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
 {
-	struct ds1307		*ds1307;
-	int			result;
+	struct ds1307 *ds1307 = priv;
 
-	ds1307 = dev_get_drvdata(kobj_to_dev(kobj));
-
-	result = regmap_bulk_write(ds1307->regmap, ds1307->nvram_offset + off,
-				   buf, count);
-	if (result) {
-		dev_err(ds1307->dev, "%s error %d\n", "nvram write", result);
-		return result;
-	}
-	return count;
+	return regmap_bulk_write(ds1307->regmap, ds1307->nvram_offset + offset,
+				 val, bytes);
 }
 
-
 /*----------------------------------------------------------------------*/
 
 static u8 do_trickle_setup_ds1339(struct ds1307 *ds1307,
@@ -1693,37 +1674,17 @@ static int ds1307_probe(struct i2c_client *client,
 	}
 
 	if (chip->nvram_size) {
-
-		ds1307->nvram = devm_kzalloc(ds1307->dev,
-					sizeof(struct bin_attribute),
-					GFP_KERNEL);
-		if (!ds1307->nvram) {
-			dev_err(ds1307->dev,
-				"cannot allocate memory for nvram sysfs\n");
-		} else {
-
-			ds1307->nvram->attr.name = "nvram";
-			ds1307->nvram->attr.mode = S_IRUGO | S_IWUSR;
-
-			sysfs_bin_attr_init(ds1307->nvram);
-
-			ds1307->nvram->read = ds1307_nvram_read;
-			ds1307->nvram->write = ds1307_nvram_write;
-			ds1307->nvram->size = chip->nvram_size;
-			ds1307->nvram_offset = chip->nvram_offset;
-
-			err = sysfs_create_bin_file(&ds1307->dev->kobj,
-						    ds1307->nvram);
-			if (err) {
-				dev_err(ds1307->dev,
-					"unable to create sysfs file: %s\n",
-					ds1307->nvram->attr.name);
-			} else {
-				set_bit(HAS_NVRAM, &ds1307->flags);
-				dev_info(ds1307->dev, "%zu bytes nvram\n",
-					 ds1307->nvram->size);
-			}
-		}
+		ds1307->nvmem_cfg.name = "ds1307_nvram";
+		ds1307->nvmem_cfg.word_size = 1;
+		ds1307->nvmem_cfg.stride = 1;
+		ds1307->nvmem_cfg.size = chip->nvram_size;
+		ds1307->nvmem_cfg.reg_read = ds1307_nvram_read;
+		ds1307->nvmem_cfg.reg_write = ds1307_nvram_write;
+		ds1307->nvmem_cfg.priv = ds1307;
+		ds1307->nvram_offset = chip->nvram_offset;
+
+		ds1307->rtc->nvmem_config = &ds1307->nvmem_cfg;
+		ds1307->rtc->nvram_old_abi = true;
 	}
 
 	ds1307->rtc->ops = rtc_ops;
@@ -1742,11 +1703,6 @@ static int ds1307_probe(struct i2c_client *client,
 
 static int ds1307_remove(struct i2c_client *client)
 {
-	struct ds1307 *ds1307 = i2c_get_clientdata(client);
-
-	if (test_and_clear_bit(HAS_NVRAM, &ds1307->flags))
-		sysfs_remove_bin_file(&ds1307->dev->kobj, ds1307->nvram);
-
 	return 0;
 }
 
-- 
2.11.0
