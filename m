Return-Path: <rtc-linux+bncBDSJBYGBRIMBBPXGRDCAKGQEIGJQA3I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id h62si130567wme.2.2017.01.20.07.56.46
        for <rtc-linux@googlegroups.com>;
        Fri, 20 Jan 2017 07:56:46 -0800 (PST)
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [rtc-linux] [PATCH 3/6] rtc: sun6i: Disable the build as a module
Date: Fri, 20 Jan 2017 16:56:40 +0100
Message-Id: <de1e4b4eda6307b664c40d6c4502058f6bb88c60.1484927680.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Since we have to provide the clock very early on, the RTC driver cannot be
built as a module. Make sure that won't happen.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/rtc/Kconfig     |  2 +-
 drivers/rtc/rtc-sun6i.c | 17 +----------------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index c93c5a8fba32..53e35c138ff3 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1434,7 +1434,7 @@ config RTC_DRV_SUN4V
 	  based RTC on SUN4V systems.
 
 config RTC_DRV_SUN6I
-	tristate "Allwinner A31 RTC"
+	bool "Allwinner A31 RTC"
 	default MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
 	depends on ARCH_SUNXI
 	help
diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 872d18609183..edd5627da10f 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -554,15 +554,6 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sun6i_rtc_remove(struct platform_device *pdev)
-{
-	struct sun6i_rtc_dev *chip = platform_get_drvdata(pdev);
-
-	rtc_device_unregister(chip->rtc);
-
-	return 0;
-}
-
 static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-rtc" },
 	{ /* sentinel */ },
@@ -571,15 +562,9 @@ MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
 
 static struct platform_driver sun6i_rtc_driver = {
 	.probe		= sun6i_rtc_probe,
-	.remove		= sun6i_rtc_remove,
 	.driver		= {
 		.name		= "sun6i-rtc",
 		.of_match_table = sun6i_rtc_dt_ids,
 	},
 };
-
-module_platform_driver(sun6i_rtc_driver);
-
-MODULE_DESCRIPTION("sun6i RTC driver");
-MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun6i_rtc_driver);
-- 
git-series 0.8.11

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
