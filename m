Return-Path: <rtc-linux+bncBDMYB2E7SQCRBJGS2OVAKGQE5NKIKOQ@googlegroups.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1on0110.outbound.protection.outlook.com. [157.56.110.110])
        by gmr-mx.google.com with ESMTPS id ye6si2663450pbc.2.2015.05.14.11.27.48
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 11:27:48 -0700 (PDT)
From: <Frank.Li@freescale.com>
To: <lznuaa@gmail.com>, <shawn.guo@linaro.org>, <dmitry.torokhov@gmail.com>,
	<robh+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-input@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Frank Li <Frank.Li@freescale.com>
Subject: [rtc-linux] [PATCH 1/7] arm: imx: power-off: change to syscon to
 access register
Date: Fri, 15 May 2015 01:18:47 +0800
Message-ID: <1431623933-3473-2-git-send-email-Frank.Li@freescale.com>
In-Reply-To: <1431623933-3473-1-git-send-email-Frank.Li@freescale.com>
References: <1431623933-3473-1-git-send-email-Frank.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

From: Frank Li <Frank.Li@freescale.com>

snvs is MFP device, which included rtc, ON/OFF key, power off

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/power/reset/imx-snvs-poweroff.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/imx-snvs-poweroff.c b/drivers/power/reset/imx-snvs-poweroff.c
index ad6ce50..b4881d7 100644
--- a/drivers/power/reset/imx-snvs-poweroff.c
+++ b/drivers/power/reset/imx-snvs-poweroff.c
@@ -22,21 +22,30 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
-static void __iomem *snvs_base;
+static struct regmap *snvs;
+
+#define SNVS_LPCR 0x38
 
 static void do_imx_poweroff(void)
 {
-	u32 value = readl(snvs_base);
-
 	/* set TOP and DP_EN bit */
-	writel(value | 0x60, snvs_base);
+	regmap_update_bits(snvs, SNVS_LPCR, 0x60, 0x60);
 }
 
 static int imx_poweroff_probe(struct platform_device *pdev)
 {
-	snvs_base = of_iomap(pdev->dev.of_node, 0);
-	if (!snvs_base) {
+	struct device_node *nd;
+
+	nd = of_get_parent(pdev->dev.of_node);
+	if (!nd)
+		return -ENODEV;
+	snvs = syscon_node_to_regmap (nd);
+	of_node_put(nd);
+
+	if (!snvs) {
 		dev_err(&pdev->dev, "failed to get memory\n");
 		return -ENODEV;
 	}
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
