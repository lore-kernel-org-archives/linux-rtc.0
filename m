Return-Path: <rtc-linux+bncBCPM5SUWUYIRBV6A2G3AKGQE4EMMHRY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com. [2607:f8b0:400e:c03::236])
        by gmr-mx.google.com with ESMTPS id r75si2050666pfr.0.2016.02.29.07.14.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Feb 2016 07:14:30 -0800 (PST)
Received: by mail-pa0-x236.google.com with SMTP id yy13so93445657pab.3
        for <rtc-linux@googlegroups.com>; Mon, 29 Feb 2016 07:14:30 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] [PATCH v3 7/8] rtc: ds3232-core: fix issue when irq is
 shared several devices
Date: Tue,  1 Mar 2016 00:13:51 +0900
Message-Id: <1456758832-10590-7-git-send-email-akinobu.mita@gmail.com>
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

ds3232-core requests irq with IRQF_SHARED, so irq can be shared by
several devices.  But the irq handler for ds3232 unconditionally
disables the irq at first and the irq is re-enabled only when the
interrupt source was the ds3232's alarm.  This behaviour breaks the
devices sharing the same irq in the various scenarios.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dennis Aberilla <denzzzhome@yahoo.com>
---
* New patch from this version

 drivers/rtc/rtc-ds3232-core.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232-core.c b/drivers/rtc/rtc-ds3232-core.c
index be8dfe0..6489380 100644
--- a/drivers/rtc/rtc-ds3232-core.c
+++ b/drivers/rtc/rtc-ds3232-core.c
@@ -59,7 +59,6 @@ struct ds3232 {
 	 */
 	struct mutex mutex;
 	bool suspended;
-	int exiting;
 };
 
 static int ds3232_check_rtc_status(struct device *dev)
@@ -314,8 +313,6 @@ static irqreturn_t ds3232_irq(int irq, void *dev_id)
 	struct device *dev = dev_id;
 	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 
-	disable_irq_nosync(irq);
-
 	/*
 	 * If rtc as a wakeup source, can't schedule the work
 	 * at system resume flow, because at this time the i2c bus
@@ -342,8 +339,8 @@ static void ds3232_work(struct work_struct *work)
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
@@ -367,9 +364,6 @@ static void ds3232_work(struct work_struct *work)
 			}
 
 			rtc_update_irq(ds3232->rtc, 1, RTC_AF | RTC_IRQF);
-
-			if (!ds3232->exiting)
-				enable_irq(ds3232->irq);
 		}
 	}
 
@@ -428,10 +422,6 @@ int ds3232_remove(struct device *dev)
 	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 
 	if (ds3232->irq > 0) {
-		mutex_lock(&ds3232->mutex);
-		ds3232->exiting = 1;
-		mutex_unlock(&ds3232->mutex);
-
 		devm_free_irq(dev, ds3232->irq, dev);
 		cancel_work_sync(&ds3232->work);
 	}
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
