Return-Path: <rtc-linux+bncBDQ4HRP464MRBTUL7TCQKGQE5B2UAVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com. [2a00:1450:400c:c09::242])
        by gmr-mx.google.com with ESMTPS id t131si100399wmf.1.2017.03.07.11.11.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Mar 2017 11:11:09 -0800 (PST)
Received: by mail-wm0-x242.google.com with SMTP id u132so2575648wmg.1
        for <rtc-linux@googlegroups.com>; Tue, 07 Mar 2017 11:11:09 -0800 (PST)
From: Heiner Kallweit <hkallweit1@gmail.com>
Cc: rtc-linux@googlegroups.com
To: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: hctosys: move hctosys functionality to rtc_device_register
Message-ID: <14cc1b9c-66af-2e09-1ca5-07aa55025beb@gmail.com>
Date: Tue, 7 Mar 2017 20:10:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

It's a little annoying that rtc driver plus all drivers it depends on
(e.g. I2C) have to be compiled into the kernel to be used with hctosys.

I think it would be more logical to set the system clock once the
rtc driver has been registered. Therefore move the hctosys
functionality to the end of rtc_device_register.

Works perfectly fine here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/Makefile  |  1 -
 drivers/rtc/class.c   | 38 ++++++++++++++++++++++++++++
 drivers/rtc/hctosys.c | 70 ---------------------------------------------------
 3 files changed, 38 insertions(+), 71 deletions(-)
 delete mode 100644 drivers/rtc/hctosys.c

diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index f07297b1..f1d57b06 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -5,7 +5,6 @@
 ccflags-$(CONFIG_RTC_DEBUG)	:= -DDEBUG
 
 obj-$(CONFIG_RTC_LIB)		+= rtc-lib.o
-obj-$(CONFIG_RTC_HCTOSYS)	+= hctosys.o
 obj-$(CONFIG_RTC_SYSTOHC)	+= systohc.o
 obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
 obj-$(CONFIG_RTC_MC146818_LIB)	+= rtc-mc146818-lib.o
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 74fd9746..dcfd2e64 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -168,6 +168,13 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 	struct rtc_wkalrm alrm;
 	int of_id = -1, id = -1, err;
 
+#if IS_ENABLED(CONFIG_RTC_HCTOSYS)
+	struct rtc_time tm;
+	struct timespec64 tv64 = {
+		.tv_nsec = NSEC_PER_SEC >> 1,
+	};
+#endif
+
 	if (dev->of_node)
 		of_id = of_alias_get_id(dev->of_node, "rtc");
 	else if (dev->parent && dev->parent->of_node)
@@ -246,6 +253,37 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 	dev_info(dev, "rtc core: registered %s as %s\n",
 			rtc->name, dev_name(&rtc->dev));
 
+#if IS_ENABLED(CONFIG_RTC_HCTOSYS)
+/* IMPORTANT: the RTC only stores whole seconds. It is arbitrary
+ * whether it stores the most close value or the value with partial
+ * seconds truncated. However, it is important that we use it to store
+ * the truncated value. This is because otherwise it is necessary,
+ * in an rtc sync function, to read both xtime.tv_sec and
+ * xtime.tv_nsec. On some processors (i.e. ARM), an atomic read
+ * of >32bits is not possible. So storing the most close value would
+ * slow down the sync API. So here we have the truncated value and
+ * the best guess is to add 0.5s.
+ */
+	if (!strcmp(CONFIG_RTC_HCTOSYS_DEVICE, dev_name(&rtc->dev))) {
+		err = rtc_read_time(rtc, &tm);
+		if (err) {
+			dev_err(dev, "hctosys: unable to read the hardware clock\n");
+			goto hctosys_out;
+		}
+
+		tv64.tv_sec = rtc_tm_to_time64(&tm);
+
+		err = do_settimeofday64(&tv64);
+
+		dev_info(dev, "setting system clock to %d-%02d-%02d %02d:%02d:%02d UTC (%lld)\n",
+			 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+			 tm.tm_hour, tm.tm_min, tm.tm_sec,
+			 (long long) tv64.tv_sec);
+hctosys_out:
+		rtc_hctosys_ret = err;
+	}
+#endif
+
 	return rtc;
 
 exit_ida:
diff --git a/drivers/rtc/hctosys.c b/drivers/rtc/hctosys.c
deleted file mode 100644
index e1cfa068..00000000
--- a/drivers/rtc/hctosys.c
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * RTC subsystem, initialize system time on startup
- *
- * Copyright (C) 2005 Tower Technologies
- * Author: Alessandro Zummo <a.zummo@towertech.it>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/rtc.h>
-
-/* IMPORTANT: the RTC only stores whole seconds. It is arbitrary
- * whether it stores the most close value or the value with partial
- * seconds truncated. However, it is important that we use it to store
- * the truncated value. This is because otherwise it is necessary,
- * in an rtc sync function, to read both xtime.tv_sec and
- * xtime.tv_nsec. On some processors (i.e. ARM), an atomic read
- * of >32bits is not possible. So storing the most close value would
- * slow down the sync API. So here we have the truncated value and
- * the best guess is to add 0.5s.
- */
-
-static int __init rtc_hctosys(void)
-{
-	int err = -ENODEV;
-	struct rtc_time tm;
-	struct timespec64 tv64 = {
-		.tv_nsec = NSEC_PER_SEC >> 1,
-	};
-	struct rtc_device *rtc = rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
-
-	if (rtc == NULL) {
-		pr_info("unable to open rtc device (%s)\n",
-			CONFIG_RTC_HCTOSYS_DEVICE);
-		goto err_open;
-	}
-
-	err = rtc_read_time(rtc, &tm);
-	if (err) {
-		dev_err(rtc->dev.parent,
-			"hctosys: unable to read the hardware clock\n");
-		goto err_read;
-
-	}
-
-	tv64.tv_sec = rtc_tm_to_time64(&tm);
-
-	err = do_settimeofday64(&tv64);
-
-	dev_info(rtc->dev.parent,
-		"setting system clock to "
-		"%d-%02d-%02d %02d:%02d:%02d UTC (%lld)\n",
-		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec,
-		(long long) tv64.tv_sec);
-
-err_read:
-	rtc_class_close(rtc);
-
-err_open:
-	rtc_hctosys_ret = err;
-
-	return err;
-}
-
-late_initcall(rtc_hctosys);
-- 
2.12.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
