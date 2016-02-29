Return-Path: <rtc-linux+bncBCPM5SUWUYIRBWWA2G3AKGQEREUXJNY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com. [2607:f8b0:400e:c00::233])
        by gmr-mx.google.com with ESMTPS id r75si2050255pfr.0.2016.02.29.07.14.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Feb 2016 07:14:33 -0800 (PST)
Received: by mail-pf0-x233.google.com with SMTP id t66so27872419pfb.3
        for <rtc-linux@googlegroups.com>; Mon, 29 Feb 2016 07:14:33 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] [PATCH v3 8/8] rtc: use rtc->ops_lock to protect alarm operations
Date: Tue,  1 Mar 2016 00:13:52 +0900
Message-Id: <1456758832-10590-8-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1456758832-10590-1-git-send-email-akinobu.mita@gmail.com>
References: <1456758832-10590-1-git-send-email-akinobu.mita@gmail.com>
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
* New patch from this version

 drivers/rtc/rtc-ds3232-core.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232-core.c b/drivers/rtc/rtc-ds3232-core.c
index 6489380..fbb1b9a 100644
--- a/drivers/rtc/rtc-ds3232-core.c
+++ b/drivers/rtc/rtc-ds3232-core.c
@@ -53,11 +53,6 @@ struct ds3232 {
 	struct rtc_device *rtc;
 	struct work_struct work;
 
-	/* The mutex protects alarm operations, and prevents a race
-	 * between the enable_irq() in the workqueue and the free_irq()
-	 * in the remove function.
-	 */
-	struct mutex mutex;
 	bool suspended;
 };
 
@@ -188,8 +183,6 @@ static int ds3232_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	int ret;
 	u8 buf[4];
 
-	mutex_lock(&ds3232->mutex);
-
 	ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
 	if (ret)
 		goto out;
@@ -216,7 +209,6 @@ static int ds3232_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 	ret = 0;
 out:
-	mutex_unlock(&ds3232->mutex);
 	return ret;
 }
 
@@ -234,8 +226,6 @@ static int ds3232_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	if (ds3232->irq <= 0)
 		return -EINVAL;
 
-	mutex_lock(&ds3232->mutex);
-
 	buf[0] = bin2bcd(alarm->time.tm_sec);
 	buf[1] = bin2bcd(alarm->time.tm_min);
 	buf[2] = bin2bcd(alarm->time.tm_hour);
@@ -268,7 +258,6 @@ static int ds3232_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		ret = regmap_write(ds3232->regmap, DS3232_REG_CR, control);
 	}
 out:
-	mutex_unlock(&ds3232->mutex);
 	return ret;
 }
 
@@ -278,11 +267,9 @@ static int ds3232_update_alarm(struct device *dev, unsigned int enabled)
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
@@ -292,9 +279,6 @@ static int ds3232_update_alarm(struct device *dev, unsigned int enabled)
 		control &= ~(DS3232_REG_CR_A1IE);
 	ret = regmap_write(ds3232->regmap, DS3232_REG_CR, control);
 
-unlock:
-	mutex_unlock(&ds3232->mutex);
-
 	return ret;
 }
 
@@ -327,10 +311,11 @@ static irqreturn_t ds3232_irq(int irq, void *dev_id)
 static void ds3232_work(struct work_struct *work)
 {
 	struct ds3232 *ds3232 = container_of(work, struct ds3232, work);
+	struct mutex *lock = &ds3232->rtc->ops_lock;
 	int ret;
 	int stat, control;
 
-	mutex_lock(&ds3232->mutex);
+	mutex_lock(lock);
 
 	ret = regmap_read(ds3232->regmap, DS3232_REG_SR, &stat);
 	if (ret)
@@ -368,7 +353,7 @@ static void ds3232_work(struct work_struct *work)
 	}
 
 unlock:
-	mutex_unlock(&ds3232->mutex);
+	mutex_unlock(lock);
 }
 
 static const struct rtc_class_ops ds3232_rtc_ops = {
@@ -395,7 +380,6 @@ int __ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 	dev_set_drvdata(dev, ds3232);
 
 	INIT_WORK(&ds3232->work, ds3232_work);
-	mutex_init(&ds3232->mutex);
 
 	ret = ds3232_check_rtc_status(dev);
 	if (ret)
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
