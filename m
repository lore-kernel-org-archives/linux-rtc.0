Return-Path: <rtc-linux+bncBDV5RYXUY4LRBKMM3DBQKGQE5ZTASMY@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id 133si1087681wmj.1.2017.01.11.02.17.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 11 Jan 2017 02:17:13 -0800 (PST)
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>,Andrew Lunn <andrew@lunn.ch>,Gregory Clement <gregory.clement@free-electrons.com>,Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,Alessandro Zummo <a.zummo@towertech.it>,linux-arm-kernel@lists.infradead.org,rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] rtc: armada38x: make struct rtc_class_ops const
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <E1cRFxi-00083n-FY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 11 Jan 2017 10:16:58 +0000
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Armada38x wants to modify its rtc_class_ops to remove the interrupt
handling when there is no usable interrupt, but this means we leave
function pointers in writable memory.

Since rtc_class_ops is small, arrange to have two instances, one for
when we have interrupts, and one for when we have none, both marked
const.  This allows the compiler to place them in read-only memory,
which is better than placing them in __ro_after_init.

Thanks to Bhumika Goyal <bhumirks@gmail.com> for pointing out that
the structure was writable and submitting a patch to add
__ro_after_init.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
As the thread has gone quiet, I'm submitting the patch I sent within that
thread.  No one appears to have raised an objection to it (other than what
appears to be a misunderstanding.)

 drivers/rtc/rtc-armada38x.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 9a3f2a6f512e..a4166ccfce36 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -202,7 +202,7 @@ static irqreturn_t armada38x_rtc_alarm_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct rtc_class_ops armada38x_rtc_ops = {
+static const struct rtc_class_ops armada38x_rtc_ops = {
 	.read_time = armada38x_rtc_read_time,
 	.set_time = armada38x_rtc_set_time,
 	.read_alarm = armada38x_rtc_read_alarm,
@@ -210,8 +210,15 @@ static struct rtc_class_ops armada38x_rtc_ops = {
 	.alarm_irq_enable = armada38x_rtc_alarm_irq_enable,
 };
 
+static const struct rtc_class_ops armada38x_rtc_ops_noirq = {
+	.read_time = armada38x_rtc_read_time,
+	.set_time = armada38x_rtc_set_time,
+	.read_alarm = armada38x_rtc_read_alarm,
+};
+
 static __init int armada38x_rtc_probe(struct platform_device *pdev)
 {
+	const struct rtc_class_ops *ops;
 	struct resource *res;
 	struct armada38x_rtc *rtc;
 	int ret;
@@ -242,19 +249,22 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
 				0, pdev->name, rtc) < 0) {
 		dev_warn(&pdev->dev, "Interrupt not available.\n");
 		rtc->irq = -1;
+	}
+	platform_set_drvdata(pdev, rtc);
+
+	if (rtc->irq != -1) {
+		device_init_wakeup(&pdev->dev, 1);
+		ops = &armada38x_rtc_ops;
+	} else {
 		/*
 		 * If there is no interrupt available then we can't
 		 * use the alarm
 		 */
-		armada38x_rtc_ops.set_alarm = NULL;
-		armada38x_rtc_ops.alarm_irq_enable = NULL;
+		ops = &armada38x_rtc_ops_noirq;
 	}
-	platform_set_drvdata(pdev, rtc);
-	if (rtc->irq != -1)
-		device_init_wakeup(&pdev->dev, 1);
 
 	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
-					&armada38x_rtc_ops, THIS_MODULE);
+						ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev)) {
 		ret = PTR_ERR(rtc->rtc_dev);
 		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
