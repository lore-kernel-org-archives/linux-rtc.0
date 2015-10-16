Return-Path: <rtc-linux+bncBCXY5EGBQUIBBSVHQOYQKGQE2I4TRBA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-out.m-online.net (mail-out.m-online.net. [212.18.0.9])
        by gmr-mx.google.com with ESMTPS id q6si79080wif.2.2015.10.16.03.39.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Oct 2015 03:39:06 -0700 (PDT)
From: Heiko Schocher <hs@denx.de>
To: linux-kernel@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Georg.Soffel@bosch-si.com,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	devicetree@vger.kernel.org
Subject: [rtc-linux] [PATCH v3] rtc: pcf8563: add CLKOUT to common clock framework
Date: Fri, 16 Oct 2015 12:39:01 +0200
Message-Id: <1444991941-3564-1-git-send-email-hs@denx.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Add the clkout output clk to the common clock framework.
Disable the CLKOUT of the RTC after power-up.
After power-up/reset of the RTC, CLKOUT is enabled by default,
with CLKOUT enabled the RTC chip has 2-3 times higher power
consumption.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

Changes in v3:
- use CONFIG_COMMON_CLK for common clk framework
  changes

Changes in v2:
- add comments from Alexandre Belloni
  - remove the DT property, instead
    register for the CLKOUT a clk in the common
    clk framework. The clk is disabled by default.

 Documentation/devicetree/bindings/rtc/pcf8563.txt |  28 ++++
 drivers/rtc/rtc-pcf8563.c                         | 170 +++++++++++++++++++++-
 2 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/pcf8563.txt

diff --git a/Documentation/devicetree/bindings/rtc/pcf8563.txt b/Documentation/devicetree/bindings/rtc/pcf8563.txt
new file mode 100644
index 0000000..cdb81ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/pcf8563.txt
@@ -0,0 +1,28 @@
+* Philips PCF8563/Epson RTC8564 Real Time Clock
+
+Philips PCF8563/Epson RTC8564 Real Time Clock
+
+Required properties:
+see: Documentation/devicetree/bindings/i2c/trivial-devices.txt
+
+Optional property:
+- #clock-cells: Should be 1.
+- clocks: Reference to the clock entry.
+- clock-output-names:
+  overwrite the default clock name "pcf8563-clkout"
+
+Example:
+
+rtcclk: rtcclk {
+	compatible = "fixed-clock";
+	#clock-cells = <1>;
+	clock-frequency = <1>;
+	clock-output-names = "rtcclk";
+};
+
+pcf8563@51 {
+	compatible = "nxp,pcf8563";
+	reg = <0x51>;
+	#clock-cells = <1>;
+	clocks = <&rtcclk 0>;
+};
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index e569243..9db3c1f 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -14,6 +14,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk-provider.h>
 #include <linux/i2c.h>
 #include <linux/bcd.h>
 #include <linux/rtc.h>
@@ -40,7 +41,14 @@
 
 #define PCF8563_REG_AMN		0x09 /* alarm */
 
-#define PCF8563_REG_CLKO	0x0D /* clock out */
+#define PCF8563_REG_CLKO		0x0D /* clock out */
+#define PCF8563_REG_CLKO_FE		0x80 /* clock out enabled */
+#define PCF8563_REG_CLKO_F_MASK		0x03 /* frequenc mask */
+#define PCF8563_REG_CLKO_F_32768HZ	0x00
+#define PCF8563_REG_CLKO_F_1024HZ	0x01
+#define PCF8563_REG_CLKO_F_32HZ		0x02
+#define PCF8563_REG_CLKO_F_1HZ		0x03
+
 #define PCF8563_REG_TMRC	0x0E /* timer control */
 #define PCF8563_TMRC_ENABLE	BIT(7)
 #define PCF8563_TMRC_4096	0
@@ -76,6 +84,9 @@ struct pcf8563 {
 	int voltage_low; /* incicates if a low_voltage was detected */
 
 	struct i2c_client *client;
+#ifdef CONFIG_COMMON_CLK
+	struct clk_hw		clkout_hw;
+#endif
 };
 
 static int pcf8563_read_block_data(struct i2c_client *client, unsigned char reg,
@@ -390,6 +401,158 @@ static int pcf8563_irq_enable(struct device *dev, unsigned int enabled)
 	return pcf8563_set_alarm_mode(to_i2c_client(dev), !!enabled);
 }
 
