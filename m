Return-Path: <rtc-linux+bncBDCPB2NTQEFBBHNP57AQKGQEEMQ5HIY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com. [2607:f8b0:400e:c05::243])
        by gmr-mx.google.com with ESMTPS id n18si1744830pfb.2.2016.11.27.23.07.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Nov 2016 23:07:09 -0800 (PST)
Received: by mail-pg0-x243.google.com with SMTP id p66so12307527pga.2
        for <rtc-linux@googlegroups.com>; Sun, 27 Nov 2016 23:07:09 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: rtc-ds3232: add device tree support
Date: Mon, 28 Nov 2016 07:06:44 +0000
Message-Id: <20161128070644.8386-1-pbrobinson@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Set the of_match_table for this driver so that devices can be described in
the device tree.  This device is used in a number of NXP devices as well as
the CryptoCap and is already defined in the various device trees.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/rtc/rtc-ds3232.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index b1f20d8..711cc5b 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
@@ -438,9 +439,18 @@ static const struct i2c_device_id ds3232_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ds3232_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id ds3232_of_match[] = {
+	{ .compatible = "dallas,ds3232", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ds3232_of_match);
+#endif
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
