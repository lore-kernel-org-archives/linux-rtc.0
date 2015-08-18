Return-Path: <rtc-linux+bncBD66BCOYSQBBBUM4ZOXAKGQE63TDYUY@googlegroups.com>
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id kr5si767944igb.2.2015.08.17.23.18.57
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 23:18:57 -0700 (PDT)
From: Keerthy <j-keerthy@ti.com>
To: <alexandre.belloni@free-electrons.com>, <tony@atomide.com>
CC: <johan@kernel.org>, <linux-omap@vger.kernel.org>,
        <rtc-linux@googlegroups.com>, <grygorii.strashko@ti.com>,
        <j-keerthy@ti.com>
Subject: [rtc-linux] [PATCH v3 2/3] rtc: omap: Add internal clock enabling support
Date: Tue, 18 Aug 2015 11:48:43 +0530
Message-ID: <1439878724-5828-3-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1439878724-5828-1-git-send-email-j-keerthy@ti.com>
References: <1439878724-5828-1-git-send-email-j-keerthy@ti.com>
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

The rtc can be clocked by an internal 32K clock. Adding the support
to enable the same.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/rtc/rtc-omap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 8b6355f..f31c012 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 /*
  * The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
@@ -132,6 +133,7 @@ struct omap_rtc_device_type {
 struct omap_rtc {
 	struct rtc_device *rtc;
 	void __iomem *base;
+	struct clk *clk;
 	int irq_alarm;
 	int irq_timer;
 	u8 interrupts_reg;
@@ -553,6 +555,11 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (rtc->irq_alarm <= 0)
 		return -ENOENT;
 
+	rtc->clk = devm_clk_get(&pdev->dev, "int-clk");
+
+	if (!IS_ERR(rtc->clk))
+		clk_prepare_enable(rtc->clk);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rtc->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rtc->base))
@@ -681,6 +688,9 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 0);
 
+	if (!IS_ERR(rtc->clk))
+		clk_disable_unprepare(rtc->clk);
+
 	rtc->type->unlock(rtc);
 	/* leave rtc running, but disable irqs */
 	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
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
