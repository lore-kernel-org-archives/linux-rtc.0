Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48232 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbdHWAdJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 22 Aug 2017 20:33:09 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: remove .open() and .release()
Date: Wed, 23 Aug 2017 02:33:04 +0200
Message-Id: <20170823003304.20031-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

There are no driver left using .open and .release. There is no good use
case for them as there is nothing the character device interface does that
should not be done in the sysfs interface or in-kernel interface.

Remove those callbacks now to avoid future confusion.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-dev.c | 18 ++++--------------
 include/linux/rtc.h   |  2 --
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index 794bc4fa4937..107e5ca95113 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -34,18 +34,11 @@ static int rtc_dev_open(struct inode *inode, struct file *file)
 
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
@@ -438,9 +431,6 @@ static int rtc_dev_release(struct inode *inode, struct file *file)
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
