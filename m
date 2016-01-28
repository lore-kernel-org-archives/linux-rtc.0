Return-Path: <rtc-linux+bncBDKZNNNLXAHBBO5CU22QKGQERBZ5CRQ@googlegroups.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id jg4si1144956pac.2.2016.01.27.19.55.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 19:55:39 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1N00BEN9KLZM80@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 28 Jan 2016 03:55:34 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V5 5/5] regulator: max77620: add regulator
 driver for max77620/max20024
To: Laxman Dewangan <ldewangan@nvidia.com>, robh+dt@kernel.org,
 pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
 lee.jones@linaro.org, broonie@kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com
References: <1453903808-29788-1-git-send-email-ldewangan@nvidia.com>
 <1453903808-29788-6-git-send-email-ldewangan@nvidia.com>
Cc: lgirdwood@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
 Mallikarjun Kasoju <mkasoju@nvidia.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A99130.1070904@samsung.com>
Date: Thu, 28 Jan 2016 12:55:28 +0900
MIME-version: 1.0
In-reply-to: <1453903808-29788-6-git-send-email-ldewangan@nvidia.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 27.01.2016 23:10, Laxman Dewangan wrote:
> MAXIM Semiconductor's PMIC, MAX77620 and MAX20024 have the
> multiple DCDC and LDOs. This supplies the power to different
> components of the system.
> Also these rails has configuration for ramp time, flexible
> power sequence, slew rate etc.
> 
> Add regulator driver to access these rails via regulator APIs.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Mallikarjun Kasoju <mkasoju@nvidia.com>
> ---
> Changes from V1:
> - Cleanup code based on comment received on mfd/rtc.
> - Avoid duplication on error message.
> 
> Changes form V2:
> - Run coccicheck and checkpatch in strict mode for the alignment.
> - Refactor Regulator driver to use core API for DT parsing.
> - Update based on API changes.
> 
> Changes from V3: 
> - Change all sys initcall to module driver.
> - change the max77620_read argument to unisgned int from u8.
> 
> Changes from V4: 
> - Added DT binding document as devicetree/bindings/regulator/regulator-max77620.txt
> - Detail out properties.

What does it mean "Detail out properties"? What have changed>

> 
>  .../bindings/regulator/regulator-max77620.txt      | 163 ++++

Please put the bindings in separate patch. It might be easier for DT
guys to review them (they are acking the bindings, not the driver). Also
I already reviewed the patchset but because of adding bindings here, you
could not add my reviewed-by tag (which makes my effort not tracked...).

Best regards,
Krzysztof


