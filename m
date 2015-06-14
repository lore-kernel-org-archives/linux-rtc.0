Return-Path: <rtc-linux+bncBDS7HNEFSALRBNG266VQKGQE2YMCC2I@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ha2si398495wib.1.2015.06.14.14.08.04
        for <rtc-linux@googlegroups.com>;
        Sun, 14 Jun 2015 14:08:04 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: whitespace fixes
Date: Sun, 14 Jun 2015 23:07:46 +0200
Message-Id: <1434316066-23448-2-git-send-email-alexandre.belloni@free-electrons.com>
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

Some entries in the Kconfig are improperly indented with spaces instead of
tabs.
Also fix whitespaces in Makefile.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/Kconfig  | 48 ++++++++++++++++++++++++------------------------
 drivers/rtc/Makefile | 12 ++++++------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 6d2752bdc7ce..23a5bcdf34ec 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -12,7 +12,7 @@ menuconfig RTC_CLASS
 	select RTC_LIB
 	help
 	  Generic RTC class support. If you say yes here, you will
- 	  be allowed to plug one or more RTCs to your system. You will
+	  be allowed to plug one or more RTCs to your system. You will
 	  probably want to enable one or more of the interfaces below.
 
 if RTC_CLASS
@@ -165,10 +165,10 @@ config RTC_DRV_88PM80X
 	  will be called rtc-88pm80x.
 
 config RTC_DRV_ABB5ZES3
-       depends on I2C
-       select REGMAP_I2C
-       tristate "Abracon AB-RTCMC-32.768kHz-B5ZE-S3"
-       help
+	depends on I2C
+	select REGMAP_I2C
+	tristate "Abracon AB-RTCMC-32.768kHz-B5ZE-S3"
+	help
 	  If you say yes here you get support for the Abracon
 	  AB-RTCMC-32.768kHz-B5ZE-S3 I2C RTC chip.
 
@@ -366,10 +366,10 @@ config RTC_DRV_ISL12022
 	  will be called rtc-isl12022.
 
 config RTC_DRV_ISL12057
-       depends on I2C
-       select REGMAP_I2C
-       tristate "Intersil ISL12057"
-       help
+	depends on I2C
+	select REGMAP_I2C
+	tristate "Intersil ISL12057"
+	help
 	  If you say yes here you get support for the Intersil ISL12057
 	  I2C RTC chip.
 
@@ -604,13 +604,13 @@ comment "SPI RTC drivers"
 if SPI_MASTER
 
 config RTC_DRV_M41T93
-        tristate "ST M41T93"
-        help
-          If you say yes here you will get support for the
-          ST M41T93 SPI RTC chip.
+	tristate "ST M41T93"
+	help
+	  If you say yes here you will get support for the
+	  ST M41T93 SPI RTC chip.
 
-          This driver can also be built as a module. If so, the module
-          will be called rtc-m41t93.
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-m41t93.
 
 config RTC_DRV_M41T94
 	tristate "ST M41T94"
@@ -1201,7 +1201,7 @@ config RTC_DRV_SH
 	  Say Y here to enable support for the on-chip RTC found in
 	  most SuperH processors.
 
- 	  To compile this driver as a module, choose M here: the
+	  To compile this driver as a module, choose M here: the
 	  module will be called rtc-sh.
 
 config RTC_DRV_VR41XX
@@ -1300,14 +1300,14 @@ config RTC_DRV_GENERIC
 	  just say Y.
 
 config RTC_DRV_PXA
-       tristate "PXA27x/PXA3xx"
-       depends on ARCH_PXA
-       help
-         If you say Y here you will get access to the real time clock
-         built into your PXA27x or PXA3xx CPU.
-
-         This RTC driver uses PXA RTC registers available since pxa27x
-         series (RDxR, RYxR) instead of legacy RCNR, RTAR.
+	tristate "PXA27x/PXA3xx"
+	depends on ARCH_PXA
+	help
+	 If you say Y here you will get access to the real time clock
+	 built into your PXA27x or PXA3xx CPU.
+
+	 This RTC driver uses PXA RTC registers available since pxa27x
+	 series (RDxR, RYxR) instead of legacy RCNR, RTAR.
 
 config RTC_DRV_VT8500
 	tristate "VIA/WonderMedia 85xx SoC RTC"
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 41ec0388a1c3..a39d8034149d 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -14,14 +14,14 @@ ifdef CONFIG_RTC_DRV_EFI
 rtc-core-y			+= rtc-efi-platform.o
 endif
 
-rtc-core-$(CONFIG_RTC_INTF_DEV)	+= rtc-dev.o
-rtc-core-$(CONFIG_RTC_INTF_PROC) += rtc-proc.o
-rtc-core-$(CONFIG_RTC_INTF_SYSFS) += rtc-sysfs.o
+rtc-core-$(CONFIG_RTC_INTF_DEV)		+= rtc-dev.o
+rtc-core-$(CONFIG_RTC_INTF_PROC)	+= rtc-proc.o
+rtc-core-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysfs.o
 
 # Keep the list ordered.
 
 obj-$(CONFIG_RTC_DRV_88PM80X)	+= rtc-88pm80x.o
-obj-$(CONFIG_RTC_DRV_88PM860X)  += rtc-88pm860x.o
+obj-$(CONFIG_RTC_DRV_88PM860X)	+= rtc-88pm860x.o
 obj-$(CONFIG_RTC_DRV_AB3100)	+= rtc-ab3100.o
 obj-$(CONFIG_RTC_DRV_AB8500)	+= rtc-ab8500.o
 obj-$(CONFIG_RTC_DRV_ABB5ZES3)	+= rtc-ab-b5ze-s3.o
@@ -56,7 +56,7 @@ obj-$(CONFIG_RTC_DRV_DS1553)	+= rtc-ds1553.o
 obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
 obj-$(CONFIG_RTC_DRV_DS1685_FAMILY)	+= rtc-ds1685.o
 obj-$(CONFIG_RTC_DRV_DS1742)	+= rtc-ds1742.o
-obj-$(CONFIG_RTC_DRV_DS2404)    += rtc-ds2404.o
+obj-$(CONFIG_RTC_DRV_DS2404)	+= rtc-ds2404.o
 obj-$(CONFIG_RTC_DRV_DS3232)	+= rtc-ds3232.o
 obj-$(CONFIG_RTC_DRV_DS3234)	+= rtc-ds3234.o
 obj-$(CONFIG_RTC_DRV_EFI)	+= rtc-efi.o
@@ -84,7 +84,7 @@ obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
 obj-$(CONFIG_RTC_DRV_MAX6900)	+= rtc-max6900.o
 obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
 obj-$(CONFIG_RTC_DRV_MAX77686)	+= rtc-max77686.o
-obj-$(CONFIG_RTC_DRV_MAX77802)  += rtc-max77802.o
+obj-$(CONFIG_RTC_DRV_MAX77802)	+= rtc-max77802.o
 obj-$(CONFIG_RTC_DRV_MAX8907)	+= rtc-max8907.o
 obj-$(CONFIG_RTC_DRV_MAX8925)	+= rtc-max8925.o
 obj-$(CONFIG_RTC_DRV_MAX8997)	+= rtc-max8997.o
-- 
2.1.4

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
