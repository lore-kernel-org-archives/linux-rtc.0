Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49163 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbdGFJmb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Jul 2017 05:42:31 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 05/11] rtc: add generic nvmem support
Date: Thu,  6 Jul 2017 11:42:02 +0200
Message-Id: <20170706094208.16240-6-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
References: <20170706094208.16240-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Many RTCs have an on board non volatile storage. It can be battery backed
RAM or an EEPROM. Use the nvmem subsystem to export it to both userspace
and in-kernel consumers.

This stays compatible with the previous (non documented) ABI that was using
/sys/class/rtc/rtcx/device/nvram to export that memory. But will warn about
the deprecation.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/rtc.txt  |   2 +
 drivers/rtc/Kconfig    |   8 ++++
 drivers/rtc/Makefile   |   1 +
 drivers/rtc/class.c    |   4 ++
 drivers/rtc/nvmem.c    | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/rtc/rtc-core.h |   8 ++++
 include/linux/rtc.h    |   7 +++
 7 files changed, 143 insertions(+)
 create mode 100644 drivers/rtc/nvmem.c

diff --git a/Documentation/rtc.txt b/Documentation/rtc.txt
index 47feb4414b7e..c0c977445fb9 100644
--- a/Documentation/rtc.txt
+++ b/Documentation/rtc.txt
@@ -164,6 +164,8 @@ offset		 The amount which the rtc clock has been adjusted in firmware.
 		 which are added to or removed from the rtc's base clock per
 		 billion ticks. A positive value makes a day pass more slowly,
 		 longer, and a negative value makes a day pass more quickly.
+*/nvmem		 The non volatile storage exported as a raw file, as described
+		 in Documentation/nvmem/nvmem.txt
 ================ ==============================================================
 
 IOCTL interface
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index d0e4b4a1c2a1..72419ac2c52a 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -77,6 +77,14 @@ config RTC_DEBUG
 	  Say yes here to enable debugging support in the RTC framework
 	  and individual RTC drivers.
 
+config RTC_NVMEM
+	bool "RTC non volatile storage support"
+	select NVMEM
+	default RTC_CLASS
+	help
+	  Say yes here to add support for the non volatile (often battery
+	  backed) storage present on RTCs.
+
 comment "RTC interfaces"
 
 config RTC_INTF_SYSFS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 4050fc8b9271..acd366b41c85 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -15,6 +15,7 @@ ifdef CONFIG_RTC_DRV_EFI
 rtc-core-y			+= rtc-efi-platform.o
 endif
 
