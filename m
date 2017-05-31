Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36331 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdEaVdk (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 31 May 2017 17:33:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id k15so6651051wmh.3
        for <linux-rtc@vger.kernel.org>; Wed, 31 May 2017 14:33:39 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 4/4] rtc: ds1307: change nvram handling to use the nvmem
 subsystem
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <85789383-af9c-fdbb-ff58-121d9fd432f5@gmail.com>
Message-ID: <b3c31254-a77f-9327-aca2-ff31d994e535@gmail.com>
Date: Wed, 31 May 2017 23:33:23 +0200
MIME-Version: 1.0
In-Reply-To: <85789383-af9c-fdbb-ff58-121d9fd432f5@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The open coded handling of attribute nvram is from 2007 when the
nvmem subsystem obviously didn't exist yet.

Now we can use nvmem to simplify the driver. A side effect is that
attribute nvram is replaced with an attribute nvmem.
This might break user space applications. However attribute nvram
is nowhere officially documented.

This patch is compile-tested only as I lack hardware with nvram.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 94 ++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 63 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 79160027..352694c4 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -25,6 +25,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
+#include <linux/nvmem-provider.h>
 
 /*
  * We can't determine type by probing, but if we expect pre-Linux code
@@ -116,11 +117,10 @@ struct ds1307 {
 	u8			offset; /* register's offset */
 	u8			regs[11];
 	u16			nvram_offset;
-	struct bin_attribute	*nvram;
+	struct nvmem_device	*nvram;
 	enum ds_type		type;
 	unsigned long		flags;
-#define HAS_NVRAM	0		/* bit 0 == sysfs file active */
-#define HAS_ALARM	1		/* bit 1 == irq claimed */
+#define HAS_ALARM	0		/* bit 0 == irq claimed */
 	struct device		*dev;
 	struct regmap		*regmap;
 	const char		*name;
@@ -676,43 +676,24 @@ static const struct rtc_class_ops mcp794xx_rtc_ops = {
 
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
-
-	ds1307 = dev_get_drvdata(kobj_to_dev(kobj));
+	struct ds1307 *ds1307 = priv;
 
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
@@ -1476,36 +1457,23 @@ static int ds1307_probe(struct i2c_client *client,
 	}
 
 	if (chip->nvram_size) {
-
-		ds1307->nvram = devm_kzalloc(ds1307->dev,
-					sizeof(struct bin_attribute),
-					GFP_KERNEL);
-		if (!ds1307->nvram) {
-			dev_err(ds1307->dev,
-				"cannot allocate memory for nvram sysfs\n");
+		struct nvmem_config nvram_cfg = {
+			.dev = ds1307->dev,
+			.reg_read = ds1307_nvram_read,
+			.reg_write = ds1307_nvram_write,
+			.size = chip->nvram_size,
+			.word_size = 1,
+			.stride = 1,
+			.priv = ds1307,
+		};
+
+		ds1307->nvram = nvmem_register(&nvram_cfg);
+		if (IS_ERR(ds1307->nvram)) {
+			dev_err(ds1307->dev, "unable to register nvmem\n");
+			ds1307->nvram = NULL;
 		} else {
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
+			dev_info(ds1307->dev, "%d bytes nvram\n",
+				 chip->nvram_size);
 		}
 	}
 
@@ -1522,8 +1490,8 @@ static int ds1307_remove(struct i2c_client *client)
 {
 	struct ds1307 *ds1307 = i2c_get_clientdata(client);
 
-	if (test_and_clear_bit(HAS_NVRAM, &ds1307->flags))
-		sysfs_remove_bin_file(&ds1307->dev->kobj, ds1307->nvram);
+	if (ds1307->nvram)
+		nvmem_unregister(ds1307->nvram);
 
 	return 0;
 }
-- 
2.13.0
