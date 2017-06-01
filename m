Return-Path: <rtc-linux+bncBDQ4HRP464MRBSMBY7EQKGQED43TZNQ@googlegroups.com>
Resent-Message-ID: <20170602194649.qva34oyasagk2g6k@piout.net>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34503 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdFATJm (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 1 Jun 2017 15:09:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so13608013wmf.1
        for <linux-rtc@vger.kernel.org>; Thu, 01 Jun 2017 12:09:42 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [rtc-linux] [PATCH v2 4/4] rtc: ds1307: change nvram handling to use
 the nvmem subsystem
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <22e48dc3-5d08-681c-5eed-d7c0e4552267@gmail.com>
Message-ID: <1785cfc0-edfd-6e2d-8e5e-169c212faca2@gmail.com>
Date: Thu, 1 Jun 2017 21:09:24 +0200
MIME-Version: 1.0
In-Reply-To: <22e48dc3-5d08-681c-5eed-d7c0e4552267@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>
Reply-To: rtc-linux@googlegroups.com

The open coded handling of attribute nvram is from 2007 when the
nvmem subsystem obviously didn't exist yet.

Now we can use nvmem to simplify the driver. A side effect is that
attribute nvram is replaced. New location is:
/sys/bus/nvmem/devices/rtc_nvram0/nvmem

This might break user space applications. However attribute nvram
is nowhere officially documented and I'm not sure whether anybody
is actually using the few nvram bytes on a rtc chip.

This patch is compile-tested only as I lack hardware with nvram.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- embed nvmem_config structure part in struct ds1307
- set name and owner members of struct nvmem_config
---
 drivers/rtc/rtc-ds1307.c | 95 ++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 63 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 79160027..cc81a5ea 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -25,6 +25,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
+#include <linux/nvmem-provider.h>
 
 /*
  * We can't determine type by probing, but if we expect pre-Linux code
@@ -116,11 +117,11 @@ struct ds1307 {
 	u8			offset; /* register's offset */
 	u8			regs[11];
 	u16			nvram_offset;
-	struct bin_attribute	*nvram;
+	struct nvmem_config	nvram_cfg;
+	struct nvmem_device	*nvram;
 	enum ds_type		type;
 	unsigned long		flags;
-#define HAS_NVRAM	0		/* bit 0 == sysfs file active */
-#define HAS_ALARM	1		/* bit 1 == irq claimed */
+#define HAS_ALARM	0		/* bit 0 == irq claimed */
 	struct device		*dev;
 	struct regmap		*regmap;
 	const char		*name;
@@ -676,43 +677,24 @@ static const struct rtc_class_ops mcp794xx_rtc_ops = {
 
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
@@ -1476,36 +1458,23 @@ static int ds1307_probe(struct i2c_client *client,
 	}
 
 	if (chip->nvram_size) {
-
-		ds1307->nvram = devm_kzalloc(ds1307->dev,
-					sizeof(struct bin_attribute),
-					GFP_KERNEL);
-		if (!ds1307->nvram) {
-			dev_err(ds1307->dev,
-				"cannot allocate memory for nvram sysfs\n");
+		ds1307->nvram_cfg.name = "ds1307_nvram";
+		ds1307->nvram_cfg.dev = ds1307->dev;
+		ds1307->nvram_cfg.reg_read = ds1307_nvram_read;
+		ds1307->nvram_cfg.reg_write = ds1307_nvram_write;
+		ds1307->nvram_cfg.size = chip->nvram_size;
+		ds1307->nvram_cfg.word_size = 1;
+		ds1307->nvram_cfg.stride = 1;
+		ds1307->nvram_cfg.priv = ds1307;
+		ds1307->nvram_cfg.owner = THIS_MODULE;
+
+		ds1307->nvram = nvmem_register(&ds1307->nvram_cfg);
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
 
@@ -1522,8 +1491,8 @@ static int ds1307_remove(struct i2c_client *client)
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


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
