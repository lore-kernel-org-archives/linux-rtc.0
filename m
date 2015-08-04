Return-Path: <rtc-linux+bncBDS7HNEFSALRBQUTQKXAKGQEID5STEI@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id jv9si51654wid.0.2015.08.04.02.45.38
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:38 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 03/15] rtc: rx8025: switch to managed irq allocation
Date: Tue,  4 Aug 2015 11:45:22 +0200
Message-Id: <1438681534-12027-4-git-send-email-alexandre.belloni@free-electrons.com>
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

Use devm_request_threaded_irq() so it is not necessary to call free_irq()
explicitly.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index d8737713135d..be91e922a139 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -554,8 +554,9 @@ static int rx8025_probe(struct i2c_client *client,
 
 	if (client->irq > 0) {
 		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
-		err = request_threaded_irq(client->irq, NULL, rx8025_handle_irq,
-				  0, "rx8025", client);
+		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+						rx8025_handle_irq, 0, "rx8025",
+						client);
 		if (err) {
 			dev_err(&client->dev, "unable to request IRQ\n");
 			goto errout;
@@ -567,14 +568,10 @@ static int rx8025_probe(struct i2c_client *client,
 
 	err = rx8025_sysfs_register(&client->dev);
 	if (err)
-		goto errout_irq;
+		goto errout;
 
 	return 0;
 
-errout_irq:
-	if (client->irq > 0)
-		free_irq(client->irq, client);
-
 errout:
 	dev_err(&adapter->dev, "probing for rx8025 failed\n");
 	return err;
@@ -582,9 +579,6 @@ errout:
 
 static int rx8025_remove(struct i2c_client *client)
 {
-	if (client->irq > 0)
-		free_irq(client->irq, client);
-
 	rx8025_sysfs_unregister(&client->dev);
 	return 0;
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
