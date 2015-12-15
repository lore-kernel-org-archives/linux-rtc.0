Return-Path: <rtc-linux+bncBDUOXGMN6YKBBPNDYGZQKGQEITUJEKI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-lb0-x242.google.com (mail-lb0-x242.google.com. [2a00:1450:4010:c04::242])
        by gmr-mx.google.com with ESMTPS id rw5si87101lbb.2.2015.12.15.09.45.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2015 09:45:33 -0800 (PST)
Received: by mail-lb0-x242.google.com with SMTP id ul9so1073080lbb.2
        for <rtc-linux@googlegroups.com>; Tue, 15 Dec 2015 09:45:33 -0800 (PST)
From: Sergei Ianovich <ynvich@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Sergei Ianovich <ynvich@gmail.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	rtc-linux@googlegroups.com (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Subject: [rtc-linux] [PATCH v5] rtc: support DS1302 RTC on ICP DAS LP-8x4x
Date: Tue, 15 Dec 2015 20:45:23 +0300
Message-Id: <1450201525-9137-1-git-send-email-ynvich@gmail.com>
In-Reply-To: <397668667-27328-3-git-send-email-ynvich@gmail.com>
References: <397668667-27328-3-git-send-email-ynvich@gmail.com>
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

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
   v4..v5
   * drop THIS_MODULE from struct platform driver
   * use "dallas" for vendor name per vendor-prefixes.txt

   v3..v4
   * move DTS bindings to a different patch

   v2..v3
   * use usleep_range instead of custom nsleep
   * number change (07/16 -> 09/21)

   v0..v2
   * use device tree
   * use devm helpers where possible

 .../devicetree/bindings/rtc/rtc-ds1302.txt         |  14 +++
 drivers/rtc/Kconfig                                |   2 +-
 drivers/rtc/rtc-ds1302.c                           | 100 ++++++++++++++++++++-
 3 files changed, 113 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-ds1302.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1302.txt b/Documentation/devicetree/bindings/rtc/rtc-ds1302.txt
new file mode 100644
index 0000000..810613b
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-ds1302.txt
@@ -0,0 +1,14 @@
+* Dallas Semiconductor DS-1302 RTC
+
+Simple device which could be used to store date/time between reboots.
+
+Required properties:
+- compatible : Should be "dallas,rtc-ds1302"
+- reg : Should be address and size of IO memory region
+
+Examples:
+
+rtc@40900000 {
+	compatible = "dallas,rtc-ds1302";
+	reg = <0x1700901c 0x1>;
+};
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 2a52424..cf36483 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -803,7 +803,7 @@ config RTC_DRV_DS1286
 
 config RTC_DRV_DS1302
 	tristate "Dallas DS1302"
-	depends on SH_SECUREEDGE5410
+	depends on SH_SECUREEDGE5410 || (ARCH_PXA && HIGH_RES_TIMERS)
 	help
 	  If you say yes here you get support for the Dallas DS1302 RTC chips.
 
diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index 6bef7a5..bd68214 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -50,7 +50,7 @@
 #define ds1302_set_tx()
 #define ds1302_set_rx()
 
-static inline int ds1302_hw_init(void)
+static inline int ds1302_hw_init(struct platform_device *pdev)
 {
 	return 0;
 }
@@ -86,6 +86,101 @@ static inline int ds1302_rxbit(void)
 	return !!(get_dp() & RTC_IODATA);
 }
 
+#elif defined(CONFIG_ARCH_PXA) && defined(CONFIG_HIGH_RES_TIMERS)
+
+#include <linux/delay.h>
+#include <linux/of.h>
+
+#define	RTC_CE		0x01
+#define	RTC_CLK		0x02
+#define	RTC_nWE		0x04
+#define	RTC_IODATA	0x08
+
+static unsigned long ds1302_state;
+
+static void *mem;
+
+static inline int ds1302_hw_init(struct platform_device *pdev)
+{
+	struct resource *r;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	mem = devm_ioremap_resource(&pdev->dev, r);
+	if (!mem)
+		return -EFAULT;
+
+	return 0;
+}
+
+static inline void ds1302_reset(void)
+{
+	ds1302_state = 0;
+	iowrite8(ds1302_state, mem);
+	usleep_range(4, 5);
+}
+
+static inline void ds1302_clock(void)
+{
+	usleep_range(1, 2);
+	ds1302_state |= RTC_CLK;
+	iowrite8(ds1302_state, mem);
+	usleep_range(1, 2);
+	ds1302_state &= ~RTC_CLK;
+	iowrite8(ds1302_state, mem);
+}
+
+static inline void ds1302_start(void)
+{
+	ds1302_state &= ~RTC_CLK;
+	ds1302_state |= RTC_CE;
+	iowrite8(ds1302_state, mem);
+	usleep_range(3, 4);
+}
+
+static inline void ds1302_stop(void)
+{
+	ds1302_state &= ~RTC_CE;
+	iowrite8(ds1302_state, mem);
+}
+
+static inline void ds1302_set_tx(void)
+{
+	ds1302_state &= ~RTC_nWE;
+	iowrite8(ds1302_state, mem);
+}
+
+static inline void ds1302_set_rx(void)
+{
+	ds1302_state |= RTC_nWE;
+	iowrite8(ds1302_state, mem);
+}
+
+static inline void ds1302_txbit(int bit)
+{
+	if (bit)
+		ds1302_state |= RTC_IODATA;
+	else
+		ds1302_state &= ~RTC_IODATA;
+	iowrite8(ds1302_state, mem);
+}
+
+static inline int ds1302_rxbit(void)
+{
+	return ioread8(mem) & 0x1;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ds1302_dt_ids[] = {
+	{ .compatible = "dallas,rtc-ds1302" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, ds1302_dt_ids);
+#endif
+
 #else
 #error "Add support for your platform"
 #endif
@@ -216,7 +311,7 @@ static int __init ds1302_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 
-	if (ds1302_hw_init()) {
+	if (ds1302_hw_init(pdev)) {
 		dev_err(&pdev->dev, "Failed to init communication channel");
 		return -EINVAL;
 	}
@@ -244,6 +339,7 @@ static int __init ds1302_rtc_probe(struct platform_device *pdev)
 static struct platform_driver ds1302_platform_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
+		.of_match_table = of_match_ptr(ds1302_dt_ids),
 	},
 };
 
-- 
2.6.2

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
