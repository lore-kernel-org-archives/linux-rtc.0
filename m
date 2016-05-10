Return-Path: <rtc-linux+bncBAABB257Y64QKGQEOZ3NYJA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.x-arc.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id t18si769062wmt.0.2016.05.10.06.19.39
        for <rtc-linux@googlegroups.com>;
        Tue, 10 May 2016 06:19:39 -0700 (PDT)
From: Wadim Egorov <w.egorov@phytec.de>
To: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
Subject: [rtc-linux] [PATCH v5 3/6] regulator: rk808: Add regulator driver for RK818
Date: Tue, 10 May 2016 15:18:57 +0200
Message-Id: <1462886340-7893-4-git-send-email-w.egorov@phytec.de>
In-Reply-To: <1462886340-7893-1-git-send-email-w.egorov@phytec.de>
References: <1462886340-7893-1-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add support for the rk818 regulator. The regulator module consists
of 4 DCDCs, 9 LDOs, 1 switch and 1 BOOST converter which is used to
power OTG and HDMI5V.

The output voltages are configurable and are meant to supply power
to the main processor and other components.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/regulator/Kconfig           |   4 +-
 drivers/regulator/rk808-regulator.c | 143 ++++++++++++++++++++++++++++++++++--
 2 files changed, 138 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 8e665e2..234131a 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -617,11 +617,11 @@ config REGULATOR_RC5T583
 	  outputs which can be controlled by i2c communication.
 
 config REGULATOR_RK808
-	tristate "Rockchip RK808 Power regulators"
+	tristate "Rockchip RK808/RK818 Power regulators"
 	depends on MFD_RK808
 	help
 	  Select this option to enable the power regulator of ROCKCHIP
-	  PMIC RK808.
+	  PMIC RK808 and RK818.
 	  This driver supports the control of different power rails of device
 	  through regulator interface. The device supports multiple DCDC/LDO
 	  outputs which can be controlled by i2c communication.
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 40d07ba..5f412a5 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1,11 +1,15 @@
 /*
- * Regulator driver for Rockchip RK808
+ * Regulator driver for Rockchip RK808/RK818
  *
  * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
  *
  * Author: Chris Zhong <zyw@rock-chips.com>
  * Author: Zhang Qing <zhangqing@rock-chips.com>
  *
+ * Copyright (C) 2016 PHYTEC Messtechnik GmbH
+ *
+ * Author: Wadim Egorov <w.egorov@phytec.de>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
@@ -32,6 +36,12 @@
 #define RK808_BUCK4_VSEL_MASK	0xf
 #define RK808_LDO_VSEL_MASK	0x1f
 
+#define RK818_BUCK_VSEL_MASK		0x3f
+#define RK818_BUCK4_VSEL_MASK		0x1f
+#define RK818_LDO_VSEL_MASK		0x1f
+#define RK818_LDO3_ON_VSEL_MASK		0xf
+#define RK818_BOOST_ON_VSEL_MASK	0xe0
+
 /* Ramp rate definitions for buck1 / buck2 only */
 #define RK808_RAMP_RATE_OFFSET		3
 #define RK808_RAMP_RATE_MASK		(3 << RK808_RAMP_RATE_OFFSET)
@@ -454,6 +464,108 @@ static const struct regulator_desc rk808_reg[] = {
 		RK808_DCDC_EN_REG, BIT(6)),
 };
 
