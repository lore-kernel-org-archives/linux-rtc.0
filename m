Received: from mta0.migadu.com (out-79.mta0.migadu.com [91.218.175.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120394766AC
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347148; cv=none; b=cTZVOrtGRR/sPXI/I8aQ4fWfljIRj+gchz1zAuzxtjghBFQnOMZxv1uTkr7peuWjykLrCD0Gsk0SAQi4psU09xIcv/aSozIiOWXj232yFebisLakcIIJWfPz4ma71IUjlKC58nGf6WCfgcnyeruEFDjwM29GR/8SYkONom1Bj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347148; c=relaxed/simple;
	bh=sH6lkVm6vZh1Gd3NVECn/sV8ep/I6wwJuRdHTGBDZJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gxz/1W+XSw87uk1b9K3lJg5Qe6npEP9RFGg2x5a7vNCTY7uRL3IBUxZUhVlPkF1S8bsQR4sa6Q+TlEJXTuPTL2uaGgwI8JWs17Uj6T75qHwSV6ByXicMYtAl0bsJy5afZinfmE2tjI1AVKO26HJcDesKo6Jt7LxXsL+u5OLp7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hCTfs1Kb; arc=none smtp.client-ip=91.218.175.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hCTfs1Kb"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sH6lkVm6vZh1Gd3NVECn/sV8ep/I6wwJuRdHTGBDZJw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788347141; v=1; x=1788951941;
 b=hCTfs1KbjC9HJPd8rQ1k1tC8K8Fksi4H7NAsYrUPi4PLJxSSNLdsJzi+ygxs/BaZuprVDp4E
 gByukAXovanejd/XKDr6HpzwYfgLK2pVJ5RN20OXYVj3DaSCYmUM1367cOiTObyqkg1rqD2Ch3U
 DAfeNjZHQllaB2JRmwK/+1Hg=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id e4175a6b2e7b939f;
	Wed, 02 Sep 2026 11:05:40 +0000
X-Mizu-Trace-ID: e4175a6b2e7b939f
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 14:05:36 +0300
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v3 07/10] regulator: bd71828: Support ROHM BD73800
Message-ID: <ce7152cd65276d2e855f7b605918f2f74f69c324.1788346553.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lPa3qMn8dZhlVFjV"
Content-Disposition: inline
In-Reply-To: <cover.1788346553.git.mazziesaccount@gmail.com>

--lPa3qMn8dZhlVFjV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The ROHM BD73800 is a power management IC which integrates 8 BUCKs and 4
LDOs. The PMIC has internal state-machine and it can support transitions
to RUN, SUSPEND and IDLE states. The LDOs 1 and 3 have two different
voltage range configurations that can be set at the manufacturing phase
by OTP. By default driver assumes low voltage ranges to be used because
the data-sheet indicates the higher voltage ranges to be an 'OTP option'.
The high voltage range can be indicated via device-tree property.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>

---
Revision history:
v3:
 - No changes
v1 =3D> v2:
 - Simplified DT parsing as was suggested by Mark
 - Fix buck5 vsel_mask
---
 drivers/regulator/Kconfig             |   4 +-
 drivers/regulator/bd71828-regulator.c | 558 +++++++++++++++++++++++++-
 2 files changed, 559 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 89789ac7a786..13928af8cad4 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -241,12 +241,12 @@ config REGULATOR_BD71815
 	  will be called bd71815-regulator.
=20
 config REGULATOR_BD71828
-	tristate "ROHM BD71828, BD72720 and BD73900 Power Regulators"
+	tristate "ROHM BD71828, BD72720 and BD73[8/9]00 Power Regulators"
 	depends on MFD_ROHM_BD71828
 	select REGULATOR_ROHM
 	help
 	  This driver supports voltage regulators on ROHM BD71828,
-	  BD71879, BD72720 and BD73900 PMICs. This will enable
+	  BD71879, BD72720 and BD73[8/9]00 PMICs. This will enable
 	  support for the software controllable buck and LDO regulators.
=20
 	  This driver can also be built as a module. If so, the module
diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71=
828-regulator.c
index 2ced81df0c02..dea551cf658a 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (C) 2019 ROHM Semiconductors
 // bd71828-regulator.c ROHM BD71828GW-DS1 regulator driver
-//
=20
 #include <linux/cleanup.h>
 #include <linux/delay.h>
@@ -10,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd71828.h>
 #include <linux/mfd/rohm-bd72720.h>
+#include <linux/mfd/rohm-bd73800.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -31,6 +31,13 @@ struct bd71828_regulator_data {
 	int reg_init_amnt;
 };
