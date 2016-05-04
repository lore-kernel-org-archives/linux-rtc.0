Return-Path: <rtc-linux+bncBDEKVJM7XAHRB44LU64QKGQEM3L4AFQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.187])
        by gmr-mx.google.com with ESMTPS id pn4si178035igb.3.2016.05.04.02.50.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2016 02:50:42 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Michael Buesch <m@bues.ch>,
	Mylene JOSSERAND <mylene.josserand@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: rv3029: hide unused i2c device table
Date: Wed,  4 May 2016 11:50:02 +0200
Message-Id: <1462355432-473635-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The added support for SPI mode made it possible to configure the driver
when I2C is disabled, leaving an unused device table:

drivers/rtc/rtc-rv3029c2.c:794:29: error: 'rv3029_id' defined but not used [-Werror=unused-variable]

This moves the table inside of the #ifdef section that has the
only user, to avoid the harmless warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: d08f50dd0afc ("rtc: rv3029: Add support of RV3049")
---
 drivers/rtc/rtc-rv3029c2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index c2ef64fb4757..1f9f7b4bf3fb 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -791,13 +791,6 @@ static struct rtc_class_ops rv3029_rtc_ops = {
 	.set_time	= rv3029_set_time,
 };
 
-static struct i2c_device_id rv3029_id[] = {
-	{ "rv3029", 0 },
-	{ "rv3029c2", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, rv3029_id);
-
 static int rv3029_probe(struct device *dev, struct regmap *regmap, int irq,
 			const char *name)
 {
@@ -875,6 +868,13 @@ static int rv3029_i2c_probe(struct i2c_client *client,
 	return rv3029_probe(&client->dev, regmap, client->irq, client->name);
 }
 
+static struct i2c_device_id rv3029_id[] = {
+	{ "rv3029", 0 },
+	{ "rv3029c2", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rv3029_id);
+
 static struct i2c_driver rv3029_driver = {
 	.driver = {
 		.name = "rtc-rv3029c2",
-- 
2.7.0

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
