Return-Path: <rtc-linux+bncBDS7HNEFSALRBLP73K3AKGQEC57K5SA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w10si114797wmw.3.2016.03.02.02.25.48
        for <rtc-linux@googlegroups.com>;
        Wed, 02 Mar 2016 02:25:48 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Juergen Borleis <jbe@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 2/2] rtc: pcf85063: remove struct pcf85063
Date: Wed,  2 Mar 2016 11:25:43 +0100
Message-Id: <1456914343-4611-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1456914343-4611-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1456914343-4611-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

No members of struct pcf85063 are used anymore, remove the whole structure.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-pcf85063.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 550f67518c5a..e8ddbb359d11 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -31,11 +31,6 @@
 
 static struct i2c_driver pcf85063_driver;
 
-struct pcf85063 {
-	struct rtc_device *rtc;
-	int voltage_low; /* indicates if a low_voltage was detected */
-};
-
 static int pcf85063_stop_clock(struct i2c_client *client, u8 *ctrl1)
 {
 	s32 ret;
@@ -168,25 +163,18 @@ static const struct rtc_class_ops pcf85063_rtc_ops = {
 static int pcf85063_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
-	struct pcf85063 *pcf85063;
+	struct rtc_device *rtc;
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	pcf85063 = devm_kzalloc(&client->dev, sizeof(struct pcf85063),
-				GFP_KERNEL);
-	if (!pcf85063)
-		return -ENOMEM;
-
-	i2c_set_clientdata(client, pcf85063);
-
-	pcf85063->rtc = devm_rtc_device_register(&client->dev,
-				pcf85063_driver.driver.name,
-				&pcf85063_rtc_ops, THIS_MODULE);
+	rtc = devm_rtc_device_register(&client->dev,
+				       pcf85063_driver.driver.name,
+				       &pcf85063_rtc_ops, THIS_MODULE);
 
-	return PTR_ERR_OR_ZERO(pcf85063->rtc);
+	return PTR_ERR_OR_ZERO(rtc);
 }
 
 static const struct i2c_device_id pcf85063_id[] = {
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
