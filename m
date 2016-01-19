Return-Path: <rtc-linux+bncBDKZNNNLXAHBB64L662AKGQEAF5OSWI@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id i25si2836337pfj.2.2016.01.18.21.13.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 18 Jan 2016 21:13:31 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1600FRGP6EZA20@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 19 Jan 2016 05:13:26 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V3 2/5] mfd: max77620: add core driver for MAX77620/MAX20024
To: Laxman Dewangan <ldewangan@nvidia.com>, robh+dt@kernel.org,
 pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
 lee.jones@linaro.org, broonie@kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com
References: <1452771166-13694-1-git-send-email-ldewangan@nvidia.com>
 <1452771166-13694-3-git-send-email-ldewangan@nvidia.com>
Cc: lgirdwood@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
 Chaitanya Bandi <bandik@nvidia.com>, Mallikarjun Kasoju <mkasoju@nvidia.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <569DC5ED.6070303@samsung.com>
Date: Tue, 19 Jan 2016 14:13:17 +0900
MIME-version: 1.0
In-reply-to: <1452771166-13694-3-git-send-email-ldewangan@nvidia.com>
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

On 14.01.2016 20:32, Laxman Dewangan wrote:
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
> Changes from V1:
> - Code cleanups per review from V1. 
> - Move register acccess APIs from header to c file.
> - Remove some of non required variable, remove duplication in error message
>  and simplify some of function implementation.
> - Register RTC driver such that it can get the regmap handle form parent device
> Changes from V2:
> - Run coccicheck and checkpatch in strict mode for the alignment.
> - Drop RTC driver and its i2c client registration.
> 
>  drivers/mfd/Kconfig          |  15 +
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77620.c       | 898 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77620.h | 402 +++++++++++++++++++
>  4 files changed, 1316 insertions(+)
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
> index 0000000..e965261
> --- /dev/null
> +++ b/drivers/mfd/max77620.c
> @@ -0,0 +1,898 @@
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

This looks unused.

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
> +static const struct regmap_config max77620_regmap_config = {
> +	.name = "power-slave",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MAX77620_REG_DVSSD4 + 1,
> +	.cache_type = REGCACHE_RBTREE,
> +	.rd_table = &max77620_readable_table,
> +	.wr_table = &max77620_writable_table,
> +	.volatile_table = &max77620_volatile_table,
> +};
> +
> +static const struct regmap_config max20024_regmap_config = {
> +	.name = "power-slave",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MAX20024_REG_MAX_ADD + 1,
> +	.cache_type = REGCACHE_RBTREE,
> +	.rd_table = &max20024_readable_table,
> +	.wr_table = &max77620_writable_table,
> +	.volatile_table = &max77620_volatile_table,
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
> +int max77620_reg_write(struct device *dev, unsigned int reg, u8 val)

Any special need why val is u8 (here and in max77620_reg_read())? The
regmap API and max77620_reg_update() use unsigned int.

Operate on unsigned ints, if it is possible. It makes everything more
consistent and easier to spot eventual wrong casts.

[...]

> diff --git a/include/linux/mfd/max77620.h b/include/linux/mfd/max77620.h
> new file mode 100644
> index 0000000..2bb4829
> --- /dev/null
> +++ b/include/linux/mfd/max77620.h
> @@ -0,0 +1,402 @@
> +/*
> + * max77620.h: Defining registers address and its bit definitions
> + *	of MAX77620 and	MAX20024
> + *
> + * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
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
> +#define  MAX77620_SDX_VOLT_MASK			0xFF
> +#define  MAX77620_SD0_VOLT_MASK			0x3F
> +#define  MAX77620_SD1_VOLT_MASK			0x7F

Duplicated space after #define

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
> +#define MAX77620_FPS_ENFPS_MASK			0x01
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
> +#define	MAX77620_GLBLM_MASK			BIT(0)

Use one space after #define.

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
