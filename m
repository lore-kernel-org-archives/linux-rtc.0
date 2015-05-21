Return-Path: <rtc-linux+bncBAABB2PT66VAKGQEE4Z7CRA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.kmu-office.ch (mail.kmu-office.ch. [2a02:418:6a02::a2])
        by gmr-mx.google.com with ESMTP id t6si127450wiz.0.2015.05.21.08.29.44
        for <rtc-linux@googlegroups.com>;
        Thu, 21 May 2015 08:29:44 -0700 (PDT)
From: Stefan Agner <stefan@agner.ch>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: maitysanchayan@gmail.com,
	shawn.guo@linaro.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Stefan Agner <stefan@agner.ch>
Subject: [rtc-linux] [PATCH] rtc: snvs: fix wakealarm by call enable_irq_wake earlier
Date: Thu, 21 May 2015 17:29:35 +0200
Message-Id: <1432222175-30673-1-git-send-email-stefan@agner.ch>
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

When entering suspend while an wakeup alarm is set, enable_set_wake
should make sure that the RTC interrupt keep being enabled and the
.irq_set_wake for the RTC interrupt get called. However, since the
driver uses the suspend_noirq callback, the call to enable_irq_wake
has been made after disabling the interrupts. While .irq_set_wake
has been called properly, the interrupt remained disabled.

Use the suspend callback to call enable_irq_wake early enough to
ensure the RTC interrupt remains enabled.

Fixes: 7654e9d4fd8f ("drivers/rtc/rtc-snvs: fix suspend/resume")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/rtc/rtc-snvs.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 0479e80..d87a85c 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -322,6 +322,13 @@ static int snvs_rtc_suspend(struct device *dev)
 	if (device_may_wakeup(dev))
 		enable_irq_wake(data->irq);
 
+	return 0;
+}
+
+static int snvs_rtc_suspend_noirq(struct device *dev)
+{
+	struct snvs_rtc_data *data = dev_get_drvdata(dev);
+
 	if (data->clk)
 		clk_disable_unprepare(data->clk);
 
@@ -331,23 +338,28 @@ static int snvs_rtc_suspend(struct device *dev)
 static int snvs_rtc_resume(struct device *dev)
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
-	int ret;
 
 	if (device_may_wakeup(dev))
-		disable_irq_wake(data->irq);
+		return disable_irq_wake(data->irq);
 
-	if (data->clk) {
-		ret = clk_prepare_enable(data->clk);
-		if (ret)
-			return ret;
-	}
+	return 0;
+}
+
+static int snvs_rtc_resume_noirq(struct device *dev)
+{
+	struct snvs_rtc_data *data = dev_get_drvdata(dev);
+
+	if (data->clk)
+		return clk_prepare_enable(data->clk);
 
 	return 0;
 }
 
 static const struct dev_pm_ops snvs_rtc_pm_ops = {
-	.suspend_noirq = snvs_rtc_suspend,
-	.resume_noirq = snvs_rtc_resume,
+	.suspend = snvs_rtc_suspend,
+	.suspend_noirq = snvs_rtc_suspend_noirq,
+	.resume = snvs_rtc_resume,
+	.resume_noirq = snvs_rtc_resume_noirq,
 };
 
 #define SNVS_RTC_PM_OPS	(&snvs_rtc_pm_ops)
-- 
2.4.1

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
