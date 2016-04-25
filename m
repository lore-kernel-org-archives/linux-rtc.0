Return-Path: <rtc-linux+bncBDQ2L75W5QGBB4FU7G4AKGQEFYFERPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id ph3si2712483pac.1.2016.04.25.10.57.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 10:57:03 -0700 (PDT)
From: Mark Brown <broonie@kernel.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
In-Reply-To: <1461590448-47685-4-git-send-email-w.egorov@phytec.de>
Message-Id: <E1aukkg-0007km-6s@debutante>
Date: Mon, 25 Apr 2016 18:56:54 +0100
Subject: [rtc-linux] Applied "regulator: rk808: remove linear range
 definitions with a single range" to the regulator tree
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The patch

   regulator: rk808: remove linear range definitions with a single range

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From afcd666d9db0ebfbf2751cce1e07b548547ca82e Mon Sep 17 00:00:00 2001
From: Wadim Egorov <w.egorov@phytec.de>
Date: Mon, 25 Apr 2016 15:20:43 +0200
Subject: [PATCH] regulator: rk808: remove linear range definitions with a
 single range

The driver was using only linear ranges. Now we remove linear range
definitions with a single range. So we have to add an ops struct for
ranges and adjust all other ops functions accordingly.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 90 +++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index d86a3dcd61e2..964b95eed271 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -66,27 +66,11 @@ static const int rk808_buck_config_regs[] = {
 	RK808_BUCK4_CONFIG_REG,
 };
 
-static const struct regulator_linear_range rk808_buck_voltage_ranges[] = {
-	REGULATOR_LINEAR_RANGE(712500, 0, 63, 12500),
-};
-
-static const struct regulator_linear_range rk808_buck4_voltage_ranges[] = {
-	REGULATOR_LINEAR_RANGE(1800000, 0, 15, 100000),
-};
-
-static const struct regulator_linear_range rk808_ldo_voltage_ranges[] = {
-	REGULATOR_LINEAR_RANGE(1800000, 0, 16, 100000),
-};
-
 static const struct regulator_linear_range rk808_ldo3_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0, 13, 100000),
 	REGULATOR_LINEAR_RANGE(2500000, 15, 15, 0),
 };
 
