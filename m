Return-Path: <rtc-linux+bncBCPM5SUWUYIRBEM5TO3QKGQE3I7YBJQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com. [2607:f8b0:400e:c00::243])
        by gmr-mx.google.com with ESMTPS id sf5si3328105pac.1.2016.03.14.07.45.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Mar 2016 07:45:37 -0700 (PDT)
Received: by mail-pf0-x243.google.com with SMTP id n5so7998572pfn.1
        for <rtc-linux@googlegroups.com>; Mon, 14 Mar 2016 07:45:36 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH v2 3/3] rtc: pcf2127: add pcf2129 device id
Date: Mon, 14 Mar 2016 23:45:01 +0900
Message-Id: <1457966701-6532-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1457966701-6532-1-git-send-email-akinobu.mita@gmail.com>
References: <1457966701-6532-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

There are only a few differences between PCF2127 and PCF2129 (PCF2127
has 512 bytes of general purpose SRAM and count-down timer).

The rtc-pcf2127 driver currently doesn't use the PCF2127 specific
functionality and Kconfig help text already says this driver supports
PCF2127/29, so we can simply add pcf2129 to device id list.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
* No changes from v1

 drivers/rtc/rtc-pcf2127.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 194c440..2bfdf63 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -1,12 +1,12 @@
 /*
- * An I2C and SPI driver for the NXP PCF2127 RTC
+ * An I2C and SPI driver for the NXP PCF2127/29 RTC
  * Copyright 2013 Til-Technologies
  *
  * Author: Renaud Cerrato <r.cerrato@til-technologies.fr>
  *
  * based on the other drivers in this same directory.
  *
- * http://www.nxp.com/documents/data_sheet/PCF2127AT.pdf
+ * Datasheet: http://cache.nxp.com/documents/data_sheet/PCF2127.pdf
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -196,6 +196,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 #ifdef CONFIG_OF
 static const struct of_device_id pcf2127_of_match[] = {
 	{ .compatible = "nxp,pcf2127" },
+	{ .compatible = "nxp,pcf2129" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pcf2127_of_match);
@@ -302,6 +303,7 @@ static int pcf2127_i2c_probe(struct i2c_client *client,
 
 static const struct i2c_device_id pcf2127_i2c_id[] = {
 	{ "pcf2127", 0 },
+	{ "pcf2129", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pcf2127_i2c_id);
@@ -364,6 +366,7 @@ static int pcf2127_spi_probe(struct spi_device *spi)
 
 static const struct spi_device_id pcf2127_spi_id[] = {
 	{ "pcf2127", 0 },
+	{ "pcf2129", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, pcf2127_spi_id);
@@ -428,5 +431,5 @@ static void __exit pcf2127_exit(void)
 module_exit(pcf2127_exit)
 
 MODULE_AUTHOR("Renaud Cerrato <r.cerrato@til-technologies.fr>");
-MODULE_DESCRIPTION("NXP PCF2127 RTC driver");
+MODULE_DESCRIPTION("NXP PCF2127/29 RTC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.5.0

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
