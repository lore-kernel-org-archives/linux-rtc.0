Return-Path: <rtc-linux+bncBAABBZHB7TFQKGQEYR7YJ3A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail02.prevas.se (mail02.prevas.se. [62.95.78.10])
        by gmr-mx.google.com with ESMTPS id 139si54749wmt.0.2017.07.31.06.30.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jul 2017 06:30:10 -0700 (PDT)
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <rtc-linux@googlegroups.com>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	<alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [RFC] rtc: ds1307: add square wave output from ds1308
Date: Mon, 31 Jul 2017 15:30:13 +0200
Message-ID: <20170731133013.22347-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

add square wave output to generic clock framework and
disable sqw output from ds1308 in order to reduce
the power consumption by ~50%.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
This contains some code duplication(of my opinion) I guess it could be done more
generic together with the ds3231.

 drivers/rtc/rtc-ds1307.c | 172 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 170 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 1cedb21ba792..f92c99d7dd2e 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -79,6 +79,7 @@ enum ds_type {
 #	define DS1307_BIT_OUT		0x80
 #	define DS1338_BIT_OSF		0x20
 #	define DS1307_BIT_SQWE		0x10
+#	define DS1308_BIT_BBCLK		0x04
 #	define DS1307_BIT_RS1		0x02
 #	define DS1307_BIT_RS0		0x01
 #define DS1337_REG_CONTROL	0x0e
@@ -1056,6 +1057,13 @@ enum {
 #define clk_32khz_to_ds1307(clk)	\
 	container_of(clk, struct ds1307, clks[DS3231_CLK_32KHZ])
 
+static int ds1308_clk_sqw_rates[] = {
+	1,
+	4096,
+	8192,
+	32768,
+};
+
 static int ds3231_clk_sqw_rates[] = {
 	1,
 	1024,
@@ -1063,6 +1071,19 @@ static int ds3231_clk_sqw_rates[] = {
 	8192,
 };
 
+static int ds1308_write_control(struct ds1307 *ds1307, u8 mask, u8 value)
+{
+	struct mutex *lock = &ds1307->rtc->ops_lock;
+	int ret;
+
+	mutex_lock(lock);
+	ret = regmap_update_bits(ds1307->regmap, DS1307_REG_CONTROL,
+				 mask, value);
+	mutex_unlock(lock);
+
+	return ret;
+}
+
 static int ds1337_write_control(struct ds1307 *ds1307, u8 mask, u8 value)
 {
 	struct mutex *lock = &ds1307->rtc->ops_lock;
@@ -1076,6 +1097,24 @@ static int ds1337_write_control(struct ds1307 *ds1307, u8 mask, u8 value)
 	return ret;
 }
 
+static unsigned long ds1308_clk_sqw_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+	int control, ret;
+	int rate_sel = 0;
+
+	ret = regmap_read(ds1307->regmap, DS1307_REG_CONTROL, &control);
+	if (ret)
+		return ret;
+	if (control & DS1307_BIT_RS0)
+		rate_sel += 1;
+	if (control & DS1307_BIT_RS1)
+		rate_sel += 2;
+
+	return ds1308_clk_sqw_rates[rate_sel];
+}
+
 static unsigned long ds3231_clk_sqw_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
@@ -1094,6 +1133,19 @@ static unsigned long ds3231_clk_sqw_recalc_rate(struct clk_hw *hw,
 	return ds3231_clk_sqw_rates[rate_sel];
 }
 
+static long ds1308_clk_sqw_round_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long *prate)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(ds1308_clk_sqw_rates) - 1; i >= 0; i--) {
+		if (ds1308_clk_sqw_rates[i] <= rate)
+			return ds1308_clk_sqw_rates[i];
+	}
+
+	return 0;
+}
+
 static long ds3231_clk_sqw_round_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long *prate)
 {
@@ -1107,6 +1159,31 @@ static long ds3231_clk_sqw_round_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static int ds1308_clk_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+	int control = 0;
+	int rate_sel;
+
+	for (rate_sel = 0; rate_sel < ARRAY_SIZE(ds1308_clk_sqw_rates);
+			rate_sel++) {
+		if (ds1308_clk_sqw_rates[rate_sel] == rate)
+			break;
+	}
+
+	if (rate_sel == ARRAY_SIZE(ds1308_clk_sqw_rates))
+		return -EINVAL;
+
+	if (rate_sel & 1)
+		control |= DS1307_BIT_RS0;
+	if (rate_sel & 2)
+		control |= DS1307_BIT_RS1;
+
+	return ds1337_write_control(ds1307, DS1307_BIT_RS0 | DS1307_BIT_RS1,
+				control);
+}
+
 static int ds3231_clk_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long parent_rate)
 {
@@ -1132,6 +1209,13 @@ static int ds3231_clk_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
 				control);
 }
 
+static int ds1308_clk_sqw_prepare(struct clk_hw *hw)
+{
+	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+
+	return ds1308_write_control(ds1307, DS1307_BIT_SQWE, 1);
+}
+
 static int ds3231_clk_sqw_prepare(struct clk_hw *hw)
 {
 	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
@@ -1139,6 +1223,13 @@ static int ds3231_clk_sqw_prepare(struct clk_hw *hw)
 	return ds1337_write_control(ds1307, DS1337_BIT_INTCN, 0);
 }
 
