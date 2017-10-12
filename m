Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52689 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756094AbdJLWEZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 18:04:25 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/2] rtc: m48t86: use generic nvmem
Date: Fri, 13 Oct 2017 00:04:21 +0200
Message-Id: <20171012220421.7784-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20171012220421.7784-1-alexandre.belloni@free-electrons.com>
References: <20171012220421.7784-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Instead of adding a binary sysfs attribute from the driver (which suffers
from a race condition as the attribute appears after the device), use the
core to register an nvmem device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-m48t86.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 22656a90cfc5..d9aea9b6d9cd 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -163,35 +163,30 @@ static const struct rtc_class_ops m48t86_rtc_ops = {
 	.proc		= m48t86_rtc_proc,
 };
 
-static ssize_t m48t86_nvram_read(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *attr,
-				 char *buf, loff_t off, size_t count)
+static int m48t86_nvram_read(void *priv, unsigned int off, void *buf,
+			     size_t count)
 {
-	struct device *dev = kobj_to_dev(kobj);
+	struct device *dev = priv;
 	unsigned int i;
 
 	for (i = 0; i < count; i++)
-		buf[i] = m48t86_readb(dev, M48T86_NVRAM(off + i));
+		((u8 *)buf)[i] = m48t86_readb(dev, M48T86_NVRAM(off + i));
 
-	return count;
+	return 0;
 }
 
-static ssize_t m48t86_nvram_write(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *attr,
-				  char *buf, loff_t off, size_t count)
+static int m48t86_nvram_write(void *priv, unsigned int off, void *buf,
+			      size_t count)
 {
-	struct device *dev = kobj_to_dev(kobj);
+	struct device *dev = priv;
 	unsigned int i;
 
 	for (i = 0; i < count; i++)
-		m48t86_writeb(dev, buf[i], M48T86_NVRAM(off + i));
+		m48t86_writeb(dev, ((u8 *)buf)[i], M48T86_NVRAM(off + i));
 
-	return count;
+	return 0;
 }
 
-static BIN_ATTR(nvram, 0644, m48t86_nvram_read, m48t86_nvram_write,
-		M48T86_NVRAM_LEN);
-
 /*
  * The RTC is an optional feature at purchase time on some Technologic Systems
  * boards. Verify that it actually exists by checking if the last two bytes
@@ -223,6 +218,15 @@ static bool m48t86_verify_chip(struct platform_device *pdev)
 	return false;
 }
 
+static struct nvmem_config m48t86_nvmem_cfg = {
+	.name = "m48t86_nvram",
+	.word_size = 1,
+	.stride = 1,
+	.size = M48T86_NVRAM_LEN,
+	.reg_read = m48t86_nvram_read,
+	.reg_write = m48t86_nvram_write,
+};
+
 static int m48t86_rtc_probe(struct platform_device *pdev)
 {
 	struct m48t86_rtc_info *info;
@@ -261,6 +265,10 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 
 	info->rtc->ops = &m48t86_rtc_ops;
 
+	m48t86_nvmem_cfg.priv = &pdev->dev;
+	info->rtc->nvmem_config = &m48t86_nvmem_cfg;
+	info->rtc->nvram_old_abi = true;
+
 	err = rtc_register_device(info->rtc);
 	if (err)
 		return err;
@@ -270,15 +278,6 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "battery %s\n",
 		 (reg & M48T86_D_VRT) ? "ok" : "exhausted");
 
-	if (device_create_bin_file(&pdev->dev, &bin_attr_nvram))
-		dev_err(&pdev->dev, "failed to create nvram sysfs entry\n");
-
-	return 0;
-}
-
-static int m48t86_rtc_remove(struct platform_device *pdev)
-{
-	device_remove_bin_file(&pdev->dev, &bin_attr_nvram);
 	return 0;
 }
 
@@ -287,7 +286,6 @@ static struct platform_driver m48t86_rtc_platform_driver = {
 		.name	= "rtc-m48t86",
 	},
 	.probe		= m48t86_rtc_probe,
-	.remove		= m48t86_rtc_remove,
 };
 
 module_platform_driver(m48t86_rtc_platform_driver);
-- 
2.14.2
