Return-Path: <rtc-linux+bncBAABBGHVXW4AKGQEOE7DEIA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com. [193.109.254.111])
        by gmr-mx.google.com with ESMTPS id s141si924214wmd.1.2016.04.14.04.10.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Apr 2016 04:10:16 -0700 (PDT)
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Thu, 14 Apr 2016 12:04:54 +0100
Subject: [rtc-linux] [PATCH V1] rtc: da9053: fix access ordering error during
 RTC interrupt at system power on
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, RTC-LINUX <rtc-linux@googlegroups.com>
CC: Support Opensource <support.opensource@diasemi.com>
Message-ID: <20160414111014.BB8B73FB1D@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Steve Twiss <stwiss.opensource@diasemi.com>

This fix alters the ordering of the IRQ and device registrations in the RTC
driver probe function. This change will apply to the RTC driver that supports
both DA9052 and DA9053 PMICs.

A problem could occur with the existing RTC driver if:

A system is started from a cold boot using the PMIC RTC IRQ to initiate a
power on operation. For instance, if an RTC alarm is used to start a
platform from power off.
The existing driver IRQ is requested before the device has been properly
registered.

i.e.
ret = da9052_request_irq()
comes before
rtc->rtc = devm_rtc_device_register();

In this case, an interrupt exists before the device has been registered and
the IRQ handler can be called immediately: this can happen be before the
memory for rtc->rtc has been allocated. The IRQ handler da9052_rtc_irq()
contains the function call:

rtc_update_irq(rtc->rtc, 1, RTC_IRQF | RTC_AF);

which in turn tries to access the unavailable rtc->rtc.

The fix is to reorder the functions inside the RTC probe. The IRQ is
requested after the RTC device resource has been registered so that
da9052_request_irq() is the last thing to happen.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.6-rc3

This wake-up IRQ fault is similar to the one previously fixed in the
DA9063 and DA9062 driver code.

See reference:
commit 77535acedc26627f16a1a39c1471f942689fe11e
Author: Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue Dec 8 16:28:39 2015 +0000

Regards,
Steve


 drivers/rtc/rtc-da9052.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-da9052.c b/drivers/rtc/rtc-da9052.c
index 1ba4371..a20bcf0 100644
--- a/drivers/rtc/rtc-da9052.c
+++ b/drivers/rtc/rtc-da9052.c
@@ -302,6 +302,13 @@ static int da9052_rtc_probe(struct platform_device *pdev)
 	if (ret != 0)
 		rtc_err(rtc, "Failed to disable TICKS: %d\n", ret);
 
+	device_init_wakeup(&pdev->dev, true);
+	rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
+				       &da9052_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rtc->rtc))
+		return PTR_ERR(rtc->rtc);
+
 	ret = da9052_request_irq(rtc->da9052, DA9052_IRQ_ALARM, "ALM",
 				da9052_rtc_irq, rtc);
 	if (ret != 0) {
@@ -309,11 +316,7 @@ static int da9052_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	device_init_wakeup(&pdev->dev, true);
-
-	rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-				       &da9052_rtc_ops, THIS_MODULE);
-	return PTR_ERR_OR_ZERO(rtc->rtc);
+	return 0;
 }
 
 static struct platform_driver da9052_rtc_driver = {
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
