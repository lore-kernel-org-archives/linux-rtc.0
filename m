Return-Path: <rtc-linux+bncBDS7HNEFSALRB3NI2O3AKGQEB4CXBTI@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e130si600435wme.2.2016.02.29.15.29.48
        for <rtc-linux@googlegroups.com>;
        Mon, 29 Feb 2016 15:29:48 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: enable COMPILE_TEST
Date: Tue,  1 Mar 2016 00:28:38 +0100
Message-Id: <1456788518-31420-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

There are several arch-specific RTC drivers that can be successfully
compiled on other platforms. Add a COMPILE_TEST dependency for those.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/Kconfig | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 08df14be7c15..bf3ce81cb085 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1095,7 +1095,7 @@ config RTC_DRV_WM8350
 
 config RTC_DRV_SPEAR
 	tristate "SPEAR ST RTC"
-	depends on PLAT_SPEAR
+	depends on PLAT_SPEAR || COMPILE_TEST
 	default y
 	help
 	 If you say Y here you will get support for the RTC found on
@@ -1127,7 +1127,7 @@ config RTC_DRV_AB8500
 
 config RTC_DRV_NUC900
 	tristate "NUC910/NUC920 RTC driver"
-	depends on ARCH_W90X900
+	depends on ARCH_W90X900 || COMPILE_TEST
 	help
 	  If you say yes here you get support for the RTC subsystem of the
 	  NUC910/NUC920 used in embedded systems.
@@ -1164,7 +1164,7 @@ config RTC_DRV_ASM9260
 
 config RTC_DRV_DAVINCI
 	tristate "TI DaVinci RTC"
-	depends on ARCH_DAVINCI_DM365
+	depends on ARCH_DAVINCI_DM365 || COMPILE_TEST
 	help
 	  If you say yes here you get support for the RTC on the
 	  DaVinci platforms (DM365).
@@ -1174,7 +1174,7 @@ config RTC_DRV_DAVINCI
 
 config RTC_DRV_DIGICOLOR
 	tristate "Conexant Digicolor RTC"
-	depends on ARCH_DIGICOLOR
+	depends on ARCH_DIGICOLOR || COMPILE_TEST
 	help
 	  If you say yes here you get support for the RTC on Conexant
 	  Digicolor platforms. This currently includes the CX92755 SoC.
@@ -1184,7 +1184,7 @@ config RTC_DRV_DIGICOLOR
 
 config RTC_DRV_IMXDI
 	tristate "Freescale IMX DryIce Real Time Clock"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	   Support for Freescale IMX DryIce RTC
 
@@ -1193,7 +1193,7 @@ config RTC_DRV_IMXDI
 
 config RTC_DRV_OMAP
 	tristate "TI OMAP Real Time Clock"
-	depends on ARCH_OMAP || ARCH_DAVINCI
+	depends on ARCH_OMAP || ARCH_DAVINCI || COMPILE_TEST
 	help
 	  Say "yes" here to support the on chip real time clock
 	  present on TI OMAP1, AM33xx, DA8xx/OMAP-L13x, AM43xx and DRA7xx.
@@ -1210,7 +1210,7 @@ config HAVE_S3C_RTC
 
 config RTC_DRV_S3C
 	tristate "Samsung S3C series SoC RTC"
-	depends on ARCH_S3C64XX || HAVE_S3C_RTC
+	depends on ARCH_S3C64XX || HAVE_S3C_RTC || COMPILE_TEST
 	help
 	  RTC (Realtime Clock) driver for the clock inbuilt into the
 	  Samsung S3C24XX series of SoCs. This can provide periodic
@@ -1226,7 +1226,7 @@ config RTC_DRV_S3C
 
 config RTC_DRV_EP93XX
 	tristate "Cirrus Logic EP93XX"
-	depends on ARCH_EP93XX
+	depends on ARCH_EP93XX || COMPILE_TEST
 	help
 	  If you say yes here you get support for the
 	  RTC embedded in the Cirrus Logic EP93XX processors.
@@ -1256,7 +1256,7 @@ config RTC_DRV_SH
 
 config RTC_DRV_VR41XX
 	tristate "NEC VR41XX"
-	depends on CPU_VR41XX
+	depends on CPU_VR41XX || COMPILE_TEST
 	help
 	  If you say Y here you will get access to the real time clock
 	  built into your NEC VR41XX CPU.
@@ -1286,14 +1286,14 @@ config RTC_DRV_PL031
 
 config RTC_DRV_AT32AP700X
 	tristate "AT32AP700X series RTC"
-	depends on PLATFORM_AT32AP
+	depends on PLATFORM_AT32AP || COMPILE_TEST
 	help
 	  Driver for the internal RTC (Realtime Clock) on Atmel AVR32
 	  AT32AP700x family processors.
 
 config RTC_DRV_AT91RM9200
 	tristate "AT91RM9200 or some AT91SAM9 RTC"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || COMPILE_TEST
 	help
 	  Driver for the internal RTC (Realtime Clock) module found on
 	  Atmel AT91RM9200's and some  AT91SAM9 chips. On AT91SAM9 chips
