Return-Path: <rtc-linux+bncBC6YH6VTZQDRBZMLS7CQKGQE66LVPNY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id h198si22561wmg.1.2017.02.16.07.31.49
        for <rtc-linux@googlegroups.com>;
        Thu, 16 Feb 2017 07:31:49 -0800 (PST)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Haim Boot <hayim@marvell.com>
Subject: [rtc-linux] [PATCH 2/3] rtc: armada38x: Add support for Armada 7K/8K
Date: Thu, 16 Feb 2017 16:31:35 +0100
Message-Id: <20170216153136.27009-3-gregory.clement@free-electrons.com>
In-Reply-To: <20170216153136.27009-1-gregory.clement@free-electrons.com>
References: <20170216153136.27009-1-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The Armada 7K/8K use the same RTC IP than the Armada 38x. However the SOC
integration differs in 2 points:
 - MBUS bridge timing initialization
 - IRQ configuration at SoC level

Moreover the Armada 7K/8K have an issue preventing to get the interrupt
from alarm 1. This commit allows to use alarm 2 for these A7K/8K but to
still use alarm 1 for the Armada 38x.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/rtc/armada-380-rtc.txt     |  8 ++-
 drivers/rtc/rtc-armada38x.c                        | 65 ++++++++++++++++++++++
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
index 2eb9d4ee7dc0..c3c9a1226f9a 100644
--- a/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
@@ -1,9 +1,11 @@
-* Real Time Clock of the Armada 38x SoCs
+* Real Time Clock of the Armada 38x/7K/8K SoCs
 
-RTC controller for the Armada 38x SoCs
+RTC controller for the Armada 38x, 7K and 8K SoCs
 
 Required properties:
-- compatible : Should be "marvell,armada-380-rtc"
+- compatible : Should be one of the following:
+	"marvell,armada-380-rtc" for Armada 38x SoC
+	"marvell,armada-8k-rtc" for Aramda 7K/8K SoCs
 - reg: a list of base address and size pairs, one for each entry in
   reg-names
 - reg names: should contain:
diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index b2a8e2ed71ca..21f355c37eab 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -24,18 +24,36 @@
 #define RTC_STATUS_ALARM1	    BIT(0)
 #define RTC_STATUS_ALARM2	    BIT(1)
 #define RTC_IRQ1_CONF	    0x4
+#define RTC_IRQ2_CONF	    0x8
 #define RTC_IRQ_AL_EN		    BIT(0)
 #define RTC_IRQ_FREQ_EN		    BIT(1)
 #define RTC_IRQ_FREQ_1HZ	    BIT(2)
 
 #define RTC_TIME	    0xC
 #define RTC_ALARM1	    0x10
+#define RTC_ALARM2	    0x14
+
+/* Armada38x SoC registers  */
 #define RTC_38X_BRIDGE_TIMING_CTL   0x0
 #define RTC_38X_PERIOD_OFFS		0
 #define RTC_38X_PERIOD_MASK		(0x3FF << RTC_38X_PERIOD_OFFS)
 #define RTC_38X_READ_DELAY_OFFS		26
 #define RTC_38X_READ_DELAY_MASK		(0x1F << RTC_38X_READ_DELAY_OFFS)
 
+/* Armada 7K/8K registers  */
+#define RTC_8K_BRIDGE_TIMING_CTL0    0x0
+#define RTC_8K_WRCLK_PERIOD_OFFS	0
+#define RTC_8K_WRCLK_PERIOD_MASK	(0xFFFF << RTC_8K_WRCLK_PERIOD_OFFS)
+#define RTC_8K_WRCLK_SETUP_OFFS		16
+#define RTC_8K_WRCLK_SETUP_MASK		(0xFFFF << RTC_8K_WRCLK_SETUP_OFFS)
+#define RTC_8K_BRIDGE_TIMING_CTL1   0x4
+#define RTC_8K_READ_DELAY_OFFS		0
+#define RTC_8K_READ_DELAY_MASK		(0xFFFF << RTC_8K_READ_DELAY_OFFS)
+
+#define RTC_8K_ISR		    0x10
+#define RTC_8K_IMR		    0x14
+#define RTC_8K_ALARM2			BIT(0)
+
 #define SOC_RTC_INTERRUPT	    0x8
 #define SOC_RTC_ALARM1			BIT(0)
 #define SOC_RTC_ALARM2			BIT(1)
