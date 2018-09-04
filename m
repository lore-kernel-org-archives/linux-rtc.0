Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726004AbeIDTQ5 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 4 Sep 2018 15:16:57 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: cmos: Do not export alarm rtc_ops when we do not support alarms
Date: Tue,  4 Sep 2018 16:51:29 +0200
Message-Id: <20180904145129.17098-1-hdegoede@redhat.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

When there is no IRQ configured for the RTC, the rtc-cmos code does not
support alarms, all alarm rtc_ops fail with -EIO / -EINVAL.

The rtc-core expects a rtc driver which does not support rtc alarms to
not have alarm ops at all. Otherwise the wakealarm sysfs attr will read
as empty rather then returning an error, making it impossible for
userspace to find out beforehand if alarms are supported.

A system without an IRQ for the RTC before this patch:
[root@localhost ~]# cat /sys/class/rtc/rtc0/wakealarm
[root@localhost ~]#

After this patch:
[root@localhost ~]# cat /sys/class/rtc/rtc0/wakealarm
cat: /sys/class/rtc/rtc0/wakealarm: No such file or directory
[root@localhost ~]#

This fixes gnome-session + systemd trying to use suspend-then-hibernate,
which causes systemd to abort the suspend when writing the RTC alarm fails.

BugLink: https://github.com/systemd/systemd/issues/9988
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/rtc/rtc-cmos.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index cd3a2411bc2f..490cdbca4430 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -244,6 +244,7 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	unsigned char	rtc_control;
 
+	/* This not only a rtc_op, but also called directly */
 	if (!is_valid_irq(cmos->irq))
 		return -EIO;
 
@@ -439,6 +440,7 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	unsigned char mon, mday, hrs, min, sec, rtc_control;
 	int ret;
 
+	/* This not only a rtc_op, but also called directly */
 	if (!is_valid_irq(cmos->irq))
 		return -EIO;
 
@@ -503,9 +505,6 @@ static int cmos_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	unsigned long	flags;
 
-	if (!is_valid_irq(cmos->irq))
-		return -EINVAL;
-
 	spin_lock_irqsave(&rtc_lock, flags);
 
 	if (enabled)
@@ -566,6 +565,12 @@ static const struct rtc_class_ops cmos_rtc_ops = {
 	.alarm_irq_enable	= cmos_alarm_irq_enable,
 };
 
+static const struct rtc_class_ops cmos_rtc_ops_no_alarm = {
+	.read_time		= cmos_read_time,
+	.set_time		= cmos_set_time,
+	.proc			= cmos_procfs,
+};
+
 /*----------------------------------------------------------------*/
 
 /*
@@ -842,9 +847,12 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 			dev_dbg(dev, "IRQ %d is already in use\n", rtc_irq);
 			goto cleanup1;
 		}
+
+		cmos_rtc.rtc->ops = &cmos_rtc_ops;
+	} else {
+		cmos_rtc.rtc->ops = &cmos_rtc_ops_no_alarm;
 	}
 
-	cmos_rtc.rtc->ops = &cmos_rtc_ops;
 	cmos_rtc.rtc->nvram_old_abi = true;
 	retval = rtc_register_device(cmos_rtc.rtc);
 	if (retval)
-- 
2.19.0.rc0
