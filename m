Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46949 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932568AbdHWUp2 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 23 Aug 2017 16:45:28 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: vr41xx: make alarms useful
Date: Wed, 23 Aug 2017 22:44:59 +0200
Message-Id: <20170823204459.4866-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Currently, the IRQs are disabled when the rtc character device is closed.
This means that the device needs to stay open to get alarms while the usual
use case will open the device, set the alarm and close the device.

Keep the alarms functional on character device release. Note that the PIE
are never enabled and would anyway be disabled by the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-vr41xx.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index e1b86bb01062..7ce22967fd16 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -119,23 +119,6 @@ static inline void write_elapsed_second(unsigned long sec)
 	spin_unlock_irq(&rtc_lock);
 }
 
-static void vr41xx_rtc_release(struct device *dev)
-{
-
-	spin_lock_irq(&rtc_lock);
-
-	rtc1_write(ECMPLREG, 0);
-	rtc1_write(ECMPMREG, 0);
-	rtc1_write(ECMPHREG, 0);
-	rtc1_write(RTCL1LREG, 0);
-	rtc1_write(RTCL1HREG, 0);
-
-	spin_unlock_irq(&rtc_lock);
-
-	disable_irq(aie_irq);
-	disable_irq(pie_irq);
-}
-
 static int vr41xx_rtc_read_time(struct device *dev, struct rtc_time *time)
 {
 	unsigned long epoch_sec, elapsed_sec;
@@ -272,7 +255,6 @@ static irqreturn_t rtclong1_interrupt(int irq, void *dev_id)
 }
 
 static const struct rtc_class_ops vr41xx_rtc_ops = {
-	.release		= vr41xx_rtc_release,
 	.ioctl			= vr41xx_rtc_ioctl,
 	.read_time		= vr41xx_rtc_read_time,
 	.set_time		= vr41xx_rtc_set_time,
-- 
2.14.1
