Return-Path: <rtc-linux+bncBCPM5SUWUYIRBF4Z6G3AKGQEPGHZQMY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com. [2607:f8b0:400e:c03::241])
        by gmr-mx.google.com with ESMTPS id r75si2465645pfr.0.2016.03.06.07.28.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2016 07:28:23 -0800 (PST)
Received: by mail-pa0-x241.google.com with SMTP id 1so520481pal.3
        for <rtc-linux@googlegroups.com>; Sun, 06 Mar 2016 07:28:23 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] [PATCH v4 5/7] rtc: ds3232: remove unused UIE code
Date: Mon,  7 Mar 2016 00:27:51 +0900
Message-Id: <1457278073-11627-5-git-send-email-akinobu.mita@gmail.com>
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

UIE mode irqs are handled by the generic rtc core now.  But there are
remaining unused code fragments for it.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dennis Aberilla <denzzzhome@yahoo.com>
---
* No changes from the previous version

 drivers/rtc/rtc-ds3232.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index bb891b9..6016681 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -279,32 +279,14 @@ static int ds3232_update_alarm(struct device *dev, unsigned int enabled)
 	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 	int control;
 	int ret;
-	u8 buf[4];
 
 	mutex_lock(&ds3232->mutex);
 
-	ret = regmap_bulk_read(ds3232->regmap, DS3232_REG_ALARM1, buf, 4);
-	if (ret)
-		goto unlock;
-
-	buf[0] = bcd2bin(buf[0]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
-								0x80 : buf[0];
-	buf[1] = bcd2bin(buf[1]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
-								0x80 : buf[1];
-	buf[2] = bcd2bin(buf[2]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
-								0x80 : buf[2];
-	buf[3] = bcd2bin(buf[3]) < 0 || (ds3232->rtc->irq_data & RTC_UF) ?
-								0x80 : buf[3];
-
-	ret = regmap_bulk_write(ds3232->regmap, DS3232_REG_ALARM1, buf, 4);
-	if (ret)
-		goto unlock;
-
 	ret = regmap_read(ds3232->regmap, DS3232_REG_CR, &control);
 	if (ret)
 		goto unlock;
 
-	if (enabled || (ds3232->rtc->irq_data & RTC_UF))
+	if (enabled)
 		/* enable alarm1 interrupt */
 		control |= DS3232_REG_CR_A1IE;
 	else
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
