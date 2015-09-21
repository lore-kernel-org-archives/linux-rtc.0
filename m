Return-Path: <rtc-linux+bncBD7ZDTFR7QFRBNWNQCYAKGQEPCS6IJQ@googlegroups.com>
MIME-Version: 1.0
Received: from foss.arm.com (foss.arm.com. [217.140.101.70])
        by gmr-mx.google.com with ESMTP id el2si2078074pbb.0.2015.09.21.08.48.06
        for <rtc-linux@googlegroups.com>;
        Mon, 21 Sep 2015 08:48:06 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 02/17] rtc: ab8500: remove misuse of
 IRQF_NO_SUSPEND flag
Date: Mon, 21 Sep 2015 16:46:58 +0100
Message-Id: <1442850433-5903-3-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
be left enabled so as to allow them to work as expected during the
suspend-resume cycle, but doesn't guarantee that it will wake the system
from a suspended state, enable_irq_wake is recommended to be used for
the wakeup.

This patch removes the use of IRQF_NO_SUSPEND flags and uses newly
introduce PM wakeup APIs dev_pm_{set,clear}_wake_irq.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/rtc/rtc-ab8500.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 51407c4c7bd2..24a0af650a1b 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -18,6 +18,7 @@
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/delay.h>
 #include <linux/of.h>
+#include <linux/pm_wakeirq.h>
 
 #define AB8500_RTC_SOFF_STAT_REG	0x00
 #define AB8500_RTC_CC_CONF_REG		0x01
@@ -493,11 +494,12 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 	}
 
 	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-			rtc_alarm_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
+			rtc_alarm_handler, IRQF_ONESHOT,
 			"ab8500-rtc", rtc);
 	if (err < 0)
 		return err;
 
+	dev_pm_set_wake_irq(&pdev->dev, irq);
 	platform_set_drvdata(pdev, rtc);
 
 	err = ab8500_sysfs_rtc_register(&pdev->dev);
@@ -513,6 +515,8 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 
 static int ab8500_rtc_remove(struct platform_device *pdev)
 {
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
 	ab8500_sysfs_rtc_unregister(&pdev->dev);
 
 	return 0;
-- 
1.9.1

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
