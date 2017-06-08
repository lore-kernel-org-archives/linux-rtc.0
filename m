Return-Path: <rtc-linux+bncBAABBUWR4TEQKGQEIKAOXXI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail02.prevas.se (mail02.prevas.se. [62.95.78.10])
        by gmr-mx.google.com with ESMTPS id f198si413090wme.6.2017.06.08.03.37.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2017 03:37:06 -0700 (PDT)
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <rtc-linux@googlegroups.com>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [rtc-linux] [PATCH 1/2] rtc: ds1307: add ds1308 variant
Date: Thu, 8 Jun 2017 12:36:54 +0200
Message-ID: <20170608103655.20043-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The ds1308 variant is very similar to the already supported ds1338
variant, it have more debug registers and a square wave clock output.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 drivers/rtc/rtc-ds1307.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 16ace2fb0c0a..a4ef03ad9395 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -34,6 +34,7 @@
  */
 enum ds_type {
 	ds_1307,
+	ds_1308,
 	ds_1337,
 	ds_1338,
 	ds_1339,
@@ -148,6 +149,10 @@ static struct chip_desc chips[last_ds_type] = {
 		.nvram_offset	= 8,
 		.nvram_size	= 56,
 	},
+	[ds_1308] = {
+		.nvram_offset	= 8,
+		.nvram_size	= 56,
+	},
 	[ds_1337] = {
 		.alarm		= 1,
 	},
@@ -179,6 +184,7 @@ static struct chip_desc chips[last_ds_type] = {
 
 static const struct i2c_device_id ds1307_id[] = {
 	{ "ds1307", ds_1307 },
+	{ "ds1308", ds_1308 },
 	{ "ds1337", ds_1337 },
 	{ "ds1338", ds_1338 },
 	{ "ds1339", ds_1339 },
@@ -203,6 +209,10 @@ static const struct of_device_id ds1307_of_match[] = {
 		.data = (void *)ds_1307
 	},
 	{
+		.compatible = "dallas,ds1308",
+		.data = (void *)ds_1308
+	},
+	{
 		.compatible = "dallas,ds1337",
 		.data = (void *)ds_1337
 	},
@@ -262,6 +272,7 @@ MODULE_DEVICE_TABLE(of, ds1307_of_match);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id ds1307_acpi_ids[] = {
 	{ .id = "DS1307", .driver_data = ds_1307 },
+	{ .id = "DS1308", .driver_data = ds_1308 },
 	{ .id = "DS1337", .driver_data = ds_1337 },
 	{ .id = "DS1338", .driver_data = ds_1338 },
 	{ .id = "DS1339", .driver_data = ds_1339 },
@@ -1442,6 +1453,7 @@ static int ds1307_probe(struct i2c_client *client,
 			goto read_rtc;
 		}
 		break;
+	case ds_1308:
 	case ds_1338:
 		/* clock halted?  turn it on, so clock can tick. */
 		if (tmp & DS1307_BIT_CH)
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
