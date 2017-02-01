Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBFM2Y7CAKGQEXRX6CMA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id q4si1656948wma.3.2017.02.01.03.57.08
        for <rtc-linux@googlegroups.com>;
        Wed, 01 Feb 2017 03:57:08 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: sun6i: extend test coverage
Date: Wed,  1 Feb 2017 12:57:06 +0100
Message-Id: <20170201115706.3750-1-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

COMPILE_TEST was wrongly placed, move it to the "depends on" line. Also,
select COMMON_CLK has the driver now needs it to be properly compiled.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index ee287cf63b01..06f3beb8e30f 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1435,8 +1435,9 @@ config RTC_DRV_SUN4V
 
 config RTC_DRV_SUN6I
 	bool "Allwinner A31 RTC"
-	default MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
-	depends on ARCH_SUNXI
+	default MACH_SUN6I || MACH_SUN8I
+	select COMMON_CLK
+	depends on ARCH_SUNXI || COMPILE_TEST
 	help
 	  If you say Y here you will get support for the RTC found in
 	  some Allwinner SoCs like the A31 or the A64.
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
