Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBLOST7CAKGQEQ4XXPKQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 66si1221513wml.3.2017.01.24.15.54.21
        for <rtc-linux@googlegroups.com>;
        Tue, 24 Jan 2017 15:54:21 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Cercueil <paul@crapouillou.net>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: jz4740: make the driver buildable as a
 module again
Date: Wed, 25 Jan 2017 00:54:17 +0100
Message-Id: <20170124235417.16194-1-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

By using kernel_halt() instead of machine_halt(), we can make the driver
build as a module.
However, jz4740 platforms not loading this module will not be able to power
off.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Revert "rtc: jz4740: make the driver builtin only"

This reverts commit b9168c539c0b2de756aaffd380384dbde8adbe07.
---
 drivers/rtc/Kconfig      |  5 ++++-
 drivers/rtc/rtc-jz4740.c | 12 ++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index ee287cf63b01..ac8c7a3d7166 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1551,12 +1551,15 @@ config RTC_DRV_MPC5121
 	  will be called rtc-mpc5121.
 
 config RTC_DRV_JZ4740
-	bool "Ingenic JZ4740 SoC"
+	tristate "Ingenic JZ4740 SoC"
 	depends on MACH_INGENIC || COMPILE_TEST
 	help
 	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
 	  controllers.
 
+	  This driver can also be buillt as a module. If so, the module
+	  will be called rtc-jz4740.
+
 config RTC_DRV_LPC24XX
 	tristate "NXP RTC for LPC178x/18xx/408x/43xx"
 	depends on ARCH_LPC18XX || COMPILE_TEST
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 72918c1ba092..64989afffa3d 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
@@ -294,7 +295,7 @@ static void jz4740_rtc_power_off(void)
 			     JZ_REG_RTC_RESET_COUNTER, reset_counter_ticks);
 
 	jz4740_rtc_poweroff(dev_for_power_off);
-	machine_halt();
+	kernel_halt();
 }
 
 static const struct of_device_id jz4740_rtc_of_match[] = {
@@ -302,6 +303,7 @@ static const struct of_device_id jz4740_rtc_of_match[] = {
 	{ .compatible = "ingenic,jz4780-rtc", .data = (void *)ID_JZ4780 },
 	{},
 };
+MODULE_DEVICE_TABLE(of, jz4740_rtc_of_match);
 
 static int jz4740_rtc_probe(struct platform_device *pdev)
 {
@@ -429,6 +431,7 @@ static const struct platform_device_id jz4740_rtc_ids[] = {
 	{ "jz4780-rtc", ID_JZ4780 },
 	{}
 };
+MODULE_DEVICE_TABLE(platform, jz4740_rtc_ids);
 
 static struct platform_driver jz4740_rtc_driver = {
 	.probe	 = jz4740_rtc_probe,
@@ -440,4 +443,9 @@ static struct platform_driver jz4740_rtc_driver = {
 	.id_table = jz4740_rtc_ids,
 };
 
-builtin_platform_driver(jz4740_rtc_driver);
+module_platform_driver(jz4740_rtc_driver);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTC driver for the JZ4740 SoC\n");
+MODULE_ALIAS("platform:jz4740-rtc");
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
