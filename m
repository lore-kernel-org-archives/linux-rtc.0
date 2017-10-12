Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52729 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755110AbdJLWFe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 18:05:34 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 3/3] rtc: ds1511: use generic nvmem
Date: Fri, 13 Oct 2017 00:05:29 +0200
Message-Id: <20171012220529.8142-3-alexandre.belloni@free-electrons.com>
In-Reply-To: <20171012220529.8142-1-alexandre.belloni@free-electrons.com>
References: <20171012220529.8142-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Instead of adding a binary sysfs attribute from the driver (which suffers
from a race condition as the attribute appears after the device), use the
core to register an nvmem device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1511.c | 58 ++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 36 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index eda45358d63a..1e95312a6f2e 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -398,42 +398,37 @@ static const struct rtc_class_ops ds1511_rtc_ops = {
 	.alarm_irq_enable	= ds1511_rtc_alarm_irq_enable,
 };
 
-static ssize_t
-ds1511_nvram_read(struct file *filp, struct kobject *kobj,
-		  struct bin_attribute *ba,
-		  char *buf, loff_t pos, size_t size)
+static int ds1511_nvram_read(void *priv, unsigned int pos, void *buf,
+			     size_t size)
 {
-	ssize_t count;
+	int i;
 
 	rtc_write(pos, DS1511_RAMADDR_LSB);
-	for (count = 0; count < size; count++)
-		*buf++ = rtc_read(DS1511_RAMDATA);
+	for (i = 0; i < size; i++)
+		*(char *)buf++ = rtc_read(DS1511_RAMDATA);
 
-	return count;
+	return 0;
 }
 
-static ssize_t
-ds1511_nvram_write(struct file *filp, struct kobject *kobj,
-		   struct bin_attribute *bin_attr,
-		   char *buf, loff_t pos, size_t size)
+static int ds1511_nvram_write(void *priv, unsigned int pos, void *buf,
+			      size_t size)
 {
-	ssize_t count;
+	int i;
 
 	rtc_write(pos, DS1511_RAMADDR_LSB);
-	for (count = 0; count < size; count++)
-		rtc_write(*buf++, DS1511_RAMDATA);
+	for (i = 0; i < size; i++)
+		rtc_write(*(char *)buf++, DS1511_RAMDATA);
 
-	return count;
+	return 0;
 }
 
-static struct bin_attribute ds1511_nvram_attr = {
-	.attr = {
-		.name = "nvram",
-		.mode = S_IRUGO | S_IWUSR,
-	},
+static struct nvmem_config ds1511_nvmem_cfg = {
+	.name = "ds1511_nvram",
+	.word_size = 1,
+	.stride = 1,
 	.size = DS1511_RAM_MAX,
-	.read = ds1511_nvram_read,
-	.write = ds1511_nvram_write,
+	.reg_read = ds1511_nvram_read,
+	.reg_write = ds1511_nvram_write,
 };
 
 static int ds1511_rtc_probe(struct platform_device *pdev)
@@ -483,6 +478,10 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 
 	pdata->rtc->ops = &ds1511_rtc_ops;
 
+	ds1511_nvmem_cfg.priv = &pdev->dev;
+	pdata->rtc->nvmem_config = &ds1511_nvmem_cfg;
+	pdata->rtc->nvram_old_abi = true;
+
 	ret = rtc_register_device(pdata->rtc);
 	if (ret)
 		return ret;
@@ -501,18 +500,6 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = sysfs_create_bin_file(&pdev->dev.kobj, &ds1511_nvram_attr);
-	if (ret)
-		dev_err(&pdev->dev, "Unable to create sysfs entry: %s\n",
-			ds1511_nvram_attr.attr.name);
-
-	return 0;
-}
-
-static int ds1511_rtc_remove(struct platform_device *pdev)
-{
-	sysfs_remove_bin_file(&pdev->dev.kobj, &ds1511_nvram_attr);
-
 	return 0;
 }
 
@@ -521,7 +508,6 @@ MODULE_ALIAS("platform:ds1511");
 
 static struct platform_driver ds1511_rtc_driver = {
 	.probe		= ds1511_rtc_probe,
-	.remove		= ds1511_rtc_remove,
 	.driver		= {
 		.name	= "ds1511",
 	},
-- 
2.14.2
