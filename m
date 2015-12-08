Return-Path: <rtc-linux+bncBAABBAENTSZQKGQEQRMBETA@googlegroups.com>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com. [195.245.230.176])
        by gmr-mx.google.com with ESMTPS id e201si170791wma.3.2015.12.08.08.34.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2015 08:34:08 -0800 (PST)
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 8 Dec 2015 16:28:39 +0000
Subject: [rtc-linux] [PATCH V1] rtc: da9063: access ordering error during RTC
 interrupt system power on
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, RTC-LINUX <rtc-linux@googlegroups.com>
CC: David Dajun Chen <david.chen@diasemi.com>, Support Opensource
	<support.opensource@diasemi.com>
Message-ID: <20151208163406.B34683FB25@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

From: Steve Twiss <stwiss.opensource@diasemi.com>

This fix alters the ordering of the IRQ and device registrations in the RTC
driver probe function. This change will apply to the RTC driver that supports
both DA9063 and DA9062 PMICs.

A problem could occur with the existing RTC driver if:

A system is started from a cold boot using the PMIC RTC IRQ to initiate a
power on operation. For instance, if an RTC alarm is used to start a
platform from power off.
The existing driver IRQ is requested before the device has been properly
registered.
i.e.
    ret = devm_request_threaded_irq() 
comes before
    rtc->rtc_dev = devm_rtc_device_register();

In this case, the interrupt can be called before the device has been
registered and the handler can be called immediately. The IRQ handler
da9063_alarm_event() contains the function call

    rtc_update_irq(rtc->rtc_dev, 1, RTC_IRQF | RTC_AF);

which in turn tries to access the unavailable rtc->rtc_dev.

The fix is to reorder the functions inside the RTC probe. The IRQ is
requested after the RTC device resource has been registered so that
get_irq_byname is the last thing to happen.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.4-rc4

Regards,
Steve


 drivers/rtc/rtc-da9063.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index 284b587..d6c853b 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -483,24 +483,23 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
+	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, DA9063_DRVNAME_RTC,
+					   &da9063_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
+	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
+	rtc->rtc_sync = false;
+
 	irq_alarm = platform_get_irq_byname(pdev, "ALARM");
 	ret = devm_request_threaded_irq(&pdev->dev, irq_alarm, NULL,
 					da9063_alarm_event,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					"ALARM", rtc);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "Failed to request ALARM IRQ %d: %d\n",
 			irq_alarm, ret);
-		return ret;
-	}
-
-	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, DA9063_DRVNAME_RTC,
-					   &da9063_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtc_dev))
-		return PTR_ERR(rtc->rtc_dev);
 
-	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
-	rtc->rtc_sync = false;
 	return ret;
 }
 
-- 
end-of-patch for PATCH V1

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
