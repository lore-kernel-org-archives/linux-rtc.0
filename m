Return-Path: <rtc-linux+bncBD747RFBYUPBB3M2ZSYQKGQEAGDVJXA@googlegroups.com>
MIME-Version: 1.0
Received: from mailout3.samsung.com (mailout3.samsung.com. [203.254.224.33])
        by gmr-mx.google.com with ESMTPS id sm2si547564pab.0.2015.10.29.23.25.49
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 29 Oct 2015 23:25:49 -0700 (PDT)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NX001UBFSJ0RE90@mailout3.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 30 Oct 2015 15:25:48 +0900 (KST)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: lee.jones@linaro.org, broonie@kernel.org
Cc: k.kozlowski@samsung.com, linux-samsung-soc@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 Thomas Abraham <thomas.ab@samsung.com>
Subject: [rtc-linux] [PATCH v5 3/4] regulator: s2mps11: add support for
 S2MPS15 regulators
Date: Fri, 30 Oct 2015 11:55:33 +0530
Message-id: <1446186334-16510-4-git-send-email-alim.akhtar@samsung.com>
In-reply-to: <1446186334-16510-1-git-send-email-alim.akhtar@samsung.com>
References: <1446186334-16510-1-git-send-email-alim.akhtar@samsung.com>
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

From: Thomas Abraham <thomas.ab@samsung.com>

The S2MPS15 PMIC is similar in functionality to S2MPS11/14 PMIC. It contains
27 LDO and 10 Buck regulators and allows programming these regulators via a
I2C interface. This patch adds initial support for LDO/Buck regulators of
S2MPS15 PMIC.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/Kconfig   |    4 +-
 drivers/regulator/s2mps11.c |  135 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 64bccff557be..3e3ee5b88b3f 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -588,10 +588,10 @@ config REGULATOR_S2MPA01
 	 via I2C bus. S2MPA01 has 10 Bucks and 26 LDO outputs.
 
 config REGULATOR_S2MPS11
-	tristate "Samsung S2MPS11/S2MPS13/S2MPS14/S2MPU02 voltage regulator"
+	tristate "Samsung S2MPS11/13/14/15/S2MPU02 voltage regulator"
 	depends on MFD_SEC_CORE
 	help
-	 This driver supports a Samsung S2MPS11/S2MPS13/S2MPS14/S2MPU02 voltage
+	 This driver supports a Samsung S2MPS11/13/14/15/S2MPU02 voltage
 	 output regulator via I2C bus. The chip is comprised of high efficient
 	 Buck converters including Dual-Phase Buck converter, Buck-Boost
 	 converter, various LDOs.
diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 72fc3c32db49..b2f3a28e720c 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -32,6 +32,7 @@
 #include <linux/mfd/samsung/s2mps11.h>
 #include <linux/mfd/samsung/s2mps13.h>
 #include <linux/mfd/samsung/s2mps14.h>
+#include <linux/mfd/samsung/s2mps15.h>
 #include <linux/mfd/samsung/s2mpu02.h>
 
 /* The highest number of possible regulators for supported devices. */
@@ -661,6 +662,133 @@ static const struct regulator_desc s2mps14_regulators[] = {
 				    S2MPS14_BUCK1235_START_SEL),
 };
 
