Return-Path: <rtc-linux+bncBDS7HNEFSALRBSUTQKXAKGQEX7H7DEY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si43823wib.2.2015.08.04.02.45.46
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:46 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 04/15] rtc: rx8025: remove useless probe error message
Date: Tue,  4 Aug 2015 11:45:23 +0200
Message-Id: <1438681534-12027-5-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1438681534-12027-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438681534-12027-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

It is useless to print a message when probe fails as the user is already
aware that it failed.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index be91e922a139..612b6876cbd5 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -513,20 +513,18 @@ static int rx8025_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct rx8025_data *rx8025;
-	int err, need_reset = 0;
+	int err = 0, need_reset = 0;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
 				     | I2C_FUNC_SMBUS_I2C_BLOCK)) {
 		dev_err(&adapter->dev,
 			"doesn't support required functionality\n");
-		err = -EIO;
-		goto errout;
+		return -EIO;
 	}
 
 	rx8025 = devm_kzalloc(&client->dev, sizeof(*rx8025), GFP_KERNEL);
 	if (!rx8025) {
-		err = -ENOMEM;
-		goto errout;
+		return -ENOMEM;
 	}
 
 	rx8025->client = client;
@@ -534,7 +532,7 @@ static int rx8025_probe(struct i2c_client *client,
 
 	err = rx8025_init_client(client, &need_reset);
 	if (err)
-		goto errout;
+		return err;
 
 	if (need_reset) {
 		struct rtc_time tm;
@@ -547,9 +545,8 @@ static int rx8025_probe(struct i2c_client *client,
 	rx8025->rtc = devm_rtc_device_register(&client->dev, client->name,
 					  &rx8025_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rx8025->rtc)) {
-		err = PTR_ERR(rx8025->rtc);
 		dev_err(&client->dev, "unable to register the class device\n");
-		goto errout;
+		return PTR_ERR(rx8025->rtc);
 	}
 
 	if (client->irq > 0) {
@@ -559,7 +556,7 @@ static int rx8025_probe(struct i2c_client *client,
 						client);
 		if (err) {
 			dev_err(&client->dev, "unable to request IRQ\n");
-			goto errout;
+			return err;
 		}
 	}
 
@@ -567,13 +564,6 @@ static int rx8025_probe(struct i2c_client *client,
 	rx8025->rtc->max_user_freq = 1;
 
 	err = rx8025_sysfs_register(&client->dev);
-	if (err)
-		goto errout;
-
-	return 0;
-
-errout:
-	dev_err(&adapter->dev, "probing for rx8025 failed\n");
 	return err;
 }
 
-- 
2.1.4

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
