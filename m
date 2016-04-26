Return-Path: <rtc-linux+bncBAABBQUE724AKGQENEK7PMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.phycore.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id c69si187266wme.2.2016.04.26.07.59.13
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Apr 2016 07:59:13 -0700 (PDT)
From: Wadim Egorov <w.egorov@phytec.de>
To: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, lee.jones@linaro.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
Subject: [rtc-linux] [PATCH v4 2/7] regulator: rk808: Migrate to regulator
 core's simplified DT parsing code
Date: Tue, 26 Apr 2016 16:54:05 +0200
Message-Id: <1461682450-22173-3-git-send-email-w.egorov@phytec.de>
In-Reply-To: <1461682450-22173-1-git-send-email-w.egorov@phytec.de>
References: <1461682450-22173-1-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

A common simplified DT parsing code for regulators was introduced in
commit a0c7b164ad11 ("regulator: of: Provide simplified DT parsing
method")

While at it also added RK8XX_DESC and RK8XX_DESC_SWITCH macros for the
regulator_desc struct initialization. This just makes the driver more compact.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/regulator/rk808-regulator.c | 250 ++++++++++++------------------------
 1 file changed, 79 insertions(+), 171 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 6601ab5..40d07ba 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -55,6 +55,42 @@
 /* max steps for increase voltage of Buck1/2, equal 100mv*/
 #define MAX_STEPS_ONE_TIME 8
 
+#define RK8XX_DESC(_id, _match, _supply, _min, _max, _step, _vreg,	\
+	_vmask, _ereg, _emask, _etime)					\
+	[_id] = {							\
+		.name		= (_match),				\
+		.supply_name	= (_supply),				\
+		.of_match	= of_match_ptr(_match),			\
+		.regulators_node = of_match_ptr("regulators"),		\
+		.type		= REGULATOR_VOLTAGE,			\
+		.id		= (_id),				\
+		.n_voltages	= (((_max) - (_min)) / (_step) + 1),	\
+		.owner		= THIS_MODULE,				\
+		.min_uV		= (_min) * 1000,			\
+		.uV_step	= (_step) * 1000,			\
+		.vsel_reg	= (_vreg),				\
+		.vsel_mask	= (_vmask),				\
+		.enable_reg	= (_ereg),				\
+		.enable_mask	= (_emask),				\
+		.enable_time	= (_etime),				\
+		.ops		= &rk808_reg_ops,			\
+	}
+
+#define RK8XX_DESC_SWITCH(_id, _match, _supply, _ereg, _emask)		\
+	[_id] = {							\
+		.name		= (_match),				\
+		.supply_name	= (_supply),				\
+		.of_match	= of_match_ptr(_match),			\
+		.regulators_node = of_match_ptr("regulators"),		\
+		.type		= REGULATOR_VOLTAGE,			\
+		.id		= (_id),				\
+		.enable_reg	= (_ereg),				\
+		.enable_mask	= (_emask),				\
+		.owner		= THIS_MODULE,				\
+		.ops		= &rk808_switch_ops			\
+	}
+
+
 struct rk808_regulator_data {
 	struct gpio_desc *dvs_gpio[2];
 };