+static void ds1308_clk_sqw_unprepare(struct clk_hw *hw)
+{
+	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+
+	ds1308_write_control(ds1307, DS1307_BIT_SQWE, 0);
+}
+
 static void ds3231_clk_sqw_unprepare(struct clk_hw *hw)
 {
 	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
@@ -1146,6 +1237,18 @@ static void ds3231_clk_sqw_unprepare(struct clk_hw *hw)
 	ds1337_write_control(ds1307, DS1337_BIT_INTCN, DS1337_BIT_INTCN);
 }
 
+static int ds1308_clk_sqw_is_prepared(struct clk_hw *hw)
+{
+	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
+	int control, ret;
+
+	ret = regmap_read(ds1307->regmap, DS1307_REG_CONTROL, &control);
+	if (ret)
+		return ret;
+
+	return control & DS1307_BIT_SQWE;
+}
+
 static int ds3231_clk_sqw_is_prepared(struct clk_hw *hw)
 {
 	struct ds1307 *ds1307 = clk_sqw_to_ds1307(hw);
@@ -1158,6 +1261,15 @@ static int ds3231_clk_sqw_is_prepared(struct clk_hw *hw)
 	return !(control & DS1337_BIT_INTCN);
 }
 
+static const struct clk_ops ds1308_clk_sqw_ops = {
+	.prepare = ds1308_clk_sqw_prepare,
+	.unprepare = ds1308_clk_sqw_unprepare,
+	.is_prepared = ds1308_clk_sqw_is_prepared,
+	.recalc_rate = ds1308_clk_sqw_recalc_rate,
+	.round_rate = ds1308_clk_sqw_round_rate,
+	.set_rate = ds1308_clk_sqw_set_rate,
+};
+
 static const struct clk_ops ds3231_clk_sqw_ops = {
 	.prepare = ds3231_clk_sqw_prepare,
 	.unprepare = ds3231_clk_sqw_unprepare,
@@ -1220,6 +1332,13 @@ static const struct clk_ops ds3231_clk_32khz_ops = {
 	.recalc_rate = ds3231_clk_32khz_recalc_rate,
 };
 
+static struct clk_init_data ds1308_clks_init[] = {
+	{
+		.name = "ds1308_clk_sqw",
+		.ops = &ds1308_clk_sqw_ops,
+	},
+};
+
 static struct clk_init_data ds3231_clks_init[] = {
 	[DS3231_CLK_SQW] = {
 		.name = "ds3231_clk_sqw",
@@ -1231,6 +1350,44 @@ static struct clk_init_data ds3231_clks_init[] = {
 	},
 };
 
+static int ds1308_clks_register(struct ds1307 *ds1307)
+{
+	struct device_node *node = ds1307->dev->of_node;
+	struct clk_onecell_data	*onecell;
+	int i;
+
+	onecell = devm_kzalloc(ds1307->dev, sizeof(*onecell), GFP_KERNEL);
+	if (!onecell)
+		return -ENOMEM;
+
+	onecell->clk_num = ARRAY_SIZE(ds1308_clks_init);
+	onecell->clks = devm_kcalloc(ds1307->dev, onecell->clk_num,
+				     sizeof(onecell->clks[0]), GFP_KERNEL);
+	if (!onecell->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(ds1308_clks_init); i++) {
+		struct clk_init_data init = ds1308_clks_init[i];
+
+		/* optional override of the clockname */
+		of_property_read_string_index(node, "clock-output-names", i,
+						&init.name);
+		ds1307->clks[i].init = &init;
+
+		onecell->clks[i] = devm_clk_register(ds1307->dev,
+						     &ds1307->clks[i]);
+		if (IS_ERR(onecell->clks[i]))
+			return PTR_ERR(onecell->clks[i]);
+	}
+
+	if (!node)
+		return 0;
+
+	of_clk_add_provider(node, of_clk_src_onecell_get, onecell);
+
+	return 0;
+}
+
 static int ds3231_clks_register(struct ds1307 *ds1307)
 {
 	struct device_node *node = ds1307->dev->of_node;
@@ -1280,10 +1437,16 @@ static void ds1307_clks_register(struct ds1307 *ds1307)
 {
 	int ret;
 
-	if (ds1307->type != ds_3231)
+	switch (ds1307->type) {
+	case ds_1308:
+		ret = ds1308_clks_register(ds1307);
+	case ds_3231:
+		ret = ds3231_clks_register(ds1307);
+		break;
+	default:
 		return;
+	}
 
-	ret = ds3231_clks_register(ds1307);
 	if (ret) {
 		dev_warn(ds1307->dev, "unable to register clock device %d\n",
 			 ret);
@@ -1545,6 +1708,11 @@ static int ds1307_probe(struct i2c_client *client,
 		}
 		break;
 	case ds_1308:
+		/* disable sqw when driven from battery backup */
+		if (ds1307->regs[DS1307_REG_CONTROL] & DS1308_BIT_BBCLK)
+			i2c_smbus_write_byte_data(client, DS1307_REG_CONTROL,
+					ds1307->regs[DS1307_REG_CONTROL]
+					& ~DS1308_BIT_BBCLK);
 	case ds_1338:
 		/* clock halted?  turn it on, so clock can tick. */
 		if (tmp & DS1307_BIT_CH)
-- 
2.13.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
