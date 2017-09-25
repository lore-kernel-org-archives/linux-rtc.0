Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from m50-138.163.com ([123.125.50.138]:38887 "EHLO m50-138.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935345AbdIYMOZ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 25 Sep 2017 08:14:25 -0400
From: "winton.liu" <18502523564@163.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "winton.liu" <18502523564@163.com>
Subject: [PATCH] rtc: ds1374: wdt:support suspend/resume for watchdog
Date: Mon, 25 Sep 2017 19:58:44 +0800
Message-Id: <1506340724-18108-1-git-send-email-18502523564@163.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

When enable CONFIG_RTC_DRV_DS1374_WDT use as watchdog,
in suspend mode, watchdog is still working but no daemon
patting the watchdog. The system will reboot if timeout.
So disable watchdog in suspend  and recover it in resume.

Signed-off-by: winton.liu <18502523564@163.com>
---
 drivers/rtc/rtc-ds1374.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 38a2e9e..e990773 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -690,6 +690,10 @@ static int ds1374_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
+#ifdef CONFIG_RTC_DRV_DS1374_WDT
+	ds1374_wdt_disable();
+#endif
+
 	if (client->irq > 0 && device_may_wakeup(&client->dev))
 		enable_irq_wake(client->irq);
 	return 0;
@@ -699,6 +703,10 @@ static int ds1374_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
+#ifdef CONFIG_RTC_DRV_DS1374_WDT
+	ds1374_wdt_settimeout(131072);
+#endif
+
 	if (client->irq > 0 && device_may_wakeup(&client->dev))
 		disable_irq_wake(client->irq);
 	return 0;
-- 
1.9.1
