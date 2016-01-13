Return-Path: <rtc-linux+bncBDKZNNNLXAHBBI55222AKGQE2ROWOJY@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id jj4si12741894pac.2.2016.01.12.16.47.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 12 Jan 2016 16:47:30 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O0V000Z78V2HA80@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 13 Jan 2016 00:47:26 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V2 2/6] mfd: max77620: add core driver for MAX77620/MAX20024
To: Laxman Dewangan <ldewangan@nvidia.com>, robh+dt@kernel.org,
 pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
 lee.jones@linaro.org, broonie@kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com>
 <1452590273-16421-3-git-send-email-ldewangan@nvidia.com>
Cc: lgirdwood@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
 Chaitanya Bandi <bandik@nvidia.com>, Mallikarjun Kasoju <mkasoju@nvidia.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56959E9A.3060903@samsung.com>
Date: Wed, 13 Jan 2016 09:47:22 +0900
MIME-version: 1.0
In-reply-to: <1452590273-16421-3-git-send-email-ldewangan@nvidia.com>
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
> MAX77620/MAX20024 are Power Management IC from the MAXIM.
> It supports RTC, multiple GPIOs, multiple DCDC and LDOs,
> watchdog, clock etc.
> 
> Add MFD drier to provides common support for accessing the
> device; additional drivers is developed on respected subsystem
> in order to use the functionality of the device.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>
> Signed-off-by: Mallikarjun Kasoju <mkasoju@nvidia.com>
> ---
> - Code cleanups per review from V1. 
> - Move register acccess APIs from header to c file.
> - Remove some of non required variable, remove duplication in error message
>  and simplify some of function implementation.
> - Register RTC driver such that it can get the regmap handle form parent device
> 
>  drivers/mfd/Kconfig          |  15 +
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77620.c       | 997 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77620.h | 407 ++++++++++++++++++
>  4 files changed, 1420 insertions(+)
>  create mode 100644 drivers/mfd/max77620.c
>  create mode 100644 include/linux/mfd/max77620.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 9581ebb..edeb85c 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -492,6 +492,21 @@ config MFD_MAX14577
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_MAX77620
> +	bool "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
> +	depends on I2C=y
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
>  	depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 0f230a6..97910ed 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -123,6 +123,7 @@ obj-$(CONFIG_MFD_DA9063)	+= da9063.o
>  obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
>  
>  obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
> +obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
>  obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
>  obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
>  obj-$(CONFIG_MFD_MAX77843)	+= max77843.o
> diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
> new file mode 100644
> index 0000000..c0cd400
> --- /dev/null
> +++ b/drivers/mfd/max77620.c
> @@ -0,0 +1,997 @@
> +/*
> + * Maxim MAX77620 MFD Driver
> + *
> + * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
> + *
> + * Author:
> + *		Laxman Dewangan <ldewangan@nvidia.com>
> + *		Chaitanya Bandi <bandik@nvidia.com>
> + *		Mallikarjun Kasoju <mkasoju@nvidia.com>
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
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/core.h>
> +#include <linux/interrupt.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/max77620.h>
> +
> +static struct resource gpio_resources[] = {
> +	{
> +		.start	= MAX77620_IRQ_TOP_GPIO,
> +		.end	= MAX77620_IRQ_TOP_GPIO,
> +		.flags  = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct resource rtc_resources[] = {
> +	{
> +		.start	= MAX77620_IRQ_TOP_RTC,
> +		.end	= MAX77620_IRQ_TOP_RTC,
> +		.flags  = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct resource thermal_resources[] = {
> +	{
> +		.start	= MAX77620_IRQ_LBT_TJALRM1,
> +		.end	= MAX77620_IRQ_LBT_TJALRM1,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	{
> +		.start	= MAX77620_IRQ_LBT_TJALRM2,
> +		.end	= MAX77620_IRQ_LBT_TJALRM2,
> +		.flags  = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static const struct regmap_irq max77620_top_irqs[] = {
> +	[MAX77620_IRQ_TOP_GLBL] = {
> +		.mask = MAX77620_IRQ_TOP_GLBL_MASK,
> +		.reg_offset = 0,
> +	},
> +	[MAX77620_IRQ_TOP_SD] = {
> +		.mask = MAX77620_IRQ_TOP_SD_MASK,
> +		.reg_offset = 0,
> +	},
> +	[MAX77620_IRQ_TOP_LDO] = {
> +		.mask = MAX77620_IRQ_TOP_LDO_MASK,
> +		.reg_offset = 0,
> +	},
> +	[MAX77620_IRQ_TOP_GPIO] = {
> +		.mask = MAX77620_IRQ_TOP_GPIO_MASK,
> +		.reg_offset = 0,
> +	},
> +	[MAX77620_IRQ_TOP_RTC] = {
> +		.mask = MAX77620_IRQ_TOP_RTC_MASK,
> +		.reg_offset = 0,
> +	},
> +	[MAX77620_IRQ_TOP_32K] = {
> +		.mask = MAX77620_IRQ_TOP_32K_MASK,
> +		.reg_offset = 0,
> +	},
> +	[MAX77620_IRQ_TOP_ONOFF] = {
> +		.mask = MAX77620_IRQ_TOP_ONOFF_MASK,
> +		.reg_offset = 0,
> +	},
> +
> +	[MAX77620_IRQ_LBT_MBATLOW] = {
> +		.mask = MAX77620_IRQ_LBM_MASK,
> +		.reg_offset = 1,
> +	},
> +	[MAX77620_IRQ_LBT_TJALRM1] = {
> +		.mask = MAX77620_IRQ_TJALRM1_MASK,
> +		.reg_offset = 1,
> +	},
> +	[MAX77620_IRQ_LBT_TJALRM2] = {
> +		.mask = MAX77620_IRQ_TJALRM2_MASK,
> +		.reg_offset = 1,
> +	},
> +
> +};
> +
> +static const char * const max77620_nverc[] = {
> +	"Shutdown-pin",
> +	"System WatchDog Timer",
> +	"Hard Reset",
> +	"Junction Temp Overload",
> +	"Main-Battery Low",
> +	"Main-Battery overvoltage Lockout",
> +	"Main-Battery undervoltage Lockout",
> +	"Reset input",
> +};
> +
> +enum max77660_ids {
> +	MAX77620_PMIC_ID,
> +	MAX77620_GPIO_ID,
> +	MAX77620_PINCTRL_ID,
> +	MAX77620_CLK_ID,
> +	MAX77620_POWER_OFF_ID,
> +	MAX77620_WDT_ID,
> +	MAX77620_THERMAL_ID,
> +	MAX77620_RTC_ID,
> +};
> +
> +#define MAX77620_SUB_MODULE_RES(_name, _id)			\
> +	[MAX77620_##_id##_ID] = {				\
> +		.name = "max77620-"#_name,			\
> +		.num_resources	= ARRAY_SIZE(_name##_resources), \
> +		.resources	= &_name##_resources[0],	\
> +		.id = MAX77620_##_id##_ID,			\
> +	}
> +
> +#define MAX20024_SUB_MODULE_RES(_name, _id)			\
> +	[MAX77620_##_id##_ID] = {				\
> +		.name = "max20024-"#_name,			\
> +		.num_resources	= ARRAY_SIZE(_name##_resources), \
> +		.resources	= &_name##_resources[0],	\
> +		.id = MAX77620_##_id##_ID,			\
> +	}
> +
> +#define MAX77620_SUB_MODULE_NO_RES(_name, _id)			\
> +	[MAX77620_##_id##_ID] = {				\
> +		.name = "max77620-"#_name,			\
> +		.id = MAX77620_##_id##_ID,			\
> +	}
> +
> +#define MAX20024_SUB_MODULE_NO_RES(_name, _id)			\
> +	[MAX77620_##_id##_ID] = {				\
> +		.name = "max20024-"#_name,			\
> +		.id = MAX77620_##_id##_ID,			\
> +	}
> +
> +static struct mfd_cell max77620_children[] = {
> +	MAX77620_SUB_MODULE_RES(gpio, GPIO),
> +	MAX77620_SUB_MODULE_NO_RES(pmic, PMIC),
> +	MAX77620_SUB_MODULE_NO_RES(pinctrl, PINCTRL),
> +	MAX77620_SUB_MODULE_NO_RES(clk, CLK),
> +	MAX77620_SUB_MODULE_NO_RES(power-off, POWER_OFF),
> +	MAX77620_SUB_MODULE_NO_RES(wdt, WDT),
> +	MAX77620_SUB_MODULE_RES(thermal, THERMAL),
> +};
> +
> +static struct mfd_cell max20024_children[] = {
> +	MAX20024_SUB_MODULE_RES(gpio, GPIO),
> +	MAX20024_SUB_MODULE_NO_RES(pmic, PMIC),
> +	MAX20024_SUB_MODULE_NO_RES(pinctrl, PINCTRL),
> +	MAX20024_SUB_MODULE_NO_RES(clk, CLK),
> +	MAX20024_SUB_MODULE_NO_RES(power-off, POWER_OFF),
> +	MAX20024_SUB_MODULE_NO_RES(wdt, WDT),
> +	MAX20024_SUB_MODULE_RES(thermal, THERMAL),
> +};
> +
> +static struct mfd_cell max77620_20024_rtc = {
> +	.name		= "max77620-rtc",
> +	.num_resources	= ARRAY_SIZE(rtc_resources),
> +	.resources	= rtc_resources,
> +	.id = MAX77620_RTC_ID,
> +};
> +
> +struct max77620_sub_modules {
> +	struct mfd_cell *cells;
> +	int ncells;
> +	u32 id;
> +};
> +
> +static const struct max77620_sub_modules max77620_cells = {
> +	.cells = max77620_children,
> +	.ncells = ARRAY_SIZE(max77620_children),
> +	.id = MAX77620,
> +};
> +
> +static const struct max77620_sub_modules  max20024_cells = {
> +	.cells = max20024_children,
> +	.ncells = ARRAY_SIZE(max20024_children),
> +	.id = MAX20024,
> +};
> +
> +
> +static const struct of_device_id max77620_of_match[] = {
> +	{
> +		.compatible = "maxim,max77620",
> +		.data = &max77620_cells,
> +	}, {
> +		.compatible = "maxim,max20024",
> +		.data = &max20024_cells,
> +	}, {
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, max77620_of_match);
> +
> +static struct regmap_irq_chip max77620_top_irq_chip = {
> +	.name = "max77620-top",
> +	.irqs = max77620_top_irqs,
> +	.num_irqs = ARRAY_SIZE(max77620_top_irqs),
> +	.num_regs = 2,
> +	.status_base = MAX77620_REG_IRQTOP,
> +	.mask_base = MAX77620_REG_IRQTOPM,
> +};
> +
> +static const struct regmap_range max77620_readable_ranges[] = {
> +	regmap_reg_range(MAX77620_REG_CNFGGLBL1, MAX77620_REG_DVSSD4),
> +};
> +
> +static const struct regmap_access_table max77620_readable_table = {
> +	.yes_ranges = max77620_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(max77620_readable_ranges),
> +};
> +
> +static const struct regmap_range max20024_readable_ranges[] = {
> +	regmap_reg_range(MAX77620_REG_CNFGGLBL1, MAX77620_REG_DVSSD4),
> +	regmap_reg_range(MAX20024_REG_MAX_ADD, MAX20024_REG_MAX_ADD),
> +};
> +
> +static const struct regmap_access_table max20024_readable_table = {
> +	.yes_ranges = max20024_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(max20024_readable_ranges),
> +};
> +
> +static const struct regmap_range max77620_writable_ranges[] = {
> +	regmap_reg_range(MAX77620_REG_CNFGGLBL1, MAX77620_REG_DVSSD4),
> +};
> +
> +static const struct regmap_access_table max77620_writable_table = {
> +	.yes_ranges = max77620_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(max77620_writable_ranges),
> +};
> +
> +static const struct regmap_range max77620_cacheable_ranges[] = {
> +	regmap_reg_range(MAX77620_REG_SD0_CFG, MAX77620_REG_LDO_CFG3),
> +	regmap_reg_range(MAX77620_REG_FPS_CFG0, MAX77620_REG_FPS_SD3),
> +};
> +
> +static const struct regmap_access_table max77620_volatile_table = {
> +	.no_ranges = max77620_cacheable_ranges,
> +	.n_no_ranges = ARRAY_SIZE(max77620_cacheable_ranges),
> +};
> +
> +static const struct regmap_config max77620_regmap_config[] = {
> +	[MAX77620_PWR_SLAVE] = {
> +		.name = "power-slave",
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = MAX77620_REG_DVSSD4 + 1,
> +		.cache_type = REGCACHE_RBTREE,
> +		.rd_table = &max77620_readable_table,
> +		.wr_table = &max77620_writable_table,
> +		.volatile_table = &max77620_volatile_table,
> +	},
> +	[MAX77620_RTC_SLAVE] = {
> +		.name = "rtc-slave",
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = 0x1b,
> +	},
> +};
> +
> +static const struct regmap_config max20024_regmap_config[] = {
> +	[MAX77620_PWR_SLAVE] = {
> +		.name = "power-slave",
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = MAX20024_REG_MAX_ADD + 1,
> +		.cache_type = REGCACHE_RBTREE,
> +		.rd_table = &max20024_readable_table,
> +		.wr_table = &max77620_writable_table,
> +		.volatile_table = &max77620_volatile_table,
> +	},
> +	[MAX77620_RTC_SLAVE] = {
> +		.name = "rtc-slave",
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = 0x1b,
> +	},
> +};
> +
> +static int max77620_slave_address[MAX77620_NUM_SLAVES] = {
> +	MAX77620_PWR_I2C_ADDR,
> +	MAX77620_RTC_I2C_ADDR,
> +};
> +
> +int max77620_irq_get_virq(struct device *dev, int irq)
> +{
> +	struct max77620_chip *chip = dev_get_drvdata(dev);
> +
> +	return regmap_irq_get_virq(chip->top_irq_data, irq);
> +}
> +EXPORT_SYMBOL_GPL(max77620_irq_get_virq);
> +
> +int max77620_reg_write(struct device *dev, int sid,
> +		unsigned int reg, u8 val)
> +{
> +	struct max77620_chip *chip = dev_get_drvdata(dev);
> +
> +	return regmap_write(chip->rmap[sid], reg, val);
> +}
> +EXPORT_SYMBOL_GPL(max77620_reg_write);
> +
> +int max77620_reg_read(struct device *dev, int sid,
> +		unsigned int reg, u8 *val)
> +{
> +	struct max77620_chip *chip = dev_get_drvdata(dev);
> +	unsigned int ival;
> +	int ret;
> +
> +	ret = regmap_read(chip->rmap[sid], reg, &ival);
> +	if (ret < 0)
> +		return ret;
> +	*val = ival;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(max77620_reg_read);
> +
> +int max77620_reg_update(struct device *dev, int sid,
> +		unsigned int reg, unsigned int mask, unsigned int val)
> +{
> +	struct max77620_chip *chip = dev_get_drvdata(dev);
> +
> +	return regmap_update_bits(chip->rmap[sid], reg, mask, val);
> +}
> +EXPORT_SYMBOL_GPL(max77620_reg_update);
> +
> +static int max77620_get_fps_period_reg_value(struct max77620_chip *chip,
> +		int tperiod)
> +{
> +	int base_fps_time = (chip->id == MAX20024) ? 20 : 40;
> +	int x, i;
> +
> +	for (i = 0; i < 0x7; ++i) {
> +		x = base_fps_time * BIT(i);
> +		if (x >= tperiod)
> +			return i;
> +	}
> +
> +	return i;
> +}
> +
> +static int max77620_config_fps(struct max77620_chip *chip,
> +		struct device_node *fps_np)
> +{
> +	struct device *dev = chip->dev;
> +	unsigned int mask = 0, config = 0;
> +	int input_enable = 2;
> +	u32 pval;
> +	int tperiod, fps_id;
> +	int ret;
> +
> +	ret = of_property_read_u32(fps_np, "reg", &pval);
> +	if (ret < 0) {
> +		dev_err(dev, "reg prop missing from node %s\n", fps_np->name);
> +		return 0;
> +	}
> +	if (pval > 2) {
> +		dev_err(dev, "FPS%u is not supported\n", pval);
> +		return 0;
> +	}
> +	fps_id = pval;
> +
> +	ret = of_property_read_u32(fps_np,
> +			"maxim,active-fps-time-period", &pval);
> +	if (!ret) {
> +		mask |= MAX77620_FPS_TIME_PERIOD_MASK;
> +		chip->active_fps_period[fps_id] = min(pval, 5120U);
> +		tperiod = max77620_get_fps_period_reg_value(chip,
> +					chip->active_fps_period[fps_id]);
> +		config |= tperiod << MAX77620_FPS_TIME_PERIOD_SHIFT;
> +	}
> +
> +	ret = of_property_read_u32(fps_np,
> +			"maxim,suspend-fps-time-period", &pval);
> +	if (!ret)
> +		chip->suspend_fps_period[fps_id] = min(pval, 5120U);
> +
> +	ret = of_property_read_u32(fps_np, "maxim,fps-enable-input", &pval);
> +	if (!ret) {
> +		if (pval > 2) {
> +			dev_err(dev, "FPS %d enable-input invalid\n", fps_id);
> +		} else {
> +			input_enable = pval;
> +			mask |= MAX77620_FPS_EN_SRC_MASK;
> +		}
> +	}
> +	config |= (input_enable & 0x3) << MAX77620_FPS_EN_SRC_SHIFT;
> +
> +	if (input_enable == 2) {
> +		bool enable_fps = of_property_read_bool(fps_np,
> +					"maxim,fps-sw-enable");
> +		mask |= MAX77620_FPS_ENFPS_MASK;
> +		if (enable_fps)
> +			config |= 1;
> +	}
> +
> +	if (!chip->sleep_enable)
> +		chip->sleep_enable = of_property_read_bool(fps_np,
> +					"maxim,enable-sleep");
> +	if (!chip->enable_global_lpm)
> +		chip->enable_global_lpm = of_property_read_bool(fps_np,
> +					"maxim,enable-global-lpm");
> +
> +	ret = max77620_reg_update(dev, MAX77620_PWR_SLAVE,
> +			MAX77620_REG_FPS_CFG0 + fps_id, mask, config);
> +	if (ret < 0) {
> +		dev_err(dev, "Reg 0x%02x write failed: %d\n",
> +			MAX77620_REG_FPS_CFG0 + fps_id, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_initialise_fps(struct max77620_chip *chip,
> +			struct device *dev)
> +{
> +	struct device_node *fps_np, *fps_child;
> +	u8 config;
> +	int fps_id;
> +	int ret;
> +
> +	for (fps_id = 0; fps_id < 3; ++fps_id) {
> +		chip->active_fps_period[fps_id] = -1;
> +		chip->suspend_fps_period[fps_id] = -1;
> +	}
> +
> +	fps_np = of_get_child_by_name(dev->of_node, "fps");
> +	if (!fps_np)
> +		goto skip_fps;
> +
> +	for_each_child_of_node(fps_np, fps_child) {
> +		ret = max77620_config_fps(chip, fps_child);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	config = chip->enable_global_lpm ? MAX77620_ONOFFCNFG2_SLP_LPM_MSK : 0;
> +	ret = max77620_reg_update(chip->dev, MAX77620_PWR_SLAVE,
> +			MAX77620_REG_ONOFFCNFG2,
> +			MAX77620_ONOFFCNFG2_SLP_LPM_MSK, config);
> +	if (ret < 0) {
> +		dev_err(dev, "Reg ONOFFCNFG2 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +skip_fps:
> +	/* Enable wake on EN0 pin */
> +	ret = max77620_reg_update(chip->dev, MAX77620_PWR_SLAVE,
> +			MAX77620_REG_ONOFFCNFG2, MAX77620_ONOFFCNFG2_WK_EN0,
> +			MAX77620_ONOFFCNFG2_WK_EN0);
> +	if (ret < 0) {
> +		dev_err(dev, "Reg ONOFFCNFG2 WK_EN0 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!chip->sleep_enable)
> +		chip->sleep_enable = of_property_read_bool(dev->of_node,
> +						"maxim,enable-sleep");
> +
> +	/* For MAX20024, SLPEN will be POR reset if CLRSE is b11 */
> +	if ((chip->id == MAX20024) && chip->sleep_enable) {
> +		config = MAX77620_ONOFFCNFG1_SLPEN | MAX20024_ONOFFCNFG1_CLRSE;
> +		ret = max77620_reg_update(chip->dev, MAX77620_PWR_SLAVE,
> +			MAX77620_REG_ONOFFCNFG1, config, config);
> +		if (ret < 0) {
> +			dev_err(dev, "Reg ONOFFCNFG1 update failed: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_init_backup_battery_charging(struct max77620_chip *chip,
> +		struct device *dev)
> +{
> +	struct device_node *bb_node;
> +	u32 pval;
> +	u8 config;
> +	int ret;
> +
> +	bb_node = of_get_child_by_name(dev->of_node, "backup-battery");
> +	if (!bb_node) {
> +		dev_info(dev, "Backup battery charging support disabled\n");
> +		max77620_reg_update(chip->dev, MAX77620_PWR_SLAVE,
> +			MAX77620_REG_CNFGBBC, MAX77620_CNFGBBC_ENABLE, 0);
> +		return 0;
> +	}
> +
> +	config = MAX77620_CNFGBBC_ENABLE;
> +	ret = of_property_read_u32(bb_node,
> +			"maxim,bb-charging-current-microamp", &pval);
> +	if (ret < 0)
> +		pval = 50;
> +	if (pval <= 50)
> +		config |= 0 << MAX77620_CNFGBBC_CURRENT_SHIFT;
> +	else if (pval <= 100)
> +		config |= 3 << MAX77620_CNFGBBC_CURRENT_SHIFT;
> +	else if (pval <= 200)
> +		config |= 0 << MAX77620_CNFGBBC_CURRENT_SHIFT;
> +	else if (pval <= 400)
> +		config |= 3 << MAX77620_CNFGBBC_CURRENT_SHIFT;
> +	else if (pval <= 600)
> +		config |= 1 << MAX77620_CNFGBBC_CURRENT_SHIFT;
> +	else
> +		config |= 2 << MAX77620_CNFGBBC_CURRENT_SHIFT;
> +
> +	if (pval > 100)
> +		config |= MAX77620_CNFGBBC_LOW_CURRENT_DISABLE;
> +
> +	ret = of_property_read_u32(bb_node,
> +			"maxim,bb-charging-voltage-microvolt", &pval);
> +	if (ret < 0)
> +		pval = 2500000;
> +	pval /= 1000;
> +	if (pval <= 2500)
> +		config |= 0 << MAX77620_CNFGBBC_VOLTAGE_SHIFT;
> +	else if (pval <= 3000)
> +		config |= 1 << MAX77620_CNFGBBC_VOLTAGE_SHIFT;
> +	else if (pval <= 3300)
> +		config |= 2 << MAX77620_CNFGBBC_VOLTAGE_SHIFT;
> +	else
> +		config |= 3 << MAX77620_CNFGBBC_VOLTAGE_SHIFT;
> +
> +	ret = of_property_read_u32(bb_node,
> +			"maxim,bb-output-resister-ohm", &pval);
> +	if (ret < 0)
> +		pval = 1000;
> +
> +	if (pval <= 100)
> +		config |= 0 << MAX77620_CNFGBBC_RESISTOR_SHIFT;
> +	else if (pval <= 1000)
> +		config |= 1 << MAX77620_CNFGBBC_RESISTOR_SHIFT;
> +	else if (pval <= 3000)
> +		config |= 2 << MAX77620_CNFGBBC_RESISTOR_SHIFT;
> +	else if (pval <= 6000)
> +		config |= 3 << MAX77620_CNFGBBC_RESISTOR_SHIFT;
> +
> +	ret = max77620_reg_write(dev, MAX77620_PWR_SLAVE,
> +			MAX77620_REG_CNFGBBC, config);
> +	if (ret < 0) {
> +		dev_err(dev, "Reg 0x%02x write failed: %d\n",
> +			MAX77620_REG_CNFGBBC, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_init_low_battery_monitor(struct max77620_chip *chip,
> +		struct device *dev)
> +{
> +	struct device_node *np;
> +	u8 mask = 0, val = 0;
> +	u32 pval;
> +	int ret;
> +
> +	np = of_get_child_by_name(dev->of_node, "low-battery-monitor");
> +	if (!np)
> +		return 0;
> +
> +	ret = of_property_read_u32(np, "maxim,low-battery-dac", &pval);
> +	if (!ret) {
> +		mask |= MAX77620_CNFGGLBL1_LBDAC_EN;
> +		if (pval)
> +			val |= MAX77620_CNFGGLBL1_LBDAC_EN;
> +	}
> +
> +	ret = of_property_read_u32(np, "maxim,low-battery-shutdown", &pval);
> +	if (!ret) {
> +		mask |= MAX77620_CNFGGLBL1_MPPLD;
> +		if (pval)
> +			val |= MAX77620_CNFGGLBL1_MPPLD;
> +	}
> +
> +	ret = of_property_read_u32(np, "maxim,low-battery-reset", &pval);
> +	if (!ret) {
> +		mask |= MAX77620_CNFGGLBL1_LBRSTEN;
> +		if (pval)
> +			val |= MAX77620_CNFGGLBL1_LBRSTEN;
> +	}
> +
> +	if (mask) {
> +		ret = max77620_reg_update(dev, MAX77620_PWR_SLAVE,
> +			MAX77620_REG_CNFGGLBL1, mask, val);
> +		if (ret < 0)
> +			dev_err(dev, "Reg CNFGGLBL1 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77620_initialise_chip(struct max77620_chip *chip,
> +			struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	u32 mrt_time = 0;
> +	u8 reg_val;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "maxim,hard-power-off-time", &mrt_time);
> +	if (ret < 0)
> +		return 0;
> +
> +	mrt_time = (mrt_time > 12) ? 12 : mrt_time;
> +	if (mrt_time <= 6)
> +		reg_val = mrt_time - 2;
> +	else
> +		reg_val = (mrt_time - 6) / 2 + 4;
> +
> +	reg_val <<= MAX77620_ONOFFCNFG1_MRT_SHIFT;
> +
> +	ret = max77620_reg_update(dev, MAX77620_PWR_SLAVE,
> +			MAX77620_REG_ONOFFCNFG1, MAX77620_ONOFFCNFG1_MRT_MASK,
> +			reg_val);
> +	if (ret < 0) {
> +		dev_err(dev, "REG ONOFFCNFG1 update failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Disable alarm wake to enable sleep from EN input signal */
> +	ret = max77620_reg_update(dev, MAX77620_PWR_SLAVE,
> +		MAX77620_REG_ONOFFCNFG2, MAX77620_ONOFFCNFG2_WK_ALARM1, 0);
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
> +	u8 val, cid_val[6];
> +	int i;
> +	int ret;
> +
> +	for (i = MAX77620_REG_CID0; i <= MAX77620_REG_CID5; ++i) {
> +		ret = max77620_reg_read(chip->dev, MAX77620_PWR_SLAVE, i, &val);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "CID%d register read failed: %d\n",
> +					i - MAX77620_REG_CID0, ret);
> +			return ret;
> +		}
> +		dev_dbg(chip->dev, "CID%d: 0x%02x\n",
> +			i - MAX77620_REG_CID0, val);
> +		cid_val[i - MAX77620_REG_CID0] = val;
> +	}
> +
> +	/* CID4 is OTP Version */
> +	dev_info(chip->dev, "MAX77620 PMIC OTP Version: 0x%02X\n", cid_val[4]);
> +
> +	/* CID5 is ES version */
> +	dev_info(chip->dev, "MAX77620 PMIC ES version: 1.%d\n",
> +				MAX77620_CID5_DIDM(cid_val[5]));
> +
> +	/* Read NVERC register */
> +	ret = max77620_reg_read(chip->dev, MAX77620_PWR_SLAVE,
> +			MAX77620_REG_NVERC, &val);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "NVERC read failed: %d\n", ret);
> +		return ret;
> +	}
> +	dev_dbg(chip->dev, "NVERC = 0x%02x\n", val);
> +	for (i = 0; i < 8; ++i) {
> +		if (val & BIT(i))
> +			dev_info(chip->dev, "NVERC: %s\n", max77620_nverc[i]);

You are still printing two dev_info (OTP, ES) and here NVERC (probably
one?). This will be printed on each boot, over and over, till the user
will learn it and will remember it forever :).

>From my point of view: one dev_info for one probed device.

I don't know if others agree with that, though. What's your opinion Lee?



> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t max77620_mbattlow_irq(int irq, void *data)
> +{
> +	struct max77620_chip *max77620 = data;
> +
> +	dev_dbg(max77620->dev, "MBATTLOW interrupt occurred\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int max77620_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct device_node *node = client->dev.of_node;
> +	const struct max77620_sub_modules *children;
> +	const struct of_device_id *match;
> +	const struct regmap_config *rmap_config = max77620_regmap_config;
> +	struct max77620_chip *chip;
> +	int i = 0;
> +	int ret = 0;
> +
> +	if (!node) {
> +		dev_err(&client->dev, "Device is not from DT\n");
> +		return -ENODEV;
> +	}
> +
> +	match = of_match_device(max77620_of_match, &client->dev);
> +	children = match->data;

You can just use of_device_get_match_data() thus removing "match" variable.

> +	if (!children)
> +		return -ENODEV;
> +
> +	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, chip);
> +	chip->dev = &client->dev;
> +	chip->irq_base = -1;
> +	chip->chip_irq = client->irq;
> +	chip->id = children->id;
> +
> +	if (chip->id == MAX20024)
> +		rmap_config = max20024_regmap_config;
> +
> +	mutex_init(&chip->mutex_config);
> +
> +	for (i = 0; i < MAX77620_NUM_SLAVES; i++) {
> +		if (max77620_slave_address[i] == client->addr)
> +			chip->clients[i] = client;
> +		else
> +			chip->clients[i] = i2c_new_dummy(client->adapter,
> +						max77620_slave_address[i]);
> +		if (!chip->clients[i]) {
> +			dev_err(&client->dev, "can't attach client %d\n", i);
> +			ret = -ENOMEM;
> +			goto fail_client_reg;
> +		}
> +
> +		chip->clients[i]->dev.of_node = node;
> +		i2c_set_clientdata(chip->clients[i], chip);
> +		chip->rmap[i] = devm_regmap_init_i2c(chip->clients[i],
> +					&rmap_config[i]);
> +		if (IS_ERR(chip->rmap[i])) {
> +			ret = PTR_ERR(chip->rmap[i]);
> +			dev_err(&client->dev,
> +				"regmap %d init failed, err %d\n", i, ret);
> +			goto fail_client_reg;
> +		}
> +	}
> +
> +	ret = max77620_read_es_version(chip);
> +	if (ret < 0)
> +		goto fail_client_reg;
> +
> +	ret = max77620_initialise_chip(chip, &client->dev);
> +	if (ret < 0)
> +		goto fail_client_reg;
> +
> +	ret = regmap_add_irq_chip(chip->rmap[MAX77620_PWR_SLAVE],
> +		chip->chip_irq, IRQF_ONESHOT | IRQF_SHARED, chip->irq_base,

Why do you need IRQF_SHARED?

> +		&max77620_top_irq_chip, &chip->top_irq_data);

More tabs needed for indentation of arguments.

Actually the alignment of arguments here is mixed. Sometimes arguments
are aligned with opening parenthesis, mostly not. Can you make it
consistent - always aligned?

Thank you for implementing the comments pointed for v1. Overall the MFD
part here looks good for me.

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
