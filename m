Return-Path: <rtc-linux+bncBAABB4P34XCQKGQE2ORVDMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from osg.samsung.com (ec2-52-27-115-49.us-west-2.compute.amazonaws.com. [52.27.115.49])
        by gmr-mx.google.com with ESMTP id s64si69837pfk.0.2017.03.03.06.30.09
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Mar 2017 06:30:09 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH 13/13] rtc: rs5c372: Add OF device ID table
Date: Fri,  3 Mar 2017 11:29:24 -0300
Message-Id: <20170303142925.17915-14-javier@osg.samsung.com>
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

 drivers/rtc/rtc-rs5c372.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index c8c757466783..d4eff8d7131f 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -15,6 +15,7 @@
 #include <linux/bcd.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 
 /*
  * Ricoh has a family of I2C based RTCs, which differ only slightly from
@@ -83,6 +84,35 @@ static const struct i2c_device_id rs5c372_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rs5c372_id);
 
+static const struct of_device_id rs5c372_of_match[] = {
+	{
+		.compatible = "ricoh,r2025sd",
+		.data = (void *)rtc_r2025sd
+	},
+	{
+		.compatible = "ricoh,r2221tl",
+		.data = (void *)rtc_r2221tl
+	},
+	{
+		.compatible = "ricoh,rs5c372a",
+		.data = (void *)rtc_rs5c372a
+	},
+	{
+		.compatible = "ricoh,rs5c372b",
+		.data = (void *)rtc_rs5c372b
+	},
+	{
+		.compatible = "ricoh,rv5c386",
+		.data = (void *)rtc_rv5c386
+	},
+	{
+		.compatible = "ricoh,rv5c387a",
+		.data = (void *)rtc_rv5c387a
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rs5c372_of_match);
+
 /* REVISIT:  this assumes that:
  *  - we're in the 21st century, so it's safe to ignore the century
  *    bit for rv5c38[67] (REG_MONTH bit 7);
@@ -581,7 +611,11 @@ static int rs5c372_probe(struct i2c_client *client,
 
 	rs5c372->client = client;
 	i2c_set_clientdata(client, rs5c372);
-	rs5c372->type = id->driver_data;
+	if (client->dev.of_node)
+		rs5c372->type = (enum rtc_type)
+			of_device_get_match_data(&client->dev);
+	else
+		rs5c372->type = id->driver_data;
 
 	/* we read registers 0x0f then 0x00-0x0f; skip the first one */
 	rs5c372->regs = &rs5c372->buf[1];
@@ -673,6 +707,7 @@ static int rs5c372_remove(struct i2c_client *client)
 static struct i2c_driver rs5c372_driver = {
 	.driver		= {
 		.name	= "rtc-rs5c372",
+		.of_match_table = of_match_ptr(rs5c372_of_match),
 	},
 	.probe		= rs5c372_probe,
 	.remove		= rs5c372_remove,
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