@@ -60,6 +78,8 @@ struct armada38x_rtc {
 };
 
 #define ALARM1	0
+#define ALARM2	1
+
 #define ALARM_REG(base, alarm)	 ((base) + (alarm) * sizeof(u32))
 
 struct armada38x_rtc_data {
@@ -102,6 +122,28 @@ static void rtc_update_38x_mbus_timing_params(struct armada38x_rtc *rtc)
 	writel(reg, rtc->regs_soc + RTC_38X_BRIDGE_TIMING_CTL);
 }
 
+static void rtc_update_8k_mbus_timing_params(struct armada38x_rtc *rtc)
+{
+	u32 reg;
+
+	reg = readl(rtc->regs_soc + RTC_8K_BRIDGE_TIMING_CTL0);
+	reg &= ~RTC_8K_WRCLK_PERIOD_MASK;
+	reg |= 0x3FF << RTC_8K_WRCLK_PERIOD_OFFS;
+	reg &= ~RTC_8K_WRCLK_SETUP_MASK;
+	reg |= 0x29 << RTC_8K_WRCLK_SETUP_OFFS;
+	writel(reg, rtc->regs_soc + RTC_8K_BRIDGE_TIMING_CTL0);
+
+	reg = readl(rtc->regs_soc + RTC_8K_BRIDGE_TIMING_CTL1);
+	reg &= ~RTC_8K_READ_DELAY_MASK;
+	reg |= 0x3F << RTC_8K_READ_DELAY_OFFS;
+	writel(reg, rtc->regs_soc + RTC_8K_BRIDGE_TIMING_CTL1);
+}
+
+static u32 read_rtc_register(struct armada38x_rtc *rtc, u8 rtc_reg)
+{
+	return readl(rtc->regs + rtc_reg);
+}
+
 static u32 read_rtc_register_38x_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
 {
 	int i, index_max = 0, max = 0;
@@ -157,6 +199,17 @@ static void armada38x_unmask_interrupt(struct armada38x_rtc *rtc)
 
 	writel(val | SOC_RTC_ALARM1_MASK, rtc->regs_soc + SOC_RTC_INTERRUPT);
 }
+
+static void armada8k_clear_isr(struct armada38x_rtc *rtc)
+{
+	writel(RTC_8K_ALARM2, rtc->regs_soc + RTC_8K_ISR);
+}
+
+static void armada8k_unmask_interrupt(struct armada38x_rtc *rtc)
+{
+	writel(RTC_8K_ALARM2, rtc->regs_soc + RTC_8K_IMR);
+}
+
 static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
@@ -312,12 +365,24 @@ static const struct armada38x_rtc_data armada38x_data = {
 	.alarm = ALARM1,
 };
 
+static const struct armada38x_rtc_data armada8k_data = {
+	.update_mbus_timing = rtc_update_8k_mbus_timing_params,
+	.read_rtc_reg = read_rtc_register,
+	.clear_isr = armada8k_clear_isr,
+	.unmask_interrupt = armada8k_unmask_interrupt,
+	.alarm = ALARM2,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id armada38x_rtc_of_match_table[] = {
 	{
 		.compatible = "marvell,armada-380-rtc",
 		.data = &armada38x_data,
 	},
+	{
+		.compatible = "marvell,armada-8k-rtc",
+		.data = &armada8k_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, armada38x_rtc_of_match_table);
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