+rtc-core-$(CONFIG_RTC_NVMEM)		+= nvmem.o
 rtc-core-$(CONFIG_RTC_INTF_DEV)		+= rtc-dev.o
 rtc-core-$(CONFIG_RTC_INTF_PROC)	+= rtc-proc.o
 rtc-core-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysfs.o
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 58e2a05765bb..2ed970d61da1 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -290,6 +290,8 @@ EXPORT_SYMBOL_GPL(rtc_device_register);
  */
 void rtc_device_unregister(struct rtc_device *rtc)
 {
+	rtc_nvmem_unregister(rtc);
+
 	mutex_lock(&rtc->ops_lock);
 	/*
 	 * Remove innards of this RTC, then disable it, before
@@ -448,6 +450,8 @@ int __rtc_register_device(struct module *owner, struct rtc_device *rtc)
 
 	rtc_proc_add_device(rtc);
 
+	rtc_nvmem_register(rtc);
+
 	rtc->registered = true;
 	dev_info(rtc->dev.parent, "registered as %s\n",
 		 dev_name(&rtc->dev));
diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
new file mode 100644
index 000000000000..8567b4ed9ac6
--- /dev/null
+++ b/drivers/rtc/nvmem.c
@@ -0,0 +1,113 @@
+/*
+ * RTC subsystem, nvmem interface
+ *
+ * Copyright (C) 2017 Alexandre Belloni
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/types.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/rtc.h>
+#include <linux/sysfs.h>
+
+#include "rtc-core.h"
+
+/*
+ * Deprecated ABI compatibility, this should be removed at some point
+ */
+
+static const char nvram_warning[] = "Deprecated ABI, please use nvmem";
+
+static ssize_t
+rtc_nvram_read(struct file *filp, struct kobject *kobj,
+	       struct bin_attribute *attr,
+	       char *buf, loff_t off, size_t count)
+{
+	struct rtc_device *rtc = attr->private;
+
+	dev_warn_once(kobj_to_dev(kobj), nvram_warning);
+
+	return nvmem_device_read(rtc->nvmem, off, count, buf);
+}
+
+static ssize_t
+rtc_nvram_write(struct file *filp, struct kobject *kobj,
+		struct bin_attribute *attr,
+		char *buf, loff_t off, size_t count)
+{
+	struct rtc_device *rtc = attr->private;
+
+	dev_warn_once(kobj_to_dev(kobj), nvram_warning);
+
+	return nvmem_device_write(rtc->nvmem, off, count, buf);
+}
+
+static int rtc_nvram_register(struct rtc_device *rtc)
+{
+	int err;
+
+	rtc->nvram = devm_kzalloc(rtc->dev.parent,
+				sizeof(struct bin_attribute),
+				GFP_KERNEL);
+	if (!rtc->nvram)
+		return -ENOMEM;
+
+	rtc->nvram->attr.name = "nvram";
+	rtc->nvram->attr.mode = 0644;
+	rtc->nvram->private = rtc;
+
+	sysfs_bin_attr_init(rtc->nvram);
+
+	rtc->nvram->read = rtc_nvram_read;
+	rtc->nvram->write = rtc_nvram_write;
+	rtc->nvram->size = rtc->nvmem_config->size;
+
+	err = sysfs_create_bin_file(&rtc->dev.parent->kobj,
+				    rtc->nvram);
+	if (err) {
+		devm_kfree(rtc->dev.parent, rtc->nvram);
+		rtc->nvram = NULL;
+	}
+
+	return err;
+}
+
+static void rtc_nvram_unregister(struct rtc_device *rtc)
+{
+	sysfs_remove_bin_file(&rtc->dev.parent->kobj, rtc->nvram);
+}
+
+/*
+ * New ABI, uses nvmem
+ */
+void rtc_nvmem_register(struct rtc_device *rtc)
+{
+	if (!rtc->nvmem_config)
+		return;
+
+	rtc->nvmem_config->dev = &rtc->dev;
+	rtc->nvmem_config->owner = rtc->owner;
+	rtc->nvmem = nvmem_register(rtc->nvmem_config);
+	if (IS_ERR_OR_NULL(rtc->nvmem))
+		return;
+
+	/* Register the old ABI */
+	if (rtc->nvram_old_abi)
+		rtc_nvram_register(rtc);
+}
+
+void rtc_nvmem_unregister(struct rtc_device *rtc)
+{
+	if (IS_ERR_OR_NULL(rtc->nvmem))
+		return;
+
+	/* unregister the old ABI */
+	if (rtc->nvram)
+		rtc_nvram_unregister(rtc);
+
+	nvmem_unregister(rtc->nvmem);
+}
diff --git a/drivers/rtc/rtc-core.h b/drivers/rtc/rtc-core.h
index 7a4ed2f7c7d7..ecab76a3207c 100644
--- a/drivers/rtc/rtc-core.h
+++ b/drivers/rtc/rtc-core.h
@@ -45,3 +45,11 @@ static inline const struct attribute_group **rtc_get_dev_attribute_groups(void)
 	return NULL;
 }
 #endif
+
+#ifdef CONFIG_RTC_NVMEM
+void rtc_nvmem_register(struct rtc_device *rtc);
+void rtc_nvmem_unregister(struct rtc_device *rtc);
+#else
+static inline void rtc_nvmem_register(struct rtc_device *rtc) {}
+static inline void rtc_nvmem_unregister(struct rtc_device *rtc) {}
+#endif
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 8e4a5f44f59e..d53ecdc060cf 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -14,6 +14,7 @@
 
 #include <linux/types.h>
 #include <linux/interrupt.h>
+#include <linux/nvmem-provider.h>
 #include <uapi/linux/rtc.h>
 
 extern int rtc_month_days(unsigned int month, unsigned int year);
@@ -144,6 +145,12 @@ struct rtc_device {
 
 	bool registered;
 
+	struct nvmem_config *nvmem_config;
+	struct nvmem_device *nvmem;
+	/* Old ABI support */
+	bool nvram_old_abi;
+	struct bin_attribute *nvram;
+
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 	struct work_struct uie_task;
 	struct timer_list uie_timer;
-- 
2.11.0
