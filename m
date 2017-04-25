Return-Path: <rtc-linux+bncBCL5RYHM6ECRBCWC7XDQKGQEAXXFWAY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x234.google.com (mail-wm0-x234.google.com. [2a00:1450:400c:c09::234])
        by gmr-mx.google.com with ESMTPS id f136si1396538wme.1.2017.04.25.07.45.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 07:45:30 -0700 (PDT)
Received: by mail-wm0-x234.google.com with SMTP id m123so97953419wma.0
        for <rtc-linux@googlegroups.com>; Tue, 25 Apr 2017 07:45:30 -0700 (PDT)
From: Gary Bisson <gary.bisson@boundarydevices.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it,
	Gary Bisson <gary.bisson@boundarydevices.com>
Subject: [rtc-linux] [PATCH 4/4] rtc: m41t80: add clock provider support
Date: Tue, 25 Apr 2017 16:45:17 +0200
Message-Id: <20170425144517.15962-5-gary.bisson@boundarydevices.com>
In-Reply-To: <20170425144517.15962-1-gary.bisson@boundarydevices.com>
References: <20170425144517.15962-1-gary.bisson@boundarydevices.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Some devices supported by the m41t80 driver have a programmable
square-wave output signal (see M41T80_FEATURE_SQ).

This enables to use this feature as a clock provider of common
clock framework.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 drivers/rtc/rtc-m41t80.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 2bdf494a9bd4..ea3d1efe9192 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -16,6 +16,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bcd.h>
+#include <linux/clk-provider.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -52,6 +53,8 @@
 #define M41T80_ALARM_REG_SIZE	\
 	(M41T80_REG_ALARM_SEC + 1 - M41T80_REG_ALARM_MON)
 
+#define M41T80_SQW_MAX_FREQ	32768
+
 #define M41T80_SEC_ST		BIT(7)	/* ST: Stop Bit */
 #define M41T80_ALMON_AFE	BIT(7)	/* AFE: AF Enable Bit */
 #define M41T80_ALMON_SQWE	BIT(6)	/* SQWE: SQW Enable Bit */
@@ -88,7 +91,11 @@ MODULE_DEVICE_TABLE(i2c, m41t80_id);
 
 struct m41t80_data {
 	u8 features;
+	struct i2c_client *client;
 	struct rtc_device *rtc;
+#ifdef CONFIG_COMMON_CLK
+	struct clk_hw sqw;
+#endif
 };
 
 static irqreturn_t m41t80_handle_irq(int irq, void *dev_id)
@@ -396,6 +403,166 @@ static struct attribute_group attr_group = {
 	.attrs = attrs,
 };
 
