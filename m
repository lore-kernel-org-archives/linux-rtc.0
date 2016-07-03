Return-Path: <rtc-linux+bncBC2JFQ6TUUPRBN7G4W5QKGQEAUY2NLQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com. [2a00:1450:400c:c09::241])
        by gmr-mx.google.com with ESMTPS id f70si49326wmf.0.2016.07.03.13.19.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jul 2016 13:19:03 -0700 (PDT)
Received: by mail-wm0-x241.google.com with SMTP id 187so17346920wmz.1
        for <rtc-linux@googlegroups.com>; Sun, 03 Jul 2016 13:19:03 -0700 (PDT)
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: m41t80: use devm_add_action_or_reset()
Date: Sun,  3 Jul 2016 21:18:58 +0100
Message-Id: <1467577138-30453-1-git-send-email-sudipm.mukherjee@gmail.com>
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
 drivers/rtc/rtc-m41t80.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index d1bf93a..49bc464 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -831,10 +831,9 @@ static int m41t80_probe(struct i2c_client *client,
 		return rc;
 	}
 
-	rc = devm_add_action(&client->dev, m41t80_remove_sysfs_group,
-			     &client->dev);
+	rc = devm_add_action_or_reset(&client->dev, m41t80_remove_sysfs_group,
+				      &client->dev);
 	if (rc) {
-		m41t80_remove_sysfs_group(&client->dev);
 		dev_err(&client->dev,
 			"Failed to add sysfs cleanup action: %d\n", rc);
 		return rc;
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
