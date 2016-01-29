Return-Path: <rtc-linux+bncBDA7X7F2WUEBBHGXVS2QKGQEXGQPZNA@googlegroups.com>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com. [2a00:1450:400c:c09::229])
        by gmr-mx.google.com with ESMTPS id q64si189122wmg.0.2016.01.29.01.06.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2016 01:06:36 -0800 (PST)
Received: by mail-wm0-x229.google.com with SMTP id r129so59091728wmr.0
        for <rtc-linux@googlegroups.com>; Fri, 29 Jan 2016 01:06:36 -0800 (PST)
Date: Fri, 29 Jan 2016 09:06:32 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
	k.kozlowski@samsung.com, Chaitanya Bandi <bandik@nvidia.com>,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V6 2/8] mfd: max77620: add core driver for MAX77620/MAX20024
Message-ID: <20160129090632.GS3368@x1>
References: <1453988274-28052-1-git-send-email-ldewangan@nvidia.com>
 <1453988274-28052-3-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1453988274-28052-3-git-send-email-ldewangan@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, 28 Jan 2016, Laxman Dewangan wrote:

> MAX77620/MAX20024 are Power Management IC from the MAXIM.
> It supports RTC, multiple GPIOs, multiple DCDC and LDOs,
> watchdog, clock etc.
>=20
> Add MFD drier to provides common support for accessing the
> device; additional drivers is developed on respected subsystem
> in order to use the functionality of the device.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>
> Signed-off-by: Mallikarjun Kasoju <mkasoju@nvidia.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
> Changes from V1:
> - Code cleanups per review from V1.=20
> - Move register acccess APIs from header to c file.
> - Remove some of non required variable, remove duplication in error messa=
ge
>  and simplify some of function implementation.
> - Register RTC driver such that it can get the regmap handle form parent =
device
>=20
> Changes from V2:
> - Run coccicheck and checkpatch in strict mode for the alignment.
> - Drop RTC driver and its i2c client registration.
>=20
> Changes from V3: =20
> - Change all sys initcall to module driver.        =20
> - change the max77620_read argument to unisgned int from u8.
>=20
> Changes from V4: =20
> - Take care of fps nodes.
> - Drop the battery charger and low battery binding and related code as
>   it need to go on power driver.
> Changes from V5: =20
> -None
>=20
>  drivers/mfd/Kconfig          |  15 +
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77620.c       | 727 +++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/max77620.h | 406 ++++++++++++++++++++++++
>  4 files changed, 1149 insertions(+)
>  create mode 100644 drivers/mfd/max77620.c
>  create mode 100644 include/linux/mfd/max77620.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 9ca66de..e5ad974 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -492,6 +492,21 @@ config MFD_MAX14577
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
> =20
> +config MFD_MAX77620
> +	bool "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
> +	depends on I2C=3Dy
> +	depends on OF
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	select IRQ_DOMAIN
> +	help
> +	  Say yes here to add support for Maxim Semiconductor MAX77620 and
> +	  MAX20024 which are Power Management IC with General purpose pins,
> +	  RTC, regulators, clock generator, watchdog etc. This driver
> +	  provides common support for accessing the device; additional drivers
> +	  must be enabled in order to use the functionality of the device.
> +
>  config MFD_MAX77686
>  	bool "Maxim Semiconductor MAX77686/802 PMIC Support"
>  	depends on I2C=3Dy
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 0f230a6..97910ed 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -123,6 +123,7 @@ obj-$(CONFIG_MFD_DA9063)	+=3D da9063.o
>  obj-$(CONFIG_MFD_DA9150)	+=3D da9150-core.o
> =20
>  obj-$(CONFIG_MFD_MAX14577)	+=3D max14577.o
> +obj-$(CONFIG_MFD_MAX77620)	+=3D max77620.o
>  obj-$(CONFIG_MFD_MAX77686)	+=3D max77686.o
>  obj-$(CONFIG_MFD_MAX77693)	+=3D max77693.o
>  obj-$(CONFIG_MFD_MAX77843)	+=3D max77843.o
> diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
> new file mode 100644
> index 0000000..49318c3
> --- /dev/null
> +++ b/drivers/mfd/max77620.c
> @@ -0,0 +1,727 @@
> +/*
> + * Maxim MAX77620 MFD Driver
> + *
> + * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
> + *
> + * Author:
> + *	Laxman Dewangan <ldewangan@nvidia.com>
> + *	Chaitanya Bandi <bandik@nvidia.com>
> + *	Mallikarjun Kasoju <mkasoju@nvidia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + */

Can you use the shorter version?

> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/core.h>
> +#include <linux/interrupt.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/max77620.h>

Alphabetical.

> +static const char *of_max77620_fps_node_name[MAX77620_FPS_COUNT] =3D {
> +	"fps0",
> +	"fps1",
> +	"fps2"
> +};

No need for this arrray.  Just use '"fps%d", i' in the for loop below.

