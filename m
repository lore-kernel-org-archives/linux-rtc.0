Return-Path: <rtc-linux+bncBCPM5SUWUYIRBU6A2G3AKGQEVE3WN5A@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com. [2607:f8b0:400e:c03::22c])
        by gmr-mx.google.com with ESMTPS id ui7si3698544pab.0.2016.02.29.07.14.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Feb 2016 07:14:27 -0800 (PST)
Received: by mail-pa0-x22c.google.com with SMTP id bj10so24176316pad.2
        for <rtc-linux@googlegroups.com>; Mon, 29 Feb 2016 07:14:27 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] [PATCH v3 6/8] rtc: ds3232-core: remove unused UIE code
Date: Tue,  1 Mar 2016 00:13:50 +0900
Message-Id: <1456758832-10590-6-git-send-email-akinobu.mita@gmail.com>
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

UIE mode irqs are handled by the generic rtc core now.  But there are
remaining unused code fragments for it.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dennis Aberilla <denzzzhome@yahoo.com>
---
* New patch from this version

 drivers/rtc/rtc-ds3232-core.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232-core.c b/drivers/rtc/rtc-ds3232-core.c
index bcce75b..be8dfe0 100644
--- a/drivers/rtc/rtc-ds3232-core.c
+++ b/drivers/rtc/rtc-ds3232-core.c
@@ -278,32 +278,14 @@ static int ds3232_update_alarm(struct device *dev, unsigned int enabled)
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
