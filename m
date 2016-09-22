Return-Path: <rtc-linux+bncBDEKVJM7XAHRB66RR27QKGQERQ2BNJQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.130])
        by gmr-mx.google.com with ESMTPS id p199si3429292wmd.1.2016.09.22.02.48.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2016 02:48:23 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: cmos: avoid unused function warning
Date: Thu, 22 Sep 2016 11:48:00 +0200
Message-Id: <20160922094817.2325831-1-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

A bug fix for the ACPI side of this driver caused a harmless
build warning:

drivers/rtc/rtc-cmos.c:1115:13: error: 'cmos_check_acpi_rtc_status' defined but not used [-Werror=unused-function]
 static void cmos_check_acpi_rtc_status(struct device *dev,

We can avoid the warning and simplify the driver at the same time
by removing the #ifdef for CONFIG_PM and rely on the SIMPLE_DEV_PM_OPS()
to set everything up correctly. cmos_resume() has to get marked
as __maybe_unused so we don't introduce another warning, and
the two variants of cmos_poweroff() can get merged into one using
an IS_ENABLED() check.

Fixes: 983bf1256edb ("rtc: cmos: Clear ACPI-driven alarms upon resume")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-cmos.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 2943a0d58a3a..dd3d59806ffa 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -848,8 +848,6 @@ static int cmos_aie_poweroff(struct device *dev)
 	return retval;
 }
 
-#ifdef CONFIG_PM
-
 static int cmos_suspend(struct device *dev)
 {
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
@@ -898,11 +896,12 @@ static int cmos_suspend(struct device *dev)
  */
 static inline int cmos_poweroff(struct device *dev)
 {
+	if (!IS_ENABLED(CONFIG_PM))
+		return -ENOSYS;
+
 	return cmos_suspend(dev);
 }
 
-#ifdef	CONFIG_PM_SLEEP
-
 static void cmos_check_wkalrm(struct device *dev)
 {
 	struct cmos_rtc *cmos = dev_get_drvdata(dev);
@@ -922,7 +921,7 @@ static void cmos_check_wkalrm(struct device *dev)
 static void cmos_check_acpi_rtc_status(struct device *dev,
 				       unsigned char *rtc_control);
 
-static int cmos_resume(struct device *dev)
+static int __maybe_unused cmos_resume(struct device *dev)
 {
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	unsigned char tmp;
@@ -975,16 +974,6 @@ static int cmos_resume(struct device *dev)
 	return 0;
 }
 
-#endif
-#else
-
-static inline int cmos_poweroff(struct device *dev)
-{
-	return -ENOSYS;
-}
-
-#endif
-
 static SIMPLE_DEV_PM_OPS(cmos_pm_ops, cmos_suspend, cmos_resume);
 
 /*----------------------------------------------------------------*/
@@ -1278,9 +1267,7 @@ static struct platform_driver cmos_platform_driver = {
 	.shutdown	= cmos_platform_shutdown,
 	.driver = {
 		.name		= driver_name,
-#ifdef CONFIG_PM
 		.pm		= &cmos_pm_ops,
-#endif
 		.of_match_table = of_match_ptr(of_cmos_match),
 	}
 };
-- 
2.9.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
