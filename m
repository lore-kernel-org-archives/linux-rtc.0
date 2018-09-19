Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:33545 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbeISGsy (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 19 Sep 2018 02:48:54 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: move rtc_add_group/s definitions
Date: Wed, 19 Sep 2018 03:13:21 +0200
Message-Id: <20180919011322.3985-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Move rtc_add_group and rtc_add_groups definition to rtc.h that is available
for all RTC drivers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-core.h | 14 --------------
 include/linux/rtc.h    | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-core.h b/drivers/rtc/rtc-core.h
index ccc17a2e293d..0abf98983e13 100644
--- a/drivers/rtc/rtc-core.h
+++ b/drivers/rtc/rtc-core.h
@@ -40,23 +40,9 @@ static inline void rtc_proc_del_device(struct rtc_device *rtc)
 
 #ifdef CONFIG_RTC_INTF_SYSFS
 const struct attribute_group **rtc_get_dev_attribute_groups(void);
-int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp);
-int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps);
 #else
 static inline const struct attribute_group **rtc_get_dev_attribute_groups(void)
 {
 	return NULL;
 }
-
-static inline
-int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
-{
-	return 0;
-}
-
-static inline
-int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
-{
-	return 0;
-}
 #endif
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index faf00a1472d4..c8bb4a2b48c3 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -272,4 +272,20 @@ static inline int rtc_nvmem_register(struct rtc_device *rtc,
 static inline void rtc_nvmem_unregister(struct rtc_device *rtc) {}
 #endif
 
+#ifdef CONFIG_RTC_INTF_SYSFS
+int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp);
+int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps);
+#else
+static inline
+int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
+{
+	return 0;
+}
+
+static inline
+int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
+{
+	return 0;
+}
+#endif
 #endif /* _LINUX_RTC_H_ */
-- 
2.19.0