+#ifdef CONFIG_COMMON_CLK
+/*
+ * Handling of the clkout
+ */
+
+#define clkout_hw_to_pcf8563(_hw) container_of(_hw, struct pcf8563, clkout_hw)
+
+static int clkout_rates[] = {
+	32768,
+	1024,
+	32,
+	1,
+};
+
+static unsigned long pcf8563_clkout_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct pcf8563 *pcf8563 = clkout_hw_to_pcf8563(hw);
+	struct i2c_client *client = pcf8563->client;
+	unsigned char buf;
+	int ret = pcf8563_read_block_data(client, PCF8563_REG_CLKO, 1, &buf);
+
+	if (ret < 0)
+		return 0;
+
+	buf &= PCF8563_REG_CLKO_F_MASK;
+	return clkout_rates[ret];
+}
+
+static long pcf8563_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long *prate)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(clkout_rates); i++)
+		if (clkout_rates[i] <= rate)
+			return clkout_rates[i];
+
+	return 0;
+}
+
+static int pcf8563_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
+{
+	struct pcf8563 *pcf8563 = clkout_hw_to_pcf8563(hw);
+	struct i2c_client *client = pcf8563->client;
+	unsigned char buf;
+	int ret = pcf8563_read_block_data(client, PCF8563_REG_CLKO, 1, &buf);
+	int i;
+
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(clkout_rates); i++)
+		if (clkout_rates[i] == rate) {
+			buf &= ~PCF8563_REG_CLKO_F_MASK;
+			buf |= i;
+			ret = pcf8563_write_block_data(client,
+						       PCF8563_REG_CLKO, 1,
+						       &buf);
+			return ret;
+		}
+
+	return -EINVAL;
+}
+
+static int pcf8563_clkout_control(struct clk_hw *hw, bool enable)
+{
+	struct pcf8563 *pcf8563 = clkout_hw_to_pcf8563(hw);
+	struct i2c_client *client = pcf8563->client;
+	unsigned char buf;
+	int ret = pcf8563_read_block_data(client, PCF8563_REG_CLKO, 1, &buf);
+
+	if (ret < 0)
+		return ret;
+
+	if (enable)
+		buf |= PCF8563_REG_CLKO_FE;
+	else
+		buf &= ~PCF8563_REG_CLKO_FE;
+
+	ret = pcf8563_write_block_data(client, PCF8563_REG_CLKO, 1, &buf);
+	return ret;
+}
+
+static int pcf8563_clkout_prepare(struct clk_hw *hw)
+{
+	return pcf8563_clkout_control(hw, 1);
+}
+
+static void pcf8563_clkout_unprepare(struct clk_hw *hw)
+{
+	pcf8563_clkout_control(hw, 0);
+}
+
+static int pcf8563_clkout_is_prepared(struct clk_hw *hw)
+{
+	struct pcf8563 *pcf8563 = clkout_hw_to_pcf8563(hw);
+	struct i2c_client *client = pcf8563->client;
+	unsigned char buf;
+	int ret = pcf8563_read_block_data(client, PCF8563_REG_CLKO, 1, &buf);
+
+	if (ret < 0)
+		return ret;
+
+	return !!(buf & PCF8563_REG_CLKO_FE);
+}
+
+static const struct clk_ops pcf8563_clkout_ops = {
+	.prepare = pcf8563_clkout_prepare,
+	.unprepare = pcf8563_clkout_unprepare,
+	.is_prepared = pcf8563_clkout_is_prepared,
+	.recalc_rate = pcf8563_clkout_recalc_rate,
+	.round_rate = pcf8563_clkout_round_rate,
+	.set_rate = pcf8563_clkout_set_rate,
+};
+
+static struct clk *pcf8563_clkout_register_clk(struct pcf8563 *pcf8563)
+{
+	struct i2c_client *client = pcf8563->client;
+	struct device_node *node = client->dev.of_node;
+	struct clk *clk;
+	struct clk_init_data init;
+	int ret;
+	unsigned char buf;
+
+	/* disable the clkout output */
+	buf = 0;
+	ret = pcf8563_write_block_data(client, PCF8563_REG_CLKO, 1, &buf);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	init.name = "pcf8563-clkout";
+	init.ops = &pcf8563_clkout_ops;
+	init.flags = CLK_IS_ROOT;
+	init.parent_names = NULL;
+	init.num_parents = 0;
+	pcf8563->clkout_hw.init = &init;
+
+	/* optional override of the clockname */
+	of_property_read_string(node, "clock-output-names", &init.name);
+
+	/* register the clock */
+	clk = clk_register(&client->dev, &pcf8563->clkout_hw);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
+	return clk;
+}
+#endif
+
 static const struct rtc_class_ops pcf8563_rtc_ops = {
 	.ioctl		= pcf8563_rtc_ioctl,
 	.read_time	= pcf8563_rtc_read_time,
@@ -459,6 +622,11 @@ static int pcf8563_probe(struct i2c_client *client,
 
 	}
 
+#ifdef CONFIG_COMMON_CLK
+	/* register clk in common clk framework */
+	pcf8563_clkout_register_clk(pcf8563);
+#endif
+
 	/* the pcf8563 alarm only supports a minute accuracy */
 	pcf8563->rtc->uie_unsupported = 1;
 
-- 
2.1.0

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
