Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:38504 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbdHWFif (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 23 Aug 2017 01:38:35 -0400
Received: by mail-lf0-f49.google.com with SMTP id y15so2772144lfd.5
        for <linux-rtc@vger.kernel.org>; Tue, 22 Aug 2017 22:38:34 -0700 (PDT)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        David Lowe <dave-lowe@ntlworld.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Marek Vasut <marex@denx.de>, Tin Huynh <tnhuynh@apm.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] rtc: ds1307: add basic support for ds1341 chip
Date: Wed, 23 Aug 2017 08:38:25 +0300
Message-Id: <20170823053825.19841-1-nikita.yoush@cogentembedded.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This adds support for reading and writing date/time from/to ds1314 chip.

Other functionality (alarms, inout clock, output clock) is not added
yet, because availability of that depends on chip connections.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/rtc/Kconfig      | 10 +++++-----
 drivers/rtc/rtc-ds1307.c | 13 +++++++++++++
 2 files changed, 18 insertions(+), 5 deletions(-)
===
DS1341/1342 chips have additional features, namely
- alarms,
- input clock (can be used instead of intercal oscillator for better
  accuracy),
- output clock ("square wave generation")

However, not all of that is available at the same time. Same chip pins,
CLKIN/nINTA and SQW/nINTB, can be used either for input/output clocks,
or for alarm interrupts. Role of these pins on particular board depends
on hardware wiring.

We can add device tree properties that describe if each of pins is wired
as clock, or as interrupt, or left unconnected, and enable support for
corresponding functionality based on that. But that requires hardware setups
for testing, and also is somewhat cumbersome. Additional complexity is
caused by bit enabling/disabling output clock also affects which pins alarm
interrupts are routed to.

Another factor is that there are hardware setups (i.e. ZII RDU2) that
power DS1341 from SuperCap, which makes power saving critical. For such
setups, kernel driver should leave register bits that control mentioned
pins in the state configured by bootloader.

Given all that, it was decided to limit support to "only date/time" for
now. That is enough for common use case. Full (and cumbersome) implementation
can be added later if ever needed.

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 72419ac2c52a..db63592a0f57 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -227,14 +227,14 @@ config RTC_DRV_AS3722
 	  will be called rtc-as3722.
 
 config RTC_DRV_DS1307
-	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00, EPSON RX-8025, ISL12057"
+	tristate "Dallas/Maxim DS1307/37/38/39/40/41, ST M41T00, EPSON RX-8025, ISL12057"
 	help
 	  If you say yes here you get support for various compatible RTC
 	  chips (often with battery backup) connected with I2C. This driver
-	  should handle DS1307, DS1337, DS1338, DS1339, DS1340, ST M41T00,
-	  EPSON RX-8025, Intersil ISL12057 and probably other chips. In some
-	  cases the RTC must already have been initialized (by manufacturing or
-	  a bootloader).
+	  should handle DS1307, DS1337, DS1338, DS1339, DS1340, DS1341,
+	  ST M41T00, EPSON RX-8025, Intersil ISL12057 and probably other chips.
+	  In some cases the RTC must already have been initialized (by
+	  manufacturing or a bootloader).
 
 	  The first seven registers on these chips hold an RTC, and other
 	  registers may add features such as NVRAM, a trickle charger for
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 4fac49e55d47..1d11f8000f8a 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -39,6 +39,7 @@ enum ds_type {
 	ds_1338,
 	ds_1339,
 	ds_1340,
+	ds_1341,
 	ds_1388,
 	ds_3231,
 	m41t0,
@@ -179,6 +180,10 @@ static struct chip_desc chips[last_ds_type] = {
 		.century_bit	= DS1340_BIT_CENTURY,
 		.trickle_charger_reg = 0x08,
 	},
+	[ds_1341] = {
+		.century_reg	= DS1307_REG_MONTH,
+		.century_bit	= DS1337_BIT_CENTURY,
+	},
 	[ds_1388] = {
 		.trickle_charger_reg = 0x0a,
 	},
@@ -209,6 +214,7 @@ static const struct i2c_device_id ds1307_id[] = {
 	{ "ds1339", ds_1339 },
 	{ "ds1388", ds_1388 },
 	{ "ds1340", ds_1340 },
+	{ "ds1341", ds_1341 },
 	{ "ds3231", ds_3231 },
 	{ "m41t0", m41t0 },
 	{ "m41t00", m41t00 },
@@ -253,6 +259,10 @@ static const struct of_device_id ds1307_of_match[] = {
 		.data = (void *)ds_1340
 	},
 	{
+		.compatible = "dallas,ds1341",
+		.data = (void *)ds_1341
+	},
+	{
 		.compatible = "maxim,ds3231",
 		.data = (void *)ds_3231
 	},
@@ -298,6 +308,7 @@ static const struct acpi_device_id ds1307_acpi_ids[] = {
 	{ .id = "DS1339", .driver_data = ds_1339 },
 	{ .id = "DS1388", .driver_data = ds_1388 },
 	{ .id = "DS1340", .driver_data = ds_1340 },
+	{ .id = "DS1341", .driver_data = ds_1341 },
 	{ .id = "DS3231", .driver_data = ds_3231 },
 	{ .id = "M41T0", .driver_data = m41t0 },
 	{ .id = "M41T00", .driver_data = m41t00 },
@@ -1323,6 +1334,7 @@ static int ds1307_probe(struct i2c_client *client,
 	static const int	bbsqi_bitpos[] = {
 		[ds_1337] = 0,
 		[ds_1339] = DS1339_BIT_BBSQI,
+		[ds_1341] = 0,
 		[ds_3231] = DS3231_BIT_BBSQW,
 	};
 	const struct rtc_class_ops *rtc_ops = &ds13xx_rtc_ops;
@@ -1401,6 +1413,7 @@ static int ds1307_probe(struct i2c_client *client,
 	switch (ds1307->type) {
 	case ds_1337:
 	case ds_1339:
+	case ds_1341:
 	case ds_3231:
 		/* get registers that the "rtc" read below won't read... */
 		err = regmap_bulk_read(ds1307->regmap, DS1337_REG_CONTROL,
-- 
2.11.0
