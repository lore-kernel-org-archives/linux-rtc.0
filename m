Return-Path: <rtc-linux+bncBDS7HNEFSALRBLH73K3AKGQEWZQCSCI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w128si122375wmd.0.2016.03.02.02.25.48
        for <rtc-linux@googlegroups.com>;
        Wed, 02 Mar 2016 02:25:48 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Juergen Borleis <jbe@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 1/2] rtc: pcf85063: remove useless DRV_VERSION
Date: Wed,  2 Mar 2016 11:25:42 +0100
Message-Id: <1456914343-4611-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Since the driver is mainlined there is no use for a separate version
number.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-pcf85063.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 4e940cc3d782..550f67518c5a 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -16,8 +16,6 @@
 #include <linux/rtc.h>
 #include <linux/module.h>
=20
-#define DRV_VERSION "0.0.1"
-
 #define PCF85063_REG_CTRL1		0x00 /* status */
 #define PCF85063_REG_CTRL1_STOP		BIT(5)
 #define PCF85063_REG_CTRL2		0x01
@@ -182,8 +180,6 @@ static int pcf85063_probe(struct i2c_client *client,
 	if (!pcf85063)
 		return -ENOMEM;
=20
-	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
-
 	i2c_set_clientdata(client, pcf85063);
=20
 	pcf85063->rtc =3D devm_rtc_device_register(&client->dev,
@@ -221,4 +217,3 @@ module_i2c_driver(pcf85063_driver);
 MODULE_AUTHOR("S=C3=B8ren Andersen <san@rosetechnology.dk>");
 MODULE_DESCRIPTION("PCF85063 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
--=20
2.7.0

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
