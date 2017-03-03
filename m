Return-Path: <rtc-linux+bncBAABBX734XCQKGQEIPMFZIA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from osg.samsung.com (ec2-52-27-115-49.us-west-2.compute.amazonaws.com. [52.27.115.49])
        by gmr-mx.google.com with ESMTP id c123si63080pfa.4.2017.03.03.06.29.51
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Mar 2017 06:29:51 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH 06/13] rtc: ds3232: Add OF device ID table
Date: Fri,  3 Mar 2017 11:29:17 -0300
Message-Id: <20170303142925.17915-7-javier@osg.samsung.com>
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

 drivers/rtc/rtc-ds3232.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 9bb39a06b994..deff431a37c4 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -442,9 +442,16 @@ static const struct i2c_device_id ds3232_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ds3232_id);
 
+static const struct of_device_id ds3232_of_match[] = {
+	{ .compatible = "dallas,ds3232" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ds3232_of_match);
+
 static struct i2c_driver ds3232_driver = {
 	.driver = {
 		.name = "rtc-ds3232",
+		.of_match_table = of_match_ptr(ds3232_of_match),
 		.pm	= &ds3232_pm_ops,
 	},
 	.probe = ds3232_i2c_probe,
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
