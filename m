Return-Path: <rtc-linux+bncBDP6N55ZUYDRBEFV3XCQKGQEQV4PJ4A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com. [2607:f8b0:400e:c05::241])
        by gmr-mx.google.com with ESMTPS id 2si372418pfz.1.2017.03.01.15.34.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 15:34:40 -0800 (PST)
Received: by mail-pg0-x241.google.com with SMTP id 1so7252242pgz.2
        for <rtc-linux@googlegroups.com>; Wed, 01 Mar 2017 15:34:40 -0800 (PST)
Date: Wed, 1 Mar 2017 15:34:38 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: omap: mark PM methods as __maybe_unused
Message-ID: <20170301233438.GA9018@dtor-ws>
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

Instead of using #ifdef guards around PM methods, let's annotate
them as __maybe_unused, as it provides better compile coverage.

Also drop empty stub for omap_rtc_runtime_resume().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/rtc/rtc-omap.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index fa856d9c5e23..a2733caa3b8f 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -882,8 +882,7 @@ static int omap_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int omap_rtc_suspend(struct device *dev)
+static int __maybe_unused omap_rtc_suspend(struct device *dev)
 {
 	struct omap_rtc *rtc = dev_get_drvdata(dev);
 
@@ -906,7 +905,7 @@ static int omap_rtc_suspend(struct device *dev)
 	return 0;
 }
 
-static int omap_rtc_resume(struct device *dev)
+static int __maybe_unused omap_rtc_resume(struct device *dev)
 {
 	struct omap_rtc *rtc = dev_get_drvdata(dev);
 
@@ -921,10 +920,8 @@ static int omap_rtc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM
-static int omap_rtc_runtime_suspend(struct device *dev)
+static int __maybe_unused omap_rtc_runtime_suspend(struct device *dev)
 {
 	struct omap_rtc *rtc = dev_get_drvdata(dev);
 
@@ -934,16 +931,9 @@ static int omap_rtc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int omap_rtc_runtime_resume(struct device *dev)
-{
-	return 0;
-}
-#endif
-
 static const struct dev_pm_ops omap_rtc_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(omap_rtc_suspend, omap_rtc_resume)
-	SET_RUNTIME_PM_OPS(omap_rtc_runtime_suspend,
-			   omap_rtc_runtime_resume, NULL)
+	SET_RUNTIME_PM_OPS(omap_rtc_runtime_suspend, NULL, NULL)
 };
 
 static void omap_rtc_shutdown(struct platform_device *pdev)
-- 
2.12.0.rc1.440.g5b76565f74-goog


-- 
Dmitry

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
