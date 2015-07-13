Return-Path: <rtc-linux+bncBAABBUPHRWWQKGQEBQVMFZQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id x12si555546igx.1.2015.07.13.01.16.17
        for <rtc-linux@googlegroups.com>;
        Mon, 13 Jul 2015 01:16:17 -0700 (PDT)
From: Shawn Guo <shawnguo@kernel.org>
To: rtc-linux@googlegroups.com
Cc: linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Frank Li <Frank.Li@freescale.com>,
	kbuild test robot <fengguang.wu@intel.com>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [rtc-linux] [PATCH] rtc: snvs: select option REGMAP_MMIO
Date: Mon, 13 Jul 2015 16:11:15 +0800
Message-Id: <1436775075-15037-1-git-send-email-shawnguo@kernel.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Select REGMAP_MMIO to fix the following build error seen with x86_64
randconfig.

  drivers/built-in.o: In function `snvs_rtc_probe':
rtc-snvs.c:(.text+0x567730): undefined reference to `devm_regmap_init_mmio_clk'

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
This is a fix to patch "rtc: snvs: use syscon to access register",
which I queued on IMX tree for 4.3.  So I will apply it to the same
branch.

Shawn

 drivers/rtc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 83b4b89b9d5a..533bfa3b6039 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1523,6 +1523,7 @@ config RTC_DRV_MXC
 
 config RTC_DRV_SNVS
 	tristate "Freescale SNVS RTC support"
+	select REGMAP_MMIO
 	depends on HAS_IOMEM
 	depends on OF
 	help
-- 
1.9.1

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