@@ -328,6 +364,8 @@ static const struct regulator_desc rk808_reg[] = {
 	{
 		.name = "DCDC_REG1",
 		.supply_name = "vcc1",
+		.of_match = of_match_ptr("DCDC_REG1"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = RK808_ID_DCDC1,
 		.ops = &rk808_buck1_2_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -342,6 +380,8 @@ static const struct regulator_desc rk808_reg[] = {
 	}, {
 		.name = "DCDC_REG2",
 		.supply_name = "vcc2",
+		.of_match = of_match_ptr("DCDC_REG2"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = RK808_ID_DCDC2,
 		.ops = &rk808_buck1_2_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -356,6 +396,8 @@ static const struct regulator_desc rk808_reg[] = {
 	}, {
 		.name = "DCDC_REG3",
 		.supply_name = "vcc3",
+		.of_match = of_match_ptr("DCDC_REG3"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = RK808_ID_DCDC3,
 		.ops = &rk808_switch_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -363,53 +405,21 @@ static const struct regulator_desc rk808_reg[] = {
 		.enable_reg = RK808_DCDC_EN_REG,
 		.enable_mask = BIT(2),
 		.owner = THIS_MODULE,
-	}, {
-		.name = "DCDC_REG4",
-		.supply_name = "vcc4",
-		.id = RK808_ID_DCDC4,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.min_uV = 1800000,
-		.uV_step = 100000,
-		.n_voltages = 16,
-		.vsel_reg = RK808_BUCK4_ON_VSEL_REG,
-		.vsel_mask = RK808_BUCK4_VSEL_MASK,
-		.enable_reg = RK808_DCDC_EN_REG,
-		.enable_mask = BIT(3),
-		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG1",
-		.supply_name = "vcc6",
-		.id = RK808_ID_LDO1,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.min_uV = 1800000,
-		.uV_step = 100000,
-		.n_voltages = 17,
-		.vsel_reg = RK808_LDO1_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(0),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG2",
-		.supply_name = "vcc6",
-		.id = RK808_ID_LDO2,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.min_uV = 1800000,
-		.uV_step = 100000,
-		.n_voltages = 17,
-		.vsel_reg = RK808_LDO2_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(1),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
+	},
+	RK8XX_DESC(RK808_ID_DCDC4, "DCDC_REG4", "vcc4", 1800, 3300, 100,
+		RK808_BUCK4_ON_VSEL_REG, RK808_BUCK4_VSEL_MASK,
+		RK808_DCDC_EN_REG, BIT(3), 0),
+	RK8XX_DESC(RK808_ID_LDO1, "LDO_REG1", "vcc6", 1800, 3400, 100,
+		RK808_LDO1_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(0), 400),
+	RK8XX_DESC(RK808_ID_LDO2, "LDO_REG2", "vcc6", 1800, 3400, 100,
+		RK808_LDO2_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(1), 400),
+	{
 		.name = "LDO_REG3",
 		.supply_name = "vcc7",
+		.of_match = of_match_ptr("LDO_REG3"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = RK808_ID_LDO3,
 		.ops = &rk808_reg_ops_ranges,
 		.type = REGULATOR_VOLTAGE,
@@ -422,117 +432,26 @@ static const struct regulator_desc rk808_reg[] = {
 		.enable_mask = BIT(2),
 		.enable_time = 400,
 		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG4",
-		.supply_name = "vcc9",
-		.id = RK808_ID_LDO4,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.min_uV = 1800000,
-		.uV_step = 100000,
-		.n_voltages = 17,
-		.vsel_reg = RK808_LDO4_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(3),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG5",
-		.supply_name = "vcc9",
-		.id = RK808_ID_LDO5,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.min_uV = 1800000,
-		.uV_step = 100000,
-		.n_voltages = 17,
-		.vsel_reg = RK808_LDO5_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(4),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG6",
-		.supply_name = "vcc10",
-		.id = RK808_ID_LDO6,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.min_uV = 800000,
-		.uV_step = 100000,
-		.n_voltages = 18,
-		.vsel_reg = RK808_LDO6_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(5),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG7",
-		.supply_name = "vcc7",
-		.id = RK808_ID_LDO7,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.min_uV = 800000,
-		.uV_step = 100000,
-		.n_voltages = 18,
-		.vsel_reg = RK808_LDO7_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(6),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
-		.name = "LDO_REG8",
-		.supply_name = "vcc11",
-		.id = RK808_ID_LDO8,
-		.ops = &rk808_reg_ops,
-		.type = REGULATOR_VOLTAGE,
-		.min_uV = 1800000,
-		.uV_step = 100000,
-		.n_voltages = 17,
-		.vsel_reg = RK808_LDO8_ON_VSEL_REG,
-		.vsel_mask = RK808_LDO_VSEL_MASK,
-		.enable_reg = RK808_LDO_EN_REG,
-		.enable_mask = BIT(7),
-		.enable_time = 400,
-		.owner = THIS_MODULE,
-	}, {
-		.name = "SWITCH_REG1",
-		.supply_name = "vcc8",
-		.id = RK808_ID_SWITCH1,
-		.ops = &rk808_switch_ops,
-		.type = REGULATOR_VOLTAGE,
-		.enable_reg = RK808_DCDC_EN_REG,
-		.enable_mask = BIT(5),
-		.owner = THIS_MODULE,
-	}, {
-		.name = "SWITCH_REG2",
-		.supply_name = "vcc12",
-		.id = RK808_ID_SWITCH2,
-		.ops = &rk808_switch_ops,
-		.type = REGULATOR_VOLTAGE,
-		.enable_reg = RK808_DCDC_EN_REG,
-		.enable_mask = BIT(6),
-		.owner = THIS_MODULE,
 	},
-};
-
-static struct of_regulator_match rk808_reg_matches[] = {
-	[RK808_ID_DCDC1]	= { .name = "DCDC_REG1" },
-	[RK808_ID_DCDC2]	= { .name = "DCDC_REG2" },
-	[RK808_ID_DCDC3]	= { .name = "DCDC_REG3" },
-	[RK808_ID_DCDC4]	= { .name = "DCDC_REG4" },
-	[RK808_ID_LDO1]		= { .name = "LDO_REG1" },
-	[RK808_ID_LDO2]		= { .name = "LDO_REG2" },
-	[RK808_ID_LDO3]		= { .name = "LDO_REG3" },
-	[RK808_ID_LDO4]		= { .name = "LDO_REG4" },
-	[RK808_ID_LDO5]		= { .name = "LDO_REG5" },
-	[RK808_ID_LDO6]		= { .name = "LDO_REG6" },
-	[RK808_ID_LDO7]		= { .name = "LDO_REG7" },
-	[RK808_ID_LDO8]		= { .name = "LDO_REG8" },
-	[RK808_ID_SWITCH1]	= { .name = "SWITCH_REG1" },
-	[RK808_ID_SWITCH2]	= { .name = "SWITCH_REG2" },
+	RK8XX_DESC(RK808_ID_LDO4, "LDO_REG4", "vcc9", 1800, 3400, 100,
+		RK808_LDO4_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(3), 400),
+	RK8XX_DESC(RK808_ID_LDO5, "LDO_REG5", "vcc9", 1800, 3400, 100,
+		RK808_LDO5_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(4), 400),
+	RK8XX_DESC(RK808_ID_LDO6, "LDO_REG6", "vcc10", 800, 2500, 100,
+		RK808_LDO6_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(5), 400),
+	RK8XX_DESC(RK808_ID_LDO7, "LDO_REG7", "vcc7", 800, 2500, 100,
+		RK808_LDO7_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(6), 400),
+	RK8XX_DESC(RK808_ID_LDO8, "LDO_REG8", "vcc11", 1800, 3400, 100,
+		RK808_LDO8_ON_VSEL_REG, RK808_LDO_VSEL_MASK, RK808_LDO_EN_REG,
+		BIT(7), 400),
+	RK8XX_DESC_SWITCH(RK808_ID_SWITCH1, "SWITCH_REG1", "vcc8",
+		RK808_DCDC_EN_REG, BIT(5)),
+	RK8XX_DESC_SWITCH(RK808_ID_SWITCH2, "SWITCH_REG2", "vcc12",
+		RK808_DCDC_EN_REG, BIT(6)),
 };
 
 static int rk808_regulator_dt_parse_pdata(struct device *dev,
@@ -541,17 +460,12 @@ static int rk808_regulator_dt_parse_pdata(struct device *dev,
 				   struct rk808_regulator_data *pdata)
 {
 	struct device_node *np;
-	int tmp, ret, i;
+	int tmp, ret = 0, i;
 
 	np = of_get_child_by_name(client_dev->of_node, "regulators");
 	if (!np)
 		return -ENXIO;
 
-	ret = of_regulator_match(dev, np, rk808_reg_matches,
-				 RK808_NUM_REGULATORS);
-	if (ret < 0)
-		goto dt_parse_end;
-
 	for (i = 0; i < ARRAY_SIZE(pdata->dvs_gpio); i++) {
 		pdata->dvs_gpio[i] =
 			devm_gpiod_get_index_optional(client_dev, "dvs", i,
@@ -598,18 +512,12 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pdata);
 
+	config.dev = &client->dev;
+	config.driver_data = pdata;
+	config.regmap = rk808->regmap;
+
 	/* Instantiate the regulators */
 	for (i = 0; i < RK808_NUM_REGULATORS; i++) {
-		if (!rk808_reg_matches[i].init_data ||
-		    !rk808_reg_matches[i].of_node)
-			continue;
-
-		config.dev = &client->dev;
-		config.driver_data = pdata;
-		config.regmap = rk808->regmap;
-		config.of_node = rk808_reg_matches[i].of_node;
-		config.init_data = rk808_reg_matches[i].init_data;
-
 		rk808_rdev = devm_regulator_register(&pdev->dev,
 						     &rk808_reg[i], &config);
 		if (IS_ERR(rk808_rdev)) {
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
