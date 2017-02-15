Return-Path: <rtc-linux+bncBDM47J4M6QEBBIUHSLCQKGQEDJHYVTI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from dukecmmtar03.coxmail.com (dukecmmtar03.coxmail.com. [68.99.120.44])
        by gmr-mx.google.com with ESMTP id u12si744828pfd.3.2017.02.15.08.36.50
        for <rtc-linux@googlegroups.com>;
        Wed, 15 Feb 2017 08:36:50 -0800 (PST)
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: rtc-linux@googlegroups.com
Cc: alex@digriz.org.uk,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 3/5] ARM: Orion5x: ts78xx: allow rtc-m48t86 to
 manage it's own resources
Date: Wed, 15 Feb 2017 09:35:25 -0700
Message-Id: <20170215163527.5697-4-hsweeten@visionengravers.com>
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

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-orion5x/ts78xx-setup.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index cb4c374..7ef80a83 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -16,7 +16,6 @@
 #include <linux/platform_device.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ata_platform.h>
-#include <linux/platform_data/rtc-m48t86.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/timeriomem-rng.h>
@@ -80,33 +79,19 @@ static struct mv_sata_platform_data ts78xx_sata_data = {
 /*****************************************************************************
  * RTC M48T86 - nicked^Wborrowed from arch/arm/mach-ep93xx/ts72xx.c
  ****************************************************************************/
-#define TS_RTC_CTRL	(TS78XX_FPGA_REGS_VIRT_BASE + 0x808)
-#define TS_RTC_DATA	(TS78XX_FPGA_REGS_VIRT_BASE + 0x80c)
+#define TS_RTC_CTRL	(TS78XX_FPGA_REGS_PHYS_BASE + 0x808)
+#define TS_RTC_DATA	(TS78XX_FPGA_REGS_PHYS_BASE + 0x80c)
 
-static unsigned char ts78xx_ts_rtc_readbyte(unsigned long addr)
-{
-	writeb(addr, TS_RTC_CTRL);
-	return readb(TS_RTC_DATA);
-}
-
-static void ts78xx_ts_rtc_writebyte(unsigned char value, unsigned long addr)
-{
-	writeb(addr, TS_RTC_CTRL);
-	writeb(value, TS_RTC_DATA);
-}
-
-static struct m48t86_ops ts78xx_ts_rtc_ops = {
-	.readbyte	= ts78xx_ts_rtc_readbyte,
-	.writebyte	= ts78xx_ts_rtc_writebyte,
+static struct resource ts78xx_ts_rtc_resources[] = {
+	DEFINE_RES_MEM(TS_RTC_CTRL, 0x01),
+	DEFINE_RES_MEM(TS_RTC_DATA, 0x01),
 };
 
 static struct platform_device ts78xx_ts_rtc_device = {
 	.name		= "rtc-m48t86",
 	.id		= -1,
-	.dev		= {
-		.platform_data	= &ts78xx_ts_rtc_ops,
-	},
-	.num_resources	= 0,
+	.resource	= ts78xx_ts_rtc_resources,
+	.num_resources 	= ARRAY_SIZE(ts78xx_ts_rtc_resources),
 };
 
 static int ts78xx_ts_rtc_load(void)
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