=20
+/*
+ * LDO1 and LDO3 node names are used also in the driver to find OTP settin=
g for
+ * the used voltage range.
+ */
+#define LDO1_NODE_NAME "ldo1"
+#define LDO3_NODE_NAME "ldo3"
+
 static const struct reg_init bd71828_buck1_inits[] =3D {
 	/*
 	 * DVS Buck voltages can be changed by register values or via GPIO.
@@ -172,6 +179,55 @@ static const struct linear_range bd72720_ldo6_volts[] =
=3D {
 	REGULATOR_LINEAR_RANGE(1800000, 0x79, 0x7f, 0),
 };
=20
+static const struct linear_range bd73800_buck12348_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x50, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0x51, 0xff, 0),
+};
+
+static const unsigned int bd73800_buck5_volt_range_sel[] =3D {
+	0x0, 0x0, 0x1, 0x1,
+};
+
+static const struct linear_range bd73800_buck5_volts[] =3D {
+	/* range selector 0 */
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x50, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0x51, 0x7f, 0),
+	/* range selector 1 */
+	REGULATOR_LINEAR_RANGE(300000, 0x00, 0x46, 10000),
+	REGULATOR_LINEAR_RANGE(1000000, 0x47, 0x7f, 0),
+};
+
+/*
+ * BUCK5 has two different pickable ranges, each having voltages matching
+ * selectors 0x0 to 0x7f. This gives 0x7f + 1 different voltages for each =
of
+ * the ranges.
+ */
+#define BD73800_NUM_BUCK5_VOLTS ((0x7f + 1) * 2)
+
+static const struct linear_range bd73800_buck67_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(1500000, 0x00, 0xc8, 10000),
+	REGULATOR_LINEAR_RANGE(3500000, 0xc9, 0xff, 0),
+};
+
+/*
+ * On the BD73800 the LDO1 and LDO3 support two different voltage areas.
+ * Whether to use 'high' or 'low' ranges is configured by OTP. There seems
+ * to be no register to read the configured area so it must be given via
+ * device-tree properties.
+ */
+static const struct linear_range bd73800_ldo13_low_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x78, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0x79, 0xff, 0),
+};
+
+static const struct linear_range bd73800_ldo13_high_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(750000, 0x00, 0xff, 10000),
+};
+
+static const struct linear_range bd73800_ldo24_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(750000, 0x00, 0xff, 10000),
+};
+
 static const unsigned int bd71828_ramp_delay[] =3D { 2500, 5000, 10000, 20=
000 };
=20
 /*
@@ -225,6 +281,36 @@ static int bd71828_ldo6_parse_dt(struct device_node *n=
p,
 	return 0;
 }
=20
+/* Operations for all other BUCKs but BUCK 5 */
+static const struct regulator_ops bd73800_buck_ops =3D {
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.list_voltage =3D regulator_list_voltage_linear_range,
+	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
+	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
+	.set_ramp_delay =3D regulator_set_ramp_delay_regmap,
+};
+
+static const struct regulator_ops bd73800_buck5_ops =3D {
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.list_voltage =3D regulator_list_voltage_pickable_linear_range,
+	.set_voltage_sel =3D regulator_set_voltage_sel_pickable_regmap,
+	.get_voltage_sel =3D regulator_get_voltage_sel_pickable_regmap,
+	.set_ramp_delay =3D regulator_set_ramp_delay_regmap,
+};
+
+static const struct regulator_ops bd73800_ldo_ops =3D {
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.list_voltage =3D regulator_list_voltage_linear_range,
+	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
+	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
+};
+
 static const struct regulator_ops bd71828_buck_ops =3D {
 	.enable =3D regulator_enable_regmap,
 	.disable =3D regulator_disable_regmap,
@@ -1565,6 +1651,412 @@ static const struct bd71828_regulator_data bd72720_=
rdata[] =3D {
 	},
 };
