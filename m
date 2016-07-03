Return-Path: <rtc-linux+bncBC2JFQ6TUUPRBXPM4W5QKGQE5ZAVR6Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com. [2a00:1450:400c:c09::243])
        by gmr-mx.google.com with ESMTPS id c135si87965wme.2.2016.07.03.13.32.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jul 2016 13:32:29 -0700 (PDT)
Received: by mail-wm0-x243.google.com with SMTP id a66so17364239wme.2
        for <rtc-linux@googlegroups.com>; Sun, 03 Jul 2016 13:32:29 -0700 (PDT)
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: abx80x: use devm_add_action_or_reset()
Date: Sun,  3 Jul 2016 21:32:22 +0100
Message-Id: <1467577942-31473-1-git-send-email-sudipm.mukherjee@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

If devm_add_action() fails we are explicitly calling the cleanup to free
the resources allocated.  Lets use the helper devm_add_action_or_reset()
and return directly in case of error, as we know that the cleanup function
has been already called by the helper if there was any error.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/rtc/rtc-abx80x.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index ba0d619..fea9a60 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -643,17 +643,15 @@ static int abx80x_probe(struct i2c_client *client,
 		return err;
 	}
 
-	err = devm_add_action(&client->dev, rtc_calib_remove_sysfs_group,
-			      &client->dev);
-	if (err) {
-		rtc_calib_remove_sysfs_group(&client->dev);
+	err = devm_add_action_or_reset(&client->dev,
+				       rtc_calib_remove_sysfs_group,
+				       &client->dev);
+	if (err)
 		dev_err(&client->dev,
 			"Failed to add sysfs cleanup action: %d\n",
 			err);
-		return err;
-	}
 
-	return 0;
+	return err;
 }
 
 static int abx80x_remove(struct i2c_client *client)
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
