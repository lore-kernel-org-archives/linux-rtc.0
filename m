Return-Path: <rtc-linux+bncBCPM5SUWUYIRBFMZ6G3AKGQEASHFOHA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com. [2607:f8b0:400e:c00::244])
        by gmr-mx.google.com with ESMTPS id ui7si2482805pab.0.2016.03.06.07.28.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2016 07:28:20 -0800 (PST)
Received: by mail-pf0-x244.google.com with SMTP id 63so6437318pfe.0
        for <rtc-linux@googlegroups.com>; Sun, 06 Mar 2016 07:28:20 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] [PATCH v4 4/7] rtc: ds3232: add register access error checks
Date: Mon,  7 Mar 2016 00:27:50 +0900
Message-Id: <1457278073-11627-4-git-send-email-akinobu.mita@gmail.com>
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

Add missing register access error checks and make it return error code
or print error message.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dennis Aberilla <denzzzhome@yahoo.com>
---
* No changes from the previous version

 drivers/rtc/rtc-ds3232.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index b27acea..bb891b9 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -262,6 +262,8 @@ static int ds3232_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		goto out;
 
 	ret = regmap_bulk_write(ds3232->regmap, DS3232_REG_ALARM1, buf, 4);
+	if (ret)
+		goto out;
 
 	if (alarm->enabled) {
 		control |= DS3232_REG_CR_A1IE;
@@ -272,7 +274,7 @@ out:
 	return ret;
 }
 
-static void ds3232_update_alarm(struct device *dev, unsigned int enabled)
+static int ds3232_update_alarm(struct device *dev, unsigned int enabled)
 {
 	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 	int control;
@@ -308,10 +310,12 @@ static void ds3232_update_alarm(struct device *dev, unsigned int enabled)
 	else
 		/* disable alarm1 interrupt */
 		control &= ~(DS3232_REG_CR_A1IE);
-	regmap_write(ds3232->regmap, DS3232_REG_CR, control);
+	ret = regmap_write(ds3232->regmap, DS3232_REG_CR, control);
 
 unlock:
 	mutex_unlock(&ds3232->mutex);
+
+	return ret;
 }
 
 static int ds3232_alarm_irq_enable(struct device *dev, unsigned int enabled)
@@ -321,9 +325,7 @@ static int ds3232_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	if (ds3232->irq <= 0)
 		return -EINVAL;
 
-	ds3232_update_alarm(dev, enabled);
-
-	return 0;
+	return ds3232_update_alarm(dev, enabled);
 }
 
 static irqreturn_t ds3232_irq(int irq, void *dev_id)
@@ -364,11 +366,24 @@ static void ds3232_work(struct work_struct *work)
 		} else {
 			/* disable alarm1 interrupt */
 			control &= ~(DS3232_REG_CR_A1IE);
-			regmap_write(ds3232->regmap, DS3232_REG_CR, control);
+			ret = regmap_write(ds3232->regmap, DS3232_REG_CR,
+						control);
+			if (ret) {
+				dev_warn(ds3232->dev,
+					"Write Control Register error %d\n",
+					ret);
+				goto unlock;
+			}
 
 			/* clear the alarm pend flag */
 			stat &= ~DS3232_REG_SR_A1F;
-			regmap_write(ds3232->regmap, DS3232_REG_SR, stat);
+			ret = regmap_write(ds3232->regmap, DS3232_REG_SR, stat);
+			if (ret) {
+				dev_warn(ds3232->dev,
+					"Write Status Register error %d\n",
+					ret);
+				goto unlock;
+			}
 
 			rtc_update_irq(ds3232->rtc, 1, RTC_AF | RTC_IRQF);
 
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
