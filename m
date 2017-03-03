Return-Path: <rtc-linux+bncBAABBUX34XCQKGQENJDMTXI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from osg.samsung.com (ec2-52-27-115-49.us-west-2.compute.amazonaws.com. [52.27.115.49])
        by gmr-mx.google.com with ESMTP id h79si67510pfh.2.2017.03.03.06.29.38
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Mar 2017 06:29:38 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH 01/13] rtc: rv8803: Add OF device ID table
Date: Fri,  3 Mar 2017 11:29:12 -0300
Message-Id: <20170303142925.17915-2-javier@osg.samsung.com>
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

 drivers/rtc/rtc-rv8803.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index f9277e536f7e..9ad97ab29866 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/rtc.h>
 
 #define RV8803_I2C_TRY_COUNT		4
@@ -556,7 +557,11 @@ static int rv8803_probe(struct i2c_client *client,
 
 	mutex_init(&rv8803->flags_lock);
 	rv8803->client = client;
-	rv8803->type = id->driver_data;
+	if (client->dev.of_node)
+		rv8803->type = (enum rv8803_type)
+			of_device_get_match_data(&client->dev);
+	else
+		rv8803->type = id->driver_data;
 	i2c_set_clientdata(client, rv8803);
 
 	flags = rv8803_read_reg(client, RV8803_FLAG);
@@ -627,9 +632,23 @@ static const struct i2c_device_id rv8803_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rv8803_id);
 
+static const struct of_device_id rv8803_of_match[] = {
+	{
+		.compatible = "microcrystal,rv8803",
+		.data = (void *)rx_8900
+	},
+	{
+		.compatible = "epson,rx8900",
+		.data = (void *)rx_8900
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rv8803_of_match);
+
 static struct i2c_driver rv8803_driver = {
 	.driver = {
 		.name = "rtc-rv8803",
+		.of_match_table = of_match_ptr(rv8803_of_match),
 	},
 	.probe		= rv8803_probe,
 	.remove		= rv8803_remove,
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