+static struct regulator_ops s2mps15_reg_ldo_ops = {
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+};
+
+static struct regulator_ops s2mps15_reg_buck_ops = {
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+};
+
+#define regulator_desc_s2mps15_ldo(num, range) {	\
+	.name		= "LDO"#num,			\
+	.id		= S2MPS15_LDO##num,		\
+	.ops		= &s2mps15_reg_ldo_ops,		\
+	.type		= REGULATOR_VOLTAGE,		\
+	.owner		= THIS_MODULE,			\
+	.linear_ranges	= range,			\
+	.n_linear_ranges = ARRAY_SIZE(range),		\
+	.n_voltages	= S2MPS15_LDO_N_VOLTAGES,	\
+	.vsel_reg	= S2MPS15_REG_L1CTRL + num - 1,	\
+	.vsel_mask	= S2MPS15_LDO_VSEL_MASK,	\
+	.enable_reg	= S2MPS15_REG_L1CTRL + num - 1,	\
+	.enable_mask	= S2MPS15_ENABLE_MASK		\
+}
+
+#define regulator_desc_s2mps15_buck(num, range) {			\
+	.name		= "BUCK"#num,					\
+	.id		= S2MPS15_BUCK##num,				\
+	.ops		= &s2mps15_reg_buck_ops,			\
+	.type		= REGULATOR_VOLTAGE,				\
+	.owner		= THIS_MODULE,					\
+	.linear_ranges	= range,					\
+	.n_linear_ranges = ARRAY_SIZE(range),				\
+	.ramp_delay	= 12500,					\
+	.n_voltages	= S2MPS15_BUCK_N_VOLTAGES,			\
+	.vsel_reg	= S2MPS15_REG_B1CTRL2 + ((num - 1) * 2),	\
+	.vsel_mask	= S2MPS15_BUCK_VSEL_MASK,			\
+	.enable_reg	= S2MPS15_REG_B1CTRL1 + ((num - 1) * 2),	\
+	.enable_mask	= S2MPS15_ENABLE_MASK				\
+}
+
+/* voltage range for s2mps15 LDO 3, 5, 15, 16, 18, 20, 23 and 27 */
+static const struct regulator_linear_range s2mps15_ldo_voltage_ranges1[] = {
+	REGULATOR_LINEAR_RANGE(1000000, 0xc, 0x38, 25000),
+};
+
+/* voltage range for s2mps15 LDO 2, 6, 14, 17, 19, 21, 24 and 25 */
+static const struct regulator_linear_range s2mps15_ldo_voltage_ranges2[] = {
+	REGULATOR_LINEAR_RANGE(1800000, 0x0, 0x3f, 25000),
+};
+
+/* voltage range for s2mps15 LDO 4, 11, 12, 13, 22 and 26 */
+static const struct regulator_linear_range s2mps15_ldo_voltage_ranges3[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0x0, 0x34, 12500),
+};
+
+/* voltage range for s2mps15 LDO 7, 8, 9 and 10 */
+static const struct regulator_linear_range s2mps15_ldo_voltage_ranges4[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0xc, 0x18, 25000),
+};
+
+/* voltage range for s2mps15 LDO 1 */
+static const struct regulator_linear_range s2mps15_ldo_voltage_ranges5[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x20, 12500),
+};
+
+/* voltage range for s2mps15 BUCK 1, 2, 3, 4, 5, 6 and 7 */
+static const struct regulator_linear_range s2mps15_buck_voltage_ranges1[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x20, 0xb0, 6250),
+};
+
+/* voltage range for s2mps15 BUCK 8, 9 and 10 */
+static const struct regulator_linear_range s2mps15_buck_voltage_ranges2[] = {
+	REGULATOR_LINEAR_RANGE(1000000, 0x20, 0xc0, 12500),
+};
+
+static const struct regulator_desc s2mps15_regulators[] = {
+	regulator_desc_s2mps15_ldo(1, s2mps15_ldo_voltage_ranges5),
+	regulator_desc_s2mps15_ldo(2, s2mps15_ldo_voltage_ranges2),
+	regulator_desc_s2mps15_ldo(3, s2mps15_ldo_voltage_ranges1),
+	regulator_desc_s2mps15_ldo(4, s2mps15_ldo_voltage_ranges3),
+	regulator_desc_s2mps15_ldo(5, s2mps15_ldo_voltage_ranges1),
+	regulator_desc_s2mps15_ldo(6, s2mps15_ldo_voltage_ranges2),
+	regulator_desc_s2mps15_ldo(7, s2mps15_ldo_voltage_ranges4),
+	regulator_desc_s2mps15_ldo(8, s2mps15_ldo_voltage_ranges4),
+	regulator_desc_s2mps15_ldo(9, s2mps15_ldo_voltage_ranges4),
+	regulator_desc_s2mps15_ldo(10, s2mps15_ldo_voltage_ranges4),
+	regulator_desc_s2mps15_ldo(11, s2mps15_ldo_voltage_ranges3),
+	regulator_desc_s2mps15_ldo(12, s2mps15_ldo_voltage_ranges3),
+	regulator_desc_s2mps15_ldo(13, s2mps15_ldo_voltage_ranges3),
+	regulator_desc_s2mps15_ldo(14, s2mps15_ldo_voltage_ranges2),
+	regulator_desc_s2mps15_ldo(15, s2mps15_ldo_voltage_ranges1),
+	regulator_desc_s2mps15_ldo(16, s2mps15_ldo_voltage_ranges1),
+	regulator_desc_s2mps15_ldo(17, s2mps15_ldo_voltage_ranges2),
+	regulator_desc_s2mps15_ldo(18, s2mps15_ldo_voltage_ranges1),
+	regulator_desc_s2mps15_ldo(19, s2mps15_ldo_voltage_ranges2),
+	regulator_desc_s2mps15_ldo(20, s2mps15_ldo_voltage_ranges1),
+	regulator_desc_s2mps15_ldo(21, s2mps15_ldo_voltage_ranges2),
+	regulator_desc_s2mps15_ldo(22, s2mps15_ldo_voltage_ranges3),
+	regulator_desc_s2mps15_ldo(23, s2mps15_ldo_voltage_ranges1),
+	regulator_desc_s2mps15_ldo(24, s2mps15_ldo_voltage_ranges2),
+	regulator_desc_s2mps15_ldo(25, s2mps15_ldo_voltage_ranges2),
+	regulator_desc_s2mps15_ldo(26, s2mps15_ldo_voltage_ranges3),
+	regulator_desc_s2mps15_ldo(27, s2mps15_ldo_voltage_ranges1),
+	regulator_desc_s2mps15_buck(1, s2mps15_buck_voltage_ranges1),
+	regulator_desc_s2mps15_buck(2, s2mps15_buck_voltage_ranges1),
+	regulator_desc_s2mps15_buck(3, s2mps15_buck_voltage_ranges1),
+	regulator_desc_s2mps15_buck(4, s2mps15_buck_voltage_ranges1),
+	regulator_desc_s2mps15_buck(5, s2mps15_buck_voltage_ranges1),
+	regulator_desc_s2mps15_buck(6, s2mps15_buck_voltage_ranges1),
+	regulator_desc_s2mps15_buck(7, s2mps15_buck_voltage_ranges1),
+	regulator_desc_s2mps15_buck(8, s2mps15_buck_voltage_ranges2),
+	regulator_desc_s2mps15_buck(9, s2mps15_buck_voltage_ranges2),
+	regulator_desc_s2mps15_buck(10, s2mps15_buck_voltage_ranges2),
+};
+
 static int s2mps14_pmic_enable_ext_control(struct s2mps11_info *s2mps11,
 		struct regulator_dev *rdev)
 {
@@ -974,6 +1102,10 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 		regulators = s2mps14_regulators;
 		BUILD_BUG_ON(S2MPS_REGULATOR_MAX < s2mps11->rdev_num);
 		break;
+	case S2MPS15X:
+		s2mps11->rdev_num = ARRAY_SIZE(s2mps15_regulators);
+		regulators = s2mps15_regulators;
+		break;
 	case S2MPU02:
 		s2mps11->rdev_num = ARRAY_SIZE(s2mpu02_regulators);
 		regulators = s2mpu02_regulators;
@@ -1070,6 +1202,7 @@ static const struct platform_device_id s2mps11_pmic_id[] = {
 	{ "s2mps11-pmic", S2MPS11X},
 	{ "s2mps13-pmic", S2MPS13X},
 	{ "s2mps14-pmic", S2MPS14X},
+	{ "s2mps15-regulator", S2MPS15X},
 	{ "s2mpu02-pmic", S2MPU02},
 	{ },
 };
@@ -1097,5 +1230,5 @@ module_exit(s2mps11_pmic_exit);
 
 /* Module information */
 MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
-MODULE_DESCRIPTION("SAMSUNG S2MPS11/S2MPS14/S2MPU02 Regulator Driver");
+MODULE_DESCRIPTION("SAMSUNG S2MPS11/S2MPS14/S2MPS15/S2MPU02 Regulator Driver");
 MODULE_LICENSE("GPL");
-- 
1.7.10.4

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
