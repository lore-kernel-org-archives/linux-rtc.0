Return-Path: <rtc-linux+bncBDM47J4M6QEBBIUHSLCQKGQEDJHYVTI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from dukecmmtar03.coxmail.com (dukecmmtar03.coxmail.com. [68.99.120.44])
        by gmr-mx.google.com with ESMTP id h130si317705pfe.1.2017.02.15.08.36.50
        for <rtc-linux@googlegroups.com>;
        Wed, 15 Feb 2017 08:36:50 -0800 (PST)
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: rtc-linux@googlegroups.com
Cc: alex@digriz.org.uk,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 5/5] rtc: m48t86: remove unused platform_data
Date: Wed, 15 Feb 2017 09:35:27 -0700
Message-Id: <20170215163527.5697-6-hsweeten@visionengravers.com>
In-Reply-To: <20170215163527.5697-1-hsweeten@visionengravers.com>
References: <20170215163527.5697-1-hsweeten@visionengravers.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

All users of this driver have been updated to allow the driver to
manage it's own resources and do the read/write operations internally.
The m48t86_ops are no longer used.

Remove the platform_data header and the support code in the driver.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
---
 drivers/rtc/rtc-m48t86.c                 | 51 ++++++++++++--------------------
 include/linux/platform_data/rtc-m48t86.h | 16 ----------
 2 files changed, 19 insertions(+), 48 deletions(-)
 delete mode 100644 include/linux/platform_data/rtc-m48t86.h

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 41ac5d6..a959fe4 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/rtc-m48t86.h>
 #include <linux/bcd.h>
 #include <linux/io.h>
 
@@ -45,7 +44,6 @@ struct m48t86_rtc_info {
 	void __iomem *index_reg;
 	void __iomem *data_reg;
 	struct rtc_device *rtc;
-	struct m48t86_ops *ops;
 };
 
 static unsigned char m48t86_readb(struct device *dev, unsigned long addr)
@@ -53,12 +51,9 @@ static unsigned char m48t86_readb(struct device *dev, unsigned long addr)
 	struct m48t86_rtc_info *info = dev_get_drvdata(dev);
 	unsigned char value;
 
-	if (info->ops) {
-		value = info->ops->readbyte(addr);
-	} else {
-		writeb(addr, info->index_reg);
-		value = readb(info->data_reg);
-	}
+	writeb(addr, info->index_reg);
+	value = readb(info->data_reg);
+
 	return value;
 }
 
@@ -67,12 +62,8 @@ static void m48t86_writeb(struct device *dev,
 {
 	struct m48t86_rtc_info *info = dev_get_drvdata(dev);
 
-	if (info->ops) {
-		info->ops->writebyte(value, addr);
-	} else {
-		writeb(addr, info->index_reg);
-		writeb(value, info->data_reg);
-	}
+	writeb(addr, info->index_reg);
+	writeb(value, info->data_reg);
 }
 
 static int m48t86_rtc_read_time(struct device *dev, struct rtc_time *tm)
@@ -235,30 +226,26 @@ static bool m48t86_verify_chip(struct platform_device *pdev)
 static int m48t86_rtc_probe(struct platform_device *pdev)
 {
 	struct m48t86_rtc_info *info;
+	struct resource *res;
 	unsigned char reg;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	info->ops = dev_get_platdata(&pdev->dev);
-	if (!info->ops) {
-		struct resource *res;
-
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!res)
-			return -ENODEV;
-		info->index_reg = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(info->index_reg))
-			return PTR_ERR(info->index_reg);
-
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		if (!res)
-			return -ENODEV;
-		info->data_reg = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(info->data_reg))
-			return PTR_ERR(info->data_reg);
-	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+	info->index_reg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(info->index_reg))
+		return PTR_ERR(info->index_reg);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -ENODEV;
+	info->data_reg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(info->data_reg))
+		return PTR_ERR(info->data_reg);
 
 	dev_set_drvdata(&pdev->dev, info);
 
diff --git a/include/linux/platform_data/rtc-m48t86.h b/include/linux/platform_data/rtc-m48t86.h
deleted file mode 100644
index 915d6b4..0000000
--- a/include/linux/platform_data/rtc-m48t86.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * ST M48T86 / Dallas DS12887 RTC driver
- * Copyright (c) 2006 Tower Technologies
- *
- * Author: Alessandro Zummo <a.zummo@towertech.it>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-struct m48t86_ops
-{
-	void (*writebyte)(unsigned char value, unsigned long addr);
-	unsigned char (*readbyte)(unsigned long addr);
-};
-- 
2.10.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
