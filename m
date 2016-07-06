Return-Path: <rtc-linux+bncBAABBF4J6O5QKGQEFFPOXLA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-out1.kundencontroller.de (mail-out1.kundencontroller.de. [85.31.184.34])
        by gmr-mx.google.com with ESMTPS id c135si249246wme.2.2016.07.06.01.43.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2016 01:43:03 -0700 (PDT)
From: Stephan Roslen <stephan@roslen.de>
Subject: [rtc-linux] [PATCH] rtc: sunxi: use external oscillator
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 maxime.ripard@free-electrons.com, wens@csie.org, rtc-linux@googlegroups.com
Message-ID: <577CC494.8020103@roslen.de>
Date: Wed, 6 Jul 2016 10:43:00 +0200
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

We noticed some serious drift problems in Allwinner A20 RTCs. I found out, that the oscillator source needs to be set to an external 32.768 KHz oscillator instead of the internal 32.000 KHz oscillator.

Signed-off-by: Stephan Roslen <stephan@roslen.de>
---
 drivers/rtc/rtc-sunxi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index abada60..001256e 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -34,9 +34,19 @@
 #include <linux/types.h>
 
 #define SUNXI_LOSC_CTRL				0x0000
+
+/* magic number required to set bit 0 */
+#define SUNXI_LOSC_CTRL_KEY			0x16AA0000
+
+#define SUNXI_LOSC_CTRL_AUTO_SWT_EN		BIT(14)
+
 #define SUNXI_LOSC_CTRL_RTC_HMS_ACC		BIT(8)
 #define SUNXI_LOSC_CTRL_RTC_YMD_ACC		BIT(7)
 
+#define SUNXI_LOSC_CTRL_EXT_GSM1		BIT(3)
+#define SUNXI_LOSC_CTRL_EXT_GSM0		BIT(2)
+#define SUNXI_LOSC_CTRL_SRC_SEL			BIT(0)
+
 #define SUNXI_RTC_YMD				0x0004
 
 #define SUNXI_RTC_HMS				0x0008
@@ -438,6 +448,8 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret;
 
+	uint32_t loscctrl;
+
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
@@ -468,6 +480,19 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	loscctrl = readl(chip->base + SUNXI_LOSC_CTRL);
+	loscctrl &= ~(SUNXI_LOSC_CTRL_AUTO_SWT_EN);
+	loscctrl |= (SUNXI_LOSC_CTRL_SRC_SEL | SUNXI_LOSC_CTRL_KEY);
+	loscctrl |= SUNXI_LOSC_CTRL_EXT_GSM1;
+	writel(loscctrl, chip->base + SUNXI_LOSC_CTRL);
+	udelay(100);
+
+	loscctrl = readl(chip->base + SUNXI_LOSC_CTRL);
+	if (!(loscctrl & SUNXI_LOSC_CTRL_SRC_SEL)) {
+		dev_err(&pdev->dev, "Error: Set LOSC to external failed.\n");
+		dev_err(&pdev->dev, "Warning: RTC time will be wrong!\n");
+	}
+
 	/* clear the alarm count value */
 	writel(0, chip->base + SUNXI_ALRM_DHMS);
 
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
