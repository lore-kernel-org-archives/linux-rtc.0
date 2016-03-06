Return-Path: <rtc-linux+bncBCPM5SUWUYIRBHMZ6G3AKGQEP7IZV6I@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id yd9si2325216pab.1.2016.03.06.07.28.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2016 07:28:29 -0800 (PST)
Received: by mail-pf0-x241.google.com with SMTP id q129so6438124pfb.3
        for <rtc-linux@googlegroups.com>; Sun, 06 Mar 2016 07:28:29 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] [PATCH v4 7/7] rtc: ds3232: use rtc->ops_lock to protect
 alarm operations
Date: Mon,  7 Mar 2016 00:27:53 +0900
Message-Id: <1457278073-11627-7-git-send-email-akinobu.mita@gmail.com>
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

ds3232->mutex is used to protect for alarm operations which
need to access status and control registers.

But we can use rtc->ops_lock instead.  rtc->ops_lock is held when most
of rtc_class_ops methods are called, so we only need to explicitly
acquire it from irq handler in order to protect form concurrent
accesses.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dennis Aberilla <denzzzhome@yahoo.com>
---
* No changes from the previous version

 drivers/rtc/rtc-ds3232.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index dacced5..b99cbe4 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -52,11 +52,6 @@ struct ds3232 {
 	int irq;
 	struct rtc_device *rtc;
 
-	/* The mutex protects alarm operations, and prevents a race
-	 * between the enable_irq() in the workqueue and the free_irq()
-	 * in the remove function.
-	 */
-	struct mutex mutex;
 	bool suspended;
 };
 
@@ -187,8 +182,6 @@ static int ds3232_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	int ret;
 	u8 buf[4];
 
-	mutex_lock(&ds3232->mutex);
-
 	ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
 	if (ret)
 		goto out;
@@ -215,7 +208,6 @@ static int ds3232_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 	ret = 0;
 out:
-	mutex_unlock(&ds3232->mutex);
 	return ret;
 }
 
@@ -233,8 +225,6 @@ static int ds3232_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	if (ds3232->irq <= 0)
 		return -EINVAL;
 
-	mutex_lock(&ds3232->mutex);
-
 	buf[0] = bin2bcd(alarm->time.tm_sec);
 	buf[1] = bin2bcd(alarm->time.tm_min);
 	buf[2] = bin2bcd(alarm->time.tm_hour);
@@ -267,7 +257,6 @@ static int ds3232_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		ret = regmap_write(ds3232->regmap, DS3232_REG_CR, control);
 	}
 out:
-	mutex_unlock(&ds3232->mutex);
 	return ret;
 }
 
@@ -277,11 +266,9 @@ static int ds3232_update_alarm(struct device *dev, unsigned int enabled)
 	int control;
 	int ret;
 
-	mutex_lock(&ds3232->mutex);
-
 	ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	if (enabled)
 		/* enable alarm1 interrupt */
@@ -291,9 +278,6 @@ static int ds3232_update_alarm(struct device *dev, unsigned int enabled)
 		control &= ~(DS3232_REG_CR_A1IE);
 	ret = regmap_write(ds3232->regmap, DS3232_REG_CR, control);
 
-unlock:
-	mutex_unlock(&ds3232->mutex);
-
 	return ret;
 }
 
@@ -311,10 +295,11 @@ static irqreturn_t ds3232_irq(int irq, void *dev_id)
 {
 	struct device *dev = dev_id;
 	struct ds3232 *ds3232 = dev_get_drvdata(dev);
+	struct mutex *lock = &ds3232->rtc->ops_lock;
 	int ret;
 	int stat, control;
 
-	mutex_lock(&ds3232->mutex);
+	mutex_lock(lock);
 
 	ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
 	if (ret)
@@ -352,7 +337,7 @@ static irqreturn_t ds3232_irq(int irq, void *dev_id)
 	}
 
 unlock:
-	mutex_unlock(&ds3232->mutex);
+	mutex_unlock(lock);
 
 	return IRQ_HANDLED;
 }
@@ -380,8 +365,6 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 	ds3232->dev = dev;
 	dev_set_drvdata(dev, ds3232);
 
-	mutex_init(&ds3232->mutex);
-
 	ret = ds3232_check_rtc_status(dev);
 	if (ret)
 		return ret;
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
