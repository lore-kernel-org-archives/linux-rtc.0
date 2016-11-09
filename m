Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB2W7RHAQKGQEPTR26HY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id 18si1483522wmr.1.2016.11.08.16.38.02
        for <rtc-linux@googlegroups.com>;
        Tue, 08 Nov 2016 16:38:02 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Paul Cercueil <paul@crapouillou.net>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 2/2] rtc: jz4740: make the driver builtin only
Date: Wed,  9 Nov 2016 01:37:53 +0100
Message-Id: <20161109003753.29759-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20161109003753.29759-1-alexandre.belloni@free-electrons.com>
References: <20161109003753.29759-1-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Since the driver is now calling machine_halt() that is not exported, it has
to be built in the kernel. Building it as a module will fail at linking
time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/Kconfig      |  5 +----
 drivers/rtc/rtc-jz4740.c | 10 +---------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 4259ce61c31b..24b0778f6e28 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1550,15 +1550,12 @@ config RTC_DRV_MPC5121
 	  will be called rtc-mpc5121.
 
 config RTC_DRV_JZ4740
-	tristate "Ingenic JZ4740 SoC"
+	bool "Ingenic JZ4740 SoC"
 	depends on MACH_INGENIC || COMPILE_TEST
 	help
 	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
 	  controllers.
 
-	  This driver can also be buillt as a module. If so, the module
-	  will be called rtc-jz4740.
-
 config RTC_DRV_LPC24XX
 	tristate "NXP RTC for LPC178x/18xx/408x/43xx"
 	depends on ARCH_LPC18XX || COMPILE_TEST
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 18feae6c4e95..72918c1ba092 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
@@ -303,7 +302,6 @@ static const struct of_device_id jz4740_rtc_of_match[] = {
 	{ .compatible = "ingenic,jz4780-rtc", .data = (void *)ID_JZ4780 },
 	{},
 };
-MODULE_DEVICE_TABLE(of, jz4740_rtc_of_match);
 
 static int jz4740_rtc_probe(struct platform_device *pdev)
 {
@@ -431,7 +429,6 @@ static const struct platform_device_id jz4740_rtc_ids[] = {
 	{ "jz4780-rtc", ID_JZ4780 },
 	{}
 };
-MODULE_DEVICE_TABLE(platform, jz4740_rtc_ids);
 
 static struct platform_driver jz4740_rtc_driver = {
 	.probe	 = jz4740_rtc_probe,
@@ -443,9 +440,4 @@ static struct platform_driver jz4740_rtc_driver = {
 	.id_table = jz4740_rtc_ids,
 };
 
-module_platform_driver(jz4740_rtc_driver);
-
-MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("RTC driver for the JZ4740 SoC\n");
-MODULE_ALIAS("platform:jz4740-rtc");
+builtin_platform_driver(jz4740_rtc_driver);
-- 
2.10.2

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
