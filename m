Return-Path: <rtc-linux+bncBDM47J4M6QEBBZMGSLCQKGQEYQR22OI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from dukecmmtar03.coxmail.com (dukecmmtar03.coxmail.com. [68.99.120.44])
        by gmr-mx.google.com with ESMTP id z191si860150itc.0.2017.02.15.08.35.49
        for <rtc-linux@googlegroups.com>;
        Wed, 15 Feb 2017 08:35:49 -0800 (PST)
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: rtc-linux@googlegroups.com
Cc: alex@digriz.org.uk,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 4/5] ARM: ep93xx: ts72xx: allow rtc-m48t86 to
 manage it's own resources
Date: Wed, 15 Feb 2017 09:35:26 -0700
Message-Id: <20170215163527.5697-5-hsweeten@visionengravers.com>
In-Reply-To: <20170215163527.5697-1-hsweeten@visionengravers.com>
References: <20170215163527.5697-1-hsweeten@visionengravers.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The rtc-m48t86 driver can now handle it's own resources and do the
read/write operations internally.

Pass the necessary resources to the driver and remove the m48t86_ops
platform data.

Remove the, then unnecessary, static remapping for the registers.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-ep93xx/ts72xx.c | 40 ++++++++++------------------------------
 arch/arm/mach-ep93xx/ts72xx.h | 11 -----------
 2 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 3b39ea3..8a5b6f0 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/platform_data/rtc-m48t86.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
@@ -45,16 +44,6 @@ static struct map_desc ts72xx_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(TS72XX_OPTIONS2_PHYS_BASE),
 		.length		= TS72XX_OPTIONS2_SIZE,
 		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)TS72XX_RTC_INDEX_VIRT_BASE,
-		.pfn		= __phys_to_pfn(TS72XX_RTC_INDEX_PHYS_BASE),
-		.length		= TS72XX_RTC_INDEX_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)TS72XX_RTC_DATA_VIRT_BASE,
-		.pfn		= __phys_to_pfn(TS72XX_RTC_DATA_PHYS_BASE),
-		.length		= TS72XX_RTC_DATA_SIZE,
-		.type		= MT_DEVICE,
 	}
 };
 
@@ -179,31 +168,22 @@ static void __init ts72xx_register_flash(void)
 	}
 }
 
+/*************************************************************************
+ * RTC M48T86
+ *************************************************************************/
+#define TS72XX_RTC_INDEX_PHYS_BASE	(EP93XX_CS1_PHYS_BASE + 0x00800000)
+#define TS72XX_RTC_DATA_PHYS_BASE	(EP93XX_CS1_PHYS_BASE + 0x01700000)
 
-static unsigned char ts72xx_rtc_readbyte(unsigned long addr)
-{
-	__raw_writeb(addr, TS72XX_RTC_INDEX_VIRT_BASE);
-	return __raw_readb(TS72XX_RTC_DATA_VIRT_BASE);
-}
-
-static void ts72xx_rtc_writebyte(unsigned char value, unsigned long addr)
-{
-	__raw_writeb(addr, TS72XX_RTC_INDEX_VIRT_BASE);
-	__raw_writeb(value, TS72XX_RTC_DATA_VIRT_BASE);
-}
-
-static struct m48t86_ops ts72xx_rtc_ops = {
-	.readbyte	= ts72xx_rtc_readbyte,
-	.writebyte	= ts72xx_rtc_writebyte,
+static struct resource ts72xx_rtc_resources[] = {
+	DEFINE_RES_MEM(TS72XX_RTC_INDEX_PHYS_BASE, 0x01),
+	DEFINE_RES_MEM(TS72XX_RTC_DATA_PHYS_BASE, 0x01),
 };
 
 static struct platform_device ts72xx_rtc_device = {
 	.name		= "rtc-m48t86",
 	.id		= -1,
-	.dev		= {
-		.platform_data	= &ts72xx_rtc_ops,
-	},
-	.num_resources	= 0,
+	.resource	= ts72xx_rtc_resources,
+	.num_resources 	= ARRAY_SIZE(ts72xx_rtc_resources),
 };
 
 static struct resource ts72xx_wdt_resources[] = {
diff --git a/arch/arm/mach-ep93xx/ts72xx.h b/arch/arm/mach-ep93xx/ts72xx.h
index 071feaa..2255ba2 100644
--- a/arch/arm/mach-ep93xx/ts72xx.h
+++ b/arch/arm/mach-ep93xx/ts72xx.h
@@ -9,8 +9,6 @@
  * febff000	22000000	4K	model number register (bits 0-2)
  * febfe000	22400000	4K	options register
  * febfd000	22800000	4K	options register #2
- * febf9000	10800000	4K	TS-5620 RTC index register
- * febf8000	11700000	4K	TS-5620 RTC data register
  */
 
 #define TS72XX_MODEL_PHYS_BASE		0x22000000
@@ -40,15 +38,6 @@
 #define TS72XX_OPTIONS2_TS9420		0x04
 #define TS72XX_OPTIONS2_TS9420_BOOT	0x02
 
-
-#define TS72XX_RTC_INDEX_VIRT_BASE	IOMEM(0xfebf9000)
-#define TS72XX_RTC_INDEX_PHYS_BASE	0x10800000
-#define TS72XX_RTC_INDEX_SIZE		0x00001000
-
-#define TS72XX_RTC_DATA_VIRT_BASE	IOMEM(0xfebf8000)
-#define TS72XX_RTC_DATA_PHYS_BASE	0x11700000
-#define TS72XX_RTC_DATA_SIZE		0x00001000
-
 #define TS72XX_WDT_CONTROL_PHYS_BASE	0x23800000
 #define TS72XX_WDT_FEED_PHYS_BASE	0x23c00000
 
-- 
2.10.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
