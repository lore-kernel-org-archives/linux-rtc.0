Return-Path: <rtc-linux+bncBAABBQUE724AKGQENEK7PMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.phycore.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id e64si546954wmi.3.2016.04.26.07.59.13
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Apr 2016 07:59:13 -0700 (PDT)
From: Wadim Egorov <w.egorov@phytec.de>
To: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, lee.jones@linaro.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
Subject: [rtc-linux] [PATCH v4 1/7] regulator: rk808: Add rk808_reg_ops_ranges
 for LDO3
Date: Tue, 26 Apr 2016 16:54:04 +0200
Message-Id: <1461682450-22173-2-git-send-email-w.egorov@phytec.de>
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

LDO_REG3 descriptor is using linear_ranges.
Add and use proper ops for LDO_REG3.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/regulator/rk808-regulator.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 67f72fe..6601ab5 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -238,6 +238,21 @@ static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
 				  sel);
 }
 
+static int rk808_set_suspend_voltage_range(struct regulator_dev *rdev, int uv)
+{
+	unsigned int reg;
+	int sel = regulator_map_voltage_linear_range(rdev, uv, uv);
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
 static int rk808_set_suspend_enable(struct regulator_dev *rdev)
 {
 	unsigned int reg;
@@ -288,6 +303,19 @@ static struct regulator_ops rk808_reg_ops = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
+static struct regulator_ops rk808_reg_ops_ranges = {
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.set_suspend_voltage	= rk808_set_suspend_voltage_range,
+	.set_suspend_enable	= rk808_set_suspend_enable,
+	.set_suspend_disable	= rk808_set_suspend_disable,
+};
+
 static struct regulator_ops rk808_switch_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -383,7 +411,7 @@ static const struct regulator_desc rk808_reg[] = {
 		.name = "LDO_REG3",
 		.supply_name = "vcc7",
 		.id = RK808_ID_LDO3,
-		.ops = &rk808_reg_ops,
+		.ops = &rk808_reg_ops_ranges,
 		.type = REGULATOR_VOLTAGE,
 		.n_voltages = 16,
 		.linear_ranges = rk808_ldo3_voltage_ranges,
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
