Return-Path: <rtc-linux+bncBDKZNNNLXAHBBXOQ222AKGQETL6FNTI@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id ui7si8635629pab.0.2016.01.12.17.29.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 12 Jan 2016 17:29:01 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O0V00ME4AS8ZU90@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 13 Jan 2016 01:28:56 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V2 6/6] regulator: max77620: add regulator
 driver for max77620/max20024
To: Laxman Dewangan <ldewangan@nvidia.com>, robh+dt@kernel.org,
 pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
 lee.jones@linaro.org, broonie@kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com>
 <1452590273-16421-7-git-send-email-ldewangan@nvidia.com>
Cc: lgirdwood@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
 Mallikarjun Kasoju <mkasoju@nvidia.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <5695A854.60108@samsung.com>
Date: Wed, 13 Jan 2016 10:28:52 +0900
MIME-version: 1.0
In-reply-to: <1452590273-16421-7-git-send-email-ldewangan@nvidia.com>
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

On 12.01.2016 18:17, Laxman Dewangan wrote:
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
>  drivers/regulator/Kconfig              |   9 +
>  drivers/regulator/Makefile             |   1 +
>  drivers/regulator/max77620-regulator.c | 991 +++++++++++++++++++++++++++++++++
>  3 files changed, 1001 insertions(+)
>  create mode 100644 drivers/regulator/max77620-regulator.c
> 
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
> index 0000000..7c89573
> --- /dev/null
> +++ b/drivers/regulator/max77620-regulator.c
> @@ -0,0 +1,991 @@
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
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>

Do you need kernel.h?
mfd/core.h looks unused.

> +#include <linux/mfd/max77620.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/of.h>
> +#include <linux/regulator/of_regulator.h>
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
> +	bool glpm_enable;
> +	bool en2_ctrl_sd0;
> +	bool sd_fsrade_disable;
> +	bool disable_remote_sense_on_suspend;
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
> +	struct regulator_dev *rdev[MAX77620_NUM_REGS];

