Return-Path: <rtc-linux+bncBDS7HNEFSALRBQUTQKXAKGQEID5STEI@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bk2si47200wib.1.2015.08.04.02.45.37
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:37 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 02/15] rtc: rx8025: Convert to threaded IRQ
Date: Tue,  4 Aug 2015 11:45:21 +0200
Message-Id: <1438681534-12027-3-git-send-email-alexandre.belloni@free-electrons.com>
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

The driver currently emulates the concept of threaded IRQ using a
workqueue, switch to threaded IRQ instead.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index a943e1c08263..d8737713135d 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -71,9 +71,7 @@ MODULE_DEVICE_TABLE(i2c, rx8025_id);
 struct rx8025_data {
 	struct i2c_client *client;
 	struct rtc_device *rtc;
-	struct work_struct work;
 	u8 ctrl1;
-	unsigned exiting:1;
 };
 
 static int rx8025_read_reg(struct i2c_client *client, int number, u8 *value)
@@ -128,26 +126,12 @@ static int rx8025_write_regs(struct i2c_client *client,
 	return ret;
 }
 
-static irqreturn_t rx8025_irq(int irq, void *dev_id)
+static irqreturn_t rx8025_handle_irq(int irq, void *dev_id)
 {
 	struct i2c_client *client = dev_id;
 	struct rx8025_data *rx8025 = i2c_get_clientdata(client);
-
-	disable_irq_nosync(irq);
-	schedule_work(&rx8025->work);
-	return IRQ_HANDLED;
-}
-
-static void rx8025_work(struct work_struct *work)
-{
-	struct rx8025_data *rx8025 = container_of(work, struct rx8025_data,
-						  work);
-	struct i2c_client *client = rx8025->client;
-	struct mutex *lock = &rx8025->rtc->ops_lock;
 	u8 status;
 
-	mutex_lock(lock);
-
 	if (rx8025_read_reg(client, RX8025_REG_CTRL2, &status))
 		goto out;
 
@@ -175,10 +159,7 @@ static void rx8025_work(struct work_struct *work)
 			 status | RX8025_BIT_CTRL2_XST);
 
 out:
-	if (!rx8025->exiting)
-		enable_irq(client->irq);
-
-	mutex_unlock(lock);
+	return IRQ_HANDLED;
 }
 
 static int rx8025_get_time(struct device *dev, struct rtc_time *dt)
@@ -550,7 +531,6 @@ static int rx8025_probe(struct i2c_client *client,
 
 	rx8025->client = client;
 	i2c_set_clientdata(client, rx8025);
-	INIT_WORK(&rx8025->work, rx8025_work);
 
 	err = rx8025_init_client(client, &need_reset);
 	if (err)
@@ -574,7 +554,7 @@ static int rx8025_probe(struct i2c_client *client,
 
 	if (client->irq > 0) {
 		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
-		err = request_irq(client->irq, rx8025_irq,
+		err = request_threaded_irq(client->irq, NULL, rx8025_handle_irq,
 				  0, "rx8025", client);
 		if (err) {
 			dev_err(&client->dev, "unable to request IRQ\n");
@@ -602,17 +582,8 @@ errout:
 
 static int rx8025_remove(struct i2c_client *client)
 {
-	struct rx8025_data *rx8025 = i2c_get_clientdata(client);
-	struct mutex *lock = &rx8025->rtc->ops_lock;
-
-	if (client->irq > 0) {
-		mutex_lock(lock);
-		rx8025->exiting = 1;
-		mutex_unlock(lock);
-
+	if (client->irq > 0)
 		free_irq(client->irq, client);
-		cancel_work_sync(&rx8025->work);
-	}
 
 	rx8025_sysfs_unregister(&client->dev);
 	return 0;
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
