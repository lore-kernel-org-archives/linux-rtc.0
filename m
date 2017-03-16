Return-Path: <rtc-linux+bncBDXOFUXT2UGBBNFBVPDAKGQE5AQXNSA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from relmlie2.idc.renesas.com (relmlor3.renesas.com. [210.160.252.173])
        by gmr-mx.google.com with ESMTP id g82si1022444pfb.5.2017.03.16.10.51.47
        for <rtc-linux@googlegroups.com>;
        Thu, 16 Mar 2017 10:51:48 -0700 (PDT)
From: Chris Brandt <chris.brandt@renesas.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Brandt <chris.brandt@renesas.com>
Subject: [rtc-linux] [PATCH 1/5] rtc: rtc-sh: add support for rza series
Date: Thu, 16 Mar 2017 13:51:08 -0400
Message-Id: <20170316175112.27913-2-chris.brandt@renesas.com>
In-Reply-To: <20170316175112.27913-1-chris.brandt@renesas.com>
References: <20170316175112.27913-1-chris.brandt@renesas.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This same RTC is used in RZ/A series MPUs, therefore with some slight
changes, this driver can be reused. Additionally, since ARM architectures
require Device Tree configurations, device tree support has been added.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/rtc/Kconfig  |  4 ++--
 drivers/rtc/rtc-sh.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index ee1b0e9..77d1495 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1303,10 +1303,10 @@ config RTC_DRV_SA1100
 
 config RTC_DRV_SH
 	tristate "SuperH On-Chip RTC"
-	depends on SUPERH && HAVE_CLK
+	depends on (SUPERH || ARCH_RENESAS) && HAVE_CLK
 	help
 	  Say Y here to enable support for the on-chip RTC found in
-	  most SuperH processors.
+	  most SuperH processors. This RTC is also found in RZ/A SoCs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called rtc-sh.
diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index c626e43..2ef4ac7 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -27,7 +27,15 @@
 #include <linux/log2.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
+#ifdef CONFIG_SUPERH
 #include <asm/rtc.h>
+#else
+/* Default values for RZ/A RTC */
+#define rtc_reg_size		sizeof(u16)
+#define RTC_BIT_INVERTED        0	/* no chip bugs */
+#define RTC_CAP_4_DIGIT_YEAR    (1 << 0)
+#define RTC_DEF_CAPABILITIES    RTC_CAP_4_DIGIT_YEAR
+#endif
 
 #define DRV_NAME	"sh-rtc"
 
@@ -570,6 +578,8 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 	rtc->alarm_irq = platform_get_irq(pdev, 2);
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (res == NULL)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(res == NULL)) {
 		dev_err(&pdev->dev, "No IO resource\n");
 		return -ENOENT;
@@ -608,6 +618,8 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 	clk_enable(rtc->clk);
 
 	rtc->capabilities = RTC_DEF_CAPABILITIES;
+
+#ifdef CONFIG_SUPERH
 	if (dev_get_platdata(&pdev->dev)) {
 		struct sh_rtc_platform_info *pinfo =
 			dev_get_platdata(&pdev->dev);
@@ -618,6 +630,7 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 		 */
 		rtc->capabilities |= pinfo->capabilities;
 	}
+#endif
 
 	if (rtc->carry_irq <= 0) {
 		/* register shared periodic/carry/alarm irq */
@@ -738,10 +751,17 @@ static int sh_rtc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(sh_rtc_pm_ops, sh_rtc_suspend, sh_rtc_resume);
 
+static const struct of_device_id sh_rtc_of_match[] = {
+	{ .compatible = "renesas,sh-rtc", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sh_rtc_of_match);
+
 static struct platform_driver sh_rtc_platform_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.pm	= &sh_rtc_pm_ops,
+		.of_match_table = sh_rtc_of_match,
 	},
 	.remove		= __exit_p(sh_rtc_remove),
 };
-- 
2.10.1


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