>  drivers/regulator/Kconfig                          |   9 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/max77620-regulator.c             | 844 +++++++++++++++++++++
>  4 files changed, 1017 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/regulator-max77620.txt
>  create mode 100644 drivers/regulator/max77620-regulator.c
> 
> diff --git a/Documentation/devicetree/bindings/regulator/regulator-max77620.txt b/Documentation/devicetree/bindings/regulator/regulator-max77620.txt
> new file mode 100644
> index 0000000..230f885
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/regulator-max77620.txt
> @@ -0,0 +1,163 @@
> +Regulator DT binding for MAX77620 Power management IC from Maxim Semiconductor.
> +
> +Device has multiple DCDC(sd[0-3] and LDOs(ldo[0-8]). The details of regulator
> +properties are defined under the sub node "regulators" of parent node.
> +
> +Please refer file <Documentation/devicetree/bindings/regulator/regulator.txt>
> +for common regulator bindings used by client.
> +
> +Following are properties of regulator subnode.
> +
> +Optional properties:
> +-------------------
> +The input supply of regulators are the optional properties on the
> +regulator node. The input supply of these regulators are provided
> +through following properties:
> +in-sd0-supply: Input supply for SD0, INA-SD0 or INB-SD0 pins.
> +in-sd1-supply: Input supply for SD1.
> +in-sd2-supply: Input supply for SD2.
> +in-sd3-supply: Input supply for SD3.
> +in-ldo0-1-supply: Input supply for LDO0 and LDO1.
> +in-ldo2-supply: Input supply for LDO2.
> +in-ldo3-5-supply: Input supply for LDO3 and LDO5
> +in-ldo4-6-supply: Input supply for LDO4 and LDO6.
> +in-ldo7-8-supply: Input supply for LDO7 and LDO8.
> +
> +
> +Optional sub nodes for regulators:
> +---------------------------------
> +The subnodes name is the name of regulator and it must be one of:
> +	sd[0-3], ldo[0-8]
> +
> +Each sub-node should contain the constraints and initialization
> +information for that regulator. The definition for each of these
> +nodes is defined using the standard binding for regulators found at
> +<Documentation/devicetree/bindings/regulator/regulator.txt>.
> +
> +Theres is also additional properties for SD/LDOs.
> +The properties are required to configure SDs/LDOs FPS parameters
> +when system is in "active" state or in "suspend" state.
> +Here "active" state means system is UP and working normally.
> +"suspend" state means system enters into the suspend state.
> +
> +- maxim,active-fps-source:	     FPS source for the gpios in active state
> +				     of the GPIO. Valid values are FPS_SRC_0,
> +				     FPS_SRC_1, FPS_SRC_2 and FPS_SRC_NONE.
> +				     Absence of this property will leave the pin
> +				     on default.
> +- maxim,active-fps-power-up-slot:    Power up slot on given FPS for active state.
> +				     Valid values are 0 to 7.
> +- maxim,active-fps-power-down-slot:  Power down slot on given FPS for active
> +				     state. Valid values are 0 to 7.
> +- maxim,suspend-fps-source:	     Suspend state FPS source. Valid values are
> +				     same as maxim,active-fps-source.
> +- maxim,suspend-fps-power-down-slot: Suspend state power down slot. Valid
> +				     values are 0 to 7.
> +- maxim,suspend-fps-power-up-slot:   Suspend state power up slot. Valid values
> +				     are 0 to 7.
> +- maxim,disable-active-discharge:    boolean, Disable active discharge.
> +
> +Example:
> +--------
> +#include <dt-bindings/mfd/max77620.h>
> +...
> +max77620@3c {
> +	regulators {
> +		in-ldo0-1-supply = <&max77620_sd2>;
> +		in-ldo7-8-supply = <&max77620_sd2>;
> +
> +		sd0 {
> +			regulator-name = "vdd-core";
> +			regulator-min-microvolt = <600000>;
> +			regulator-max-microvolt = <1400000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +			maxim,active-fps-source = <FPS_SRC_1>;
> +		};
> +
> +		sd1 {
> +			regulator-name = "vddio-ddr";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			maxim,active-fps-source = <FPS_SRC_0>;
> +		};
> +
> +		sd2 {
> +			regulator-name = "vdd-pre-reg";
> +			regulator-min-microvolt = <1350000>;
> +			regulator-max-microvolt = <1350000>;
> +		};
> +
> +		sd3 {
> +			regulator-name = "vdd-1v8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		ldo0 {
> +			regulator-name = "avdd-sys";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		ldo1 {
> +			regulator-name = "vdd-pex";
> +			regulator-min-microvolt = <1050000>;
> +			regulator-max-microvolt = <1050000>;
> +		};
> +
> +		ldo2 {
> +			regulator-name = "vddio-sdmmc3";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		ldo3 {
> +			regulator-name = "vdd-cam-hv";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +
> +		ldo4 {
> +			regulator-name = "vdd-rtc";
> +			regulator-min-microvolt = <1250000>;
> +			regulator-max-microvolt = <1250000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		ldo5 {
> +			regulator-name = "avdd-ts-hv";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +		};
> +
> +		ldo6 {
> +			regulator-name = "vdd-ts";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		ldo7 {
> +			regulator-name = "vdd-gen-pll-edp";
> +			regulator-min-microvolt = <1050000>;
> +			regulator-max-microvolt = <1050000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		ldo8 {
> +			regulator-name = "vdd-hdmi-dp";
> +			regulator-min-microvolt = <1050000>;
> +			regulator-max-microvolt = <1050000>;
> +		};
> +	};
> +};
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 8155e80..b92214b 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -343,6 +343,15 @@ config REGULATOR_MAX1586
>  	  regulator via I2C bus. The provided regulator is suitable
>  	  for PXA27x chips to control VCC_CORE and VCC_USIM voltages.
>  
> +config REGULATOR_MAX77620
> +	tristate "Maxim 77620/MAX20024 voltage regulator"
> +	depends on MFD_MAX77620
> +	help
> +	  This driver controls Maxim MAX77620 voltage output regulator
> +	  via I2C bus. The provided regulator is suitable for Tegra
> +	  chip to control Step-Down DC-DC and LDOs. Say Y here to
> +	  enable the regulator driver.
> +
>  config REGULATOR_MAX8649
>  	tristate "Maxim 8649 voltage regulator"
>  	depends on I2C
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 980b194..2564c00 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_REGULATOR_LP8755) += lp8755.o
>  obj-$(CONFIG_REGULATOR_LTC3589) += ltc3589.o
>  obj-$(CONFIG_REGULATOR_MAX14577) += max14577.o
>  obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
> +obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
>  obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
>  obj-$(CONFIG_REGULATOR_MAX8660) += max8660.o
>  obj-$(CONFIG_REGULATOR_MAX8907) += max8907-regulator.o
> diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
> new file mode 100644
> index 0000000..a15ca6b
> --- /dev/null
> +++ b/drivers/regulator/max77620-regulator.c
> @@ -0,0 +1,844 @@
> +/*
> + * Maxim MAX77620 Regulator driver
> + *
> + * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * Author: Mallikarjun Kasoju <mkasoju@nvidia.com>
> + *	Laxman Dewangan <ldewangan@nvidia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <linux/mfd/max77620.h>
> +
> +#define max77620_rails(_name)	"max77620-"#_name
> +
> +/* Power Mode */
> +#define MAX77620_POWER_MODE_NORMAL		3
> +#define MAX77620_POWER_MODE_LPM			2
> +#define MAX77620_POWER_MODE_GLPM		1
> +#define MAX77620_POWER_MODE_DISABLE		0
> +
> +/* SD Slew Rate */
> +#define MAX77620_SD_SR_13_75			0
> +#define MAX77620_SD_SR_27_5			1
> +#define MAX77620_SD_SR_55			2
> +#define MAX77620_SD_SR_100			3
> +
> +#define MAX77620_FPS_SRC_NUM			3
> +
> +struct max77620_regulator_info {
> +	u8 type;
> +	u32 min_uV;
> +	u32 max_uV;
> +	u32 step_uV;
> +	u8 fps_addr;
> +	u8 volt_addr;
> +	u8 cfg_addr;
> +	u8 volt_mask;
> +	u8 power_mode_mask;
> +	u8 power_mode_shift;
> +	u8 remote_sense_addr;
> +	u8 remote_sense_mask;
> +	struct regulator_desc desc;
> +};
> +
> +struct max77620_regulator_pdata {
> +	bool sd_fsrade_disable;
> +	struct regulator_init_data *reg_idata;
> +	int active_fps_src;
> +	int active_fps_pd_slot;
> +	int active_fps_pu_slot;
> +	int suspend_fps_src;
> +	int suspend_fps_pd_slot;
> +	int suspend_fps_pu_slot;
> +	int current_mode;
> +};
> +
> +struct max77620_regulator {
> +	struct device *dev;
> +	struct max77620_chip *max77620_chip;
> +	struct max77620_regulator_info *rinfo[MAX77620_NUM_REGS];
> +	struct max77620_regulator_pdata reg_pdata[MAX77620_NUM_REGS];
> +	struct regulator_desc *rdesc[MAX77620_NUM_REGS];
> +	int enable_power_mode[MAX77620_NUM_REGS];
> +	int current_power_mode[MAX77620_NUM_REGS];
> +	int active_fps_src[MAX77620_NUM_REGS];
> +};
> +
> +#define fps_src_name(fps_src)	\
> +	(fps_src == FPS_SRC_0 ? "FPS_SRC_0" :	\
> +	fps_src == FPS_SRC_1 ? "FPS_SRC_1" :	\
> +	fps_src == FPS_SRC_2 ? "FPS_SRC_2" : "FPS_SRC_NONE")
> +
> +static int max77620_regulator_get_fps_src(struct max77620_regulator *pmic,
> +					  int id)
> +{
> +	struct max77620_regulator_info *rinfo = pmic->rinfo[id];
> +	struct device *parent = pmic->max77620_chip->dev;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = max77620_reg_read(parent, rinfo->fps_addr, &val);
> +	if (ret < 0) {
> +		dev_err(pmic->dev, "Reg 0x%02x read failed %d\n",
> +			rinfo->fps_addr, ret);
> +		return ret;
> +	}
> +
> +	return (val & MAX77620_FPS_SRC_MASK) >> MAX77620_FPS_SRC_SHIFT;
> +}
> +
> +static int max77620_regulator_set_fps_src(struct max77620_regulator *pmic,
> +					  int fps_src, int id)
> +{
> +	struct max77620_regulator_info *rinfo = pmic->rinfo[id];
> +	struct device *parent = pmic->max77620_chip->dev;
> +	unsigned int val;
> +	int ret;
> +
> +	switch (fps_src) {
> +	case FPS_SRC_0:
> +	case FPS_SRC_1:
> +	case FPS_SRC_2:
> +	case FPS_SRC_NONE:
> +		break;
> +
> +	case FPS_SRC_DEF:
> +		ret = max77620_reg_read(parent, rinfo->fps_addr, &val);
> +		if (ret < 0) {
> +			dev_err(pmic->dev, "Reg 0x%02x read failed %d\n",
> +				rinfo->fps_addr, ret);
> +			return ret;
> +		}
> +		ret = (val & MAX77620_FPS_SRC_MASK) >> MAX77620_FPS_SRC_SHIFT;
> +		pmic->active_fps_src[id] = ret;
> +		return 0;
> +
> +	default:
> +		dev_err(pmic->dev, "Invalid FPS %d for regulator %d\n",
> +			fps_src, id);
> +		return -EINVAL;
> +	}
> +
> +	ret = max77620_reg_update(parent, rinfo->fps_addr,
> +				  MAX77620_FPS_SRC_MASK,
> +				  fps_src << MAX77620_FPS_SRC_SHIFT);
> +	if (ret < 0) {
> +		dev_err(pmic->dev, "Reg 0x%02x update failed %d\n",
> +			rinfo->fps_addr, ret);
> +		return ret;
> +	}
> +	pmic->active_fps_src[id] = fps_src;
> +
> +	return 0;
> +}
> +
> +static int max77620_regulator_set_fps_slots(struct max77620_regulator *pmic,
> +					    int id, bool is_suspend)
> +{
> +	struct max77620_regulator_pdata *rpdata = &pmic->reg_pdata[id];
> +	struct max77620_regulator_info *rinfo = pmic->rinfo[id];
> +	struct device *parent = pmic->max77620_chip->dev;
> +	unsigned int val = 0;
> +	unsigned int mask = 0;
> +	int pu = rpdata->active_fps_pu_slot;
> +	int pd = rpdata->active_fps_pd_slot;
> +	int ret = 0;
> +
> +	if (is_suspend) {
> +		pu = rpdata->suspend_fps_pu_slot;
> +		pd = rpdata->suspend_fps_pd_slot;
> +	}
> +
> +	/* FPS power up period setting */
> +	if (pu >= 0) {
> +		val |= (pu << MAX77620_FPS_PU_PERIOD_SHIFT);
> +		mask |= MAX77620_FPS_PU_PERIOD_MASK;
> +	}
> +
> +	/* FPS power down period setting */
> +	if (pd >= 0) {
> +		val |= (pd << MAX77620_FPS_PD_PERIOD_SHIFT);
> +		mask |= MAX77620_FPS_PD_PERIOD_MASK;
> +	}
> +
> +	if (mask) {
> +		ret = max77620_reg_update(parent, rinfo->fps_addr, mask, val);
> +		if (ret < 0) {
> +			dev_err(pmic->dev, "Reg 0x%02x update failed: %d\n",
> +				rinfo->fps_addr, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int max77620_regulator_set_power_mode(struct max77620_regulator *pmic,
> +					     int power_mode, int id)
> +{
> +	struct max77620_regulator_info *rinfo = pmic->rinfo[id];
> +	struct device *parent = pmic->max77620_chip->dev;
> +	u8 mask = rinfo->power_mode_mask;
> +	u8 shift = rinfo->power_mode_shift;
> +	u8 addr;
> +	int ret;
> +
> +	switch (rinfo->type) {
> +	case MAX77620_REGULATOR_TYPE_SD:
> +		addr = rinfo->cfg_addr;
> +		break;
> +	default:
> +		addr = rinfo->volt_addr;
> +		break;
> +	}
> +
> +	ret = max77620_reg_update(parent, addr, mask, power_mode << shift);
> +	if (ret < 0) {
> +		dev_err(pmic->dev, "Regulator %d mode set failed: %d\n",
> +			id, ret);
> +		return ret;
> +	}
> +	pmic->current_power_mode[id] = power_mode;
> +
> +	return ret;
> +}
> +
> +static int max77620_regulator_get_power_mode(struct max77620_regulator *pmic,
> +					     int id)
> +{
> +	struct max77620_regulator_info *rinfo = pmic->rinfo[id];
> +	struct device *parent = pmic->max77620_chip->dev;
> +	unsigned int val, addr;
> +	u8 mask = rinfo->power_mode_mask;
> +	u8 shift = rinfo->power_mode_shift;
> +	int ret;
> +
> +	switch (rinfo->type) {
> +	case MAX77620_REGULATOR_TYPE_SD:
> +		addr = rinfo->cfg_addr;
> +		break;
> +	default:
> +		addr = rinfo->volt_addr;
> +		break;
> +	}
> +
> +	ret = max77620_reg_read(parent, addr, &val);
> +	if (ret < 0) {
> +		dev_err(pmic->dev, "Regulator %d: Reg 0x%02x read failed: %d\n",
> +			id, addr, ret);
> +		return ret;
> +	}
> +
> +	return (val & mask) >> shift;
> +}
> +
> +static int max77620_read_slew_rate(struct max77620_regulator *pmic, int id)
> +{
> +	struct max77620_regulator_info *rinfo = pmic->rinfo[id];
> +	struct device *parent = pmic->max77620_chip->dev;
> +	unsigned int rval;
> +	int slew_rate;
> +	int ret;
> +
> +	switch (rinfo->type) {
> +	case MAX77620_REGULATOR_TYPE_SD:
> +		ret = max77620_reg_read(parent, rinfo->cfg_addr, &rval);
> +		if (ret < 0) {
> +			dev_err(pmic->dev, "Register 0x%02x read failed: %d\n",
> +				rinfo->cfg_addr, ret);
> +			return ret;
> +		}
> +
> +		slew_rate = (rval >> MAX77620_SD_SR_SHIFT) & 0x3;
> +		switch (slew_rate) {
> +		case 0:
> +			slew_rate = 13750;
> +			break;
> +		case 1:
> +			slew_rate = 27500;
> +			break;
> +		case 2:
> +			slew_rate = 55000;
> +			break;
> +		case 3:
> +			slew_rate = 100000;
> +			break;
> +		}
> +		rinfo->desc.ramp_delay = slew_rate;
> +		break;
> +	default:
> +		ret = max77620_reg_read(parent, rinfo->cfg_addr, &rval);
> +		if (ret < 0) {
> +			dev_err(pmic->dev, "Register 0x%02x read failed: %d\n",
> +				rinfo->cfg_addr, ret);
> +			return ret;
> +		}
> +		slew_rate = rval & 0x1;
> +		switch (slew_rate) {
> +		case 0:
> +			slew_rate = 100000;
> +			break;
> +		case 1:
> +			slew_rate = 5000;
> +			break;
> +		}
> +		rinfo->desc.ramp_delay = slew_rate;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_init_sd_fs_trade(struct max77620_regulator *pmic, int id)
> +{
> +	struct max77620_regulator_pdata *rpdata = &pmic->reg_pdata[id];
> +	struct max77620_regulator_info *rinfo = pmic->rinfo[id];
> +	struct device *parent = pmic->max77620_chip->dev;
> +	u8 val;
> +	int ret;
> +
> +	val = (rpdata->sd_fsrade_disable) ? MAX77620_SD_FSRADE_MASK : 0;
> +	ret = max77620_reg_update(parent, rinfo->cfg_addr,
> +				  MAX77620_SD_FSRADE_MASK, val);
> +	if (ret < 0)
> +		dev_err(pmic->dev, "Reg 0x%02x update failed: %d\n",
> +			rinfo->cfg_addr, ret);
> +
> +	return ret;
> +}
> +
> +static int max77620_init_pmic(struct max77620_regulator *pmic, int id)
> +{
> +	struct max77620_regulator_pdata *rpdata = &pmic->reg_pdata[id];
> +	struct max77620_regulator_info *rinfo = pmic->rinfo[id];
> +	int ret;
> +
> +	/* Initialise sd_fstrade */
> +	if (rinfo->type == MAX77620_REGULATOR_TYPE_SD) {
> +		ret = max77620_init_sd_fs_trade(pmic, id);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Update power mode */
> +	ret = max77620_regulator_get_power_mode(pmic, id);
> +	if (ret < 0)
> +		return ret;
> +
> +	pmic->current_power_mode[id] = ret;
> +	pmic->enable_power_mode[id] = MAX77620_POWER_MODE_NORMAL;
> +
> +	if (rpdata->active_fps_src == FPS_SRC_DEF) {
> +		ret = max77620_regulator_get_fps_src(pmic, id);
> +		if (ret < 0)
> +			return ret;
> +		rpdata->active_fps_src = ret;
> +	}
> +
> +	 /* If rails are externally control of FPS then enable it always. */
> +	if (rpdata->active_fps_src == FPS_SRC_NONE) {
> +		ret = max77620_regulator_set_power_mode(pmic,
> +					pmic->enable_power_mode[id],
> +					id);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		if (pmic->current_power_mode[id] !=
> +		     pmic->enable_power_mode[id]) {
> +			ret = max77620_regulator_set_power_mode(pmic,
> +					pmic->enable_power_mode[id],
> +					id);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	ret = max77620_regulator_set_fps_src(pmic, rpdata->active_fps_src, id);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = max77620_regulator_set_fps_slots(pmic, id, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int max77620_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct max77620_regulator *pmic = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +
> +	if (pmic->active_fps_src[id] != FPS_SRC_NONE)
> +		return 0;
> +
> +	return max77620_regulator_set_power_mode(pmic,
> +			pmic->enable_power_mode[id], id);
> +}
> +
> +static int max77620_regulator_disable(struct regulator_dev *rdev)
> +{
> +	struct max77620_regulator *pmic = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +
> +	if (pmic->active_fps_src[id] != FPS_SRC_NONE)
> +		return 0;
> +
> +	return max77620_regulator_set_power_mode(pmic,
> +			MAX77620_POWER_MODE_DISABLE, id);
> +}
> +
> +static int max77620_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct max77620_regulator *pmic = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +	int ret = 1;
> +
> +	if (pmic->active_fps_src[id] != FPS_SRC_NONE)
> +		return 1;
> +
> +	ret = max77620_regulator_get_power_mode(pmic, id);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret != MAX77620_POWER_MODE_DISABLE)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int max77620_regulator_set_mode(struct regulator_dev *rdev,
> +				       unsigned int mode)
> +{
> +	struct max77620_regulator *pmic = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +	struct max77620_regulator_info *rinfo = pmic->rinfo[id];
> +	struct max77620_regulator_pdata *rpdata = &pmic->reg_pdata[id];
> +	struct device *parent = pmic->max77620_chip->dev;
> +	bool fpwm = false;
> +	int power_mode;
> +	int ret;
> +	u8 val;
> +
> +	switch (mode) {
> +	case REGULATOR_MODE_FAST:
> +		fpwm = true;
> +		power_mode = MAX77620_POWER_MODE_NORMAL;
> +		break;
> +
> +	case REGULATOR_MODE_NORMAL:
> +		power_mode = MAX77620_POWER_MODE_NORMAL;
> +		break;
> +
> +	case REGULATOR_MODE_IDLE:
> +		power_mode = MAX77620_POWER_MODE_LPM;
> +		break;
> +
> +	default:
> +		dev_err(pmic->dev, "Regulator %d mode %d is invalid\n",
> +			id, mode);
> +		return -EINVAL;
> +	}
> +
> +	if (rinfo->type != MAX77620_REGULATOR_TYPE_SD)
> +		goto skip_fpwm;
> +
> +	val = (fpwm) ? MAX77620_SD_FPWM_MASK : 0;
> +	ret = max77620_reg_update(parent, rinfo->cfg_addr,
> +				  MAX77620_SD_FPWM_MASK, val);
> +	if (ret < 0) {
> +		dev_err(pmic->dev, "Reg 0x%02x update failed: %d\n",
> +			rinfo->cfg_addr, ret);
> +		return ret;
> +	}
> +	rpdata->current_mode = mode;
> +
> +skip_fpwm:
> +	ret = max77620_regulator_set_power_mode(pmic, power_mode, id);
> +	if (ret < 0)
> +		return ret;
> +
> +	pmic->enable_power_mode[id] = power_mode;
> +
> +	return 0;
> +}
> +
> +static unsigned int max77620_regulator_get_mode(struct regulator_dev *rdev)
> +{
> +	struct max77620_regulator *pmic = rdev_get_drvdata(rdev);
> +	struct device *parent = pmic->max77620_chip->dev;
> +	int id = rdev_get_id(rdev);
> +	struct max77620_regulator_info *rinfo = pmic->rinfo[id];
> +	int fpwm = 0;
> +	int ret;
> +	int pm_mode, reg_mode;
> +	unsigned int val;
> +
> +	ret = max77620_regulator_get_power_mode(pmic, id);
> +	if (ret < 0)
> +		return 0;
> +
> +	pm_mode = ret;
> +
> +	if (rinfo->type == MAX77620_REGULATOR_TYPE_SD) {
> +		ret = max77620_reg_read(parent, rinfo->cfg_addr, &val);
> +		if (ret < 0) {
> +			dev_err(pmic->dev, "Reg 0x%02x read failed: %d\n",
> +				rinfo->cfg_addr, ret);
> +			return ret;
> +		}
> +		fpwm = !!(val & MAX77620_SD_FPWM_MASK);
> +	}
> +
> +	switch (pm_mode) {
> +	case MAX77620_POWER_MODE_NORMAL:
> +	case MAX77620_POWER_MODE_DISABLE:
> +		if (fpwm)
> +			reg_mode = REGULATOR_MODE_FAST;
> +		else
> +			reg_mode = REGULATOR_MODE_NORMAL;
> +		break;
> +	case MAX77620_POWER_MODE_LPM:
> +	case MAX77620_POWER_MODE_GLPM:
> +		reg_mode = REGULATOR_MODE_IDLE;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return reg_mode;
> +}
> +
> +static int max77620_regulator_set_ramp_delay(struct regulator_dev *rdev,
> +					     int ramp_delay)
> +{
> +	struct max77620_regulator *pmic = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +	struct max77620_regulator_info *rinfo = pmic->rinfo[id];
> +	struct device *parent = pmic->max77620_chip->dev;
> +	int ret, val;
> +	u8 mask;
> +
> +	if (rinfo->type == MAX77620_REGULATOR_TYPE_SD) {
> +		if (ramp_delay <= 13750)
> +			val = 0;
> +		else if (ramp_delay <= 27500)
> +			val = 1;
> +		else if (ramp_delay <= 55000)
> +			val = 2;
> +		else
> +			val = 3;
> +		val <<= MAX77620_SD_SR_SHIFT;
> +		mask = MAX77620_SD_SR_MASK;
> +	} else {
> +		if (ramp_delay <= 5000)
> +			val = 1;
> +		else
> +			val = 0;
> +		mask = MAX77620_LDO_SLEW_RATE_MASK;
> +	}
> +
> +	ret = max77620_reg_update(parent, rinfo->cfg_addr, mask, val);
> +	if (ret < 0)
> +		dev_err(pmic->dev, "Reg 0x%02x update failed: %d\n",
> +			rinfo->cfg_addr, ret);
> +
> +	return ret;
> +}
> +
> +static int max77620_of_parse_cb(struct device_node *np,
> +				const struct regulator_desc *desc,
> +				struct regulator_config *config)
> +{
> +	struct max77620_regulator *pmic = config->driver_data;
> +	struct max77620_regulator_pdata *rpdata = &pmic->reg_pdata[desc->id];
> +	u32 pval;
> +	int ret;
> +
> +	rpdata->sd_fsrade_disable = of_property_read_bool(np,
> +				"maxim,disable-active-discharge");
> +
> +	ret = of_property_read_u32(np, "maxim,active-fps-source", &pval);
> +	rpdata->active_fps_src = (!ret) ? pval : FPS_SRC_DEF;
> +
> +	ret = of_property_read_u32(np, "maxim,active-fps-power-up-slot", &pval);
> +	rpdata->active_fps_pu_slot = (!ret) ? pval : -1;
> +
> +	ret = of_property_read_u32(
> +			np, "maxim,active-fps-power-down-slot", &pval);
> +	rpdata->active_fps_pd_slot = (!ret) ? pval : -1;
> +
> +	ret = of_property_read_u32(np, "maxim,suspend-fps-source", &pval);
> +	rpdata->suspend_fps_src = (!ret) ? pval : -1;
> +
> +	ret = of_property_read_u32(
> +			np, "maxim,suspend-fps-power-up-slot", &pval);
> +	rpdata->suspend_fps_pu_slot = (!ret) ? pval : -1;
> +
> +	ret = of_property_read_u32(
> +			np, "maxim,suspend-fps-power-down-slot", &pval);
> +	rpdata->suspend_fps_pd_slot = (!ret) ? pval : -1;
> +
> +	return max77620_init_pmic(pmic, desc->id);
> +}
> +
> +static struct regulator_ops max77620_regulator_ops = {
> +	.is_enabled = max77620_regulator_is_enabled,
> +	.enable = max77620_regulator_enable,
> +	.disable = max77620_regulator_disable,
> +	.list_voltage = regulator_list_voltage_linear,
> +	.map_voltage = regulator_map_voltage_linear,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.set_mode = max77620_regulator_set_mode,
> +	.get_mode = max77620_regulator_get_mode,
> +	.set_ramp_delay = max77620_regulator_set_ramp_delay,
> +	.set_voltage_time_sel = regulator_set_voltage_time_sel,
> +};
> +
> +#define MAX77620_SD_CNF2_ROVS_EN_NONE	0
> +#define RAIL_SD(_id, _name, _sname, _volt_mask, _min_uV, _max_uV,	\
> +		_step_uV, _rs_add, _rs_mask)				\
> +	[MAX77620_REGULATOR_ID_##_id] = {				\
> +		.type = MAX77620_REGULATOR_TYPE_SD,			\
> +		.volt_mask = MAX77620_##_volt_mask##_VOLT_MASK,		\
> +		.volt_addr = MAX77620_REG_##_id,			\
> +		.cfg_addr = MAX77620_REG_##_id##_CFG,			\
> +		.fps_addr = MAX77620_REG_FPS_##_id,			\
> +		.remote_sense_addr = _rs_add,				\
> +		.remote_sense_mask = MAX77620_SD_CNF2_ROVS_EN_##_rs_mask, \
> +		.min_uV = _min_uV,					\
> +		.max_uV = _max_uV,					\
> +		.step_uV = _step_uV,					\
> +		.power_mode_mask = MAX77620_SD_POWER_MODE_MASK,		\
> +		.power_mode_shift = MAX77620_SD_POWER_MODE_SHIFT,	\
> +		.desc = {						\
> +			.name = max77620_rails(_name),			\
> +			.of_match = of_match_ptr(#_name),		\
> +			.regulators_node = of_match_ptr("regulators"),	\
> +			.of_parse_cb = max77620_of_parse_cb,		\
> +			.supply_name = _sname,				\
> +			.id = MAX77620_REGULATOR_ID_##_id,		\
> +			.ops = &max77620_regulator_ops,			\
> +			.n_voltages = ((_max_uV - _min_uV) / _step_uV) + 1, \
> +			.min_uV = _min_uV,				\
> +			.uV_step = _step_uV,				\
> +			.enable_time = 500,				\
> +			.vsel_mask = MAX77620_##_volt_mask##_VOLT_MASK,	\
> +			.vsel_reg = MAX77620_REG_##_id,			\
> +			.type = REGULATOR_VOLTAGE,			\
> +		},							\
> +	}
> +
> +#define RAIL_LDO(_id, _name, _sname, _type, _min_uV, _max_uV, _step_uV) \
> +	[MAX77620_REGULATOR_ID_##_id] = {				\
> +		.type = MAX77620_REGULATOR_TYPE_LDO_##_type,		\
> +		.volt_mask = MAX77620_LDO_VOLT_MASK,			\
> +		.volt_addr = MAX77620_REG_##_id##_CFG,			\
> +		.cfg_addr = MAX77620_REG_##_id##_CFG2,			\
> +		.fps_addr = MAX77620_REG_FPS_##_id,			\
> +		.remote_sense_addr = 0xFF,				\
> +		.min_uV = _min_uV,					\
> +		.max_uV = _max_uV,					\
> +		.step_uV = _step_uV,					\
> +		.power_mode_mask = MAX77620_LDO_POWER_MODE_MASK,	\
> +		.power_mode_shift = MAX77620_LDO_POWER_MODE_SHIFT,	\
> +		.desc = {						\
> +			.name = max77620_rails(_name),			\
> +			.of_match = of_match_ptr(#_name),		\
> +			.regulators_node = of_match_ptr("regulators"),	\
> +			.of_parse_cb = max77620_of_parse_cb,		\
> +			.supply_name = _sname,				\
> +			.id = MAX77620_REGULATOR_ID_##_id,		\
> +			.ops = &max77620_regulator_ops,			\
> +			.n_voltages = ((_max_uV - _min_uV) / _step_uV) + 1, \
> +			.min_uV = _min_uV,				\
> +			.uV_step = _step_uV,				\
> +			.enable_time = 500,				\
> +			.vsel_mask = MAX77620_LDO_VOLT_MASK,		\
> +			.vsel_reg = MAX77620_REG_##_id##_CFG,		\
> +			.type = REGULATOR_VOLTAGE,			\
> +		},							\
> +	}
> +
> +static struct max77620_regulator_info max77620_regs_info[MAX77620_NUM_REGS] = {
> +	RAIL_SD(SD0, sd0, "in-sd0", SD0, 600000, 1400000, 12500, 0x22, SD0),
> +	RAIL_SD(SD1, sd1, "in-sd1", SD1, 600000, 1550000, 12500, 0x22, SD1),
> +	RAIL_SD(SD2, sd2, "in-sd2", SDX, 600000, 3787500, 12500, 0xFF, NONE),
> +	RAIL_SD(SD3, sd3, "in-sd3", SDX, 600000, 3787500, 12500, 0xFF, NONE),
> +	RAIL_SD(SD4, sd4, "in-sd4", SDX, 600000, 3787500, 12500, 0xFF, NONE),
> +
> +	RAIL_LDO(LDO0, ldo0, "in-ldo0-1", N, 800000, 2375000, 25000),
> +	RAIL_LDO(LDO1, ldo1, "in-ldo0-1", N, 800000, 2375000, 25000),
> +	RAIL_LDO(LDO2, ldo2, "in-ldo2",   P, 800000, 3950000, 50000),
> +	RAIL_LDO(LDO3, ldo3, "in-ldo3-5", P, 800000, 3950000, 50000),
> +	RAIL_LDO(LDO4, ldo4, "in-ldo4-6", P, 800000, 1587500, 12500),
> +	RAIL_LDO(LDO5, ldo5, "in-ldo3-5", P, 800000, 3950000, 50000),
> +	RAIL_LDO(LDO6, ldo6, "in-ldo4-6", P, 800000, 3950000, 50000),
> +	RAIL_LDO(LDO7, ldo7, "in-ldo7-8", N, 800000, 3950000, 50000),
> +	RAIL_LDO(LDO8, ldo8, "in-ldo7-8", N, 800000, 3950000, 50000),
> +};
> +
> +static struct max77620_regulator_info max20024_regs_info[MAX77620_NUM_REGS] = {
> +	RAIL_SD(SD0, sd0, "in-sd0", SD0, 800000, 1587500, 12500, 0x22, SD0),
> +	RAIL_SD(SD1, sd1, "in-sd1", SD1, 600000, 3387500, 12500, 0x22, SD1),
> +	RAIL_SD(SD2, sd2, "in-sd2", SDX, 600000, 3787500, 12500, 0xFF, NONE),
> +	RAIL_SD(SD3, sd3, "in-sd3", SDX, 600000, 3787500, 12500, 0xFF, NONE),
> +	RAIL_SD(SD4, sd4, "in-sd4", SDX, 600000, 3787500, 12500, 0xFF, NONE),
> +
> +	RAIL_LDO(LDO0, ldo0, "in-ldo0-1", N, 800000, 2375000, 25000),
> +	RAIL_LDO(LDO1, ldo1, "in-ldo0-1", N, 800000, 2375000, 25000),
> +	RAIL_LDO(LDO2, ldo2, "in-ldo2",   P, 800000, 3950000, 50000),
> +	RAIL_LDO(LDO3, ldo3, "in-ldo3-5", P, 800000, 3950000, 50000),
> +	RAIL_LDO(LDO4, ldo4, "in-ldo4-6", P, 800000, 1587500, 12500),
> +	RAIL_LDO(LDO5, ldo5, "in-ldo3-5", P, 800000, 3950000, 50000),
> +	RAIL_LDO(LDO6, ldo6, "in-ldo4-6", P, 800000, 3950000, 50000),
> +	RAIL_LDO(LDO7, ldo7, "in-ldo7-8", N, 800000, 3950000, 50000),
> +	RAIL_LDO(LDO8, ldo8, "in-ldo7-8", N, 800000, 3950000, 50000),
> +};
> +
> +static int max77620_regulator_probe(struct platform_device *pdev)
> +{
> +	struct max77620_chip *max77620_chip = dev_get_drvdata(pdev->dev.parent);
> +	struct max77620_regulator_info *regulator_info;
> +	struct device *dev = &pdev->dev;
> +	struct regulator_config config = { };
> +	struct max77620_regulator *pmic;
> +	int ret = 0;
> +	int id;
> +
> +	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
> +	if (!pmic)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pmic);
> +	pmic->max77620_chip = max77620_chip;
> +	pmic->dev = dev;
> +	if (!dev->of_node)
> +		dev->of_node = pdev->dev.parent->of_node;
> +
> +	regulator_info = (max77620_chip->id == MAX77620) ? max77620_regs_info :
> +				max20024_regs_info;
> +
> +	config.regmap = max77620_chip->rmap;
> +	config.dev = dev;
> +	config.driver_data = pmic;
> +
> +	for (id = 0; id < MAX77620_NUM_REGS; ++id) {
> +		struct regulator_dev *rdev;
> +		struct regulator_desc *rdesc;
> +
> +		if ((max77620_chip->id == MAX77620) &&
> +		    (id == MAX77620_REGULATOR_ID_SD4))
> +			continue;
> +
> +		rdesc = &regulator_info[id].desc;
> +		pmic->rinfo[id] = &max77620_regs_info[id];
> +		pmic->enable_power_mode[id] = MAX77620_POWER_MODE_NORMAL;
> +		pmic->rdesc[id] = rdesc;
> +
> +		ret = max77620_read_slew_rate(pmic, id);
> +		if (ret < 0)
> +			return ret;
> +
> +		rdev = devm_regulator_register(dev, rdesc, &config);
> +		if (IS_ERR(rdev)) {
> +			ret = PTR_ERR(rdev);
> +			dev_err(dev, "Regulator registration %s failed: %d\n",
> +				rdesc->name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int max77620_regulator_suspend(struct device *dev)
> +{
> +	struct max77620_regulator *pmic = dev_get_drvdata(dev);
> +	struct max77620_regulator_pdata *reg_pdata;
> +	struct max77620_regulator_info *rinfo;
> +	int id;
> +
> +	for (id = 0; id < MAX77620_NUM_REGS; ++id) {
> +		reg_pdata = &pmic->reg_pdata[id];
> +		rinfo = pmic->rinfo[id];
> +
> +		max77620_regulator_set_fps_slots(pmic, id, true);
> +		if (reg_pdata->suspend_fps_src < 0)
> +			continue;
> +
> +		max77620_regulator_set_fps_src(pmic, reg_pdata->suspend_fps_src,
> +					       id);
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_regulator_resume(struct device *dev)
> +{
> +	struct max77620_regulator *pmic = dev_get_drvdata(dev);
> +	struct max77620_regulator_pdata *reg_pdata;
> +	struct max77620_regulator_info *rinfo;
> +	int id;
> +
> +	for (id = 0; id < MAX77620_NUM_REGS; ++id) {
> +		reg_pdata = &pmic->reg_pdata[id];
> +		rinfo = pmic->rinfo[id];
> +
> +		max77620_regulator_set_fps_slots(pmic, id, false);
> +		if (reg_pdata->active_fps_src < 0)
> +			continue;
> +		max77620_regulator_set_fps_src(pmic, reg_pdata->active_fps_src,
> +					       id);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops max77620_regulator_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(max77620_regulator_suspend,
> +				max77620_regulator_resume)
> +};
> +
> +static const struct platform_device_id max77620_regulator_devtype[] = {
> +	{ .name = "max77620-pmic", },
> +	{ .name = "max20024-pmic", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, max77620_regulator_devtype);
> +
> +static struct platform_driver max77620_regulator_driver = {
> +	.probe = max77620_regulator_probe,
> +	.id_table = max77620_regulator_devtype,
> +	.driver = {
> +		.name = "max77620-pmic",
> +		.pm = &max77620_regulator_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(max77620_regulator_driver);
> +
> +MODULE_DESCRIPTION("MAX77620/MAX20024 regulator driver");
> +MODULE_AUTHOR("Mallikarjun Kasoju <mkasoju@nvidia.com>");
> +MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> +MODULE_ALIAS("platform:max77620-pmic");
> +MODULE_LICENSE("GPL v2");
> 

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