> +static struct resource gpio_resources[] =3D {
> +	{
> +		.start	=3D MAX77620_IRQ_TOP_GPIO,
> +		.end	=3D MAX77620_IRQ_TOP_GPIO,
> +		.flags  =3D IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct resource power_resources[] =3D {
> +	{
> +		.start	=3D MAX77620_IRQ_LBT_MBATLOW,
> +		.end	=3D MAX77620_IRQ_LBT_MBATLOW,
> +		.flags  =3D IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct resource rtc_resources[] =3D {
> +	{
> +		.start	=3D MAX77620_IRQ_TOP_RTC,
> +		.end	=3D MAX77620_IRQ_TOP_RTC,
> +		.flags  =3D IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct resource thermal_resources[] =3D {
> +	{
> +		.start	=3D MAX77620_IRQ_LBT_TJALRM1,
> +		.end	=3D MAX77620_IRQ_LBT_TJALRM1,
> +		.flags  =3D IORESOURCE_IRQ,
> +	},
> +	{
> +		.start	=3D MAX77620_IRQ_LBT_TJALRM2,
> +		.end	=3D MAX77620_IRQ_LBT_TJALRM2,
> +		.flags  =3D IORESOURCE_IRQ,
> +	}
> +};

Simplify all of these by using the DEFINE_RES_* defines.

> +static const struct regmap_irq max77620_top_irqs[] =3D {
> +	[MAX77620_IRQ_TOP_GLBL] =3D {
> +		.mask =3D MAX77620_IRQ_TOP_GLBL_MASK,
> +		.reg_offset =3D 0,
> +	},
> +	[MAX77620_IRQ_TOP_SD] =3D {
> +		.mask =3D MAX77620_IRQ_TOP_SD_MASK,
> +		.reg_offset =3D 0,
> +	},
> +	[MAX77620_IRQ_TOP_LDO] =3D {
> +		.mask =3D MAX77620_IRQ_TOP_LDO_MASK,
> +		.reg_offset =3D 0,
> +	},
> +	[MAX77620_IRQ_TOP_GPIO] =3D {
> +		.mask =3D MAX77620_IRQ_TOP_GPIO_MASK,
> +		.reg_offset =3D 0,
> +	},
> +	[MAX77620_IRQ_TOP_RTC] =3D {
> +		.mask =3D MAX77620_IRQ_TOP_RTC_MASK,
> +		.reg_offset =3D 0,
> +	},
> +	[MAX77620_IRQ_TOP_32K] =3D {
> +		.mask =3D MAX77620_IRQ_TOP_32K_MASK,
> +		.reg_offset =3D 0,
> +	},
> +	[MAX77620_IRQ_TOP_ONOFF] =3D {
> +		.mask =3D MAX77620_IRQ_TOP_ONOFF_MASK,
> +		.reg_offset =3D 0,
> +	},
> +
> +	[MAX77620_IRQ_LBT_MBATLOW] =3D {
> +		.mask =3D MAX77620_IRQ_LBM_MASK,
> +		.reg_offset =3D 1,
> +	},
> +	[MAX77620_IRQ_LBT_TJALRM1] =3D {
> +		.mask =3D MAX77620_IRQ_TJALRM1_MASK,
> +		.reg_offset =3D 1,
> +	},
> +	[MAX77620_IRQ_LBT_TJALRM2] =3D {
> +		.mask =3D MAX77620_IRQ_TJALRM2_MASK,
> +		.reg_offset =3D 1,
> +	},
> +
> +};

Please simply by using REGMAP_IRQ_REG().

> +#define MAX77620_SUB_MODULE_RES(_name, _id)			\
> +	[_id] =3D {						\
> +		.name =3D "max77620-"#_name,			\
> +		.num_resources	=3D ARRAY_SIZE(_name##_resources), \
> +		.resources	=3D &_name##_resources[0],	\
> +		.id =3D _id,					\
> +	}
> +
> +#define MAX20024_SUB_MODULE_RES(_name, _id)			\
> +	[_id] =3D {						\
> +		.name =3D "max20024-"#_name,			\
> +		.num_resources	=3D ARRAY_SIZE(_name##_resources), \
> +		.resources	=3D &_name##_resources[0],	\
> +		.id =3D _id,					\
> +	}
> +
> +#define MAX77620_SUB_MODULE_NO_RES(_name, _id)			\
> +	[_id] =3D {						\
> +		.name =3D "max77620-"#_name,			\
> +		.id =3D _id,					\
> +	}
> +
> +#define MAX20024_SUB_MODULE_NO_RES(_name, _id)			\
> +	[_id] =3D {						\
> +		.name =3D "max20024-"#_name,			\
> +		.id =3D _id,					\
> +	}

I don't want people hand-rolling this stuff.  If it's useful to you,
it's useful to others, so great a generic implementation that lives in
the kernel headers directory.

> +static struct mfd_cell max77620_children[] =3D {
> +	MAX77620_SUB_MODULE_NO_RES(pinctrl, 0),
> +	MAX77620_SUB_MODULE_RES(gpio, 1),
> +	MAX77620_SUB_MODULE_NO_RES(pmic, 2),
> +	MAX77620_SUB_MODULE_RES(rtc, 3),
> +	MAX77620_SUB_MODULE_RES(power, 4),
> +	MAX77620_SUB_MODULE_NO_RES(wdt, 5),
> +	MAX77620_SUB_MODULE_NO_RES(clk, 6),
> +	MAX77620_SUB_MODULE_RES(thermal, 7),

For what purpose are you id'ing these manually?

> +};
> +
> +static struct mfd_cell max20024_children[] =3D {
> +	MAX20024_SUB_MODULE_NO_RES(pinctrl, 0),
> +	MAX20024_SUB_MODULE_RES(gpio, 1),
> +	MAX20024_SUB_MODULE_NO_RES(pmic, 2),
> +	MAX20024_SUB_MODULE_RES(rtc, 3),
> +	MAX77620_SUB_MODULE_RES(power, 4),
> +	MAX20024_SUB_MODULE_NO_RES(wdt, 5),
> +	MAX20024_SUB_MODULE_NO_RES(clk, 6),
> +};
> +
> +struct max77620_sub_modules {
> +	struct mfd_cell *cells;
> +	int ncells;
> +	u32 id;

Do you have any way of interrogating the device for it's ID i.e. can
you obtain this dynamically?

> +};
> +
> +static const struct max77620_sub_modules max77620_cells =3D {
> +	.cells =3D max77620_children,
> +	.ncells =3D ARRAY_SIZE(max77620_children),
> +	.id =3D MAX77620,
> +};
> +
> +static const struct max77620_sub_modules  max20024_cells =3D {
> +	.cells =3D max20024_children,
> +	.ncells =3D ARRAY_SIZE(max20024_children),
> +	.id =3D MAX20024,
> +};
> +
> +static struct regmap_irq_chip max77620_top_irq_chip =3D {
> +	.name =3D "max77620-top",
> +	.irqs =3D max77620_top_irqs,
> +	.num_irqs =3D ARRAY_SIZE(max77620_top_irqs),
> +	.num_regs =3D 2,
> +	.status_base =3D MAX77620_REG_IRQTOP,
> +	.mask_base =3D MAX77620_REG_IRQTOPM,
> +};
> +
> +static const struct regmap_range max77620_readable_ranges[] =3D {
> +	regmap_reg_range(MAX77620_REG_CNFGGLBL1, MAX77620_REG_DVSSD4),
> +};
> +
> +static const struct regmap_access_table max77620_readable_table =3D {
> +	.yes_ranges =3D max77620_readable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(max77620_readable_ranges),
> +};
> +
> +static const struct regmap_range max20024_readable_ranges[] =3D {
> +	regmap_reg_range(MAX77620_REG_CNFGGLBL1, MAX77620_REG_DVSSD4),
> +	regmap_reg_range(MAX20024_REG_MAX_ADD, MAX20024_REG_MAX_ADD),
> +};
> +
> +static const struct regmap_access_table max20024_readable_table =3D {
> +	.yes_ranges =3D max20024_readable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(max20024_readable_ranges),
> +};
> +
> +static const struct regmap_range max77620_writable_ranges[] =3D {
> +	regmap_reg_range(MAX77620_REG_CNFGGLBL1, MAX77620_REG_DVSSD4),
> +};
> +
> +static const struct regmap_access_table max77620_writable_table =3D {
> +	.yes_ranges =3D max77620_writable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(max77620_writable_ranges),
> +};
> +
> +static const struct regmap_range max77620_cacheable_ranges[] =3D {
> +	regmap_reg_range(MAX77620_REG_SD0_CFG, MAX77620_REG_LDO_CFG3),
> +	regmap_reg_range(MAX77620_REG_FPS_CFG0, MAX77620_REG_FPS_SD3),
> +};
> +
> +static const struct regmap_access_table max77620_volatile_table =3D {
> +	.no_ranges =3D max77620_cacheable_ranges,
> +	.n_no_ranges =3D ARRAY_SIZE(max77620_cacheable_ranges),
> +};
> +
> +static const struct regmap_config max77620_regmap_config =3D {
> +	.name =3D "power-slave",
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX77620_REG_DVSSD4 + 1,
> +	.cache_type =3D REGCACHE_RBTREE,
> +	.rd_table =3D &max77620_readable_table,
> +	.wr_table =3D &max77620_writable_table,
> +	.volatile_table =3D &max77620_volatile_table,
> +};
> +
> +static const struct regmap_config max20024_regmap_config =3D {
> +	.name =3D "power-slave",
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX20024_REG_MAX_ADD + 1,
> +	.cache_type =3D REGCACHE_RBTREE,
> +	.rd_table =3D &max20024_readable_table,
> +	.wr_table =3D &max77620_writable_table,
> +	.volatile_table =3D &max77620_volatile_table,
> +};
> +
> +int max77620_irq_get_virq(struct device *dev, int irq)
> +{
> +	struct max77620_chip *chip =3D dev_get_drvdata(dev);
> +
> +	return regmap_irq_get_virq(chip->top_irq_data, irq);
> +}
> +EXPORT_SYMBOL_GPL(max77620_irq_get_virq);
> +
> +int max77620_reg_write(struct device *dev, unsigned int reg, unsigned in=
t val)
> +{
> +	struct max77620_chip *chip =3D dev_get_drvdata(dev);
> +
> +	return regmap_write(chip->rmap, reg, val);
> +}
> +EXPORT_SYMBOL_GPL(max77620_reg_write);
> +
> +int max77620_reg_read(struct device *dev, unsigned int reg, unsigned int=
 *val)
> +{
> +	struct max77620_chip *chip =3D dev_get_drvdata(dev);
> +
> +	return regmap_read(chip->rmap, reg, val);
> +}
> +EXPORT_SYMBOL_GPL(max77620_reg_read);
> +
> +int max77620_reg_update(struct device *dev, unsigned int reg,
> +			unsigned int mask, unsigned int val)
> +{
> +	struct max77620_chip *chip =3D dev_get_drvdata(dev);
> +
> +	return regmap_update_bits(chip->rmap, reg, mask, val);
> +}
> +EXPORT_SYMBOL_GPL(max77620_reg_update);

All of the above look look look abstraction for the sake of
abstraction.  Why aren't you ing the regmap_ calls from the child
devices?

> +static int max77620_get_fps_period_reg_value(struct max77620_chip *chip,
> +					     int tperiod)
> +{
> +	int base_fps_time =3D (chip->id =3D=3D MAX20024) ? 20 : 40;
> +	int x, i;
> +
> +	for (i =3D 0; i < 0x7; ++i) {
> +		x =3D base_fps_time * BIT(i);
> +		if (x >=3D tperiod)
> +			return i;
> +	}
> +
> +	return i;
> +}
> +
> +static int max77620_config_fps(struct max77620_chip *chip,
> +			       struct device_node *fps_np)
> +{
> +	struct device *dev =3D chip->dev;
> +	unsigned int mask =3D 0, config =3D 0;
> +	u32 pval;
> +	int tperiod, fps_id;
> +	int ret;
> +
> +	for (fps_id =3D 0; fps_id < MAX77620_FPS_COUNT; ++fps_id) {
> +		if (!strcmp(fps_np->name, of_max77620_fps_node_name[fps_id]))
> +			break;
> +	}

Please see my comment at the declaration of of_max77620_fps_node_name
for my suggestion.

> +	if (fps_id =3D=3D MAX77620_FPS_COUNT) {

>=3D

> +		dev_err(dev, "FPS child name %s is not valid\n", fps_np->name);

"node name"

> +		return -EINVAL;
> +	}
> +
> +	ret =3D of_property_read_u32(fps_np, "maxim,shutdown-fps-time-period-us=
",
> +				   &pval);

What's a pval?

Do me that's a pointer to a value, which is not the case here.

> +	if (!ret) {
> +		mask |=3D MAX77620_FPS_TIME_PERIOD_MASK;
> +		chip->shutdown_fps_period[fps_id] =3D min(pval, 5120U);
> +		tperiod =3D max77620_get_fps_period_reg_value(
> +				chip, chip->shutdown_fps_period[fps_id]);

Don't break lines after '('.

> +		config |=3D tperiod << MAX77620_FPS_TIME_PERIOD_SHIFT;
> +	}
> +
> +	ret =3D of_property_read_u32(fps_np, "maxim,suspend-fps-time-period-us"=
,
> +				   &pval);
> +	if (!ret)
> +		chip->suspend_fps_period[fps_id] =3D min(pval, 5120U);
> +
> +	ret =3D of_property_read_u32(fps_np, "maxim,fps-control", &pval);
> +	if (!ret) {
> +		if (pval > 2) {
> +			dev_err(dev, "FPS %d fps-control invalid\n", fps_id);

You can't issue an error, then not return one.

Either return, or demote to dev_warn().

> +		} else {
> +			mask |=3D MAX77620_FPS_EN_SRC_MASK;
> +			config |=3D (pval & 0x3) << MAX77620_FPS_EN_SRC_SHIFT;
> +			if (pval =3D=3D 2) {
> +				mask |=3D MAX77620_FPS_ENFPS_SW_MASK;
> +				config |=3D MAX77620_FPS_ENFPS_SW;
> +			}
> +		}
> +	}
> +
> +	if (!chip->sleep_enable)
> +		chip->sleep_enable =3D of_property_read_bool(fps_np,
> +					"maxim,enable-sleep");

Better to break at the '=3D' here.

> +	if (!chip->enable_global_lpm)
> +		chip->enable_global_lpm =3D of_property_read_bool(fps_np,
> +					"maxim,enable-global-lpm");

Same here.

> +	ret =3D max77620_reg_update(dev, MAX77620_REG_FPS_CFG0 + fps_id,
> +				  mask, config);
> +	if (ret < 0) {
> +		dev_err(dev, "Reg 0x%02x update failed: %d\n",
> +			MAX77620_REG_FPS_CFG0 + fps_id, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_initialise_fps(struct max77620_chip *chip,
> +				   struct device *dev)
> +{
> +	struct device_node *fps_np, *fps_child;
> +	u8 config;
> +	int fps_id;
> +	int ret;
> +
> +	for (fps_id =3D 0; fps_id < 3; ++fps_id) {

MAX77620_FPS_COUNT

fps_id++

> +		chip->shutdown_fps_period[fps_id] =3D -1;
> +		chip->suspend_fps_period[fps_id] =3D -1;
> +	}
> +
> +	fps_np =3D of_get_child_by_name(dev->of_node, "fps");
> +	if (!fps_np)
> +		goto skip_fps;
> +
> +	for_each_child_of_node(fps_np, fps_child) {
> +		ret =3D max77620_config_fps(chip, fps_child);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	config =3D chip->enable_global_lpm ? MAX77620_ONOFFCNFG2_SLP_LPM_MSK : =
0;
> +	ret =3D max77620_reg_update(chip->dev, MAX77620_REG_ONOFFCNFG2,
> +				  MAX77620_ONOFFCNFG2_SLP_LPM_MSK, config);
> +	if (ret < 0) {
> +		dev_err(dev, "Reg ONOFFCNFG2 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +skip_fps:
> +	/* Enable wake on EN0 pin */
> +	ret =3D max77620_reg_update(chip->dev, MAX77620_REG_ONOFFCNFG2,
> +				  MAX77620_ONOFFCNFG2_WK_EN0,
> +				  MAX77620_ONOFFCNFG2_WK_EN0);
> +	if (ret < 0) {
> +		dev_err(dev, "Reg ONOFFCNFG2 WK_EN0 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!chip->sleep_enable)
> +		chip->sleep_enable =3D of_property_read_bool(dev->of_node,
> +						"maxim,enable-sleep");
> +
> +	/* For MAX20024, SLPEN will be POR reset if CLRSE is b11 */
> +	if ((chip->id =3D=3D MAX20024) && chip->sleep_enable) {
> +		config =3D MAX77620_ONOFFCNFG1_SLPEN | MAX20024_ONOFFCNFG1_CLRSE;
> +		ret =3D max77620_reg_update(chip->dev, MAX77620_REG_ONOFFCNFG1,
> +					  config, config);
> +		if (ret < 0) {
> +			dev_err(dev, "Reg ONOFFCNFG1 update failed: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_initialise_chip(struct max77620_chip *chip,
> +				    struct device *dev)
> +{
> +	struct device_node *np =3D dev->of_node;
> +	u32 mrt_time =3D 0;
> +	u8 reg_val;
> +	int ret;
> +
> +	ret =3D of_property_read_u32(np, "maxim,hard-power-off-time", &mrt_time=
);
> +	if (ret < 0)
> +		return 0;
> +
> +	mrt_time =3D (mrt_time > 12) ? 12 : mrt_time;
> +	if (mrt_time <=3D 6)
> +		reg_val =3D mrt_time - 2;
> +	else
> +		reg_val =3D (mrt_time - 6) / 2 + 4;

These need defining.

> +	reg_val <<=3D MAX77620_ONOFFCNFG1_MRT_SHIFT;
> +
> +	ret =3D max77620_reg_update(dev, MAX77620_REG_ONOFFCNFG1,
> +				  MAX77620_ONOFFCNFG1_MRT_MASK, reg_val);
> +	if (ret < 0) {
> +		dev_err(dev, "REG ONOFFCNFG1 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Disable alarm wake to enable sleep from EN input signal */
> +	ret =3D max77620_reg_update(dev, MAX77620_REG_ONOFFCNFG2,
> +				  MAX77620_ONOFFCNFG2_WK_ALARM1, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "REG ONOFFCNFG2 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int max77620_read_es_version(struct max77620_chip *chip)
> +{
> +	unsigned int val;
> +	u8 cid_val[6];
> +	int i;
> +	int ret;
> +
> +	for (i =3D MAX77620_REG_CID0; i <=3D MAX77620_REG_CID5; ++i) {

i++

> +		ret =3D max77620_reg_read(chip->dev, i, &val);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "CID%d register read failed: %d\n",
> +				i - MAX77620_REG_CID0, ret);
> +			return ret;
> +		}

> +		dev_dbg(chip->dev, "CID%d: 0x%02x\n",
> +			i - MAX77620_REG_CID0, val);
> +		cid_val[i - MAX77620_REG_CID0] =3D val;
> +	}
> +
> +	/* CID4 is OTP Version  and CID5 is ES version */
> +	dev_info(chip->dev, "PMIC Version OTP:0x%02X and ES:0x%02X\n",
> +		 cid_val[4], MAX77620_CID5_DIDM(cid_val[5]));
> +
> +	return ret;
> +}
> +
> +static int max77620_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct device_node *node =3D client->dev.of_node;

You've used 'np' before, which also happens to be my preference.

> +	const struct max77620_sub_modules *children;
> +	const struct regmap_config *rmap_config =3D &max77620_regmap_config;
> +	struct max77620_chip *chip;
> +	int ret =3D 0;
> +
> +	if (!node) {
> +		dev_err(&client->dev, "Device is not from DT\n");
> +		return -ENODEV;
> +	}
> +
> +	children =3D of_device_get_match_data(&client->dev);
> +	if (!children)
> +		return -ENODEV;
> +
> +	chip =3D devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, chip);
> +	chip->dev =3D &client->dev;
> +	chip->irq_base =3D -1;
> +	chip->chip_irq =3D client->irq;
> +	chip->id =3D children->id;
> +	chip->base_client =3D client;

You don't need client AND client->dev AND client->irq.

If you have one, you have them all, please the superfluous
attributes.

> +	if (chip->id =3D=3D MAX20024)
> +		rmap_config =3D &max20024_regmap_config;
> +
> +	chip->rmap =3D devm_regmap_init_i2c(chip->base_client, rmap_config);
> +	if (IS_ERR(chip->rmap)) {
> +		ret =3D PTR_ERR(chip->rmap);
> +		dev_err(&client->dev, "regmap init failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	mutex_init(&chip->mutex_config);
> +
> +	ret =3D max77620_read_es_version(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D max77620_initialise_chip(chip, &client->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_add_irq_chip(chip->rmap, chip->chip_irq,
> +				  IRQF_ONESHOT | IRQF_SHARED,
> +				  chip->irq_base, &max77620_top_irq_chip,
> +				  &chip->top_irq_data);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to add top irq_chip %d\n", ret);
> +		return ret;
> +	}

What do you mean by 'top'?

> +	ret =3D max77620_initialise_fps(chip, &client->dev);
> +	if (ret < 0)
> +		goto fail_free_irq;
> +
> +	ret =3D  mfd_add_devices(&client->dev, -1, children->cells,

Please use the PLATFORM_DEVID_ defines.

> +			       children->ncells, NULL, 0,
> +			       regmap_irq_get_domain(chip->top_irq_data));
> +	if (ret < 0) {
> +		dev_err(&client->dev, "mfd add dev fail %d\n", ret);

"Failed to add sub devices"

> +		goto fail_free_irq;
> +	}
> +
> +	return 0;
> +
> +fail_free_irq:
> +	regmap_del_irq_chip(chip->chip_irq, chip->top_irq_data);
> +
> +	return ret;
> +}
> +
> +static int max77620_remove(struct i2c_client *client)
> +{
> +	struct max77620_chip *chip =3D i2c_get_clientdata(client);
> +
> +	mfd_remove_devices(chip->dev);
> +	regmap_del_irq_chip(chip->chip_irq, chip->top_irq_data);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int max77620_set_fps_period(struct max77620_chip *chip,
> +				   int fps_id, int time_period)
> +{
> +	struct device *dev =3D chip->dev;
> +	int period =3D max77620_get_fps_period_reg_value(chip, time_period);
> +	int ret;
> +
> +	ret =3D max77620_reg_update(dev, MAX77620_REG_FPS_CFG0 + fps_id,
> +				  MAX77620_FPS_TIME_PERIOD_MASK,
> +				  period << MAX77620_FPS_TIME_PERIOD_SHIFT);
> +	if (ret < 0) {
> +		dev_err(dev, "Reg 0x%02x write failed: %d\n",
> +			MAX77620_REG_FPS_CFG0 + fps_id, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_i2c_suspend(struct device *dev)
> +{
> +	struct max77620_chip *chip =3D dev_get_drvdata(dev);
> +	unsigned int config;
> +	int fps;
> +	int ret;
> +
> +	for (fps =3D 0; fps < 2; ++fps) {
> +		if (chip->suspend_fps_period[fps] < 0)
> +			continue;
> +
> +		ret =3D max77620_set_fps_period(chip, fps,
> +					      chip->suspend_fps_period[fps]);
> +		if (ret < 0)
> +			dev_err(dev, "FPS%d config failed: %d\n", fps, ret);
> +	}
> +
> +	/*
> +	 * For MAX20024: No need to configure SLPEN on suspend as
> +	 * it will be configured on Init.
> +	 */
> +	if (chip->id =3D=3D MAX20024)
> +		goto out;
> +
> +	config =3D (chip->sleep_enable) ? MAX77620_ONOFFCNFG1_SLPEN : 0;
> +	ret =3D max77620_reg_update(chip->dev, MAX77620_REG_ONOFFCNFG1,
> +				  MAX77620_ONOFFCNFG1_SLPEN,
> +				  config);
> +	if (ret < 0) {
> +		dev_err(dev, "Reg ONOFFCNFG1 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Disable WK_EN0 */
> +	ret =3D max77620_reg_update(chip->dev, MAX77620_REG_ONOFFCNFG2,
> +				  MAX77620_ONOFFCNFG2_WK_EN0, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "Reg ONOFFCNFG2 WK_EN0 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +out:
> +	disable_irq(chip->chip_irq);
> +
> +	return 0;
> +}
> +
> +static int max77620_i2c_resume(struct device *dev)
> +{
> +	struct max77620_chip *chip =3D dev_get_drvdata(dev);
> +	int ret;
> +	int fps;
> +
> +	for (fps =3D 0; fps < 2; ++fps) {
> +		if (chip->shutdown_fps_period[fps] < 0)
> +			continue;
> +
> +		ret =3D max77620_set_fps_period(chip, fps,
> +					      chip->shutdown_fps_period[fps]);
> +		if (ret < 0)
> +			dev_err(dev, "FPS%d config failed: %d\n", fps, ret);
> +	}
> +
> +	/*
> +	 * For MAX20024: No need to configure WKEN0 on resume as
> +	 * it is configured on Init.
> +	 */
> +	if (chip->id =3D=3D MAX20024)
> +		goto out;
> +
> +	/* Enable WK_EN0 */
> +	ret =3D max77620_reg_update(chip->dev, MAX77620_REG_ONOFFCNFG2,
> +				  MAX77620_ONOFFCNFG2_WK_EN0,
> +		MAX77620_ONOFFCNFG2_WK_EN0);
> +	if (ret < 0) {
> +		dev_err(dev, "Reg ONOFFCNFG2 WK_EN0 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +out:
> +	enable_irq(chip->chip_irq);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct i2c_device_id max77620_id[] =3D {
> +	{"max77620", MAX77620},
> +	{"max20024", MAX20024},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, max77620_id);
> +
> +static const struct of_device_id max77620_of_match[] =3D {
> +	{
> +		.compatible =3D "maxim,max77620",
> +		.data =3D &max77620_cells,
> +	}, {
> +		.compatible =3D "maxim,max20024",
> +		.data =3D &max20024_cells,
> +	}, {
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, max77620_of_match);

This is not acceptable.  EITHER use DT OR MFD methods of registering
devices, do not mix the two.

> +static const struct dev_pm_ops max77620_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(max77620_i2c_suspend, max77620_i2c_resume)
> +};
> +
> +static struct i2c_driver max77620_driver =3D {
> +	.driver =3D {
> +		.name =3D "max77620",
> +		.pm =3D &max77620_pm_ops,
> +		.of_match_table =3D max77620_of_match,
> +	},
> +	.probe =3D max77620_probe,
> +	.remove =3D max77620_remove,
> +	.id_table =3D max77620_id,
> +};
> +
> +module_i2c_driver(max77620_driver);
> +
> +MODULE_DESCRIPTION("MAX77620/MAX20024 Multi Function Device Core Driver"=
);
> +MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> +MODULE_AUTHOR("Chaitanya Bandi <bandik@nvidia.com>");
> +MODULE_AUTHOR("Mallikarjun Kasoju <mkasoju@nvidia.com>");
> +MODULE_ALIAS("i2c:max77620");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/max77620.h b/include/linux/mfd/max77620.h
> new file mode 100644
> index 0000000..5e014f1
> --- /dev/null
> +++ b/include/linux/mfd/max77620.h
> @@ -0,0 +1,406 @@
> +/*
> + * max77620.h: Defining registers address and its bit definitions

Please remove the filename from the header.

> + *	of MAX77620 and	MAX20024
> + *
> + * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + */

Can you use the shorter version?

> +#ifndef _LINUX_MFD_MAX77620_H_
> +#define _LINUX_MFD_MAX77620_H_
> +
> +/* GLOBAL, PMIC, GPIO, FPS, ONOFFC, CID Registers */
> +#define MAX77620_REG_CNFGGLBL1			0x00
> +#define MAX77620_REG_CNFGGLBL2			0x01
> +#define MAX77620_REG_CNFGGLBL3			0x02
> +#define MAX77620_REG_CNFG1_32K			0x03
> +#define MAX77620_REG_CNFGBBC			0x04
> +#define MAX77620_REG_IRQTOP			0x05
> +#define MAX77620_REG_INTLBT			0x06
> +#define MAX77620_REG_IRQSD			0x07
> +#define MAX77620_REG_IRQ_LVL2_L0_7		0x08
> +#define MAX77620_REG_IRQ_LVL2_L8		0x09
> +#define MAX77620_REG_IRQ_LVL2_GPIO		0x0A
> +#define MAX77620_REG_ONOFFIRQ			0x0B
> +#define MAX77620_REG_NVERC			0x0C
> +#define MAX77620_REG_IRQTOPM			0x0D
> +#define MAX77620_REG_INTENLBT			0x0E
> +#define MAX77620_REG_IRQMASKSD			0x0F
> +#define MAX77620_REG_IRQ_MSK_L0_7		0x10
> +#define MAX77620_REG_IRQ_MSK_L8			0x11
> +#define MAX77620_REG_ONOFFIRQM			0x12
> +#define MAX77620_REG_STATLBT			0x13
> +#define MAX77620_REG_STATSD			0x14
> +#define MAX77620_REG_ONOFFSTAT			0x15
> +
> +/* SD and LDO Registers */
> +#define MAX77620_REG_SD0			0x16
> +#define MAX77620_REG_SD1			0x17
> +#define MAX77620_REG_SD2			0x18
> +#define MAX77620_REG_SD3			0x19
> +#define MAX77620_REG_SD4			0x1A
> +#define MAX77620_REG_DVSSD0			0x1B
> +#define MAX77620_REG_DVSSD1			0x1C
> +#define MAX77620_REG_SD0_CFG			0x1D
> +#define MAX77620_REG_SD1_CFG			0x1E
> +#define MAX77620_REG_SD2_CFG			0x1F
> +#define MAX77620_REG_SD3_CFG			0x20
> +#define MAX77620_REG_SD4_CFG			0x21
> +#define MAX77620_REG_SD_CFG2			0x22
> +#define MAX77620_REG_LDO0_CFG			0x23
> +#define MAX77620_REG_LDO0_CFG2			0x24
> +#define MAX77620_REG_LDO1_CFG			0x25
> +#define MAX77620_REG_LDO1_CFG2			0x26
> +#define MAX77620_REG_LDO2_CFG			0x27
> +#define MAX77620_REG_LDO2_CFG2			0x28
> +#define MAX77620_REG_LDO3_CFG			0x29
> +#define MAX77620_REG_LDO3_CFG2			0x2A
> +#define MAX77620_REG_LDO4_CFG			0x2B
> +#define MAX77620_REG_LDO4_CFG2			0x2C
> +#define MAX77620_REG_LDO5_CFG			0x2D
> +#define MAX77620_REG_LDO5_CFG2			0x2E
> +#define MAX77620_REG_LDO6_CFG			0x2F
> +#define MAX77620_REG_LDO6_CFG2			0x30
> +#define MAX77620_REG_LDO7_CFG			0x31
> +#define MAX77620_REG_LDO7_CFG2			0x32
> +#define MAX77620_REG_LDO8_CFG			0x33
> +#define MAX77620_REG_LDO8_CFG2			0x34
> +#define MAX77620_REG_LDO_CFG3			0x35
> +
> +#define MAX77620_LDO_SLEW_RATE_MASK		0x1
> +
> +/* LDO Configuration 3 */
> +#define MAX77620_TRACK4_MASK			BIT(5)
> +#define MAX77620_TRACK4_SHIFT			5
> +
> +/* Voltage */
> +#define MAX77620_SDX_VOLT_MASK			0xFF
> +#define MAX77620_SD0_VOLT_MASK			0x3F
> +#define MAX77620_SD1_VOLT_MASK			0x7F
> +#define MAX77620_LDO_VOLT_MASK			0x3F
> +
> +#define MAX77620_REG_GPIO0			0x36
> +#define MAX77620_REG_GPIO1			0x37
> +#define MAX77620_REG_GPIO2			0x38
> +#define MAX77620_REG_GPIO3			0x39
> +#define MAX77620_REG_GPIO4			0x3A
> +#define MAX77620_REG_GPIO5			0x3B
> +#define MAX77620_REG_GPIO6			0x3C
> +#define MAX77620_REG_GPIO7			0x3D
> +#define MAX77620_REG_PUE_GPIO			0x3E
> +#define MAX77620_REG_PDE_GPIO			0x3F
> +#define MAX77620_REG_AME_GPIO			0x40
> +#define MAX77620_REG_ONOFFCNFG1			0x41
> +#define MAX77620_REG_ONOFFCNFG2			0x42
> +
> +/* FPS Registers */
> +#define MAX77620_REG_FPS_CFG0			0x43
> +#define MAX77620_REG_FPS_CFG1			0x44
> +#define MAX77620_REG_FPS_CFG2			0x45
> +#define MAX77620_REG_FPS_LDO0			0x46
> +#define MAX77620_REG_FPS_LDO1			0x47
> +#define MAX77620_REG_FPS_LDO2			0x48
> +#define MAX77620_REG_FPS_LDO3			0x49
> +#define MAX77620_REG_FPS_LDO4			0x4A
> +#define MAX77620_REG_FPS_LDO5			0x4B
> +#define MAX77620_REG_FPS_LDO6			0x4C
> +#define MAX77620_REG_FPS_LDO7			0x4D
> +#define MAX77620_REG_FPS_LDO8			0x4E
> +#define MAX77620_REG_FPS_SD0			0x4F
> +#define MAX77620_REG_FPS_SD1			0x50
> +#define MAX77620_REG_FPS_SD2			0x51
> +#define MAX77620_REG_FPS_SD3			0x52
> +#define MAX77620_REG_FPS_SD4			0x53
> +#define MAX77620_REG_FPS_NONE			0
> +
> +#define MAX77620_FPS_SRC_MASK			0xC0
> +#define MAX77620_FPS_SRC_SHIFT			6
> +#define MAX77620_FPS_PU_PERIOD_MASK		0x38
> +#define MAX77620_FPS_PU_PERIOD_SHIFT		3
> +#define MAX77620_FPS_PD_PERIOD_MASK		0x07
> +#define MAX77620_FPS_PD_PERIOD_SHIFT		0
> +#define MAX77620_FPS_TIME_PERIOD_MASK		0x38
> +#define MAX77620_FPS_TIME_PERIOD_SHIFT		3
> +#define MAX77620_FPS_EN_SRC_MASK		0x06
> +#define MAX77620_FPS_EN_SRC_SHIFT		1
> +#define MAX77620_FPS_ENFPS_SW_MASK		0x01
> +#define MAX77620_FPS_ENFPS_SW			0x01
> +
> +#define MAX77620_REG_FPS_GPIO1			0x54
> +#define MAX77620_REG_FPS_GPIO2			0x55
> +#define MAX77620_REG_FPS_GPIO3			0x56
> +#define MAX77620_REG_FPS_RSO			0x57
> +#define MAX77620_REG_CID0			0x58
> +#define MAX77620_REG_CID1			0x59
> +#define MAX77620_REG_CID2			0x5A
> +#define MAX77620_REG_CID3			0x5B
> +#define MAX77620_REG_CID4			0x5C
> +#define MAX77620_REG_CID5			0x5D
> +
> +#define MAX77620_REG_DVSSD4			0x5E
> +#define MAX20024_REG_MAX_ADD			0x70
> +
> +#define MAX77620_CID_DIDM_MASK			0xF0
> +#define MAX77620_CID_DIDM_SHIFT			4
> +
> +/* CNCG2SD */
> +#define MAX77620_SD_CNF2_ROVS_EN_SD1		BIT(1)
> +#define MAX77620_SD_CNF2_ROVS_EN_SD0		BIT(2)
> +
> +/* Device Identification Metal */
> +#define MAX77620_CID5_DIDM(n)			(((n) >> 4) & 0xF)
> +/* Device Indentification OTP */
> +#define MAX77620_CID5_DIDO(n)			((n) & 0xF)
> +
> +/* SD CNFG1 */
> +#define MAX77620_SD_SR_MASK			0xC0
> +#define MAX77620_SD_SR_SHIFT			6
> +#define MAX77620_SD_POWER_MODE_MASK		0x30
> +#define MAX77620_SD_POWER_MODE_SHIFT		4
> +#define MAX77620_SD_CFG1_ADE_MASK		BIT(3)
> +#define MAX77620_SD_CFG1_ADE_DISABLE		0
> +#define MAX77620_SD_CFG1_ADE_ENABLE		BIT(3)
> +#define MAX77620_SD_FPWM_MASK			0x04
> +#define MAX77620_SD_FPWM_SHIFT			2
> +#define MAX77620_SD_FSRADE_MASK			0x01
> +#define MAX77620_SD_FSRADE_SHIFT		0
> +#define MAX77620_SD_CFG1_FPWM_SD_MASK		BIT(2)
> +#define MAX77620_SD_CFG1_FPWM_SD_SKIP		0
> +#define MAX77620_SD_CFG1_FPWM_SD_FPWM		BIT(2)
> +#define MAX77620_SD_CFG1_FSRADE_SD_MASK		BIT(0)
> +#define MAX77620_SD_CFG1_FSRADE_SD_DISABLE	0
> +#define MAX77620_SD_CFG1_FSRADE_SD_ENABLE	BIT(0)
> +
> +/* LDO_CNFG2 */
> +#define MAX77620_LDO_POWER_MODE_MASK		0xC0
> +#define MAX77620_LDO_POWER_MODE_SHIFT		6
> +#define MAX77620_LDO_CFG2_ADE_MASK		BIT(1)
> +#define MAX77620_LDO_CFG2_ADE_DISABLE		0
> +#define MAX77620_LDO_CFG2_ADE_ENABLE		BIT(1)
> +#define MAX77620_LDO_CFG2_SS_MASK		BIT(0)
> +#define MAX77620_LDO_CFG2_SS_FAST		BIT(0)
> +#define MAX77620_LDO_CFG2_SS_SLOW		0
> +
> +#define MAX77620_IRQ_TOP_GLBL_MASK		BIT(7)
> +#define MAX77620_IRQ_TOP_SD_MASK		BIT(6)
> +#define MAX77620_IRQ_TOP_LDO_MASK		BIT(5)
> +#define MAX77620_IRQ_TOP_GPIO_MASK		BIT(4)
> +#define MAX77620_IRQ_TOP_RTC_MASK		BIT(3)
> +#define MAX77620_IRQ_TOP_32K_MASK		BIT(2)
> +#define MAX77620_IRQ_TOP_ONOFF_MASK		BIT(1)
> +
> +#define MAX77620_IRQ_LBM_MASK			BIT(3)
> +#define MAX77620_IRQ_TJALRM1_MASK		BIT(2)
> +#define MAX77620_IRQ_TJALRM2_MASK		BIT(1)
> +
> +#define MAX77620_PWR_I2C_ADDR			0x3c
> +#define MAX77620_RTC_I2C_ADDR			0x68
> +
> +#define MAX77620_CNFG_GPIO_DRV_MASK		BIT(0)
> +#define MAX77620_CNFG_GPIO_DRV_PUSHPULL		BIT(0)
> +#define MAX77620_CNFG_GPIO_DRV_OPENDRAIN	0
> +#define MAX77620_CNFG_GPIO_DIR_MASK		BIT(1)
> +#define MAX77620_CNFG_GPIO_DIR_INPUT		BIT(1)
> +#define MAX77620_CNFG_GPIO_DIR_OUTPUT		0
> +#define MAX77620_CNFG_GPIO_INPUT_VAL_MASK	BIT(2)
> +#define MAX77620_CNFG_GPIO_OUTPUT_VAL_MASK	BIT(3)
> +#define MAX77620_CNFG_GPIO_OUTPUT_VAL_HIGH	BIT(3)
> +#define MAX77620_CNFG_GPIO_OUTPUT_VAL_LOW	0
> +#define MAX77620_CNFG_GPIO_INT_MASK		(0x3 << 4)
> +#define MAX77620_CNFG_GPIO_INT_FALLING		BIT(4)
> +#define MAX77620_CNFG_GPIO_INT_RISING		BIT(5)
> +#define MAX77620_CNFG_GPIO_DBNC_MASK		(0x3 << 6)
> +#define MAX77620_CNFG_GPIO_DBNC_None		(0x0 << 6)
> +#define MAX77620_CNFG_GPIO_DBNC_8ms		(0x1 << 6)
> +#define MAX77620_CNFG_GPIO_DBNC_16ms		(0x2 << 6)
> +#define MAX77620_CNFG_GPIO_DBNC_32ms		(0x3 << 6)
> +
> +#define MAX77620_IRQ_LVL2_GPIO_EDGE0		BIT(0)
> +#define MAX77620_IRQ_LVL2_GPIO_EDGE1		BIT(1)
> +#define MAX77620_IRQ_LVL2_GPIO_EDGE2		BIT(2)
> +#define MAX77620_IRQ_LVL2_GPIO_EDGE3		BIT(3)
> +#define MAX77620_IRQ_LVL2_GPIO_EDGE4		BIT(4)
> +#define MAX77620_IRQ_LVL2_GPIO_EDGE5		BIT(5)
> +#define MAX77620_IRQ_LVL2_GPIO_EDGE6		BIT(6)
> +#define MAX77620_IRQ_LVL2_GPIO_EDGE7		BIT(7)
> +
> +#define MAX77620_CNFG1_32K_OUT0_EN		BIT(2)
> +
> +#define MAX77620_ONOFFCNFG1_SFT_RST		BIT(7)
> +#define MAX77620_ONOFFCNFG1_MRT_MASK		0x38
> +#define MAX77620_ONOFFCNFG1_MRT_SHIFT		0x3
> +#define MAX77620_ONOFFCNFG1_SLPEN		BIT(2)
> +#define MAX77620_ONOFFCNFG1_PWR_OFF		BIT(1)
> +#define MAX20024_ONOFFCNFG1_CLRSE		0x18
> +
> +#define MAX77620_ONOFFCNFG2_SFT_RST_WK		BIT(7)
> +#define MAX77620_ONOFFCNFG2_WD_RST_WK		BIT(6)
> +#define MAX77620_ONOFFCNFG2_SLP_LPM_MSK		BIT(5)
> +#define MAX77620_ONOFFCNFG2_WK_ALARM1		BIT(2)
> +#define MAX77620_ONOFFCNFG2_WK_EN0		BIT(0)
> +
> +#define MAX77620_GLBLM_MASK			BIT(0)
> +
> +#define MAX77620_WDTC_MASK			0x3
> +#define MAX77620_WDTOFFC			BIT(4)
> +#define MAX77620_WDTSLPC			BIT(3)
> +#define MAX77620_WDTEN				BIT(2)
> +
> +#define MAX77620_TWD_MASK			0x3
> +#define MAX77620_TWD_2s				0x0
> +#define MAX77620_TWD_16s			0x1
> +#define MAX77620_TWD_64s			0x2
> +#define MAX77620_TWD_128s			0x3
> +
> +#define MAX77620_CNFGGLBL1_LBDAC_EN		BIT(7)
> +#define MAX77620_CNFGGLBL1_MPPLD		BIT(6)
> +#define MAX77620_CNFGGLBL1_LBHYST		(BIT(5) | BIT(4))
> +#define MAX77620_CNFGGLBL1_LBDAC		0x0E
> +#define MAX77620_CNFGGLBL1_LBRSTEN		BIT(0)
> +
> +/* CNFG BBC registers */
> +#define MAX77620_CNFGBBC_ENABLE			BIT(0)
> +#define MAX77620_CNFGBBC_CURRENT_MASK		0x06
> +#define MAX77620_CNFGBBC_CURRENT_SHIFT		1
> +#define MAX77620_CNFGBBC_VOLTAGE_MASK		0x18
> +#define MAX77620_CNFGBBC_VOLTAGE_SHIFT		3
> +#define MAX77620_CNFGBBC_LOW_CURRENT_DISABLE	BIT(5)
> +#define MAX77620_CNFGBBC_RESISTOR_MASK		0xC0
> +#define MAX77620_CNFGBBC_RESISTOR_SHIFT		6
> +
> +#define MAX77620_FPS_COUNT			3
> +
> +/* I2c Slave Id */
> +enum {
> +	MAX77620_PWR_SLAVE,
> +	MAX77620_RTC_SLAVE,
> +	MAX77620_NUM_SLAVES,
> +};
> +
> +/* GPIOs */
> +enum {
> +	MAX77620_GPIO0,
> +	MAX77620_GPIO1,
> +	MAX77620_GPIO2,
> +	MAX77620_GPIO3,
> +	MAX77620_GPIO4,
> +	MAX77620_GPIO5,
> +	MAX77620_GPIO6,
> +	MAX77620_GPIO7,
> +
> +	MAX77620_GPIO_NR,
> +};
> +
> +/* Interrupts */
> +enum {
> +	MAX77620_IRQ_TOP_GLBL,		/* Low-Battery */
> +	MAX77620_IRQ_TOP_SD,		/* SD power fail */
> +	MAX77620_IRQ_TOP_LDO,		/* LDO power fail */
> +	MAX77620_IRQ_TOP_GPIO,		/* TOP GPIO internal int to MAX77620 */
> +	MAX77620_IRQ_TOP_RTC,		/* RTC */
> +	MAX77620_IRQ_TOP_32K,		/* 32kHz oscillator */
> +	MAX77620_IRQ_TOP_ONOFF,		/* ON/OFF oscillator */
> +
> +	MAX77620_IRQ_LBT_MBATLOW,	/* Thermal alarm status, > 120C */
> +	MAX77620_IRQ_LBT_TJALRM1,	/* Thermal alarm status, > 120C */
> +	MAX77620_IRQ_LBT_TJALRM2,	/* Thermal alarm status, > 140C */
> +
> +	MAX77620_IRQ_GPIO0,		/* GPIO0 edge detection */
> +	MAX77620_IRQ_GPIO1,		/* GPIO1 edge detection */
> +	MAX77620_IRQ_GPIO2,		/* GPIO2 edge detection */
> +	MAX77620_IRQ_GPIO3,		/* GPIO3 edge detection */
> +	MAX77620_IRQ_GPIO4,		/* GPIO4 edge detection */
> +	MAX77620_IRQ_GPIO5,		/* GPIO5 edge detection */
> +	MAX77620_IRQ_GPIO6,		/* GPIO6 edge detection */
> +	MAX77620_IRQ_GPIO7,		/* GPIO7 edge detection */
> +
> +	MAX77620_IRQ_ONOFF_MRWRN,	/* Hard power off warnning */
> +	MAX77620_IRQ_ONOFF_EN0_1SEC,	/* EN0 active for 1s */
> +	MAX77620_IRQ_ONOFF_EN0_F,	/* EN0 falling */
> +	MAX77620_IRQ_ONOFF_EN0_R,	/* EN0 rising */
> +	MAX77620_IRQ_ONOFF_LID_F,	/* LID falling */
> +	MAX77620_IRQ_ONOFF_LID_R,	/* LID rising */
> +	MAX77620_IRQ_ONOFF_ACOK_F,	/* ACOK falling */
> +	MAX77620_IRQ_ONOFF_ACOK_R,	/* ACOK rising */
> +
> +	MAX77620_IRQ_NVER,		/* Non-Volatile Event Recorder */
> +	MAX77620_IRQ_NR,
> +};
> +
> +enum max77620_regulators {
> +	MAX77620_REGULATOR_ID_SD0,
> +	MAX77620_REGULATOR_ID_SD1,
> +	MAX77620_REGULATOR_ID_SD2,
> +	MAX77620_REGULATOR_ID_SD3,
> +	MAX77620_REGULATOR_ID_SD4,
> +	MAX77620_REGULATOR_ID_LDO0,
> +	MAX77620_REGULATOR_ID_LDO1,
> +	MAX77620_REGULATOR_ID_LDO2,
> +	MAX77620_REGULATOR_ID_LDO3,
> +	MAX77620_REGULATOR_ID_LDO4,
> +	MAX77620_REGULATOR_ID_LDO5,
> +	MAX77620_REGULATOR_ID_LDO6,
> +	MAX77620_REGULATOR_ID_LDO7,
> +	MAX77620_REGULATOR_ID_LDO8,
> +	MAX77620_NUM_REGS,
> +};
> +
> +/* FPS Source */
> +enum max77620_regulator_fps_src {
> +	FPS_SRC_0,
> +	FPS_SRC_1,
> +	FPS_SRC_2,
> +	FPS_SRC_NONE,
> +	FPS_SRC_DEF,
> +};
> +
> +/* Regulator types */
> +enum max77620_regulator_type {
> +	MAX77620_REGULATOR_TYPE_SD,
> +	MAX77620_REGULATOR_TYPE_LDO_N,
> +	MAX77620_REGULATOR_TYPE_LDO_P,
> +};
> +
> +enum max77620_chip_id {
> +	MAX77620,
> +	MAX20024,
> +};
> +
> +struct max77620_chip {
> +	struct device *dev;
> +
> +	struct i2c_client *base_client;
> +	struct regmap *rmap;
> +
> +	int chip_irq;
> +	int irq_base;
> +
> +	struct mutex mutex_config;
> +	bool sleep_enable;
> +	bool enable_global_lpm;
> +	int shutdown_fps_period[MAX77620_FPS_COUNT];
> +	int suspend_fps_period[MAX77620_FPS_COUNT];
> +
> +	struct regmap_irq_chip_data *top_irq_data;
> +	struct regmap_irq_chip_data *gpio_irq_data;
> +
> +	/* chip id */
> +	u32 id;
> +};
> +
> +extern int max77620_irq_get_virq(struct device *dev, int irq);
> +extern int max77620_reg_write(struct device *dev, unsigned int reg,
> +		unsigned int val);
> +extern int max77620_reg_read(struct device *dev, unsigned int reg,
> +		unsigned int *val);
> +extern int max77620_reg_update(struct device *dev, unsigned int reg,
> +		unsigned int mask, unsigned int val);
> +#endif /* _LINUX_MFD_MAX77620_H_ */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
