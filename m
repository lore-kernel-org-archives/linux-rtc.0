Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:39931 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbeIMB3K (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 12 Sep 2018 21:29:10 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: unexport non devm managed registration
Date: Wed, 12 Sep 2018 22:22:45 +0200
Message-Id: <20180912202245.14789-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Ensure the non managed version of the un/registration functions is not used
anymore. No driver is using it anymore and they should not be necessary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c | 12 +++++-------
 include/linux/rtc.h |  5 -----
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 0fca4d74c76b..3b43787f154b 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -286,9 +286,10 @@ static void rtc_device_get_offset(struct rtc_device *rtc)
  *
  * Returns the pointer to the new struct class device.
  */
-struct rtc_device *rtc_device_register(const char *name, struct device *dev,
-					const struct rtc_class_ops *ops,
-					struct module *owner)
+static struct rtc_device *rtc_device_register(const char *name,
+					      struct device *dev,
+					      const struct rtc_class_ops *ops,
+					      struct module *owner)
 {
 	struct rtc_device *rtc;
 	struct rtc_wkalrm alrm;
@@ -351,15 +352,13 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 			name, err);
 	return ERR_PTR(err);
 }
-EXPORT_SYMBOL_GPL(rtc_device_register);
-
 
 /**
  * rtc_device_unregister - removes the previously registered RTC class device
  *
  * @rtc: the RTC class device to destroy
  */
-void rtc_device_unregister(struct rtc_device *rtc)
+static void rtc_device_unregister(struct rtc_device *rtc)
 {
 	mutex_lock(&rtc->ops_lock);
 	/*
@@ -372,7 +371,6 @@ void rtc_device_unregister(struct rtc_device *rtc)
 	mutex_unlock(&rtc->ops_lock);
 	put_device(&rtc->dev);
 }
-EXPORT_SYMBOL_GPL(rtc_device_unregister);
 
 static void devm_rtc_device_release(struct device *dev, void *res)
 {
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 6aedc30003e7..faf00a1472d4 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -167,17 +167,12 @@ struct rtc_device {
 #define RTC_TIMESTAMP_BEGIN_2000	946684800LL /* 2000-01-01 00:00:00 */
 #define RTC_TIMESTAMP_END_2099		4102444799LL /* 2099-12-31 23:59:59 */
 
-extern struct rtc_device *rtc_device_register(const char *name,
-					struct device *dev,
-					const struct rtc_class_ops *ops,
-					struct module *owner);
 extern struct rtc_device *devm_rtc_device_register(struct device *dev,
 					const char *name,
 					const struct rtc_class_ops *ops,
 					struct module *owner);
 struct rtc_device *devm_rtc_allocate_device(struct device *dev);
 int __rtc_register_device(struct module *owner, struct rtc_device *rtc);
-extern void rtc_device_unregister(struct rtc_device *rtc);
 extern void devm_rtc_device_unregister(struct device *dev,
 					struct rtc_device *rtc);
 
-- 
2.19.0.rc2
