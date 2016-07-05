Return-Path: <rtc-linux+bncBAABBLV7525QKGQESDMDMKQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.phycard.co.uk. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id r10si83181wmf.0.2016.07.05.04.53.18
        for <rtc-linux@googlegroups.com>;
        Tue, 05 Jul 2016 04:53:18 -0700 (PDT)
From: Stefan Christ <s.christ@phytec.de>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com, rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 2/2] rtc: m41t80: add suspend handlers for alarm IRQ
Date: Tue, 5 Jul 2016 13:53:17 +0200
Message-Id: <1467719597-5593-2-git-send-email-s.christ@phytec.de>
In-Reply-To: <1467719597-5593-1-git-send-email-s.christ@phytec.de>
References: <1467719597-5593-1-git-send-email-s.christ@phytec.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Allow the alarm IRQ of RTC to be used as a wakeup source for the system
suspend.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
 drivers/rtc/rtc-m41t80.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 04e8577..4f09089 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -337,6 +337,30 @@ static struct rtc_class_ops m41t80_rtc_ops = {
 	.proc = m41t80_rtc_proc,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int m41t80_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (client->irq >= 0 && device_may_wakeup(dev))
+		enable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static int m41t80_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (client->irq >= 0 && device_may_wakeup(dev))
+		disable_irq_wake(client->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(m41t80_pm, m41t80_suspend, m41t80_resume);
+
 static ssize_t flags_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
@@ -873,6 +897,7 @@ static int m41t80_remove(struct i2c_client *client)
 static struct i2c_driver m41t80_driver = {
 	.driver = {
 		.name = "rtc-m41t80",
+		.pm = &m41t80_pm,
 	},
 	.probe = m41t80_probe,
 	.remove = m41t80_remove,
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
