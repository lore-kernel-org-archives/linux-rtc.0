Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35524 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbdFEP5z (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 5 Jun 2017 11:57:55 -0400
Received: by mail-wr0-f193.google.com with SMTP id g76so7839500wrd.2
        for <linux-rtc@vger.kernel.org>; Mon, 05 Jun 2017 08:57:54 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 4/4] rtc: ds1307: change nvram handling to use the nvmem
 subsystem
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <a8dce195-b22a-47ce-992d-6437ce4e8297@gmail.com>
Message-ID: <12ad1679-7152-6ad1-c241-9d4200b7ba12@gmail.com>
Date: Mon, 5 Jun 2017 17:57:46 +0200
MIME-Version: 1.0
In-Reply-To: <a8dce195-b22a-47ce-992d-6437ce4e8297@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The open coded handling of attribute nvram is from 2007 when the
nvmem subsystem obviously didn't exist yet.

Now we can use nvmem to simplify the driver. A side effect is that
attribute nvram is replaced. New location is:
/sys/bus/nvmem/devices/ds1307_nvram0/nvmem

This might break user space applications. However attribute nvram
is nowhere officially documented and I'm not sure whether anybody
is actually using the few nvram bytes on a rtc chip.

This patch is compile-tested only as I lack hardware with nvram.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- embed nvmem_config structure part in struct ds1307
- set name and owner members of struct nvmem_config
v3:
- extend Kconfig help text
- use IS_REACHABLE to not access the NVMEM API if ds1307 is
  built-in and NVMEM is a module. I don't use Kconfig dependencies
  because only few supported chips have NVRAM.
---
 drivers/rtc/Kconfig      |   5 ++-
 drivers/rtc/rtc-ds1307.c | 101 ++++++++++++++++++-----------------------------
 2 files changed, 42 insertions(+), 64 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8d3b9572..22ac31fd 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -219,8 +219,9 @@ config RTC_DRV_DS1307
 
 	  The first seven registers on these chips hold an RTC, and other
 	  registers may add features such as NVRAM, a trickle charger for
-	  the RTC/NVRAM backup power, and alarms. NVRAM is visible in
-	  sysfs, but other chip features may not be available.
+	  the RTC/NVRAM backup power, and alarms.
+	  If your chip has NVRAM and CONFIG_NVMEM is set then the NVRAM
+	  is accessible via sysfs.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds1307.
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 79160027..a2a90cd2 100644
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
@@ -676,42 +677,27 @@ static const struct rtc_class_ops mcp794xx_rtc_ops = {
 
 /*----------------------------------------------------------------------*/
 
-static ssize_t
-ds1307_nvram_read(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr,
-		char *buf, loff_t off, size_t count)
-{
-	struct ds1307		*ds1307;
-	int			result;
+#if IS_REACHABLE(CONFIG_NVMEM)
 
-	ds1307 = dev_get_drvdata(kobj_to_dev(kobj));
+static int ds1307_nvram_read(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
+{
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
 
+#endif
 
 /*----------------------------------------------------------------------*/
 
@@ -1475,39 +1461,28 @@ static int ds1307_probe(struct i2c_client *client,
 			dev_dbg(ds1307->dev, "got IRQ %d\n", client->irq);
 	}
 
+#if IS_REACHABLE(CONFIG_NVMEM)
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
+#endif
 
 	ds1307_hwmon_register(ds1307);
 	ds1307_clks_register(ds1307);
@@ -1522,8 +1497,10 @@ static int ds1307_remove(struct i2c_client *client)
 {
 	struct ds1307 *ds1307 = i2c_get_clientdata(client);
 
-	if (test_and_clear_bit(HAS_NVRAM, &ds1307->flags))
-		sysfs_remove_bin_file(&ds1307->dev->kobj, ds1307->nvram);
+#if IS_REACHABLE(CONFIG_NVMEM)
+	if (ds1307->nvram)
+		nvmem_unregister(ds1307->nvram);
+#endif
 
 	return 0;
 }
-- 
2.13.0
