Return-Path: <rtc-linux+bncBAABBLFT2XAQKGQEB5HL3UA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from relay1.mentorg.com (relay1.mentorg.com. [192.94.38.131])
        by gmr-mx.google.com with ESMTPS id g192si588166pfb.1.2016.11.23.00.56.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Nov 2016 00:56:12 -0800 (PST)
From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>,
	<linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Nicolae Rosia
	<Nicolae_Rosia@mentor.com>
Subject: [rtc-linux] [PATCH v2 2/2] rtc: rtc-twl: make driver DT only
Date: Wed, 23 Nov 2016 10:55:57 +0200
Message-ID: <20161123085557.5656-3-Nicolae_Rosia@mentor.com>
In-Reply-To: <20161123085557.5656-1-Nicolae_Rosia@mentor.com>
References: <20161123085557.5656-1-Nicolae_Rosia@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Since there are no platform based users and all users
of this code are TI OMAP-based which is DT only, it makes
sense to remove unused code.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 drivers/rtc/Kconfig   |  1 +
 drivers/rtc/rtc-twl.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e859d14..2189216 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -481,6 +481,7 @@ config RTC_DRV_TWL92330
 config RTC_DRV_TWL4030
 	tristate "TI TWL4030/TWL5030/TWL6030/TPS659x0"
 	depends on TWL4030_CORE
+	depends on OF
 	help
 	  If you say yes here you get support for the RTC on the
 	  TWL4030/TWL5030/TWL6030 family chips, used mostly with OMAP3 platforms.
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 1e41526..c18c392 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -496,10 +496,16 @@ static const struct rtc_class_ops twl_rtc_ops = {
 static int twl_rtc_probe(struct platform_device *pdev)
 {
 	struct twl_rtc *twl_rtc;
+	struct device_node *np = pdev->dev.of_node;
 	int ret = -EINVAL;
 	int irq = platform_get_irq(pdev, 0);
 	u8 rd_reg;
 
+	if (!np) {
+		dev_err(&pdev->dev, "no DT info\n");
+		return -EINVAL;
+	}
+
 	if (irq <= 0)
 		return ret;
 
@@ -632,15 +638,11 @@ static int twl_rtc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(twl_rtc_pm_ops, twl_rtc_suspend, twl_rtc_resume);
 
-#ifdef CONFIG_OF
 static const struct of_device_id twl_rtc_of_match[] = {
 	{.compatible = "ti,twl4030-rtc", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, twl_rtc_of_match);
-#endif
-
-MODULE_ALIAS("platform:twl_rtc");
 
 static struct platform_driver twl4030rtc_driver = {
 	.probe		= twl_rtc_probe,
@@ -649,7 +651,7 @@ static struct platform_driver twl4030rtc_driver = {
 	.driver		= {
 		.name		= "twl_rtc",
 		.pm		= &twl_rtc_pm_ops,
-		.of_match_table = of_match_ptr(twl_rtc_of_match),
+		.of_match_table = twl_rtc_of_match,
 	},
 };
 
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
