Return-Path: <rtc-linux+bncBCPM5SUWUYIRBGUZ6G3AKGQE7U62N6Y@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com. [2607:f8b0:400e:c03::244])
        by gmr-mx.google.com with ESMTPS id 12si2396052pfb.1.2016.03.06.07.28.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2016 07:28:26 -0800 (PST)
Received: by mail-pa0-x244.google.com with SMTP id hj7so6180971pac.1
        for <rtc-linux@googlegroups.com>; Sun, 06 Mar 2016 07:28:26 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] [PATCH v4 6/7] rtc: ds3232: fix issue when irq is shared
 several devices
Date: Mon,  7 Mar 2016 00:27:52 +0900
Message-Id: <1457278073-11627-6-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1457278073-11627-1-git-send-email-akinobu.mita@gmail.com>
References: <1457278073-11627-1-git-send-email-akinobu.mita@gmail.com>
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

ds3232-core requests irq with IRQF_SHARED, so irq can be shared by
several devices.  But the irq handler for ds3232 unconditionally
disables the irq at first and the irq is re-enabled only when the
interrupt source was the ds3232's alarm.  This behaviour breaks the
devices sharing the same irq in the various scenarios.

This converts to use threaded irq and remove outdated code in
suspend/resume paths.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Suggested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dennis Aberilla <denzzzhome@yahoo.com>
---
* v4
- use threaded irq and remove outdated code and comment in suspend/resume paths

 drivers/rtc/rtc-ds3232.c | 81 +++++++-----------------------------------------
 1 file changed, 12 insertions(+), 69 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 6016681..dacced5 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -20,7 +20,6 @@
 #include <linux/spi/spi.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
-#include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
 
@@ -52,7 +51,6 @@ struct ds3232 {
 	struct regmap *regmap;
 	int irq;
 	struct rtc_device *rtc;
-	struct work_struct work;
 
 	/* The mutex protects alarm operations, and prevents a race
 	 * between the enable_irq() in the workqueue and the free_irq()
@@ -60,7 +58,6 @@ struct ds3232 {
 	 */
 	struct mutex mutex;
 	bool suspended;
-	int exiting;
 };
 
 static int ds3232_check_rtc_status(struct device *dev)
@@ -314,23 +311,6 @@ static irqreturn_t ds3232_irq(int irq, void *dev_id)
 {
 	struct device *dev = dev_id;
 	struct ds3232 *ds3232 = dev_get_drvdata(dev);
-
-	disable_irq_nosync(irq);
-
-	/*
-	 * If rtc as a wakeup source, can't schedule the work
-	 * at system resume flow, because at this time the i2c bus
-	 * has not been resumed.
-	 */
-	if (!ds3232->suspended)
-		schedule_work(&ds3232->work);
-
-	return IRQ_HANDLED;
-}
-
-static void ds3232_work(struct work_struct *work)
-{
-	struct ds3232 *ds3232 = container_of(work, struct ds3232, work);
 	int ret;
 	int stat, control;
 
@@ -343,8 +323,8 @@ static void ds3232_work(struct work_struct *work)
 	if (stat & DS3232_REG_SR_A1F) {
 		ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
 		if (ret) {
-			pr_warn("Read Control Register error - Disable IRQ%d\n",
-				ds3232->irq);
+			dev_warn(ds3232->dev,
+				"Read Control Register error %d\n", ret);
 		} else {
 			/* disable alarm1 interrupt */
 			control &= ~(DS3232_REG_CR_A1IE);
@@ -368,14 +348,13 @@ static void ds3232_work(struct work_struct *work)
 			}
 
 			rtc_update_irq(ds3232->rtc, 1, RTC_AF | RTC_IRQF);
-
-			if (!ds3232->exiting)
-				enable_irq(ds3232->irq);
 		}
 	}
 
 unlock:
 	mutex_unlock(&ds3232->mutex);
+
+	return IRQ_HANDLED;
 }
 
 static const struct rtc_class_ops ds3232_rtc_ops = {
@@ -401,7 +380,6 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 	ds3232->dev = dev;
 	dev_set_drvdata(dev, ds3232);
 
-	INIT_WORK(&ds3232->work, ds3232_work);
 	mutex_init(&ds3232->mutex);
 
 	ret = ds3232_check_rtc_status(dev);
@@ -409,8 +387,10 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 		return ret;
 
 	if (ds3232->irq > 0) {
-		ret = devm_request_irq(dev, ds3232->irq, ds3232_irq,
-				       IRQF_SHARED, name, dev);
+		ret = devm_request_threaded_irq(dev, ds3232->irq, NULL,
+						ds3232_irq,
+						IRQF_SHARED | IRQF_ONESHOT,
+						name, dev);
 		if (ret) {
 			ds3232->irq = 0;
 			dev_err(dev, "unable to request IRQ\n");
@@ -423,33 +403,14 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 	return PTR_ERR_OR_ZERO(ds3232->rtc);
 }
 
-static int ds3232_remove(struct device *dev)
-{
-	struct ds3232 *ds3232 = dev_get_drvdata(dev);
-
-	if (ds3232->irq > 0) {
-		mutex_lock(&ds3232->mutex);
-		ds3232->exiting = 1;
-		mutex_unlock(&ds3232->mutex);
-
-		devm_free_irq(dev, ds3232->irq, dev);
-		cancel_work_sync(&ds3232->work);
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int ds3232_suspend(struct device *dev)
 {
 	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 
-	if (device_can_wakeup(dev)) {
-		ds3232->suspended = true;
-		if (irq_set_irq_wake(ds3232->irq, 1)) {
+	if (device_may_wakeup(dev)) {
+		if (enable_irq_wake(ds3232->irq))
 			dev_warn_once(dev, "Cannot set wakeup source\n");
-			ds3232->suspended = false;
-		}
 	}
 
 	return 0;
@@ -459,14 +420,8 @@ static int ds3232_resume(struct device *dev)
 {
 	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 
-	if (ds3232->suspended) {
-		ds3232->suspended = false;
-
-		/* Clear the hardware alarm pend flag */
-		schedule_work(&ds3232->work);
-
-		irq_set_irq_wake(ds3232->irq, 0);
-	}
+	if (device_may_wakeup(dev))
+		disable_irq_wake(ds3232->irq);
 
 	return 0;
 }
@@ -497,11 +452,6 @@ static int ds3232_i2c_probe(struct i2c_client *client,
 	return ds3232_probe(&client->dev, regmap, client->irq, client->name);
 }
 
-static int ds3232_i2c_remove(struct i2c_client *client)
-{
-	return ds3232_remove(&client->dev);
-}
-
 static const struct i2c_device_id ds3232_id[] = {
 	{ "ds3232", 0 },
 	{ }
@@ -514,7 +464,6 @@ static struct i2c_driver ds3232_driver = {
 		.pm	= &ds3232_pm_ops,
 	},
 	.probe = ds3232_i2c_probe,
-	.remove = ds3232_i2c_remove,
 	.id_table = ds3232_id,
 };
 
@@ -611,17 +560,11 @@ static int ds3234_probe(struct spi_device *spi)
 	return ds3232_probe(&spi->dev, regmap, spi->irq, "ds3234");
 }
 
-static int ds3234_remove(struct spi_device *spi)
-{
-	return ds3232_remove(&spi->dev);
-}
-
 static struct spi_driver ds3234_driver = {
 	.driver = {
 		.name	 = "ds3234",
 	},
 	.probe	 = ds3234_probe,
-	.remove = ds3234_remove,
 };
 
 static int ds3234_register_driver(void)
-- 
2.5.0

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