You don't need the rdev. You are not using it anyway.


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
> +static int max77620_regulator_get_fps_src(struct max77620_regulator *reg,
> +		 int id)
> +{
> +	struct max77620_regulator_info *rinfo = reg->rinfo[id];
> +	struct device *parent = reg->max77620_chip->dev;
> +	u8 val;
> +	int ret;
> +
> +	ret = max77620_reg_read(parent, MAX77620_PWR_SLAVE,
> +			rinfo->fps_addr, &val);
> +	if (ret < 0) {
> +		dev_err(reg->dev, "Reg 0x%02x read failed %d\n",
> +				rinfo->fps_addr, ret);
> +		return ret;
> +	}
> +
> +	return (val & MAX77620_FPS_SRC_MASK) >> MAX77620_FPS_SRC_SHIFT;
> +}
> +
> +static int max77620_regulator_set_fps_src(struct max77620_regulator *reg,
> +		int fps_src, int id)
> +{
> +	struct max77620_regulator_info *rinfo = reg->rinfo[id];
> +	struct device *parent = reg->max77620_chip->dev;
> +	u8 val;
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
> +		ret = max77620_reg_read(parent, MAX77620_PWR_SLAVE,
> +			rinfo->fps_addr, &val);
> +		if (ret < 0) {
> +			dev_err(reg->dev, "Reg 0x%02x read failed %d\n",
> +				rinfo->fps_addr, ret);
> +			return ret;
> +		}
> +		ret = (val & MAX77620_FPS_SRC_MASK) >> MAX77620_FPS_SRC_SHIFT;
> +		reg->active_fps_src[id] = ret;
> +		return 0;
> +
> +	default:
> +		dev_err(reg->dev, "Invalid FPS %d for regulator %d\n",
> +			fps_src, id);
> +		return -EINVAL;
> +	}
> +
> +	ret = max77620_reg_update(parent, MAX77620_PWR_SLAVE,
> +			rinfo->fps_addr, MAX77620_FPS_SRC_MASK,
> +			fps_src << MAX77620_FPS_SRC_SHIFT);
> +	if (ret < 0) {
> +		dev_err(reg->dev, "Reg 0x%02x update failed %d\n",
> +			rinfo->fps_addr, ret);
> +		return ret;
> +	}
> +	reg->active_fps_src[id] = fps_src;
> +
> +	return 0;
> +}
> +
> +static int max77620_regulator_set_fps_slots(struct max77620_regulator *reg,
> +			int id, bool is_suspend)
> +{
> +	struct max77620_regulator_pdata *rpdata = &reg->reg_pdata[id];
> +	struct max77620_regulator_info *rinfo = reg->rinfo[id];
> +	struct device *parent = reg->max77620_chip->dev;
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
> +		ret = max77620_reg_update(parent, MAX77620_PWR_SLAVE,
> +				rinfo->fps_addr, mask, val);
> +		if (ret < 0) {
> +			dev_err(reg->dev, "Reg 0x%02x update failed: %d\n",
> +				rinfo->fps_addr, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int max77620_regulator_set_power_mode(struct max77620_regulator *reg,
> +	int power_mode, int id)
> +{
> +	struct max77620_regulator_info *rinfo = reg->rinfo[id];
> +	int ret;

Could you put the 'ret' at the end of these variables?

> +	struct device *parent = reg->max77620_chip->dev;
> +	u8 mask = rinfo->power_mode_mask;
> +	u8 shift = rinfo->power_mode_shift;
> +	u8 addr;
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
> +	ret = max77620_reg_update(parent, MAX77620_PWR_SLAVE,
> +			addr, mask, power_mode << shift);
> +	if (ret < 0) {
> +		dev_err(reg->dev, "Regulator %d mode set failed: %d\n",
> +			id, ret);
> +		return ret;
> +	}
> +	reg->current_power_mode[id] = power_mode;
> +
> +	return ret;
> +}
> +
> +static int max77620_regulator_get_power_mode(struct max77620_regulator *reg,
> +			int id)
> +{
> +	struct max77620_regulator_info *rinfo = reg->rinfo[id];
> +	struct device *parent = reg->max77620_chip->dev;
> +	u8 val;

Another nit: 'val' after 'u8 addr'.

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
> +	ret = max77620_reg_read(parent, MAX77620_PWR_SLAVE, addr, &val);
> +	if (ret < 0) {
> +		dev_err(reg->dev, "Regulator %d: Reg 0x%02x read failed: %d\n",
> +			id, addr, ret);
> +		return ret;
> +	}
> +
> +	return (val & mask) >> shift;
> +}
> +
> +static int max77620_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct max77620_regulator *reg = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +	struct max77620_regulator_pdata *rpdata = &reg->reg_pdata[id];
> +
> +	if (reg->active_fps_src[id] != FPS_SRC_NONE)
> +		return 0;
> +
> +	if ((id == MAX77620_REGULATOR_ID_SD0) && rpdata->en2_ctrl_sd0)
> +		return 0;
> +
> +	return max77620_regulator_set_power_mode(reg,
> +			reg->enable_power_mode[id], id);
> +}
> +
> +static int max77620_regulator_disable(struct regulator_dev *rdev)
> +{
> +	struct max77620_regulator *reg = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +	struct max77620_regulator_pdata *rpdata = &reg->reg_pdata[id];
> +
> +	if (reg->active_fps_src[id] != FPS_SRC_NONE)
> +		return 0;
> +
> +	if ((id == MAX77620_REGULATOR_ID_SD0) && rpdata->en2_ctrl_sd0)
> +		return 0;
> +
> +	return max77620_regulator_set_power_mode(reg,
> +			MAX77620_POWER_MODE_DISABLE, id);
> +}
> +
> +static int max77620_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct max77620_regulator *reg = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +	struct max77620_regulator_pdata *rpdata = &reg->reg_pdata[id];
> +	int ret = 1;
> +
> +	if (reg->active_fps_src[id] != FPS_SRC_NONE)
> +		return 1;
> +
> +	if ((id == MAX77620_REGULATOR_ID_SD0) && rpdata->en2_ctrl_sd0)
> +		return 1;
> +
> +	ret = max77620_regulator_get_power_mode(reg, id);
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
> +				unsigned int mode)
> +{
> +	struct max77620_regulator *reg = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +	struct max77620_regulator_info *rinfo = reg->rinfo[id];
> +	struct max77620_regulator_pdata *rpdata = &reg->reg_pdata[id];
> +	struct device *parent = reg->max77620_chip->dev;
> +	int power_mode;
> +	int ret;
> +	bool fpwm = false;
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
> +		if (rpdata->glpm_enable)
> +			power_mode = MAX77620_POWER_MODE_GLPM;
> +		else
> +			power_mode = MAX77620_POWER_MODE_LPM;
> +		break;
> +
> +	default:
> +		dev_err(reg->dev, "Regulator %d mode %d is invalid\n",
> +			id, mode);
> +		return -EINVAL;
> +	}
> +
> +	if (rinfo->type != MAX77620_REGULATOR_TYPE_SD)
> +		goto skip_fpwm;
> +
> +	if (fpwm)
> +		ret = max77620_reg_update(parent, MAX77620_PWR_SLAVE,
> +				rinfo->cfg_addr, MAX77620_SD_FPWM_MASK,
> +				MAX77620_SD_FPWM_MASK);
> +	else
> +		ret = max77620_reg_update(parent, MAX77620_PWR_SLAVE,
> +				rinfo->cfg_addr, MAX77620_SD_FPWM_MASK, 0);

Instead something like:

u8 fwpm_val;
if (fpwm)
        fwpm_val = MAX77620_SD_FPWM_MASK;
else
        fwpm_val = 0;

max77620_reg_update(..., fwpm_val);

You could actually combine it with 'fwpm' variable (replacing it) but I
am not sure if that would make the code more readable. But definitely
one place of calling max77620_reg_update() would be nice.

> +	if (ret < 0) {
> +		dev_err(reg->dev, "Reg 0x%02x update failed: %d\n",
> +				rinfo->cfg_addr, ret);
> +		return ret;
> +	}
> +	rpdata->current_mode = mode;
> +
> +skip_fpwm:
> +	ret = max77620_regulator_set_power_mode(reg, power_mode, id);
> +	if (ret < 0)

You are not reverting the changes made before - setting the fwpm. The
entire operation is not atomic. I am not sure whether that is important
or not... up to you actually.

> +		return ret;
> +
> +	reg->enable_power_mode[id] = power_mode;
> +
> +	return 0;
> +}
> +
> +static unsigned int max77620_regulator_get_mode(struct regulator_dev *rdev)
> +{
> +	struct max77620_regulator *reg = rdev_get_drvdata(rdev);
> +	struct device *parent = reg->max77620_chip->dev;
> +	int id = rdev_get_id(rdev);
> +	struct max77620_regulator_info *rinfo = reg->rinfo[id];
> +	int fpwm = 0;
> +	int ret;
> +	int pm_mode, reg_mode;
> +	u8 val;
> +
> +	ret = max77620_regulator_get_power_mode(reg, id);
> +	if (ret < 0)
> +		return 0;
> +
> +	pm_mode = ret;
> +
> +	if (rinfo->type == MAX77620_REGULATOR_TYPE_SD) {
> +		ret = max77620_reg_read(parent, MAX77620_PWR_SLAVE,
> +				rinfo->cfg_addr, &val);
> +		if (ret < 0) {
> +			dev_err(reg->dev, "Reg 0x%02x read failed: %d\n",
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
> +			int ramp_delay)
> +{
> +	struct max77620_regulator *reg = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +	struct max77620_regulator_info *rinfo = reg->rinfo[id];
> +	struct device *parent = reg->max77620_chip->dev;
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
> +	ret = max77620_reg_update(parent, MAX77620_PWR_SLAVE,
> +				rinfo->cfg_addr, mask, val);
> +	if (ret < 0)
> +		dev_err(reg->dev, "Reg 0x%02x update failed: %d\n",
> +				rinfo->cfg_addr, ret);
> +
> +	return ret;
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
> +	[MAX77620_REGULATOR_ID_##_id] = {			\
> +		.type = MAX77620_REGULATOR_TYPE_SD,			\
> +		.volt_mask = MAX77620_##_volt_mask##_VOLT_MASK,	\
> +		.volt_addr = MAX77620_REG_##_id,		\
> +		.cfg_addr = MAX77620_REG_##_id##_CFG,		\
> +		.fps_addr = MAX77620_REG_FPS_##_id,		\
> +		.remote_sense_addr = _rs_add,			\
> +		.remote_sense_mask = MAX77620_SD_CNF2_ROVS_EN_##_rs_mask, \
> +		.min_uV = _min_uV,				\
> +		.max_uV = _max_uV,				\
> +		.step_uV = _step_uV,				\
> +		.power_mode_mask = MAX77620_SD_POWER_MODE_MASK,		\
> +		.power_mode_shift = MAX77620_SD_POWER_MODE_SHIFT,	\
> +		.desc = {					\
> +			.name = max77620_rails(_name),		\
> +			.supply_name = _sname,			\
> +			.id = MAX77620_REGULATOR_ID_##_id,	\
> +			.ops = &max77620_regulator_ops,		\
> +			.n_voltages = ((_max_uV - _min_uV) / _step_uV) + 1, \
> +			.min_uV = _min_uV,	\
> +			.uV_step = _step_uV,	\
> +			.enable_time = 500,	\
> +			.vsel_mask = MAX77620_##_volt_mask##_VOLT_MASK,	\
> +			.vsel_reg = MAX77620_REG_##_id,	\
> +			.type = REGULATOR_VOLTAGE,	\
> +		},						\
> +	}
> +
> +#define RAIL_LDO(_id, _name, _sname, _type, _min_uV, _max_uV, _step_uV) \
> +	[MAX77620_REGULATOR_ID_##_id] = {			\
> +		.type = MAX77620_REGULATOR_TYPE_LDO_##_type,		\
> +		.volt_mask = MAX77620_LDO_VOLT_MASK,			\
> +		.volt_addr = MAX77620_REG_##_id##_CFG,		\
> +		.cfg_addr = MAX77620_REG_##_id##_CFG2,		\
> +		.fps_addr = MAX77620_REG_FPS_##_id,		\
> +		.remote_sense_addr = 0xFF,			\
> +		.min_uV = _min_uV,				\
> +		.max_uV = _max_uV,				\
> +		.step_uV = _step_uV,				\
> +		.power_mode_mask = MAX77620_LDO_POWER_MODE_MASK,	\
> +		.power_mode_shift = MAX77620_LDO_POWER_MODE_SHIFT,	\
> +		.desc = {					\
> +			.name = max77620_rails(_name),		\
> +			.supply_name = _sname,			\
> +			.id = MAX77620_REGULATOR_ID_##_id,	\
> +			.ops = &max77620_regulator_ops,		\
> +			.n_voltages = ((_max_uV - _min_uV) / _step_uV) + 1, \
> +			.min_uV = _min_uV,	\
> +			.uV_step = _step_uV,	\
> +			.enable_time = 500,	\

Here and before please put the line concatenator '\' aligned with
previous, so:
+			.min_uV = _min_uV,			\


> +			.vsel_mask = MAX77620_LDO_VOLT_MASK,	\
> +			.vsel_reg = MAX77620_REG_##_id##_CFG, \
> +			.type = REGULATOR_VOLTAGE,		\
> +		},						\
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
> +static struct of_regulator_match max77620_regulator_matches[] = {
> +	{ .name = "sd0", },
> +	{ .name = "sd1", },
> +	{ .name = "sd2", },
> +	{ .name = "sd3", },
> +	{ .name = "sd4", },
> +	{ .name = "ldo0", },
> +	{ .name = "ldo1", },
> +	{ .name = "ldo2", },
> +	{ .name = "ldo3", },
> +	{ .name = "ldo4", },
> +	{ .name = "ldo5", },
> +	{ .name = "ldo6", },
> +	{ .name = "ldo7", },
> +	{ .name = "ldo8", },
> +};
> +
> +static int max77620_regulator_preinit(struct max77620_regulator *reg, int id)
> +{
> +	struct max77620_regulator_pdata *rpdata = &reg->reg_pdata[id];
> +	struct max77620_regulator_info *rinfo = reg->rinfo[id];
> +	struct device *parent = reg->max77620_chip->dev;
> +	struct regulator_init_data *ridata = reg->reg_pdata[id].reg_idata;
> +	struct regulator_desc *rdesc = &max77620_regs_info[id].desc;
> +	struct device *dev = reg->dev;
> +	int init_uv;
> +	u8 val, mask, rval;
> +	int slew_rate;
> +	int ret;
> +
> +	if (!ridata)
> +		return 0;
> +
> +	/* Update power mode */
> +	ret = max77620_regulator_get_power_mode(reg, id);
> +	if (ret < 0)
> +		return ret;
> +
> +	reg->current_power_mode[id] = ret;
> +	reg->enable_power_mode[id] = MAX77620_POWER_MODE_NORMAL;
> +
> +	if (rpdata->active_fps_src == FPS_SRC_DEF) {
> +		ret = max77620_regulator_get_fps_src(reg, id);
> +		if (ret < 0)
> +			return ret;
> +		rpdata->active_fps_src = ret;
> +	}
> +
> +	/*
> +	 * If rails are externally control of FPS control then enable it
> +	 * always.
> +	 */
> +	if ((rpdata->active_fps_src != FPS_SRC_NONE) &&
> +		(reg->current_power_mode[id] != reg->enable_power_mode[id])) {
> +		ret = max77620_regulator_set_power_mode(reg,
> +				reg->enable_power_mode[id], id);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Enable rail before changing FPS to NONE to avoid glitch */
> +	if (ridata && ridata->constraints.boot_on &&
> +		(rpdata->active_fps_src == FPS_SRC_NONE)) {
> +		init_uv = ridata->constraints.min_uV;
> +		if (init_uv && (init_uv == ridata->constraints.max_uV)) {
> +			val = (init_uv - rdesc->min_uV) / rdesc->uV_step;
> +			ret = max77620_reg_update(parent, MAX77620_PWR_SLAVE,
> +					rdesc->vsel_reg, rdesc->vsel_mask, val);
> +			if (ret < 0) {
> +				dev_err(dev, "Reg 0x%02x update failed: %d\n",
> +					rdesc->vsel_reg, ret);
> +				return ret;
> +			}
> +		}
> +
> +		ret = max77620_regulator_set_power_mode(reg,
> +				reg->enable_power_mode[id], id);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = max77620_regulator_set_fps_src(reg, rpdata->active_fps_src, id);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = max77620_regulator_set_fps_slots(reg, id, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (rinfo->type) {
> +	case MAX77620_REGULATOR_TYPE_SD:
> +		ret = max77620_reg_read(parent, MAX77620_PWR_SLAVE,
> +				rinfo->cfg_addr, &rval);
> +		if (ret < 0) {
> +			dev_err(reg->dev, "Register 0x%02x read failed: %d\n",
> +					rinfo->cfg_addr, ret);
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
> +
> +		mask = MAX77620_SD_FSRADE_MASK;
> +		val = 0;
> +		if (rpdata->sd_fsrade_disable)
> +			val |= MAX77620_SD_FSRADE_MASK;
> +
> +		ret = max77620_reg_update(parent, MAX77620_PWR_SLAVE,
> +				rinfo->cfg_addr, mask, val);
> +		if (ret < 0) {
> +			dev_err(reg->dev, "Reg 0x%02x update failed: %d\n",
> +				rinfo->cfg_addr, ret);
> +			return ret;
> +		}
> +		break;
> +	default:
> +		ret = max77620_reg_read(parent, MAX77620_PWR_SLAVE,
> +				rinfo->cfg_addr, &rval);
> +		if (ret < 0) {
> +			dev_err(reg->dev, "Register 0x%02x read failed: %d\n",
> +					rinfo->cfg_addr, ret);
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
> +	if ((id == MAX77620_REGULATOR_ID_SD0) && rpdata->en2_ctrl_sd0) {
> +		ret = max77620_regulator_set_power_mode(reg,
> +				MAX77620_POWER_MODE_NORMAL, id);
> +		if (!ret)
> +			ret = max77620_regulator_set_fps_src(reg, FPS_SRC_0,
> +					id);
> +	}
> +
> +	return ret;
> +}
> +
> +static int max77620_get_regulator_dt_data(struct platform_device *pdev,
> +		struct max77620_regulator *max77620_regs)
> +{
> +	struct device_node *np;
> +	u32 prop;
> +	int id;
> +	int ret;
> +
> +	np = of_get_child_by_name(pdev->dev.parent->of_node, "regulators");
> +	if (!np) {
> +		dev_err(&pdev->dev, "Device is not having regulators node\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_regulator_match(&pdev->dev, np, max77620_regulator_matches,
> +			ARRAY_SIZE(max77620_regulator_matches));

Why not using 'regulators_node' and getting rid of this and some code
below? If you need to parse custom regulator properties use 'of_parse_cb'.

> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "regulator node parsing failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (id = 0; id < ARRAY_SIZE(max77620_regulator_matches); ++id) {
> +		struct device_node *reg_node;
> +		struct max77620_regulator_pdata *reg_pdata =
> +					&max77620_regs->reg_pdata[id];
> +
> +		reg_node = max77620_regulator_matches[id].of_node;
> +		reg_pdata->reg_idata = max77620_regulator_matches[id].init_data;
> +
> +		if (!reg_pdata->reg_idata)
> +			continue;
> +
> +		reg_pdata->glpm_enable = of_property_read_bool(reg_node,
> +					"maxim,enable-group-low-power");
> +
> +		reg_pdata->en2_ctrl_sd0 = of_property_read_bool(reg_node,
> +					"maxim,enable-sd0-en2-control");
> +
> +		reg_pdata->sd_fsrade_disable = of_property_read_bool(reg_node,
> +					"maxim,disable-active-discharge");
> +
> +		reg_pdata->disable_remote_sense_on_suspend =
> +				of_property_read_bool(reg_node,
> +				"maxim,disable-remote-sense-on-suspend");
> +
> +		ret = of_property_read_u32(reg_node,
> +				"maxim,active-fps-source", &prop);
> +		if (!ret)
> +			reg_pdata->active_fps_src = prop;
> +		else
> +			reg_pdata->active_fps_src = FPS_SRC_DEF;
> +
> +		ret = of_property_read_u32(reg_node,
> +				"maxim,active-fps-power-up-slot", &prop);
> +		if (!ret)
> +			reg_pdata->active_fps_pu_slot = prop;
> +		else
> +			reg_pdata->active_fps_pu_slot = -1;
> +
> +		ret = of_property_read_u32(reg_node,
> +				"maxim,active-fps-power-down-slot", &prop);
> +		if (!ret)
> +			reg_pdata->active_fps_pd_slot = prop;
> +		else
> +			reg_pdata->active_fps_pd_slot = -1;
> +
> +		reg_pdata->suspend_fps_src = -1;
> +		reg_pdata->suspend_fps_pu_slot = -1;
> +		reg_pdata->suspend_fps_pd_slot = -1;
> +		ret = of_property_read_u32(reg_node,
> +				"maxim,suspend-fps-source", &prop);
> +		if (!ret)
> +			reg_pdata->suspend_fps_src = prop;
> +
> +		ret = of_property_read_u32(reg_node,
> +				"maxim,suspend-fps-power-up-slot", &prop);
> +		if (!ret)
> +			reg_pdata->suspend_fps_pu_slot = prop;
> +
> +		ret = of_property_read_u32(reg_node,
> +				"maxim,suspend-fps-power-down-slot", &prop);
> +		if (!ret)
> +			reg_pdata->suspend_fps_pd_slot = prop;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_regulator_probe(struct platform_device *pdev)
> +{
> +	struct max77620_chip *max77620_chip = dev_get_drvdata(pdev->dev.parent);
> +	struct regulator_desc *rdesc;

This is should be local to the for-loop,

> +	struct max77620_regulator *pmic;
> +	struct regulator_config config = { };
> +	struct max77620_regulator_info *regulator_info;
> +	int ret = 0;
> +	int id;
> +
> +	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
> +	if (!pmic)
> +		return -ENOMEM;
> +
> +	max77620_get_regulator_dt_data(pdev, pmic);
> +
> +	platform_set_drvdata(pdev, pmic);
> +	pmic->max77620_chip = max77620_chip;
> +	pmic->dev = &pdev->dev;
> +
> +	if (max77620_chip->id == MAX77620)
> +		regulator_info = max77620_regs_info;
> +	else
> +		regulator_info = max20024_regs_info;
> +
> +	for (id = 0; id < MAX77620_NUM_REGS; ++id) {
> +
> +		if ((max77620_chip->id == MAX77620) &&
> +			(id == MAX77620_REGULATOR_ID_SD4))
> +			continue;
> +
> +		rdesc = &regulator_info[id].desc;
> +		pmic->rinfo[id] = &max77620_regs_info[id];
> +		pmic->enable_power_mode[id] = MAX77620_POWER_MODE_NORMAL;
> +
> +		config.regmap = max77620_chip->rmap[MAX77620_PWR_SLAVE];
> +		config.dev = &pdev->dev;
> +		config.init_data = pmic->reg_pdata[id].reg_idata;
> +		config.driver_data = pmic;

Don't do it for each regulator. Set the config.regmap/dev/driver_data
once before the loop.

Each regulator_register() makes a copy of passed 'config'.

> +		config.of_node = max77620_regulator_matches[id].of_node;
> +
> +		ret = max77620_regulator_preinit(pmic, id);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "Preinit regualtor %s failed: %d\n",
> +				rdesc->name, ret);
> +			return ret;
> +		}
> +
> +		pmic->rdev[id] = devm_regulator_register(&pdev->dev,
> +						rdesc, &config);
> +		if (IS_ERR(pmic->rdev[id])) {
> +			ret = PTR_ERR(pmic->rdev[id]);
> +			dev_err(&pdev->dev, "Reg registeration %s failed: %d\n",

s/registeration/init/ (or registration?)

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
> +	struct device *parent = pmic->dev->parent;
> +	int id;
> +	int ret;
> +
> +	for (id = 0; id < MAX77620_NUM_REGS; ++id) {
> +		reg_pdata = &pmic->reg_pdata[id];
> +		rinfo = pmic->rinfo[id];
> +		if (!reg_pdata || !rinfo)
> +			continue;
> +
> +		if (reg_pdata->disable_remote_sense_on_suspend &&
> +			(rinfo->remote_sense_addr != 0xFF)) {
> +			ret = max77620_reg_update(parent, MAX77620_PWR_SLAVE,
> +				rinfo->remote_sense_addr,
> +				rinfo->remote_sense_mask, 0);
> +			if (ret < 0)
> +				dev_err(dev, "Reg 0x%02x update failed: %d\n",
> +					rinfo->remote_sense_addr, ret);
> +		}
> +
> +		max77620_regulator_set_fps_slots(pmic, id, true);
> +		if (reg_pdata->suspend_fps_src >= 0)
> +			max77620_regulator_set_fps_src(pmic,
> +				reg_pdata->suspend_fps_src, id);
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
> +	struct device *parent = pmic->dev->parent;
> +	int id;
> +	int ret;
> +
> +	for (id = 0; id < MAX77620_NUM_REGS; ++id) {
> +		reg_pdata = &pmic->reg_pdata[id];
> +		rinfo = pmic->rinfo[id];
> +		if (!reg_pdata || !rinfo)
> +			continue;
> +
> +		if (reg_pdata->disable_remote_sense_on_suspend &&
> +			(rinfo->remote_sense_addr != 0xFF)) {
> +			ret = max77620_reg_update(parent, MAX77620_PWR_SLAVE,
> +				rinfo->remote_sense_addr,
> +				rinfo->remote_sense_mask,
> +				rinfo->remote_sense_mask);
> +			if (ret < 0)
> +				dev_err(dev, "Reg 0x%02x update failed: %d\n",
> +					rinfo->remote_sense_addr, ret);
> +		}
> +
> +		max77620_regulator_set_fps_slots(pmic, id, false);
> +		if (reg_pdata->active_fps_src >= 0)
> +			max77620_regulator_set_fps_src(pmic,
> +				reg_pdata->active_fps_src, id);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops max77620_regulator_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(max77620_regulator_suspend,
> +			max77620_regulator_resume)
> +};
> +
> +static const struct platform_device_id max77620_regulator_devtype[] = {
> +	{
> +		.name = "max77620-pmic",
> +	},
> +	{
> +		.name = "max20024-pmic",
> +	},

Sentinel.
MODULE_DEVICE_TABLE

Best regards,
Krzysztof

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
