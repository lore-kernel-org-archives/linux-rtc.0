Return-Path: <rtc-linux+bncBAABB2X34XCQKGQERUIBREI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from osg.samsung.com (ec2-52-27-115-49.us-west-2.compute.amazonaws.com. [52.27.115.49])
        by gmr-mx.google.com with ESMTP id y90si59769pfa.6.2017.03.03.06.30.01
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Mar 2017 06:30:01 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH 10/13] rtc: s35390a: Add OF device ID table
Date: Fri,  3 Mar 2017 11:29:21 -0300
Message-Id: <20170303142925.17915-11-javier@osg.samsung.com>
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

 drivers/rtc/rtc-s35390a.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 5dab4665ca3b..449820eeefe8 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -58,6 +58,13 @@ static const struct i2c_device_id s35390a_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, s35390a_id);
 
+static const struct of_device_id s35390a_of_match[] = {
+	{ .compatible = "s35390a" },
+	{ .compatible = "sii,s35390a" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, s35390a_of_match);
+
 struct s35390a {
 	struct i2c_client *client[8];
 	struct rtc_device *rtc;
@@ -502,6 +509,7 @@ static int s35390a_remove(struct i2c_client *client)
 static struct i2c_driver s35390a_driver = {
 	.driver		= {
 		.name	= "rtc-s35390a",
+		.of_match_table = of_match_ptr(s35390a_of_match),
 	},
 	.probe		= s35390a_probe,
 	.remove		= s35390a_remove,
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
