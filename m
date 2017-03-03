Return-Path: <rtc-linux+bncBAABBWP34XCQKGQE6FBF34I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from osg.samsung.com (ec2-52-27-115-49.us-west-2.compute.amazonaws.com. [52.27.115.49])
        by gmr-mx.google.com with ESMTP id r66si55925pfb.7.2017.03.03.06.29.45
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Mar 2017 06:29:45 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH 04/13] rtc: ds1307: Add OF device ID table
Date: Fri,  3 Mar 2017 11:29:15 -0300
Message-Id: <20170303142925.17915-5-javier@osg.samsung.com>
In-Reply-To: <20170303142925.17915-1-javier@osg.samsung.com>
References: <20170303142925.17915-1-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/rtc/rtc-ds1307.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 4ad97be48043..f085b487bbe7 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/rtc/ds1307.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
@@ -192,6 +193,65 @@ static const struct i2c_device_id ds1307_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ds1307_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id ds1307_of_match[] = {
+	{
+		.compatible = "dallas,ds1307",
+		.data = (void *)ds_1307
+	},
+	{
+		.compatible = "dallas,ds1337",
+		.data = (void *)ds_1337
+	},
+	{
+		.compatible = "dallas,ds1338",
+		.data = (void *)ds_1338
+	},
+	{
+		.compatible = "dallas,ds1339",
+		.data = (void *)ds_1339
+	},
+	{
+		.compatible = "dallas,ds1388",
+		.data = (void *)ds_1388
+	},
+	{
+		.compatible = "dallas,ds1340",
+		.data = (void *)ds_1340
+	},
+	{
+		.compatible = "maxim,ds3231",
+		.data = (void *)ds_3231
+	},
+	{
+		.compatible = "st,m41t00",
+		.data = (void *)m41t00
+	},
+	{
+		.compatible = "microchip,mcp7940x",
+		.data = (void *)mcp794xx
+	},
+	{
+		.compatible = "microchip,mcp7941x",
+		.data = (void *)mcp794xx
+	},
+	{
+		.compatible = "pericom,pt7c4338",
+		.data = (void *)ds_1307
+	},
+	{
+		.compatible = "epson,rx8025",
+		.data = (void *)rx_8025
+	},
+	{
+		.compatible = "isil,isl12057",
+		.data = (void *)ds_1337
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ds1307_of_match);
+#endif
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id ds1307_acpi_ids[] = {
 	{ .id = "DS1307", .driver_data = ds_1307 },
@@ -1318,7 +1378,12 @@ static int ds1307_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, ds1307);
 
 	ds1307->client	= client;
-	if (id) {
+
+	if (client->dev.of_node) {
+		ds1307->type = (enum ds_type)
+			of_device_get_match_data(&client->dev);
+		chip = &chips[ds1307->type];
+	} else if (id) {
 		chip = &chips[id->driver_data];
 		ds1307->type = id->driver_data;
 	} else {
@@ -1711,6 +1776,7 @@ static int ds1307_remove(struct i2c_client *client)
 static struct i2c_driver ds1307_driver = {
 	.driver = {
 		.name	= "rtc-ds1307",
+		.of_match_table = of_match_ptr(ds1307_of_match),
 		.acpi_match_table = ACPI_PTR(ds1307_acpi_ids),
 	},
 	.probe		= ds1307_probe,
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
