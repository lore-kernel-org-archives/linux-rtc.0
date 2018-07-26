Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:59293 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729839AbeGZO6V (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:21 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/8] rtc: simplify rtc_irq_set_state/rtc_irq_set_freq
Date: Thu, 26 Jul 2018 15:40:53 +0200
Message-Id: <20180726134056.18273-6-alexandre.belloni@bootlin.com>
In-Reply-To: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The PIE doesn't handle tasks anymore, remove the pointer from the
interface.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 4 ++--
 drivers/rtc/rtc-dev.c   | 8 ++++----
 include/linux/rtc.h     | 6 ++----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index ae0d67610c7b..76eb3a2957cc 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -746,7 +746,7 @@ static int rtc_update_hrtimer(struct rtc_device *rtc, int enabled)
  * Note that rtc_irq_set_freq() should previously have been used to
  * specify the desired frequency of periodic IRQ.
  */
-int rtc_irq_set_state(struct rtc_device *rtc, struct rtc_task *task, int enabled)
+int rtc_irq_set_state(struct rtc_device *rtc, int enabled)
 {
 	int err = 0;
 
@@ -770,7 +770,7 @@ EXPORT_SYMBOL_GPL(rtc_irq_set_state);
  * Note that rtc_irq_set_state() is used to enable or disable the
  * periodic IRQs.
  */
-int rtc_irq_set_freq(struct rtc_device *rtc, struct rtc_task *task, int freq)
+int rtc_irq_set_freq(struct rtc_device *rtc, int freq)
 {
 	int err = 0;
 
diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index efa221e8bc22..43d962a9c210 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -341,11 +341,11 @@ static long rtc_dev_ioctl(struct file *file,
 		return rtc_set_time(rtc, &tm);
 
 	case RTC_PIE_ON:
-		err = rtc_irq_set_state(rtc, NULL, 1);
+		err = rtc_irq_set_state(rtc, 1);
 		break;
 
 	case RTC_PIE_OFF:
-		err = rtc_irq_set_state(rtc, NULL, 0);
+		err = rtc_irq_set_state(rtc, 0);
 		break;
 
 	case RTC_AIE_ON:
@@ -365,7 +365,7 @@ static long rtc_dev_ioctl(struct file *file,
 		return rtc_update_irq_enable(rtc, 0);
 
 	case RTC_IRQP_SET:
-		err = rtc_irq_set_freq(rtc, NULL, arg);
+		err = rtc_irq_set_freq(rtc, arg);
 		break;
 
 	case RTC_IRQP_READ:
@@ -427,7 +427,7 @@ static int rtc_dev_release(struct inode *inode, struct file *file)
 	/* Keep ioctl until all drivers are converted */
 	rtc_dev_ioctl(file, RTC_UIE_OFF, 0);
 	rtc_update_irq_enable(rtc, 0);
-	rtc_irq_set_state(rtc, NULL, 0);
+	rtc_irq_set_state(rtc, 0);
 
 	clear_bit_unlock(RTC_DEV_BUSY, &rtc->flags);
 	return 0;
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 8cc23fdfd4ee..bf4d375025d1 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -202,10 +202,8 @@ extern void rtc_update_irq(struct rtc_device *rtc,
 extern struct rtc_device *rtc_class_open(const char *name);
 extern void rtc_class_close(struct rtc_device *rtc);
 
-extern int rtc_irq_set_state(struct rtc_device *rtc,
-				struct rtc_task *task, int enabled);
-extern int rtc_irq_set_freq(struct rtc_device *rtc,
-				struct rtc_task *task, int freq);
+extern int rtc_irq_set_state(struct rtc_device *rtc, int enabled);
+extern int rtc_irq_set_freq(struct rtc_device *rtc, int freq);
 extern int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled);
 extern int rtc_alarm_irq_enable(struct rtc_device *rtc, unsigned int enabled);
 extern int rtc_dev_update_irq_enable_emul(struct rtc_device *rtc,
-- 
2.18.0
