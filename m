Return-Path: <rtc-linux+bncBC433LF43MBBBKWA5W3AKGQEKWLS3MI@googlegroups.com>
MIME-Version: 1.0
Received: from outils.crapouillou.net ([2001:910:1321:33:0:c0ff:fea8:213b])
        by gmr-mx.google.com with ESMTPS id s141si224030wmd.1.2016.03.05.14.39.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Mar 2016 14:39:38 -0800 (PST)
From: Paul Cercueil <paul@crapouillou.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Paul Cercueil <paul@crapouillou.net>,
	Paul Burton <paul.burton@imgtec.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 4/5] rtc: jz4740_rtc: Add support for acting as
 the system power controller
Date: Sat,  5 Mar 2016 23:38:50 +0100
Message-Id: <1457217531-26064-4-git-send-email-paul@crapouillou.net>
In-Reply-To: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
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

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/rtc/rtc-jz4740.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 3914b1c..f53cfd6 100644
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
@@ -59,8 +66,13 @@ struct jz4740_rtc {
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
@@ -246,6 +258,49 @@ void jz4740_rtc_poweroff(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
 
+static void jz4740_rtc_power_off(void)
+{
+	struct jz4740_rtc *rtc = dev_get_drvdata(dev_for_power_off);
+	unsigned long wakeup_filter_ticks;
+	unsigned long reset_counter_ticks;
+	struct clk *rtc_clk;
+	unsigned long rtc_rate;
+
+	rtc_clk = clk_get(dev_for_power_off, "rtc");
+	if (IS_ERR(rtc_clk))
+		panic("unable to get RTC clock");
+	rtc_rate = clk_get_rate(rtc_clk);
+	clk_put(rtc_clk);
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
@@ -314,6 +369,28 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (of_device_is_system_power_controller(pdev->dev.of_node)) {
+		if (!pm_power_off) {
+			/* Default: 60ms */
+			rtc->reset_pin_assert_time = 60;
+			device_property_read_u32(&pdev->dev,
+					"reset-pin-assert-time",
+					&rtc->reset_pin_assert_time);
+
+			/* Default: 100ms */
+			rtc->min_wakeup_pin_assert_time = 100;
+			device_property_read_u32(&pdev->dev,
+					"min-wakeup-pin-assert-time",
+					&rtc->min_wakeup_pin_assert_time);
+
+			dev_for_power_off = &pdev->dev;
+			pm_power_off = jz4740_rtc_power_off;
+		} else {
+			dev_err(&pdev->dev,
+					"Poweroff handler already present!\n");
+		}
+	}
+
 	return 0;
 }
 
-- 
2.7.0

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
