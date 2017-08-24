Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33046 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdHXIxC (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 24 Aug 2017 04:53:02 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2] rtc: remove .open() and .release()
Date: Thu, 24 Aug 2017 10:52:59 +0200
Message-Id: <20170824085259.12886-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

There are no driver left using .open and .release. There is no good use
case for them as there is nothing the character device interface does that
should not be done in the sysfs interface or in-kernel interface.

Remove those callbacks now to avoid future confusion.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Changes in v2:
 - remove warning


 drivers/rtc/rtc-dev.c | 19 ++++---------------
 include/linux/rtc.h   |  2 --
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index 794bc4fa4937..2f5f6d6aa79a 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -27,25 +27,17 @@ static int rtc_dev_open(struct inode *inode, struct file *file)
 	int err;
 	struct rtc_device *rtc = container_of(inode->i_cdev,
 					struct rtc_device, char_dev);
-	const struct rtc_class_ops *ops = rtc->ops;
 
 	if (test_and_set_bit_lock(RTC_DEV_BUSY, &rtc->flags))
 		return -EBUSY;
 
 	file->private_data = rtc;
 
-	err = ops->open ? ops->open(rtc->dev.parent) : 0;
-	if (err == 0) {
-		spin_lock_irq(&rtc->irq_lock);
-		rtc->irq_data = 0;
-		spin_unlock_irq(&rtc->irq_lock);
-
-		return 0;
-	}
+	spin_lock_irq(&rtc->irq_lock);
+	rtc->irq_data = 0;
+	spin_unlock_irq(&rtc->irq_lock);
 
-	/* something has gone wrong */
-	clear_bit_unlock(RTC_DEV_BUSY, &rtc->flags);
-	return err;
+	return 0;
 }
 
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
@@ -438,9 +430,6 @@ static int rtc_dev_release(struct inode *inode, struct file *file)
 	rtc_update_irq_enable(rtc, 0);
 	rtc_irq_set_state(rtc, NULL, 0);
 
-	if (rtc->ops->release)
-		rtc->ops->release(rtc->dev.parent);
-
 	clear_bit_unlock(RTC_DEV_BUSY, &rtc->flags);
 	return 0;
 }
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 0a0f0d14a5fb..e6d0f9c1cafd 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -72,8 +72,6 @@ extern struct class *rtc_class;
  * issued through ioctl() ...
  */
 struct rtc_class_ops {
-	int (*open)(struct device *);
-	void (*release)(struct device *);
 	int (*ioctl)(struct device *, unsigned int, unsigned long);
 	int (*read_time)(struct device *, struct rtc_time *);
 	int (*set_time)(struct device *, struct rtc_time *);
-- 
2.14.1
