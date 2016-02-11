Return-Path: <rtc-linux+bncBCPM5SUWUYIRB7W26K2QKGQEOBMG5ZY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com. [2607:f8b0:400e:c00::242])
        by gmr-mx.google.com with ESMTPS id 79si1177371pft.0.2016.02.11.07.49.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2016 07:49:16 -0800 (PST)
Received: by mail-pf0-x242.google.com with SMTP id e127so2699424pfe.3
        for <rtc-linux@googlegroups.com>; Thu, 11 Feb 2016 07:49:16 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Jack Lan <jack.lan@freescale.com>,
	Srikanth Srinivasan <srikanth.srinivasan@freescale.com>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] [PATCH 4/4] rtc: ds3232-core: fix read on /dev/rtc after RTC_AIE_ON
Date: Fri, 12 Feb 2016 00:48:56 +0900
Message-Id: <1455205736-24425-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1455205736-24425-1-git-send-email-akinobu.mita@gmail.com>
References: <1455205736-24425-1-git-send-email-akinobu.mita@gmail.com>
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

The rtctest (tools/testing/selftests/timers/rtctest.c) found that
reading ds3232 rtc device immediately return the value 0x20 (RTC_AF)
without waiting alarm interrupt.

This is because alarm_irq_enable() of ds3232 driver changes RTC_AF
flag in rtc->irq_data.  So calling ioctl with RTC_AIE_ON generates
invalid value in rtc device.

The lower-level driver should not touch rtc->irq_data directly.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jack Lan <jack.lan@freescale.com>
Cc: Srikanth Srinivasan <srikanth.srinivasan@freescale.com>
Cc: Dennis Aberilla <denzzzhome@yahoo.com>
---
 drivers/rtc/rtc-ds3232-core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232-core.c b/drivers/rtc/rtc-ds3232-core.c
index a45a755..b4e8be8 100644
--- a/drivers/rtc/rtc-ds3232-core.c
+++ b/drivers/rtc/rtc-ds3232-core.c
@@ -273,7 +273,7 @@ out:
 	return ret;
 }
 
-static void ds3232_update_alarm(struct device *dev)
+static void ds3232_update_alarm(struct device *dev, unsigned int enabled)
 {
 	struct ds3232 *ds3232 = dev_get_drvdata(dev);
 	int control;
@@ -303,7 +303,7 @@ static void ds3232_update_alarm(struct device *dev)
 	if (control < 0)
 		goto unlock;
 
-	if (ds3232->rtc->irq_data & (RTC_AF | RTC_UF))
+	if (enabled || (ds3232->rtc->irq_data & RTC_UF))
 		/* enable alarm1 interrupt */
 		control |= DS3232_REG_CR_A1IE;
 	else
@@ -322,12 +322,8 @@ static int ds3232_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	if (ds3232->ops->irq(dev) <= 0)
 		return -EINVAL;
 
-	if (enabled)
-		ds3232->rtc->irq_data |= RTC_AF;
-	else
-		ds3232->rtc->irq_data &= ~RTC_AF;
+	ds3232_update_alarm(dev, enabled);
 
-	ds3232_update_alarm(dev);
 	return 0;
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
