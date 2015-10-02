Return-Path: <rtc-linux+bncBAABBQ4XXGYAKGQETZIOX3A@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id bn1si210179wib.0.2015.10.02.02.17.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 02 Oct 2015 02:17:55 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v1 2/4] rtc: pcf2127: remove useless driver version
Date: Fri,  2 Oct 2015 11:17:20 +0200
Message-Id: <1443777442-15920-3-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1443777442-15920-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1443777442-15920-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

A driver version is only really sensible for oot drivers. Also the
dev_info about having found a chip only signals that allocating the
driver data succeeded and so isn't worth much.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/rtc/rtc-pcf2127.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 4f66c4216b5a..7eb6ff26185e 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -20,8 +20,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
=20
-#define DRV_VERSION "0.0.1"
-
 #define PCF2127_REG_CTRL1       (0x00)  /* Control Register 1 */
 #define PCF2127_REG_CTRL2       (0x01)  /* Control Register 2 */
 #define PCF2127_REG_CTRL3       (0x02)  /* Control Register 3 */
@@ -203,8 +201,6 @@ static int pcf2127_probe(struct i2c_client *client,
 	if (!pcf2127)
 		return -ENOMEM;
=20
-	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
-
 	i2c_set_clientdata(client, pcf2127);
=20
 	pcf2127->rtc =3D devm_rtc_device_register(&client->dev,
@@ -243,4 +239,3 @@ module_i2c_driver(pcf2127_driver);
 MODULE_AUTHOR("Renaud Cerrato <r.cerrato@til-technologies.fr>");
 MODULE_DESCRIPTION("NXP PCF2127 RTC driver");
 MODULE_LICENSE("GPL v2");
-MODULE_VERSION(DRV_VERSION);
--=20
2.6.0

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
