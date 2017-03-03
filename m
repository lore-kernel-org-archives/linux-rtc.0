Return-Path: <rtc-linux+bncBAABB3734XCQKGQEXDE7T2A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from osg.samsung.com (ec2-52-27-115-49.us-west-2.compute.amazonaws.com. [52.27.115.49])
        by gmr-mx.google.com with ESMTP id y90si59817pfa.6.2017.03.03.06.30.06
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Mar 2017 06:30:06 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH 12/13] rtc: m41t80: Add OF device ID table
Date: Fri,  3 Mar 2017 11:29:23 -0300
Message-Id: <20170303142925.17915-13-javier@osg.samsung.com>
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

 drivers/rtc/rtc-m41t80.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 58698d21c2c3..5b070aa711f9 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
@@ -86,8 +87,61 @@ static const struct i2c_device_id m41t80_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, m41t80_id);
 
+static const struct of_device_id m41t80_of_match[] = {
+	{
+		.compatible = "st,m41t62",
+		.data = (void *)(M41T80_FEATURE_SQ | M41T80_FEATURE_SQ_ALT)
+	},
+	{
+		.compatible = "st,m41t65",
+		.data = (void *)(M41T80_FEATURE_HT | M41T80_FEATURE_WD)
+	},
+	{
+		.compatible = "st,m41t80",
+		.data = (void *)(M41T80_FEATURE_SQ)
+	},
+	{
+		.compatible = "st,m41t81",
+		.data = (void *)(M41T80_FEATURE_HT | M41T80_FEATURE_SQ)
+	},
+	{
+		.compatible = "st,m41t81s",
+		.data = (void *)(M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ)
+	},
+	{
+		.compatible = "st,m41t82",
+		.data = (void *)(M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ)
+	},
+	{
+		.compatible = "st,m41t83",
+		.data = (void *)(M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ)
+	},
+	{
+		.compatible = "st,m41t84",
+		.data = (void *)(M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ)
+	},
+	{
+		.compatible = "st,m41t85",
+		.data = (void *)(M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ)
+	},
+	{
+		.compatible = "st,m41t87",
+		.data = (void *)(M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ)
+	},
+	{
+		.compatible = "st,rv4162",
+		.data = (void *)(M41T80_FEATURE_SQ | M41T80_FEATURE_WD | M41T80_FEATURE_SQ_ALT)
+	},
+	{
+		.compatible = "rv4162",
+		.data = (void *)(M41T80_FEATURE_SQ | M41T80_FEATURE_WD | M41T80_FEATURE_SQ_ALT)
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, m41t80_of_match);
+
 struct m41t80_data {
-	u8 features;
+	unsigned long features;
 	struct rtc_device *rtc;
 };
 
@@ -786,7 +840,11 @@ static int m41t80_probe(struct i2c_client *client,
 	if (!m41t80_data)
 		return -ENOMEM;
 
-	m41t80_data->features = id->driver_data;
+	if (client->dev.of_node)
+		m41t80_data->features = (unsigned long)
+			of_device_get_match_data(&client->dev);
+	else
+		m41t80_data->features = id->driver_data;
 	i2c_set_clientdata(client, m41t80_data);
 
 	if (client->irq > 0) {
@@ -894,6 +952,7 @@ static int m41t80_remove(struct i2c_client *client)
 static struct i2c_driver m41t80_driver = {
 	.driver = {
 		.name = "rtc-m41t80",
+		.of_match_table = of_match_ptr(m41t80_of_match),
 		.pm = &m41t80_pm,
 	},
 	.probe = m41t80_probe,
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
