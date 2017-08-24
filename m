Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46350 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbdHXKak (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 24 Aug 2017 06:30:40 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: ds1307: call the platform's logic for handle IRQs.
Date: Thu, 24 Aug 2017 12:30:26 +0200
Message-Id: <20170824103026.18231-1-enric.balletbo@collabora.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On some systems the nIRQ pin is often connect to a GPIO, then, if a given
interrupt line is supposed to wake up the system, the corresponding input
of that interrupt controller need to be enabled to receive signal from the
line in question. Before this commit such systems would not wake up
because are not marked as wakeup IRQs in the IRQ subsystem.

This commit calls enable_irq_wake() on suspend and disables that input to
prevent the dedicated controller from triggering interrupts unnecessarily
after wakeup.

After this commit a system composed by a RTC DS1339 chip connected to a
GPIO line on a AM335x SoC is able to wakeup from suspend-to-RAM, otherwise
the line is ignored.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/rtc/rtc-ds1307.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 4b43aa6..c4b0f6a 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1711,11 +1711,36 @@ static int ds1307_probe(struct i2c_client *client,
 	return err;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int ds1307_suspend(struct device *dev)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(ds1307->irq);
+
+	return 0;
+}
+
+static int ds1307_resume(struct device *dev)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(ds1307->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(ds1307_pm_ops, ds1307_suspend, ds1307_resume);
+
 static struct i2c_driver ds1307_driver = {
 	.driver = {
 		.name	= "rtc-ds1307",
 		.of_match_table = of_match_ptr(ds1307_of_match),
 		.acpi_match_table = ACPI_PTR(ds1307_acpi_ids),
+		.pm	= &ds1307_pm_ops,
 	},
 	.probe		= ds1307_probe,
 	.id_table	= ds1307_id,
-- 
2.9.3
