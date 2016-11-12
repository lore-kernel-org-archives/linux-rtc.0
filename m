Return-Path: <rtc-linux+bncBAABB7WTTPAQKGQEHYNL6SY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from relay1.mentorg.com (relay1.mentorg.com. [192.94.38.131])
        by gmr-mx.google.com with ESMTPS id n18si3821565pfb.2.2016.11.12.02.07.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Nov 2016 02:07:57 -0800 (PST)
From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>
CC: <rtc-linux@googlegroups.com>, <linux-omap@vger.kernel.org>, Tony Lindgren
	<tony@atomide.com>, Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [rtc-linux] [PATCH 3/3] rtc: rtc-twl: use irq_of_parse_and_map helper
Date: Sat, 12 Nov 2016 12:07:26 +0200
Message-ID: <1478945246-32056-4-git-send-email-Nicolae_Rosia@mentor.com>
In-Reply-To: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
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

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 drivers/rtc/Kconfig   | 2 +-
 drivers/rtc/rtc-twl.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 2189216..7ac7579 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -481,7 +481,7 @@ config RTC_DRV_TWL92330
 config RTC_DRV_TWL4030
 	tristate "TI TWL4030/TWL5030/TWL6030/TPS659x0"
 	depends on TWL4030_CORE
-	depends on OF
+	depends on OF && OF_IRQ
 	help
 	  If you say yes here you get support for the RTC on the
 	  TWL4030/TWL5030/TWL6030 family chips, used mostly with OMAP3 platforms.
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 3d76322..7994baf 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 
 #include <linux/i2c/twl.h>
 
@@ -494,7 +495,7 @@ static int twl_rtc_probe(struct platform_device *pdev)
 	struct twl_rtc *twl_rtc;
 	struct device_node *np = pdev->dev.of_node;
 	int ret = -EINVAL;
-	int irq = platform_get_irq(pdev, 0);
+	int irq;
 	u8 rd_reg;
 
 	if (!np) {
@@ -502,6 +503,7 @@ static int twl_rtc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	irq = irq_of_parse_and_map(np, 0);
 	if (irq <= 0)
 		return ret;
 
-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