+#ifdef CONFIG_COMMON_CLK
+#define sqw_to_m41t80_data(_hw) container_of(_hw, struct m41t80_data, sqw)
+
+static unsigned long m41t80_sqw_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct m41t80_data *m41t80 = sqw_to_m41t80_data(hw);
+	struct i2c_client *client = m41t80->client;
+	int reg_sqw = (m41t80->features & M41T80_FEATURE_SQ_ALT) ?
+		M41T80_REG_WDAY : M41T80_REG_SQW;
+	int ret = i2c_smbus_read_byte_data(client, reg_sqw);
+	unsigned long val = M41T80_SQW_MAX_FREQ;
+
+	if (ret < 0)
+		return 0;
+
+	ret >>= 4;
+	if (ret == 0)
+		val = 0;
+	else if (ret > 1)
+		val = val / (1 << ret);
+
+	return val;
+}
+
+static long m41t80_sqw_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate)
+{
+	int i, freq = M41T80_SQW_MAX_FREQ;
+
+	if (freq <= rate)
+		return freq;
+
+	for (i = 2; i <= ilog2(M41T80_SQW_MAX_FREQ); i++) {
+		freq /= 1 << i;
+		if (freq <= rate)
+			return freq;
+	}
+
+	return 0;
+}
+
+static int m41t80_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct m41t80_data *m41t80 = sqw_to_m41t80_data(hw);
+	struct i2c_client *client = m41t80->client;
+	int reg_sqw = (m41t80->features & M41T80_FEATURE_SQ_ALT) ?
+		M41T80_REG_WDAY : M41T80_REG_SQW;
+	int reg, ret, val = 0;
+
+	if (rate) {
+		if (!is_power_of_2(rate))
+			return -EINVAL;
+		val = ilog2(rate);
+		if (val == ilog2(M41T80_SQW_MAX_FREQ))
+			val = 1;
+		else if (val < (ilog2(M41T80_SQW_MAX_FREQ) - 1))
+			val = ilog2(M41T80_SQW_MAX_FREQ) - val;
+		else
+			return -EINVAL;
+	}
+
+	reg = i2c_smbus_read_byte_data(client, reg_sqw);
+	if (reg < 0)
+		return reg;
+
+	reg = (reg & 0x0f) | (val << 4);
+
+	ret = i2c_smbus_write_byte_data(client, reg_sqw, reg);
+	if (ret < 0)
+		return ret;
+
+	return -EINVAL;
+}
+
+static int m41t80_sqw_control(struct clk_hw *hw, bool enable)
+{
+	struct m41t80_data *m41t80 = sqw_to_m41t80_data(hw);
+	struct i2c_client *client = m41t80->client;
+	int ret = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
+
+	if (ret < 0)
+		return ret;
+
+	if (enable)
+		ret |= M41T80_ALMON_SQWE;
+	else
+		ret &= ~M41T80_ALMON_SQWE;
+
+	return i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON, ret);
+}
+
+static int m41t80_sqw_prepare(struct clk_hw *hw)
+{
+	return m41t80_sqw_control(hw, 1);
+}
+
+static void m41t80_sqw_unprepare(struct clk_hw *hw)
+{
+	m41t80_sqw_control(hw, 0);
+}
+
+static int m41t80_sqw_is_prepared(struct clk_hw *hw)
+{
+	struct m41t80_data *m41t80 = sqw_to_m41t80_data(hw);
+	struct i2c_client *client = m41t80->client;
+	int ret = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
+
+	if (ret < 0)
+		return ret;
+
+	return !!(ret & M41T80_ALMON_SQWE);
+}
+
+static const struct clk_ops m41t80_sqw_ops = {
+	.prepare = m41t80_sqw_prepare,
+	.unprepare = m41t80_sqw_unprepare,
+	.is_prepared = m41t80_sqw_is_prepared,
+	.recalc_rate = m41t80_sqw_recalc_rate,
+	.round_rate = m41t80_sqw_round_rate,
+	.set_rate = m41t80_sqw_set_rate,
+};
+
+static struct clk *m41t80_sqw_register_clk(struct m41t80_data *m41t80)
+{
+	struct i2c_client *client = m41t80->client;
+	struct device_node *node = client->dev.of_node;
+	struct clk *clk;
+	struct clk_init_data init;
+	int ret;
+
+	/* First disable the clock */
+	ret = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	ret = i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON,
+					ret & ~(M41T80_ALMON_SQWE));
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	init.name = "m41t80-sqw";
+	init.ops = &m41t80_sqw_ops;
+	init.flags = 0;
+	init.parent_names = NULL;
+	init.num_parents = 0;
+	m41t80->sqw.init = &init;
+
+	/* optional override of the clockname */
+	of_property_read_string(node, "clock-output-names", &init.name);
+
+	/* register the clock */
+	clk = clk_register(&client->dev, &m41t80->sqw);
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
+	return clk;
+}
+#endif
+
 #ifdef CONFIG_RTC_DRV_M41T80_WDT
 /*
  *****************************************************************************
@@ -713,6 +880,7 @@ static int m41t80_probe(struct i2c_client *client,
 	if (!m41t80_data)
 		return -ENOMEM;
 
+	m41t80_data->client = client;
 	m41t80_data->features = id->driver_data;
 	i2c_set_clientdata(client, m41t80_data);
 
@@ -801,6 +969,10 @@ static int m41t80_probe(struct i2c_client *client,
 		}
 	}
 #endif
+#ifdef CONFIG_COMMON_CLK
+	if (m41t80_data->features & M41T80_FEATURE_SQ)
+		m41t80_sqw_register_clk(m41t80_data);
+#endif
 	return 0;
 }
 
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