+static const struct regulator_desc rk818_reg[] = {
+	{
+		.name = "DCDC_REG1",
+		.supply_name = "vcc1",
+		.of_match = of_match_ptr("DCDC_REG1"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK818_ID_DCDC1,
+		.ops = &rk808_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = 712500,
+		.uV_step = 12500,
+		.n_voltages = 64,
+		.vsel_reg = RK818_BUCK1_ON_VSEL_REG,
+		.vsel_mask = RK818_BUCK_VSEL_MASK,
+		.enable_reg = RK818_DCDC_EN_REG,
+		.enable_mask = BIT(0),
+		.owner = THIS_MODULE,
+	}, {
+		.name = "DCDC_REG2",
+		.supply_name = "vcc2",
+		.of_match = of_match_ptr("DCDC_REG2"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK818_ID_DCDC2,
+		.ops = &rk808_reg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.min_uV = 712500,
+		.uV_step = 12500,
+		.n_voltages = 64,
+		.vsel_reg = RK818_BUCK2_ON_VSEL_REG,
+		.vsel_mask = RK818_BUCK_VSEL_MASK,
+		.enable_reg = RK818_DCDC_EN_REG,
+		.enable_mask = BIT(1),
+		.owner = THIS_MODULE,
+	}, {
+		.name = "DCDC_REG3",
+		.supply_name = "vcc3",
+		.of_match = of_match_ptr("DCDC_REG3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK818_ID_DCDC3,
+		.ops = &rk808_switch_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 1,
+		.enable_reg = RK818_DCDC_EN_REG,
+		.enable_mask = BIT(2),
+		.owner = THIS_MODULE,
+	},
+	RK8XX_DESC(RK818_ID_DCDC4, "DCDC_REG4", "vcc4", 1800, 3600, 100,
+		RK818_BUCK4_ON_VSEL_REG, RK818_BUCK4_VSEL_MASK,
+		RK818_DCDC_EN_REG, BIT(3), 0),
+	RK8XX_DESC(RK818_ID_BOOST, "DCDC_BOOST", "boost", 4700, 5400, 100,
+		RK818_BOOST_LDO9_ON_VSEL_REG, RK818_BOOST_ON_VSEL_MASK,
+		RK818_DCDC_EN_REG, BIT(4), 0),
+	RK8XX_DESC(RK818_ID_LDO1, "LDO_REG1", "vcc6", 1800, 3400, 100,
+		RK818_LDO1_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(0), 400),
+	RK8XX_DESC(RK818_ID_LDO2, "LDO_REG2", "vcc6", 1800, 3400, 100,
+		RK818_LDO1_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(1), 400),
+	{
+		.name = "LDO_REG3",
+		.supply_name = "vcc7",
+		.of_match = of_match_ptr("LDO_REG3"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = RK818_ID_LDO3,
+		.ops = &rk808_reg_ops_ranges,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 16,
+		.linear_ranges = rk808_ldo3_voltage_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rk808_ldo3_voltage_ranges),
+		.vsel_reg = RK818_LDO3_ON_VSEL_REG,
+		.vsel_mask = RK818_LDO3_ON_VSEL_MASK,
+		.enable_reg = RK818_LDO_EN_REG,
+		.enable_mask = BIT(2),
+		.enable_time = 400,
+		.owner = THIS_MODULE,
+	},
+	RK8XX_DESC(RK818_ID_LDO4, "LDO_REG4", "vcc8", 1800, 3400, 100,
+		RK818_LDO4_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(3), 400),
+	RK8XX_DESC(RK818_ID_LDO5, "LDO_REG5", "vcc7", 1800, 3400, 100,
+		RK818_LDO5_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(4), 400),
+	RK8XX_DESC(RK818_ID_LDO6, "LDO_REG6", "vcc8", 800, 2500, 100,
+		RK818_LDO6_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(5), 400),
+	RK8XX_DESC(RK818_ID_LDO7, "LDO_REG7", "vcc7", 800, 2500, 100,
+		RK818_LDO7_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(6), 400),
+	RK8XX_DESC(RK818_ID_LDO8, "LDO_REG8", "vcc8", 1800, 3400, 100,
+		RK818_LDO8_ON_VSEL_REG, RK818_LDO_VSEL_MASK, RK818_LDO_EN_REG,
+		BIT(7), 400),
+	RK8XX_DESC(RK818_ID_LDO9, "LDO_REG9", "vcc9", 1800, 3400, 100,
+		RK818_BOOST_LDO9_ON_VSEL_REG, RK818_LDO_VSEL_MASK,
+		RK818_DCDC_EN_REG, BIT(5), 400),
+	RK8XX_DESC_SWITCH(RK818_ID_SWITCH, "SWITCH_REG", "vcc9",
+		RK818_DCDC_EN_REG, BIT(6)),
+	RK8XX_DESC_SWITCH(RK818_ID_HDMI_SWITCH, "HDMI_SWITCH", "h_5v",
+		RK818_H5V_EN_REG, BIT(0)),
+	RK8XX_DESC_SWITCH(RK818_ID_OTG_SWITCH, "OTG_SWITCH", "usb",
+		RK818_DCDC_EN_REG, BIT(7)),
+};
+
 static int rk808_regulator_dt_parse_pdata(struct device *dev,
 				   struct device *client_dev,
 				   struct regmap *map,
@@ -499,7 +611,8 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	struct regulator_config config = {};
 	struct regulator_dev *rk808_rdev;
 	struct rk808_regulator_data *pdata;
-	int ret, i;
+	const struct regulator_desc *regulators;
+	int ret, i, nregulators;
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -512,14 +625,29 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pdata);
 
+	switch (rk808->variant) {
+	case RK808_ID:
+		regulators = rk808_reg;
+		nregulators = RK808_NUM_REGULATORS;
+		break;
+	case RK818_ID:
+		regulators = rk818_reg;
+		nregulators = RK818_NUM_REGULATORS;
+		break;
+	default:
+		dev_err(&client->dev, "unsupported RK8XX ID %lu\n",
+			rk808->variant);
+		return -EINVAL;
+	}
+
 	config.dev = &client->dev;
 	config.driver_data = pdata;
 	config.regmap = rk808->regmap;
 
 	/* Instantiate the regulators */
-	for (i = 0; i < RK808_NUM_REGULATORS; i++) {
+	for (i = 0; i < nregulators; i++) {
 		rk808_rdev = devm_regulator_register(&pdev->dev,
-						     &rk808_reg[i], &config);
+						     &regulators[i], &config);
 		if (IS_ERR(rk808_rdev)) {
 			dev_err(&client->dev,
 				"failed to register %d regulator\n", i);
@@ -540,8 +668,9 @@ static struct platform_driver rk808_regulator_driver = {
 
 module_platform_driver(rk808_regulator_driver);
 
-MODULE_DESCRIPTION("regulator driver for the rk808 series PMICs");
-MODULE_AUTHOR("Chris Zhong<zyw@rock-chips.com>");
-MODULE_AUTHOR("Zhang Qing<zhangqing@rock-chips.com>");
+MODULE_DESCRIPTION("regulator driver for the RK808/RK818 series PMICs");
+MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
+MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
+MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:rk808-regulator");
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
