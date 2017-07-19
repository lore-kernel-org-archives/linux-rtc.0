Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35003 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753413AbdGSLkD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 19 Jul 2017 07:40:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id n64so2162729wmg.2
        for <linux-rtc@vger.kernel.org>; Wed, 19 Jul 2017 04:40:03 -0700 (PDT)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] rtc: zynqmp: Disable the build as a module
Date: Wed, 19 Jul 2017 13:39:57 +0200
Message-Id: <9881f4ae2afb2cd671715bcd1fcb9035688c40c9.1500464394.git.michal.simek@xilinx.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The patch:
"timers: Introduce in-kernel alarm-timer interface"
(sha1: ff3ead96d17f47ee70c294a5cc2cce9b61e82f0f)
introduced new requirement that RTC drivers with alarm functionality
can't be used as a module.
When module is unloaded there is still a reference that's why
rtc_device_release() is not called and ida is not freed.

That's why when module is loaded again it can't use the same RTC number
based on aliases.

Log:
sh-4.3# modprobe rtc-zynqmp
[   42.468565] rtc_zynqmp ffa60000.rtc: rtc core: registered
ffa60000.rtc as rtc5
sh-4.3# rmmod rtc-zynqmp
sh-4.3# modprobe rtc-zynqmp
[   48.648222] rtc_zynqmp ffa60000.rtc: /aliases ID 5 not available
[   48.654280] rtc_zynqmp ffa60000.rtc: rtc core: registered
ffa60000.rtc as rtc0

This patch is removing module support which is just a workaround till
alarm-timer interface is fixed to support device releasing when alarm
timer is not used.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Based on discussion:
https://www.mail-archive.com/rtc-linux@googlegroups.com/msg00908.html

---
 drivers/rtc/Kconfig      |  2 +-
 drivers/rtc/rtc-zynqmp.c | 15 +--------------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 72419ac2c52a..a2bbe7c2cf92 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1225,7 +1225,7 @@ config RTC_DRV_OPAL
 	  will be called rtc-opal.
 
 config RTC_DRV_ZYNQMP
-	tristate "Xilinx Zynq Ultrascale+ MPSoC RTC"
+	bool "Xilinx Zynq Ultrascale+ MPSoC RTC"
 	depends on OF
 	help
 	  If you say yes here you get support for the RTC controller found on
diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index da18a8ae3c1d..5fc50145dbd2 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -268,14 +268,6 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(xrtcdev->rtc);
 }
 
-static int xlnx_rtc_remove(struct platform_device *pdev)
-{
-	xlnx_rtc_alarm_irq_enable(&pdev->dev, 0);
-	device_init_wakeup(&pdev->dev, 0);
-
-	return 0;
-}
-
 static int __maybe_unused xlnx_rtc_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -312,7 +304,6 @@ static int __maybe_unused xlnx_rtc_resume(struct device *dev)
 
 static struct platform_driver xlnx_rtc_driver = {
 	.probe		= xlnx_rtc_probe,
-	.remove		= xlnx_rtc_remove,
 	.driver		= {
 		.name	= KBUILD_MODNAME,
 		.pm	= &xlnx_rtc_pm_ops,
@@ -320,8 +311,4 @@ static int __maybe_unused xlnx_rtc_resume(struct device *dev)
 	},
 };
 
-module_platform_driver(xlnx_rtc_driver);
-
-MODULE_DESCRIPTION("Xilinx Zynq MPSoC RTC driver");
-MODULE_AUTHOR("Xilinx Inc.");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(xlnx_rtc_driver);
-- 
1.9.1