@@ -1301,7 +1301,7 @@ config RTC_DRV_AT91RM9200
 
 config RTC_DRV_AT91SAM9
 	tristate "AT91SAM9 RTT as RTC"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || COMPILE_TEST
 	select MFD_SYSCON
 	help
 	  Some AT91SAM9 SoCs provide an RTT (Real Time Timer) block which
@@ -1343,7 +1343,7 @@ config RTC_DRV_GENERIC
 	tristate "Generic RTC support"
 	# Please consider writing a new RTC driver instead of using the generic
 	# RTC abstraction
-	depends on PARISC || M68K || PPC || SUPERH32
+	depends on PARISC || M68K || PPC || SUPERH32 || COMPILE_TEST
 	help
 	  Say Y or M here to enable RTC support on systems using the generic
 	  RTC abstraction. If you do not know what you are doing, you should
@@ -1363,7 +1363,7 @@ config RTC_DRV_PXA
 
 config RTC_DRV_VT8500
 	tristate "VIA/WonderMedia 85xx SoC RTC"
-	depends on ARCH_VT8500
+	depends on ARCH_VT8500 || COMPILE_TEST
 	help
 	  If you say Y here you will get access to the real time clock
 	  built into your VIA VT8500 SoC or its relatives.
@@ -1378,7 +1378,7 @@ config RTC_DRV_SUN4V
 
 config RTC_DRV_SUN6I
 	tristate "Allwinner A31 RTC"
-	default MACH_SUN6I || MACH_SUN8I
+	default MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
 	depends on ARCH_SUNXI
 	help
 	  If you say Y here you will get support for the RTC found in
@@ -1386,7 +1386,7 @@ config RTC_DRV_SUN6I
 
 config RTC_DRV_SUNXI
 	tristate "Allwinner sun4i/sun7i RTC"
-	depends on MACH_SUN4I || MACH_SUN7I
+	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
 	help
 	  If you say Y here you will get support for the RTC found on
 	  Allwinner A10/A20.
@@ -1407,7 +1407,7 @@ config RTC_DRV_TX4939
 
 config RTC_DRV_MV
 	tristate "Marvell SoC RTC"
-	depends on ARCH_DOVE || ARCH_MVEBU
+	depends on ARCH_DOVE || ARCH_MVEBU || COMPILE_TEST
 	help
 	  If you say yes here you will get support for the in-chip RTC
 	  that can be found in some of Marvell's SoC devices, such as
@@ -1418,7 +1418,7 @@ config RTC_DRV_MV
 
 config RTC_DRV_ARMADA38X
 	tristate "Armada 38x Marvell SoC RTC"
-	depends on ARCH_MVEBU
+	depends on ARCH_MVEBU || COMPILE_TEST
 	help
 	  If you say yes here you will get support for the in-chip RTC
 	  that can be found in the Armada 38x Marvell's SoC device
@@ -1448,7 +1448,7 @@ config RTC_DRV_PS3
 
 config RTC_DRV_COH901331
 	tristate "ST-Ericsson COH 901 331 RTC"
-	depends on ARCH_U300
+	depends on ARCH_U300 || COMPILE_TEST
 	help
 	  If you say Y here you will get access to ST-Ericsson
 	  COH 901 331 RTC clock found in some ST-Ericsson Mobile
@@ -1460,7 +1460,7 @@ config RTC_DRV_COH901331
 
 config RTC_DRV_STMP
 	tristate "Freescale STMP3xxx/i.MX23/i.MX28 RTC"
-	depends on ARCH_MXS
+	depends on ARCH_MXS || COMPILE_TEST
 	select STMP_DEVICE
 	help
 	  If you say yes here you will get support for the onboard
@@ -1495,7 +1495,7 @@ config RTC_DRV_MPC5121
 
 config RTC_DRV_JZ4740
 	tristate "Ingenic JZ4740 SoC"
-	depends on MACH_JZ4740
+	depends on MACH_JZ4740 || COMPILE_TEST
 	help
 	  If you say yes here you get support for the Ingenic JZ4740 SoC RTC
 	  controller.
@@ -1516,7 +1516,7 @@ config RTC_DRV_LPC24XX
 	  so, the module will be called rtc-lpc24xx.
 
 config RTC_DRV_LPC32XX
-	depends on ARCH_LPC32XX
+	depends on ARCH_LPC32XX || COMPILE_TEST
 	tristate "NXP LPC32XX RTC"
 	help
 	  This enables support for the NXP RTC in the LPC32XX
@@ -1526,7 +1526,7 @@ config RTC_DRV_LPC32XX
 
 config RTC_DRV_PM8XXX
 	tristate "Qualcomm PMIC8XXX RTC"
-	depends on MFD_PM8XXX || MFD_SPMI_PMIC
+	depends on MFD_PM8XXX || MFD_SPMI_PMIC || COMPILE_TEST
 	help
 	  If you say yes here you get support for the
 	  Qualcomm PMIC8XXX RTC.
@@ -1536,7 +1536,7 @@ config RTC_DRV_PM8XXX
 
 config RTC_DRV_TEGRA
 	tristate "NVIDIA Tegra Internal RTC driver"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	help
 	  If you say yes here you get support for the
 	  Tegra 200 series internal RTC module.
-- 
2.7.0

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
