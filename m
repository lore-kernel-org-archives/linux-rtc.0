Return-Path: <rtc-linux+bncBD66BCOYSQBBBT5OY3AAKGQE2ENI76A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTPS id 200si58647itz.2.2016.10.26.22.57.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Oct 2016 22:57:35 -0700 (PDT)
From: Keerthy <j-keerthy@ti.com>
To: <alexandre.belloni@free-electrons.com>
CC: <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lokeshvutla@ti.com>, <j-keerthy@ti.com>, <t-kristo@ti.com>
Subject: [rtc-linux] [PATCH 2/2] rtc: omap: prevent disabling of clock/module
 during suspend
Date: Thu, 27 Oct 2016 11:27:26 +0530
Message-ID: <1477547846-5335-2-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1477547846-5335-1-git-send-email-j-keerthy@ti.com>
References: <1477547846-5335-1-git-send-email-j-keerthy@ti.com>
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

From: Tero Kristo <t-kristo@ti.com>

If RTC is running from an internal clock source, the RTC module can't
be disabled; otherwise it stops ticking completely. Current suspend
handler implementation disables the clock/module unconditionally,
instead fix this by disabling the clock only if we are running on
external clock source, which is not affected by suspend.

The prevention of disabling the clock must be done via implementing
the runtime_pm handlers for the device, and returning an error code
from the runtime suspend handler; otherwise OMAP core PM will disable
the clocks for the driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Boot tested and checked for rtc ticking on am335x-boneblack, am335x-bone
am437x-gp-evm, dra7-evm, dra72-evm.

 drivers/rtc/rtc-omap.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index dddaa60..51e5244 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -147,6 +147,7 @@ struct omap_rtc {
 	u8 interrupts_reg;
 	bool is_pmic_controller;
 	bool has_ext_clk;
+	bool is_suspending;
 	const struct omap_rtc_device_type *type;
 	struct pinctrl_dev *pctldev;
 };
@@ -900,8 +901,7 @@ static int omap_rtc_suspend(struct device *dev)
 		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
 	rtc->type->lock(rtc);
 
-	/* Disable the clock/module */
-	pm_runtime_put_sync(dev);
+	rtc->is_suspending = true;
 
 	return 0;
 }
@@ -910,9 +910,6 @@ static int omap_rtc_resume(struct device *dev)
 {
 	struct omap_rtc *rtc = dev_get_drvdata(dev);
 
-	/* Enable the clock/module so that we can access the registers */
-	pm_runtime_get_sync(dev);
-
 	rtc->type->unlock(rtc);
 	if (device_may_wakeup(dev))
 		disable_irq_wake(rtc->irq_alarm);
@@ -920,11 +917,34 @@ static int omap_rtc_resume(struct device *dev)
 		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, rtc->interrupts_reg);
 	rtc->type->lock(rtc);
 
+	rtc->is_suspending = false;
+
 	return 0;
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(omap_rtc_pm_ops, omap_rtc_suspend, omap_rtc_resume);
+#ifdef CONFIG_PM
+static int omap_rtc_runtime_suspend(struct device *dev)
+{
+	struct omap_rtc *rtc = dev_get_drvdata(dev);
+
+	if (rtc->is_suspending && !rtc->has_ext_clk)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int omap_rtc_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops omap_rtc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(omap_rtc_suspend, omap_rtc_resume)
+	SET_RUNTIME_PM_OPS(omap_rtc_runtime_suspend,
+			   omap_rtc_runtime_resume, NULL)
+};
 
 static void omap_rtc_shutdown(struct platform_device *pdev)
 {
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