=20
+static const struct bd71828_regulator_data bd73800_rdata[] =3D {
+	{
+		.desc =3D {
+			.name =3D "buck1",
+			.of_match =3D of_match_ptr("buck1"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD73800_BUCK1,
+			.ops =3D &bd73800_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd73800_buck12348_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd73800_buck12348_volts),
+			.n_voltages =3D BD73800_NUM_VOLTS,
+			.enable_reg =3D BD73800_REG_BUCK1_ON,
+			.enable_mask =3D BD73800_MASK_RUN_EN,
+			.vsel_reg =3D BD73800_REG_BUCK1_VOLT_RUN,
+			.vsel_mask =3D BD73800_MASK_VOLT,
+			.ramp_delay_table =3D bd71828_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd71828_ramp_delay),
+			.ramp_reg =3D BD73800_REG_BUCK1_MODE,
+			.ramp_mask =3D BD73800_MASK_RAMP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND,
+			.run_reg =3D BD73800_REG_BUCK1_VOLT_RUN,
+			.run_mask =3D BD73800_MASK_VOLT,
+			.idle_reg =3D BD73800_REG_BUCK1_VOLT_IDLE,
+			.idle_mask =3D BD73800_MASK_VOLT,
+			.idle_on_mask =3D BD73800_MASK_IDLE_EN,
+			.suspend_reg =3D BD73800_REG_BUCK1_VOLT_SUSP,
+			.suspend_mask =3D BD73800_MASK_VOLT,
+			.suspend_on_mask =3D BD73800_MASK_SUSP_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck2",
+			.of_match =3D of_match_ptr("buck2"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD73800_BUCK2,
+			.ops =3D &bd73800_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd73800_buck12348_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd73800_buck12348_volts),
+			.n_voltages =3D BD73800_NUM_VOLTS,
+			.enable_reg =3D BD73800_REG_BUCK2_ON,
+			.enable_mask =3D BD73800_MASK_RUN_EN,
+			.vsel_reg =3D BD73800_REG_BUCK2_VOLT_RUN,
+			.vsel_mask =3D BD73800_MASK_VOLT,
+			.ramp_delay_table =3D bd71828_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd71828_ramp_delay),
+			.ramp_reg =3D BD73800_REG_BUCK2_MODE,
+			.ramp_mask =3D BD73800_MASK_RAMP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND,
+			.run_reg =3D BD73800_REG_BUCK2_VOLT_RUN,
+			.run_mask =3D BD73800_MASK_VOLT,
+			.idle_reg =3D BD73800_REG_BUCK2_VOLT_IDLE,
+			.idle_mask =3D BD73800_MASK_VOLT,
+			.idle_on_mask =3D BD73800_MASK_IDLE_EN,
+			.suspend_reg =3D BD73800_REG_BUCK2_VOLT_SUSP,
+			.suspend_mask =3D BD73800_MASK_VOLT,
+			.suspend_on_mask =3D BD73800_MASK_SUSP_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck3",
+			.of_match =3D of_match_ptr("buck3"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD73800_BUCK3,
+			.ops =3D &bd73800_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd73800_buck12348_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd73800_buck12348_volts),
+			.n_voltages =3D BD73800_NUM_VOLTS,
+			.enable_reg =3D BD73800_REG_BUCK3_ON,
+			.enable_mask =3D BD73800_MASK_RUN_EN,
+			.vsel_reg =3D BD73800_REG_BUCK3_VOLT_RUN,
+			.vsel_mask =3D BD73800_MASK_VOLT,
+			.ramp_delay_table =3D bd71828_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd71828_ramp_delay),
+			.ramp_reg =3D BD73800_REG_BUCK3_MODE,
+			.ramp_mask =3D BD73800_MASK_RAMP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND,
+			.run_reg =3D BD73800_REG_BUCK3_VOLT_RUN,
+			.run_mask =3D BD73800_MASK_VOLT,
+			.idle_reg =3D BD73800_REG_BUCK3_VOLT_IDLE,
+			.idle_mask =3D BD73800_MASK_VOLT,
+			.idle_on_mask =3D BD73800_MASK_IDLE_EN,
+			.suspend_reg =3D BD73800_REG_BUCK3_VOLT_SUSP,
+			.suspend_mask =3D BD73800_MASK_VOLT,
+			.suspend_on_mask =3D BD73800_MASK_SUSP_EN,
+		},
+
+	}, {
+		.desc =3D {
+			.name =3D "buck4",
+			.of_match =3D of_match_ptr("buck4"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD73800_BUCK4,
+			.ops =3D &bd73800_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd73800_buck12348_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd73800_buck12348_volts),
+			.n_voltages =3D BD73800_NUM_VOLTS,
+			.enable_reg =3D BD73800_REG_BUCK4_ON,
+			.enable_mask =3D BD73800_MASK_RUN_EN,
+			.vsel_reg =3D BD73800_REG_BUCK4_VOLT_RUN,
+			.vsel_mask =3D BD73800_MASK_VOLT,
+			.ramp_delay_table =3D bd71828_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd71828_ramp_delay),
+			.ramp_reg =3D BD73800_REG_BUCK4_MODE,
+			.ramp_mask =3D BD73800_MASK_RAMP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND,
+			.run_reg =3D BD73800_REG_BUCK4_VOLT_RUN,
+			.run_mask =3D BD73800_MASK_VOLT,
+			.idle_reg =3D BD73800_REG_BUCK4_VOLT_IDLE,
+			.idle_mask =3D BD73800_MASK_VOLT,
+			.idle_on_mask =3D BD73800_MASK_IDLE_EN,
+			.suspend_reg =3D BD73800_REG_BUCK4_VOLT_SUSP,
+			.suspend_mask =3D BD73800_MASK_VOLT,
+			.suspend_on_mask =3D BD73800_MASK_SUSP_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck5",
+			.of_match =3D of_match_ptr("buck5"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD73800_BUCK5,
+			.ops =3D &bd73800_buck5_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd73800_buck5_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd73800_buck5_volts),
+			.linear_range_selectors_bitfield =3D
+						bd73800_buck5_volt_range_sel,
+			.n_voltages =3D BD73800_NUM_BUCK5_VOLTS,
+			.enable_reg =3D BD73800_REG_BUCK5_ON,
+			.enable_mask =3D BD73800_MASK_RUN_EN,
+			.vsel_reg =3D BD73800_REG_BUCK5_VOLT_RUN,
+			.vsel_mask =3D BD73800_MASK_BUCK5_VOLT,
+			.vsel_range_reg =3D BD73800_REG_BUCK5_MODE,
+			.vsel_range_mask =3D BD73800_BUCK5_RANGE_MASK,
+			.range_applied_by_vsel =3D true,
+			.ramp_delay_table =3D bd71828_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd71828_ramp_delay),
+			.ramp_reg =3D BD73800_REG_BUCK5_MODE,
+			.ramp_mask =3D BD73800_MASK_RAMP_DELAY,
+			.owner =3D THIS_MODULE,
+		},
+		.dvs =3D {
+			/*
+			 * We don't support setting the IDLE / SUSPEND voltages
+			 * for the BUCK 5 for now. Reason is that the pickable
+			 * range selector bit is common for all states (RUN,
+			 * SUSPEND and IDLE), and toggling it for one impacts
+			 * also others.
+			 * Furthermore, writing the BD73800 range selector does
+			 * not impact the RUN voltage until a new voltage value
+			 * is also written to the vsel register. Hence the
+			 * voltage change can be done without any 'intermediate
+			 * voltages', even when the range is changed when the
+			 * BUCK is enabled.
+			 * It, however, is not documented how the IDLE / SUSPEND
+			 * states work in this regard. I expect the full
+			 * combination of the range selector and vsel is taken
+			 * into account at the state change, no matter when they
+			 * have been written to.
+			 */
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND,
+			.run_reg =3D BD73800_REG_BUCK5_VOLT_RUN,
+			.run_mask =3D BD73800_MASK_VOLT,
+			.idle_on_mask =3D BD73800_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD73800_MASK_SUSP_EN,
+		},
+
+	}, {
+		.desc =3D {
+			.name =3D "buck6",
+			.of_match =3D of_match_ptr("buck6"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD73800_BUCK6,
+			.ops =3D &bd73800_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd73800_buck67_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd73800_buck67_volts),
+			.n_voltages =3D BD73800_NUM_VOLTS,
+			.enable_reg =3D BD73800_REG_BUCK6_ON,
+			.enable_mask =3D BD73800_MASK_RUN_EN,
+			.vsel_reg =3D BD73800_REG_BUCK6_VOLT_RUN,
+			.vsel_mask =3D BD73800_MASK_VOLT,
+			.ramp_delay_table =3D bd71828_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd71828_ramp_delay),
+			.ramp_reg =3D BD73800_REG_BUCK6_MODE,
+			.ramp_mask =3D BD73800_MASK_RAMP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND,
+			.run_reg =3D BD73800_REG_BUCK6_VOLT_RUN,
+			.run_mask =3D BD73800_MASK_VOLT,
+			.idle_reg =3D BD73800_REG_BUCK6_VOLT_IDLE,
+			.idle_mask =3D BD73800_MASK_VOLT,
+			.idle_on_mask =3D BD73800_MASK_IDLE_EN,
+			.suspend_reg =3D BD73800_REG_BUCK6_VOLT_SUSP,
+			.suspend_mask =3D BD73800_MASK_VOLT,
+			.suspend_on_mask =3D BD73800_MASK_SUSP_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck7",
+			.of_match =3D of_match_ptr("buck7"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD73800_BUCK7,
+			.ops =3D &bd73800_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd73800_buck67_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd73800_buck67_volts),
+			.n_voltages =3D BD73800_NUM_VOLTS,
+			.enable_reg =3D BD73800_REG_BUCK7_ON,
+			.enable_mask =3D BD73800_MASK_RUN_EN,
+			.vsel_reg =3D BD73800_REG_BUCK7_VOLT_RUN,
+			.vsel_mask =3D BD73800_MASK_VOLT,
+			.ramp_delay_table =3D bd71828_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd71828_ramp_delay),
+			.ramp_reg =3D BD73800_REG_BUCK7_MODE,
+			.ramp_mask =3D BD73800_MASK_RAMP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND,
+			.run_reg =3D BD73800_REG_BUCK7_VOLT_RUN,
+			.run_mask =3D BD73800_MASK_VOLT,
+			.idle_reg =3D BD73800_REG_BUCK7_VOLT_IDLE,
+			.idle_mask =3D BD73800_MASK_VOLT,
+			.idle_on_mask =3D BD73800_MASK_IDLE_EN,
+			.suspend_reg =3D BD73800_REG_BUCK7_VOLT_SUSP,
+			.suspend_mask =3D BD73800_MASK_VOLT,
+			.suspend_on_mask =3D BD73800_MASK_SUSP_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck8",
+			.of_match =3D of_match_ptr("buck8"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD73800_BUCK8,
+			.ops =3D &bd73800_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd73800_buck12348_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd73800_buck12348_volts),
+			.n_voltages =3D BD73800_NUM_VOLTS,
+			.enable_reg =3D BD73800_REG_BUCK8_ON,
+			.enable_mask =3D BD73800_MASK_RUN_EN,
+			.vsel_reg =3D BD73800_REG_BUCK8_VOLT_RUN,
+			.vsel_mask =3D BD73800_MASK_VOLT,
+			.ramp_delay_table =3D bd71828_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd71828_ramp_delay),
+			.ramp_reg =3D BD73800_REG_BUCK8_MODE,
+			.ramp_mask =3D BD73800_MASK_RAMP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND,
+			.run_reg =3D BD73800_REG_BUCK8_VOLT_RUN,
+			.run_mask =3D BD73800_MASK_VOLT,
+			.idle_reg =3D BD73800_REG_BUCK8_VOLT_IDLE,
+			.idle_mask =3D BD73800_MASK_VOLT,
+			.idle_on_mask =3D BD73800_MASK_IDLE_EN,
+			.suspend_reg =3D BD73800_REG_BUCK8_VOLT_SUSP,
+			.suspend_mask =3D BD73800_MASK_VOLT,
+			.suspend_on_mask =3D BD73800_MASK_SUSP_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo1",
+			.of_match =3D of_match_ptr(LDO1_NODE_NAME),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD73800_LDO1,
+			.ops =3D &bd73800_ldo_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd73800_ldo13_low_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd73800_ldo13_low_volts),
+			.n_voltages =3D BD73800_NUM_VOLTS,
+			.enable_reg =3D BD73800_REG_LDO1_ON,
+			.enable_mask =3D BD73800_MASK_RUN_EN,
+			.vsel_reg =3D BD73800_REG_LDO1_VOLT,
+			.vsel_mask =3D BD73800_MASK_VOLT,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			/*
+			 * LDOs support only single voltage for all states.
+			 * Voltage can be individually enabled for each state
+			 * though. Allow setting enable/disable config by
+			 * setting the <state>_on_mask for all supported states.
+			 */
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND,
+			.run_reg =3D BD73800_REG_LDO1_VOLT,
+			.run_mask =3D BD73800_MASK_VOLT,
+			.idle_on_mask =3D BD73800_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD73800_MASK_SUSP_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo2",
+			.of_match =3D of_match_ptr("ldo2"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD73800_LDO2,
+			.ops =3D &bd73800_ldo_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd73800_ldo24_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd73800_ldo24_volts),
+			.n_voltages =3D BD73800_NUM_VOLTS,
+			.enable_reg =3D BD73800_REG_LDO2_ON,
+			.enable_mask =3D BD73800_MASK_RUN_EN,
+			.vsel_reg =3D BD73800_REG_LDO2_VOLT,
+			.vsel_mask =3D BD73800_MASK_VOLT,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND,
+			.run_reg =3D BD73800_REG_LDO2_VOLT,
+			.run_mask =3D BD73800_MASK_VOLT,
+			.idle_on_mask =3D BD73800_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD73800_MASK_SUSP_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo3",
+			.of_match =3D of_match_ptr(LDO3_NODE_NAME),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD73800_LDO3,
+			.ops =3D &bd73800_ldo_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd73800_ldo13_low_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd73800_ldo13_low_volts),
+			.n_voltages =3D BD73800_NUM_VOLTS,
+			.enable_reg =3D BD73800_REG_LDO3_ON,
+			.enable_mask =3D BD73800_MASK_RUN_EN,
+			.vsel_reg =3D BD73800_REG_LDO3_VOLT,
+			.vsel_mask =3D BD73800_MASK_VOLT,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND,
+			.run_reg =3D BD73800_REG_LDO3_VOLT,
+			.run_mask =3D BD73800_MASK_VOLT,
+			.idle_on_mask =3D BD73800_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD73800_MASK_SUSP_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo4",
+			.of_match =3D of_match_ptr("ldo4"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD73800_LDO4,
+			.ops =3D &bd73800_ldo_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd73800_ldo24_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd73800_ldo24_volts),
+			.n_voltages =3D BD73800_NUM_VOLTS,
+			.enable_reg =3D BD73800_REG_LDO4_ON,
+			.enable_mask =3D BD73800_MASK_RUN_EN,
+			.vsel_reg =3D BD73800_REG_LDO4_VOLT,
+			.vsel_mask =3D BD73800_MASK_VOLT,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND,
+			.run_reg =3D BD73800_REG_LDO4_VOLT,
+			.run_mask =3D BD73800_MASK_VOLT,
+			.idle_on_mask =3D BD73800_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD73800_MASK_SUSP_EN,
+		},
+	},
+};
+
 static int bd72720_buck10_ldon_head_mode(struct device *dev,
 					 struct device_node *npreg,
 					 struct regmap *regmap,
@@ -1619,6 +2111,52 @@ static int bd72720_dt_parse(struct device *dev,
 	return bd72720_buck10_ldon_head_mode(dev, nproot, regmap, buck10_desc);
 }
=20
+static bool bd73800_use_ldo_high_range(struct device_node *nproot,
+				       const char *ldo_node)
+{
+	struct device_node *np __free(device_node) =3D
+		of_get_child_by_name(nproot, ldo_node);
+
+	if (!np)
+		return false;
+
+	return of_property_read_bool(np, "rohm,ldo-range-high");
+}
+
+static int bd73800_check_ldo_otp_options(struct device *dev,
+					 struct bd71828_regulator_data *d,
+					 unsigned int num_reg_data)
+{
+	struct device_node *nproot __free(device_node) =3D
+		of_get_child_by_name(dev->parent->of_node, "regulators");
+
+	/*
+	 * The code assumes regulator IDs to start from 0 and to match the
+	 * indexing of regulator data arrays. WARN if someone changes this.
+	 */
+	WARN_ON(d[BD73800_LDO1].desc.id !=3D BD73800_LDO1);
+	WARN_ON(d[BD73800_LDO3].desc.id !=3D BD73800_LDO3);
+
+	if (!nproot) {
+		dev_err(dev, "failed to find regulators node\n");
+		return -ENODEV;
+	}
+
+	if (bd73800_use_ldo_high_range(nproot, LDO1_NODE_NAME)) {
+		d[BD73800_LDO1].desc.linear_ranges =3D bd73800_ldo13_high_volts;
+		d[BD73800_LDO1].desc.n_linear_ranges =3D
+					ARRAY_SIZE(bd73800_ldo13_high_volts);
+	}
+
+	if (bd73800_use_ldo_high_range(nproot, LDO3_NODE_NAME)) {
+		d[BD73800_LDO3].desc.linear_ranges =3D bd73800_ldo13_high_volts;
+		d[BD73800_LDO3].desc.n_linear_ranges =3D
+					ARRAY_SIZE(bd73800_ldo13_high_volts);
+	}
+
+	return 0;
+}
+
 static int bd71828_probe(struct platform_device *pdev)
 {
 	int i, j, ret, num_regulators;
@@ -1656,6 +2194,23 @@ static int bd71828_probe(struct platform_device *pde=
v)
 		num_regulators =3D ARRAY_SIZE(bd71828_rdata);
=20
 		break;
+
+	case ROHM_CHIP_TYPE_BD73800:
+	{
+		rdata =3D devm_kmemdup(&pdev->dev, bd73800_rdata,
+				     sizeof(bd73800_rdata), GFP_KERNEL);
+		if (!rdata)
+			return -ENOMEM;
+
+		num_regulators =3D ARRAY_SIZE(bd73800_rdata);
+
+		ret =3D bd73800_check_ldo_otp_options(&pdev->dev, rdata,
+						    num_regulators);
+		if (ret)
+			return ret;
+
+		break;
+	}
 	default:
 		return dev_err_probe(&pdev->dev, -EINVAL,
 				     "Unsupported device\n");
@@ -1692,6 +2247,7 @@ static int bd71828_probe(struct platform_device *pdev)
 static const struct platform_device_id bd71828_pmic_id[] =3D {
 	{ .name =3D "bd71828-pmic", .driver_data =3D ROHM_CHIP_TYPE_BD71828 },
 	{ .name =3D "bd72720-pmic", .driver_data =3D ROHM_CHIP_TYPE_BD72720 },
+	{ .name =3D "bd73800-pmic", .driver_data =3D ROHM_CHIP_TYPE_BD73800 },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, bd71828_pmic_id);
--=20
2.55.0


--lPa3qMn8dZhlVFjV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqYAwAACgkQeFA3/03a
ocW8BwgAv++z/Tfspn3XuGT3IfXxrehJiWMirQgQAxdnsx8Y+J1wr5OFiE1K7Hqn
96Y9wOpj+uFRMwjYxeIGp+GFKyAhV23Ra8+3dqh5mnNMlj1gfKoCm04ofxjfM4eA
s6AaHTD8i75YuHj2JtwvilkvZjasIFwcaoCUn/KipIYu9PyXgthIP7P96k5VR6al
QSjCG6jiNvgajqresr9Si3jvW2hqkGAbwr5C0Xolq8U7K6knSKGPy92H/rx9ISk7
AAx1zIwMomGVJRvdU4x5HWyvLtXZKCvN5CM95U5q4+3Du3SdQpFA3RKbFoRE0BpB
O6i+FHxarktDqR8XJAbyuNlczJwXdg==
=RMIr
-----END PGP SIGNATURE-----

--lPa3qMn8dZhlVFjV--