-static const struct regulator_linear_range rk808_ldo6_voltage_ranges[] = {
-	REGULATOR_LINEAR_RANGE(800000, 0, 17, 100000),
-};
-
 static int rk808_buck1_2_get_voltage_sel_regmap(struct regulator_dev *rdev)
 {
 	struct rk808_regulator_data *pdata = rdev_get_drvdata(rdev);
@@ -242,6 +226,21 @@ static int rk808_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
 {
 	unsigned int reg;
+	int sel = regulator_map_voltage_linear(rdev, uv, uv);
+
+	if (sel < 0)
+		return -EINVAL;
+
+	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
+
+	return regmap_update_bits(rdev->regmap, reg,
+				  rdev->desc->vsel_mask,
+				  sel);
+}
+
+static int rk808_set_suspend_voltage_range(struct regulator_dev *rdev, int uv)
+{
+	unsigned int reg;
 	int sel = regulator_map_voltage_linear_range(rdev, uv, uv);
 
 	if (sel < 0)
@@ -277,8 +276,8 @@ static int rk808_set_suspend_disable(struct regulator_dev *rdev)
 }
 
 static struct regulator_ops rk808_buck1_2_ops = {
-	.list_voltage		= regulator_list_voltage_linear_range,
-	.map_voltage		= regulator_map_voltage_linear_range,
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= rk808_buck1_2_get_voltage_sel_regmap,
 	.set_voltage_sel	= rk808_buck1_2_set_voltage_sel,
 	.set_voltage_time_sel	= rk808_buck1_2_set_voltage_time_sel,
@@ -292,6 +291,19 @@ static struct regulator_ops rk808_buck1_2_ops = {
 };
 
 static struct regulator_ops rk808_reg_ops = {
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.set_suspend_voltage	= rk808_set_suspend_voltage,
+	.set_suspend_enable	= rk808_set_suspend_enable,
+	.set_suspend_disable	= rk808_set_suspend_disable,
+};
+
+static struct regulator_ops rk808_reg_ops_ranges = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -299,7 +311,7 @@ static struct regulator_ops rk808_reg_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
-	.set_suspend_voltage	= rk808_set_suspend_voltage,
+	.set_suspend_voltage	= rk808_set_suspend_voltage_range,
 	.set_suspend_enable	= rk808_set_suspend_enable,
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
@@ -319,9 +331,9 @@ static const struct regulator_desc rk808_reg[] = {
 		.id = RK808_ID_DCDC1,
 		.ops = &rk808_buck1_2_ops,
 		.type = REGULATOR_VOLTAGE,
+		.min_uV = 712500,
+		.uV_step = 12500,
 		.n_voltages = 64,
-		.linear_ranges = rk808_buck_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_buck_voltage_ranges),
 		.vsel_reg = RK808_BUCK1_ON_VSEL_REG,
 		.vsel_mask = RK808_BUCK_VSEL_MASK,
 		.enable_reg = RK808_DCDC_EN_REG,
@@ -333,9 +345,9 @@ static const struct regulator_desc rk808_reg[] = {
 		.id = RK808_ID_DCDC2,
 		.ops = &rk808_buck1_2_ops,
 		.type = REGULATOR_VOLTAGE,
+		.min_uV = 712500,
+		.uV_step = 12500,
 		.n_voltages = 64,
-		.linear_ranges = rk808_buck_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_buck_voltage_ranges),
 		.vsel_reg = RK808_BUCK2_ON_VSEL_REG,
 		.vsel_mask = RK808_BUCK_VSEL_MASK,
 		.enable_reg = RK808_DCDC_EN_REG,
@@ -357,9 +369,9 @@ static const struct regulator_desc rk808_reg[] = {
 		.id = RK808_ID_DCDC4,
 		.ops = &rk808_reg_ops,
 		.type = REGULATOR_VOLTAGE,
+		.min_uV = 1800000,
+		.uV_step = 100000,
 		.n_voltages = 16,
-		.linear_ranges = rk808_buck4_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_buck4_voltage_ranges),
 		.vsel_reg = RK808_BUCK4_ON_VSEL_REG,
 		.vsel_mask = RK808_BUCK4_VSEL_MASK,
 		.enable_reg = RK808_DCDC_EN_REG,
@@ -371,9 +383,9 @@ static const struct regulator_desc rk808_reg[] = {
 		.id = RK808_ID_LDO1,
 		.ops = &rk808_reg_ops,
 		.type = REGULATOR_VOLTAGE,
+		.min_uV = 1800000,
+		.uV_step = 100000,
 		.n_voltages = 17,
-		.linear_ranges = rk808_ldo_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo_voltage_ranges),
 		.vsel_reg = RK808_LDO1_ON_VSEL_REG,
 		.vsel_mask = RK808_LDO_VSEL_MASK,
 		.enable_reg = RK808_LDO_EN_REG,
@@ -386,9 +398,9 @@ static const struct regulator_desc rk808_reg[] = {
 		.id = RK808_ID_LDO2,
 		.ops = &rk808_reg_ops,
 		.type = REGULATOR_VOLTAGE,
+		.min_uV = 1800000,
+		.uV_step = 100000,
 		.n_voltages = 17,
-		.linear_ranges = rk808_ldo_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo_voltage_ranges),
 		.vsel_reg = RK808_LDO2_ON_VSEL_REG,
 		.vsel_mask = RK808_LDO_VSEL_MASK,
 		.enable_reg = RK808_LDO_EN_REG,
@@ -416,9 +428,9 @@ static const struct regulator_desc rk808_reg[] = {
 		.id = RK808_ID_LDO4,
 		.ops = &rk808_reg_ops,
 		.type = REGULATOR_VOLTAGE,
+		.min_uV = 1800000,
+		.uV_step = 100000,
 		.n_voltages = 17,
-		.linear_ranges = rk808_ldo_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo_voltage_ranges),
 		.vsel_reg = RK808_LDO4_ON_VSEL_REG,
 		.vsel_mask = RK808_LDO_VSEL_MASK,
 		.enable_reg = RK808_LDO_EN_REG,
@@ -431,9 +443,9 @@ static const struct regulator_desc rk808_reg[] = {
 		.id = RK808_ID_LDO5,
 		.ops = &rk808_reg_ops,
 		.type = REGULATOR_VOLTAGE,
+		.min_uV = 1800000,
+		.uV_step = 100000,
 		.n_voltages = 17,
-		.linear_ranges = rk808_ldo_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo_voltage_ranges),
 		.vsel_reg = RK808_LDO5_ON_VSEL_REG,
 		.vsel_mask = RK808_LDO_VSEL_MASK,
 		.enable_reg = RK808_LDO_EN_REG,
@@ -446,9 +458,9 @@ static const struct regulator_desc rk808_reg[] = {
 		.id = RK808_ID_LDO6,
 		.ops = &rk808_reg_ops,
 		.type = REGULATOR_VOLTAGE,
+		.min_uV = 800000,
+		.uV_step = 100000,
 		.n_voltages = 18,
-		.linear_ranges = rk808_ldo6_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo6_voltage_ranges),
 		.vsel_reg = RK808_LDO6_ON_VSEL_REG,
 		.vsel_mask = RK808_LDO_VSEL_MASK,
 		.enable_reg = RK808_LDO_EN_REG,
@@ -461,9 +473,9 @@ static const struct regulator_desc rk808_reg[] = {
 		.id = RK808_ID_LDO7,
 		.ops = &rk808_reg_ops,
 		.type = REGULATOR_VOLTAGE,
+		.min_uV = 800000,
+		.uV_step = 100000,
 		.n_voltages = 18,
-		.linear_ranges = rk808_ldo6_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo6_voltage_ranges),
 		.vsel_reg = RK808_LDO7_ON_VSEL_REG,
 		.vsel_mask = RK808_LDO_VSEL_MASK,
 		.enable_reg = RK808_LDO_EN_REG,
@@ -476,9 +488,9 @@ static const struct regulator_desc rk808_reg[] = {
 		.id = RK808_ID_LDO8,
 		.ops = &rk808_reg_ops,
 		.type = REGULATOR_VOLTAGE,
+		.min_uV = 1800000,
+		.uV_step = 100000,
 		.n_voltages = 17,
-		.linear_ranges = rk808_ldo_voltage_ranges,
-		.n_linear_ranges = ARRAY_SIZE(rk808_ldo_voltage_ranges),
 		.vsel_reg = RK808_LDO8_ON_VSEL_REG,
 		.vsel_mask = RK808_LDO_VSEL_MASK,
 		.enable_reg = RK808_LDO_EN_REG,
-- 
2.8.0.rc3

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
