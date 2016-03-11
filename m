Return-Path: <rtc-linux+bncBCPM5SUWUYIRBTPBRO3QKGQEM5EM2TQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com. [2607:f8b0:400e:c03::22c])
        by gmr-mx.google.com with ESMTPS id ui7si1463890pab.0.2016.03.11.08.22.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Mar 2016 08:22:37 -0800 (PST)
Received: by mail-pa0-x22c.google.com with SMTP id tt10so102462448pab.3
        for <rtc-linux@googlegroups.com>; Fri, 11 Mar 2016 08:22:37 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Renaud Cerrato <r.cerrato@til-technologies.fr>
Subject: [rtc-linux] [PATCH 3/3] rtc: pcf2127: add pcf2129 device id
Date: Sat, 12 Mar 2016 01:22:16 +0900
Message-Id: <1457713336-24262-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1457713336-24262-1-git-send-email-akinobu.mita@gmail.com>
References: <1457713336-24262-1-git-send-email-akinobu.mita@gmail.com>
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
Cc: Renaud Cerrato <r.cerrato@til-technologies.fr>
---
 drivers/rtc/rtc-pcf2127.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 5729ee9..2dc1690 100644
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
@@ -297,6 +298,7 @@ static int pcf2127_i2c_probe(struct i2c_client *client,
 
 static const struct i2c_device_id pcf2127_i2c_id[] = {
 	{ "pcf2127", 0 },
+	{ "pcf2129", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pcf2127_i2c_id);
@@ -359,6 +361,7 @@ static int pcf2127_spi_probe(struct spi_device *spi)
 
 static const struct spi_device_id pcf2127_spi_id[] = {
 	{ "pcf2127", 0 },
+	{ "pcf2129", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, pcf2127_spi_id);
@@ -423,5 +426,5 @@ static void __exit pcf2127_exit(void)
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
