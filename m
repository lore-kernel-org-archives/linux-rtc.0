Return-Path: <rtc-linux+bncBC433LF43MBBBT6Y33AAKGQE2GXHKWQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from outils.crapouillou.net (outils.crapouillou.net. [89.234.176.41])
        by gmr-mx.google.com with ESMTPS id d62si1385152wmd.0.2016.10.31.13.40.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2016 13:40:47 -0700 (PDT)
From: Paul Cercueil <paul@crapouillou.net>
To: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Maarten ter Huurne <maarten@treewalker.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Cc: Paul Cercueil <paul@crapouillou.net>
Subject: [rtc-linux] [PATCH v3 4/7] rtc: jz4740_rtc: Add support for acting as
 the system power controller
Date: Mon, 31 Oct 2016 21:39:48 +0100
Message-Id: <20161031203951.5444-4-paul@crapouillou.net>
In-Reply-To: <20161031203951.5444-1-paul@crapouillou.net>
References: <20161030230247.20538-1-paul@crapouillou.net>
 <20161031203951.5444-1-paul@crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The 'system-power-controller' singleton entry can be used in the
devicetree node of the jz4740-rtc driver to specify that the driver is
granted the right to power off the system through the registers of the
RTC unit.

See the documentation for more details:
Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Maarten ter Huurne <maarten@treewalker.org>
---
 drivers/rtc/rtc-jz4740.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

v2:
- Get a handle to the 'rtc' clock in the probe function, to handle errors early
- Call clk_prepare_enable() on the 'rtc' clock before calling clk_get_rate()
- Use the -msec suffix for the OF properties that deal with time
- Use of_property_read_32() instead of device_property_read_u32()

v3: Replace the -msec suffix by -ms

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 4213554..3f9d0da 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -14,11 +14,13 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -28,6 +30,8 @@
 #define JZ_REG_RTC_SEC_ALARM	0x08
 #define JZ_REG_RTC_REGULATOR	0x0C
 #define JZ_REG_RTC_HIBERNATE	0x20
+#define JZ_REG_RTC_WAKEUP_FILTER	0x24
+#define JZ_REG_RTC_RESET_COUNTER	0x28
 #define JZ_REG_RTC_SCRATCHPAD	0x34
 
 /* The following are present on the jz4780 */
@@ -45,6 +49,9 @@
 /* Magic value to enable writes on jz4780 */
 #define JZ_RTC_WENR_MAGIC	0xA55A
 
+#define JZ_RTC_WAKEUP_FILTER_MASK	0x0000FFE0
+#define JZ_RTC_RESET_COUNTER_MASK	0x00000FE0
+
 enum jz4740_rtc_type {
 	ID_JZ4740,
 	ID_JZ4780,
@@ -55,12 +62,18 @@ struct jz4740_rtc {
 	enum jz4740_rtc_type type;
 
 	struct rtc_device *rtc;
+	struct clk *clk;
 
 	int irq;
 
 	spinlock_t lock;
+
+	unsigned int min_wakeup_pin_assert_time;
+	unsigned int reset_pin_assert_time;
 };
 
+static struct device *dev_for_power_off;
+
 static inline uint32_t jz4740_rtc_reg_read(struct jz4740_rtc *rtc, size_t reg)
 {
 	return readl(rtc->base + reg);
@@ -246,6 +259,46 @@ void jz4740_rtc_poweroff(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
 
+static void jz4740_rtc_power_off(void)
+{
+	struct jz4740_rtc *rtc = dev_get_drvdata(dev_for_power_off);
+	unsigned long rtc_rate;
+	unsigned long wakeup_filter_ticks;
+	unsigned long reset_counter_ticks;
+
+	clk_prepare_enable(rtc->clk);
+
+	rtc_rate = clk_get_rate(rtc->clk);
+
+	/*
+	 * Set minimum wakeup pin assertion time: 100 ms.
+	 * Range is 0 to 2 sec if RTC is clocked at 32 kHz.
+	 */
+	wakeup_filter_ticks =
+		(rtc->min_wakeup_pin_assert_time * rtc_rate) / 1000;
+	if (wakeup_filter_ticks < JZ_RTC_WAKEUP_FILTER_MASK)
+		wakeup_filter_ticks &= JZ_RTC_WAKEUP_FILTER_MASK;
+	else
+		wakeup_filter_ticks = JZ_RTC_WAKEUP_FILTER_MASK;
+	jz4740_rtc_reg_write(rtc,
+			JZ_REG_RTC_WAKEUP_FILTER, wakeup_filter_ticks);
+
+	/*
+	 * Set reset pin low-level assertion time after wakeup: 60 ms.
+	 * Range is 0 to 125 ms if RTC is clocked at 32 kHz.
+	 */
+	reset_counter_ticks = (rtc->reset_pin_assert_time * rtc_rate) / 1000;
+	if (reset_counter_ticks < JZ_RTC_RESET_COUNTER_MASK)
+		reset_counter_ticks &= JZ_RTC_RESET_COUNTER_MASK;
+	else
+		reset_counter_ticks = JZ_RTC_RESET_COUNTER_MASK;
+	jz4740_rtc_reg_write(rtc,
+			JZ_REG_RTC_RESET_COUNTER, reset_counter_ticks);
+
+	jz4740_rtc_poweroff(dev_for_power_off);
+	machine_halt();
+}
+
 static const struct of_device_id jz4740_rtc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-rtc", .data = (void *) ID_JZ4740 },
 	{ .compatible = "ingenic,jz4780-rtc", .data = (void *) ID_JZ4780 },
@@ -262,6 +315,7 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	const struct of_device_id *of_id = of_match_device(
 			jz4740_rtc_of_match, &pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
@@ -283,6 +337,12 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->base))
 		return PTR_ERR(rtc->base);
 
+	rtc->clk = devm_clk_get(&pdev->dev, "rtc");
+	if (IS_ERR(rtc->clk)) {
+		dev_err(&pdev->dev, "Failed to get RTC clock\n");
+		return PTR_ERR(rtc->clk);
+	}
+
 	spin_lock_init(&rtc->lock);
 
 	platform_set_drvdata(pdev, rtc);
@@ -314,6 +374,27 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (np && of_device_is_system_power_controller(np)) {
+		if (!pm_power_off) {
+			/* Default: 60ms */
+			rtc->reset_pin_assert_time = 60;
+			of_property_read_u32(np, "reset-pin-assert-time-ms",
+					&rtc->reset_pin_assert_time);
+
+			/* Default: 100ms */
+			rtc->min_wakeup_pin_assert_time = 100;
+			of_property_read_u32(np,
+					"min-wakeup-pin-assert-time-ms",
+					&rtc->min_wakeup_pin_assert_time);
+
+			dev_for_power_off = &pdev->dev;
+			pm_power_off = jz4740_rtc_power_off;
+		} else {
+			dev_warn(&pdev->dev,
+					"Poweroff handler already present!\n");
+		}
+	}
+
 	return 0;
 }
 
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
