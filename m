Return-Path: <rtc-linux+bncBAABBJGP4S5AKGQEKXVJLUY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from root.phytec.de (mail.x-arc.co.uk. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id x203si160578wme.0.2016.06.09.01.24.03
        for <rtc-linux@googlegroups.com>;
        Thu, 09 Jun 2016 01:24:03 -0700 (PDT)
Subject: [rtc-linux] Re: [RESEND PATCH v5 1/5] mfd: RK808: Add RK818 support
To: Lee Jones <lee.jones@linaro.org>
References: <1464850228-17244-1-git-send-email-w.egorov@phytec.de>
 <20160608141735.GE14888@dell>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, dianders@chromium.org, zyw@rock-chips.com
From: Wadim Egorov <w.egorov@phytec.de>
Message-ID: <5759277D.7090101@phytec.de>
Date: Thu, 9 Jun 2016 10:23:25 +0200
MIME-Version: 1.0
In-Reply-To: <20160608141735.GE14888@dell>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 08.06.2016 16:17, Lee Jones wrote:
> On Thu, 02 Jun 2016, Wadim Egorov wrote:
>
>> The RK818 chip is a power management IC for multimedia and handheld
> "Power Management IC (PMIC)"
>
>> devices. It contains the following components:
>>
>> - Regulators
>> - RTC
>> - Clkout
> Clocking
>
>> - battery support
> Battery support
>
>> Both chips RK808 and RK818 are using a similar register map.
> "Both RK808 ad RK818 chips"
>
>> So we can reuse the RTC and Clkout functionality.
> Swap '.' for ','.
>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>  drivers/mfd/Kconfig       |   4 +-
>>  drivers/mfd/rk808.c       | 231 ++++++++++++++++++++++++++++++++++++++--------
>>  include/linux/mfd/rk808.h | 162 ++++++++++++++++++++++++++++++--
>>  3 files changed, 350 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 1bcf601..7ba464b 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -839,13 +839,13 @@ config MFD_RC5T583
>>  	  different functionality of the device.
>>  
>>  config MFD_RK808
>> -	tristate "Rockchip RK808 Power Management chip"
>> +	tristate "Rockchip RK808/RK818 Power Management chip"
> "Chip"
>
>>  	depends on I2C && OF
>>  	select MFD_CORE
>>  	select REGMAP_I2C
>>  	select REGMAP_IRQ
>>  	help
>> -	  If you say yes here you get support for the RK808
>> +	  If you say yes here you get support for the RK808 and RK818
>>  	  Power Management chips.
>>  	  This driver provides common support for accessing the device
>>  	  through I2C interface. The device supports multiple sub-devices
>> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
>> index 49d7f62..3cf9724 100644
>> --- a/drivers/mfd/rk808.c
>> +++ b/drivers/mfd/rk808.c
>> @@ -1,11 +1,15 @@
>>  /*
>> - * MFD core driver for Rockchip RK808
>> + * MFD core driver for Rockchip RK808/RK818
>>   *
>>   * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>>   *
>>   * Author: Chris Zhong <zyw@rock-chips.com>
>>   * Author: Zhang Qing <zhangqing@rock-chips.com>
>>   *
>> + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
>> + *
>> + * Author: Wadim Egorov <w.egorov@phytec.de>
>> + *
>>   * This program is free software; you can redistribute it and/or modify it
>>   * under the terms and conditions of the GNU General Public License,
>>   * version 2, as published by the Free Software Foundation.
>> @@ -22,12 +26,7 @@
>>  #include <linux/mfd/core.h>
>>  #include <linux/module.h>
>>  #include <linux/regmap.h>
>> -
>> -struct rk808_reg_data {
>> -	int addr;
>> -	int mask;
>> -	int value;
>> -};
> Why are you moving this to the header?

It is now part of the rk808 struct.

>
>> +#include <linux/of_device.h>
>>  
>>  static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
>>  {
>> @@ -57,6 +56,14 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
>>  	return false;
>>  }
>>  
>> +static const struct regmap_config rk818_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.max_register = RK818_USB_CTRL_REG,
>> +	.cache_type = REGCACHE_RBTREE,
>> +	.volatile_reg = rk808_is_volatile_reg,
>> +};
>> +
>>  static const struct regmap_config rk808_regmap_config = {
>>  	.reg_bits = 8,
>>  	.val_bits = 8,
>> @@ -83,7 +90,17 @@ static const struct mfd_cell rk808s[] = {
>>  	},
>>  };
>>  
>> -static const struct rk808_reg_data pre_init_reg[] = {
>> +static const struct mfd_cell rk818s[] = {
>> +	{ .name = "rk808-clkout", },
> How does this differ to a normal -clock driver?

I don't know. It is a normal clock driver.

>
>> +	{ .name = "rk808-regulator", },
>> +	{
>> +		.name = "rk808-rtc",
>> +		.num_resources = ARRAY_SIZE(rtc_resources),
>> +		.resources = &rtc_resources[0],
> .resources = rtc_resources,  ?
>
>> +	},
>> +};
>> +
>> +static const struct rk8xx_reg_data rk808_pre_init_reg[] = {
>>  	{ RK808_BUCK3_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_150MA },
>>  	{ RK808_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_200MA },
>>  	{ RK808_BOOST_CONFIG_REG, BOOST_ILMIN_MASK, BOOST_ILMIN_100MA },
>> @@ -94,6 +111,22 @@ static const struct rk808_reg_data pre_init_reg[] = {
>>  						    VB_LO_SEL_3500MV },
>>  };
>>  
>> +static const struct rk8xx_reg_data rk818_pre_init_reg[] = {
>> +	{ RK818_USB_CTRL_REG,	RK818_USB_ILIM_SEL_MASK,
>> +						RK818_USB_ILMIN_2000MA },
>> +	/* close charger when usb lower then 3.4V */
>> +	{ RK818_USB_CTRL_REG,	RK818_USB_CHG_SD_VSEL_MASK, (0x7 << 4) },
>> +	/* no action when vref */
>> +	{ RK818_H5V_EN_REG,	BIT(1),		RK818_REF_RDY_CTRL },
>> +	/* enable HDMI 5V */
>> +	{ RK818_H5V_EN_REG,	BIT(0),		RK818_H5V_EN },
>> +	/* improve efficiency */
>> +	{ RK818_BUCK2_CONFIG_REG, BUCK2_RATE_MASK,	BUCK_ILMIN_250MA },
>> +	{ RK818_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,	BUCK_ILMIN_250MA },
>> +	{ RK818_BOOST_CONFIG_REG, BOOST_ILMIN_MASK,	BOOST_ILMIN_100MA },
>> +	{ RK808_VB_MON_REG,	MASK_ALL,	VB_LO_ACT | VB_LO_SEL_3500MV },
>> +};
> The alignment here looks odd.

I will fix it in the next version.

>
>>  static const struct regmap_irq rk808_irqs[] = {
>>  	/* INT_STS */
>>  	[RK808_IRQ_VOUT_LO] = {
>> @@ -136,6 +169,76 @@ static const struct regmap_irq rk808_irqs[] = {
>>  	},
>>  };
>>  
>> +static const struct regmap_irq rk818_irqs[] = {
>> +	/* INT_STS */
>> +	[RK818_IRQ_VOUT_LO] = {
>> +		.mask = RK818_IRQ_VOUT_LO_MSK,
>> +		.reg_offset = 0,
>> +	},
>> +	[RK818_IRQ_VB_LO] = {
>> +		.mask = RK818_IRQ_VB_LO_MSK,
>> +		.reg_offset = 0,
>> +	},
>> +	[RK818_IRQ_PWRON] = {
>> +		.mask = RK818_IRQ_PWRON_MSK,
>> +		.reg_offset = 0,
>> +	},
>> +	[RK818_IRQ_PWRON_LP] = {
>> +		.mask = RK818_IRQ_PWRON_LP_MSK,
>> +		.reg_offset = 0,
>> +	},
>> +	[RK818_IRQ_HOTDIE] = {
>> +		.mask = RK818_IRQ_HOTDIE_MSK,
>> +		.reg_offset = 0,
>> +	},
>> +	[RK818_IRQ_RTC_ALARM] = {
>> +		.mask = RK818_IRQ_RTC_ALARM_MSK,
>> +		.reg_offset = 0,
>> +	},
>> +	[RK818_IRQ_RTC_PERIOD] = {
>> +		.mask = RK818_IRQ_RTC_PERIOD_MSK,
>> +		.reg_offset = 0,
>> +	},
>> +	[RK818_IRQ_USB_OV] = {
>> +		.mask = RK818_IRQ_USB_OV_MSK,
>> +		.reg_offset = 0,
>> +	},
>> +
>> +	/* INT_STS2 */
>> +	[RK818_IRQ_PLUG_IN] = {
>> +		.mask = RK818_IRQ_PLUG_IN_MSK,
>> +		.reg_offset = 1,
>> +	},
>> +	[RK818_IRQ_PLUG_OUT] = {
>> +		.mask = RK818_IRQ_PLUG_OUT_MSK,
>> +		.reg_offset = 1,
>> +	},
>> +	[RK818_IRQ_CHG_OK] = {
>> +		.mask = RK818_IRQ_CHG_OK_MSK,
>> +		.reg_offset = 1,
>> +	},
>> +	[RK818_IRQ_CHG_TE] = {
>> +		.mask = RK818_IRQ_CHG_TE_MSK,
>> +		.reg_offset = 1,
>> +	},
>> +	[RK818_IRQ_CHG_TS1] = {
>> +		.mask = RK818_IRQ_CHG_TS1_MSK,
>> +		.reg_offset = 1,
>> +	},
>> +	[RK818_IRQ_TS2] = {
>> +		.mask = RK818_IRQ_TS2_MSK,
>> +		.reg_offset = 1,
>> +	},
>> +	[RK818_IRQ_CHG_CVTLIM] = {
>> +		.mask = RK818_IRQ_CHG_CVTLIM_MSK,
>> +		.reg_offset = 1,
>> +	},
>> +	[RK818_IRQ_DISCHG_ILIM] = {
>> +		.mask = RK818_IRQ_DISCHG_ILIM_MSK,
>> +		.reg_offset = 1,
>> +	},
>> +};
>> +
>>  static struct regmap_irq_chip rk808_irq_chip = {
>>  	.name = "rk808",
>>  	.irqs = rk808_irqs,
>> @@ -148,6 +251,18 @@ static struct regmap_irq_chip rk808_irq_chip = {
>>  	.init_ack_masked = true,
>>  };
>>  
>> +static struct regmap_irq_chip rk818_irq_chip = {
>> +	.name = "rk818",
>> +	.irqs = rk818_irqs,
>> +	.num_irqs = ARRAY_SIZE(rk818_irqs),
>> +	.num_regs = 2,
>> +	.irq_reg_stride = 2,
>> +	.status_base = RK818_INT_STS_REG1,
>> +	.mask_base = RK818_INT_STS_MSK_REG1,
>> +	.ack_base = RK818_INT_STS_REG1,
>> +	.init_ack_masked = true,
>> +};
>> +
>>  static struct i2c_client *rk808_i2c_client;
>>  static void rk808_device_shutdown(void)
>>  {
>> @@ -167,6 +282,48 @@ static void rk808_device_shutdown(void)
>>  		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>>  }
>>  
>> +static const struct of_device_id rk808_of_match[] = {
>> +	{ .compatible = "rockchip,rk808", .data = (void *) RK808_ID },
>> +	{ .compatible = "rockchip,rk818", .data = (void *) RK818_ID },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, rk808_of_match);
>> +
>> +static int rk8xx_match_device(struct rk808 *rk808, struct device *dev)
> If you're going to do it this way, please switch these parameters.
>
> It's more common to return the pointer however.

If it's more common I will return a pointer to rk808.

>
>> +{
>> +	const struct of_device_id *of_id;
>> +
>> +	of_id = of_match_device(rk808_of_match, dev);
>> +	if (!of_id) {
>> +		dev_err(dev, "Unable to match OF ID\n");
>> +		return -ENODEV;
>> +	}
>> +	rk808->variant = (long) of_id->data;
>> +
>> +	switch (rk808->variant) {
>> +	case RK808_ID:
>> +		rk808->nr_cells = ARRAY_SIZE(rk808s);
>> +		rk808->cells = rk808s;
>> +		rk808->regmap_cfg = &rk808_regmap_config;
>> +		rk808->regmap_irq_chip = &rk808_irq_chip;
>> +		rk808->pre_init_reg = rk808_pre_init_reg;
>> +		rk808->nr_pre_init_regs = ARRAY_SIZE(rk808_pre_init_reg);
>> +		break;
>> +	case RK818_ID:
>> +		rk808->nr_cells = ARRAY_SIZE(rk818s);
>> +		rk808->cells = rk818s;
>> +		rk808->regmap_cfg = &rk818_regmap_config;
>> +		rk808->regmap_irq_chip = &rk818_irq_chip;
>> +		rk808->pre_init_reg = rk818_pre_init_reg;
>> +		rk808->nr_pre_init_regs = ARRAY_SIZE(rk818_pre_init_reg);
>> +		break;
>> +	default:
>> +		dev_err(dev, "unsupported RK8XX ID %lu\n", rk808->variant);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>>  static int rk808_probe(struct i2c_client *client,
>>  		       const struct i2c_device_id *id)
>>  {
>> @@ -176,46 +333,52 @@ static int rk808_probe(struct i2c_client *client,
>>  	int ret;
>>  	int i;
>>  
>> -	if (!client->irq) {
>> -		dev_err(&client->dev, "No interrupt support, no core IRQ\n");
>> -		return -EINVAL;
>> -	}
>> -
>>  	rk808 = devm_kzalloc(&client->dev, sizeof(*rk808), GFP_KERNEL);
>>  	if (!rk808)
>>  		return -ENOMEM;
>>  
>> -	rk808->regmap = devm_regmap_init_i2c(client, &rk808_regmap_config);
>> +	ret = rk8xx_match_device(rk808, &client->dev);
> Is there a way to dynamically probe the device?  No device ID you can
> read directly from the silicon?

AFAIK there is no device ID register. At least it is not documented in
the manual.

Wadim

>
>> +	if (ret)
>> +		return ret;
>> +
>> +	rk808->i2c = client;
>> +	i2c_set_clientdata(client, rk808);
>> +
>> +	rk808->regmap = devm_regmap_init_i2c(client, rk808->regmap_cfg);
>>  	if (IS_ERR(rk808->regmap)) {
>>  		dev_err(&client->dev, "regmap initialization failed\n");
>>  		return PTR_ERR(rk808->regmap);
>>  	}
>>  
>> -	for (i = 0; i < ARRAY_SIZE(pre_init_reg); i++) {
>> -		ret = regmap_update_bits(rk808->regmap, pre_init_reg[i].addr,
>> -					 pre_init_reg[i].mask,
>> -					 pre_init_reg[i].value);
>> -		if (ret) {
>> -			dev_err(&client->dev,
>> -				"0x%x write err\n", pre_init_reg[i].addr);
>> -			return ret;
>> -		}
>> +	if (!client->irq) {
>> +		dev_err(&client->dev, "No interrupt support, no core IRQ\n");
>> +		return -EINVAL;
>>  	}
>>  
>>  	ret = regmap_add_irq_chip(rk808->regmap, client->irq,
>>  				  IRQF_ONESHOT, -1,
>> -				  &rk808_irq_chip, &rk808->irq_data);
>> +				  rk808->regmap_irq_chip, &rk808->irq_data);
>>  	if (ret) {
>>  		dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
>>  		return ret;
>>  	}
>>  
>> -	rk808->i2c = client;
>> -	i2c_set_clientdata(client, rk808);
>> +	for (i = 0; i < rk808->nr_pre_init_regs; i++) {
>> +		ret = regmap_update_bits(rk808->regmap,
>> +					rk808->pre_init_reg[i].addr,
>> +					rk808->pre_init_reg[i].mask,
>> +					rk808->pre_init_reg[i].value);
>> +		if (ret) {
>> +			dev_err(&client->dev,
>> +				"0x%x write err\n",
>> +				rk808->pre_init_reg[i].addr);
>> +			return ret;
>> +		}
>> +	}
>>  
>> -	ret = devm_mfd_add_devices(&client->dev, -1,
>> -				   rk808s, ARRAY_SIZE(rk808s), NULL, 0,
>> -				   regmap_irq_get_domain(rk808->irq_data));
>> +	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
>> +			      rk808->cells, rk808->nr_cells, NULL, 0,
>> +			      regmap_irq_get_domain(rk808->irq_data));
>>  	if (ret) {
>>  		dev_err(&client->dev, "failed to add MFD devices %d\n", ret);
>>  		goto err_irq;
>> @@ -245,14 +408,9 @@ static int rk808_remove(struct i2c_client *client)
>>  	return 0;
>>  }
>>  
>> -static const struct of_device_id rk808_of_match[] = {
>> -	{ .compatible = "rockchip,rk808" },
>> -	{ },
>> -};
>> -MODULE_DEVICE_TABLE(of, rk808_of_match);
>> -
>>  static const struct i2c_device_id rk808_ids[] = {
>>  	{ "rk808" },
>> +	{ "rk818" },
>>  	{ },
>>  };
>>  MODULE_DEVICE_TABLE(i2c, rk808_ids);
>> @@ -272,4 +430,5 @@ module_i2c_driver(rk808_i2c_driver);
>>  MODULE_LICENSE("GPL");
>>  MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
>>  MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
>> -MODULE_DESCRIPTION("RK808 PMIC driver");
>> +MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
>> +MODULE_DESCRIPTION("RK808/RK818 PMIC driver");
>> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
>> index 441b6ee..5ce810c 100644
>> --- a/include/linux/mfd/rk808.h
>> +++ b/include/linux/mfd/rk808.h
>> @@ -1,11 +1,15 @@
>>  /*
>> - * rk808.h for Rockchip RK808
>> + * Register definitions for Rockchip's RK808/RK818 PMIC
>>   *
>>   * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>>   *
>>   * Author: Chris Zhong <zyw@rock-chips.com>
>>   * Author: Zhang Qing <zhangqing@rock-chips.com>
>>   *
>> + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
>> + *
>> + * Author: Wadim Egorov <w.egorov@phytec.de>
>> + *
>>   * This program is free software; you can redistribute it and/or modify it
>>   * under the terms and conditions of the GNU General Public License,
>>   * version 2, as published by the Free Software Foundation.
>> @@ -16,8 +20,8 @@
>>   * more details.
>>   */
>>  
>> -#ifndef __LINUX_REGULATOR_rk808_H
>> -#define __LINUX_REGULATOR_rk808_H
>> +#ifndef __LINUX_REGULATOR_RK808_H
>> +#define __LINUX_REGULATOR_RK808_H
>>  
>>  #include <linux/regulator/machine.h>
>>  #include <linux/regmap.h>
>> @@ -28,7 +32,7 @@
>>  
>>  #define RK808_DCDC1	0 /* (0+RK808_START) */
>>  #define RK808_LDO1	4 /* (4+RK808_START) */
>> -#define RK808_NUM_REGULATORS   14
>> +#define RK808_NUM_REGULATORS	14
>>  
>>  enum rk808_reg {
>>  	RK808_ID_DCDC1,
>> @@ -115,7 +119,92 @@ enum rk808_reg {
>>  #define RK808_INT_STS_MSK_REG2	0x4f
>>  #define RK808_IO_POL_REG	0x50
>>  
>> -/* IRQ Definitions */
>> +/* RK818 */
>> +#define RK818_DCDC1			0
>> +#define RK818_LDO1			4
>> +#define RK818_NUM_REGULATORS		17
>> +
>> +enum rk818_reg {
>> +	RK818_ID_DCDC1,
>> +	RK818_ID_DCDC2,
>> +	RK818_ID_DCDC3,
>> +	RK818_ID_DCDC4,
>> +	RK818_ID_BOOST,
>> +	RK818_ID_LDO1,
>> +	RK818_ID_LDO2,
>> +	RK818_ID_LDO3,
>> +	RK818_ID_LDO4,
>> +	RK818_ID_LDO5,
>> +	RK818_ID_LDO6,
>> +	RK818_ID_LDO7,
>> +	RK818_ID_LDO8,
>> +	RK818_ID_LDO9,
>> +	RK818_ID_SWITCH,
>> +	RK818_ID_HDMI_SWITCH,
>> +	RK818_ID_OTG_SWITCH,
>> +};
>> +
>> +#define RK818_DCDC_EN_REG		0x23
>> +#define RK818_LDO_EN_REG		0x24
>> +#define RK818_SLEEP_SET_OFF_REG1	0x25
>> +#define RK818_SLEEP_SET_OFF_REG2	0x26
>> +#define RK818_DCDC_UV_STS_REG		0x27
>> +#define RK818_DCDC_UV_ACT_REG		0x28
>> +#define RK818_LDO_UV_STS_REG		0x29
>> +#define RK818_LDO_UV_ACT_REG		0x2a
>> +#define RK818_DCDC_PG_REG		0x2b
>> +#define RK818_LDO_PG_REG		0x2c
>> +#define RK818_VOUT_MON_TDB_REG		0x2d
>> +#define RK818_BUCK1_CONFIG_REG		0x2e
>> +#define RK818_BUCK1_ON_VSEL_REG		0x2f
>> +#define RK818_BUCK1_SLP_VSEL_REG	0x30
>> +#define RK818_BUCK2_CONFIG_REG		0x32
>> +#define RK818_BUCK2_ON_VSEL_REG		0x33
>> +#define RK818_BUCK2_SLP_VSEL_REG	0x34
>> +#define RK818_BUCK3_CONFIG_REG		0x36
>> +#define RK818_BUCK4_CONFIG_REG		0x37
>> +#define RK818_BUCK4_ON_VSEL_REG		0x38
>> +#define RK818_BUCK4_SLP_VSEL_REG	0x39
>> +#define RK818_BOOST_CONFIG_REG		0x3a
>> +#define RK818_LDO1_ON_VSEL_REG		0x3b
>> +#define RK818_LDO1_SLP_VSEL_REG		0x3c
>> +#define RK818_LDO2_ON_VSEL_REG		0x3d
>> +#define RK818_LDO2_SLP_VSEL_REG		0x3e
>> +#define RK818_LDO3_ON_VSEL_REG		0x3f
>> +#define RK818_LDO3_SLP_VSEL_REG		0x40
>> +#define RK818_LDO4_ON_VSEL_REG		0x41
>> +#define RK818_LDO4_SLP_VSEL_REG		0x42
>> +#define RK818_LDO5_ON_VSEL_REG		0x43
>> +#define RK818_LDO5_SLP_VSEL_REG		0x44
>> +#define RK818_LDO6_ON_VSEL_REG		0x45
>> +#define RK818_LDO6_SLP_VSEL_REG		0x46
>> +#define RK818_LDO7_ON_VSEL_REG		0x47
>> +#define RK818_LDO7_SLP_VSEL_REG		0x48
>> +#define RK818_LDO8_ON_VSEL_REG		0x49
>> +#define RK818_LDO8_SLP_VSEL_REG		0x4a
>> +#define RK818_BOOST_LDO9_ON_VSEL_REG	0x54
>> +#define RK818_BOOST_LDO9_SLP_VSEL_REG	0x55
>> +#define RK818_DEVCTRL_REG		0x4b
>> +#define RK818_INT_STS_REG1		0X4c
>> +#define RK818_INT_STS_MSK_REG1		0x4d
>> +#define RK818_INT_STS_REG2		0x4e
>> +#define RK818_INT_STS_MSK_REG2		0x4f
>> +#define RK818_IO_POL_REG		0x50
>> +#define RK818_H5V_EN_REG		0x52
>> +#define RK818_SLEEP_SET_OFF_REG3	0x53
>> +#define RK818_BOOST_LDO9_ON_VSEL_REG	0x54
>> +#define RK818_BOOST_LDO9_SLP_VSEL_REG	0x55
>> +#define RK818_BOOST_CTRL_REG		0x56
>> +#define RK818_DCDC_ILMAX		0x90
>> +#define RK818_USB_CTRL_REG		0xa1
>> +
>> +#define RK818_H5V_EN			BIT(0)
>> +#define RK818_REF_RDY_CTRL		BIT(1)
>> +#define RK818_USB_ILIM_SEL_MASK		0xf
>> +#define RK818_USB_ILMIN_2000MA		0x7
>> +#define RK818_USB_CHG_SD_VSEL_MASK	0x70
>> +
>> +/* RK808 IRQ Definitions */
>>  #define RK808_IRQ_VOUT_LO	0
>>  #define RK808_IRQ_VB_LO		1
>>  #define RK808_IRQ_PWRON		2
>> @@ -137,6 +226,43 @@ enum rk808_reg {
>>  #define RK808_IRQ_PLUG_IN_INT_MSK	BIT(0)
>>  #define RK808_IRQ_PLUG_OUT_INT_MSK	BIT(1)
>>  
>> +/* RK818 IRQ Definitions */
>> +#define RK818_IRQ_VOUT_LO	0
>> +#define RK818_IRQ_VB_LO		1
>> +#define RK818_IRQ_PWRON		2
>> +#define RK818_IRQ_PWRON_LP	3
>> +#define RK818_IRQ_HOTDIE	4
>> +#define RK818_IRQ_RTC_ALARM	5
>> +#define RK818_IRQ_RTC_PERIOD	6
>> +#define RK818_IRQ_USB_OV	7
>> +#define RK818_IRQ_PLUG_IN	8
>> +#define RK818_IRQ_PLUG_OUT	9
>> +#define RK818_IRQ_CHG_OK	10
>> +#define RK818_IRQ_CHG_TE	11
>> +#define RK818_IRQ_CHG_TS1	12
>> +#define RK818_IRQ_TS2		13
>> +#define RK818_IRQ_CHG_CVTLIM	14
>> +#define RK818_IRQ_DISCHG_ILIM	7
>> +
>> +#define RK818_IRQ_VOUT_LO_MSK		BIT(0)
>> +#define RK818_IRQ_VB_LO_MSK		BIT(1)
>> +#define RK818_IRQ_PWRON_MSK		BIT(2)
>> +#define RK818_IRQ_PWRON_LP_MSK		BIT(3)
>> +#define RK818_IRQ_HOTDIE_MSK		BIT(4)
>> +#define RK818_IRQ_RTC_ALARM_MSK		BIT(5)
>> +#define RK818_IRQ_RTC_PERIOD_MSK	BIT(6)
>> +#define RK818_IRQ_USB_OV_MSK		BIT(7)
>> +#define RK818_IRQ_PLUG_IN_MSK		BIT(0)
>> +#define RK818_IRQ_PLUG_OUT_MSK		BIT(1)
>> +#define RK818_IRQ_CHG_OK_MSK		BIT(2)
>> +#define RK818_IRQ_CHG_TE_MSK		BIT(3)
>> +#define RK818_IRQ_CHG_TS1_MSK		BIT(4)
>> +#define RK818_IRQ_TS2_MSK		BIT(5)
>> +#define RK818_IRQ_CHG_CVTLIM_MSK	BIT(6)
>> +#define RK818_IRQ_DISCHG_ILIM_MSK	BIT(7)
>> +
>> +#define RK818_NUM_IRQ		16
>> +
>>  #define RK808_VBAT_LOW_2V8	0x00
>>  #define RK808_VBAT_LOW_2V9	0x01
>>  #define RK808_VBAT_LOW_3V0	0x02
>> @@ -191,9 +317,27 @@ enum {
>>  	BOOST_ILMIN_250MA,
>>  };
>>  
>> +enum {
>> +	RK808_ID,
>> +	RK818_ID,
>> +};
>> +
>> +struct rk8xx_reg_data {
>> +	int addr;
>> +	int mask;
>> +	int value;
>> +};
>> +
>>  struct rk808 {
>> -	struct i2c_client *i2c;
>> -	struct regmap_irq_chip_data *irq_data;
>> -	struct regmap *regmap;
>> +	struct i2c_client		*i2c;
>> +	struct regmap_irq_chip_data	*irq_data;
>> +	struct regmap			*regmap;
>> +	long				variant;
>> +	int				nr_cells;
>> +	const struct mfd_cell		*cells;
>> +	const struct regmap_config	*regmap_cfg;
>> +	const struct regmap_irq_chip	*regmap_irq_chip;
>> +	const struct rk8xx_reg_data	*pre_init_reg;
>> +	int				nr_pre_init_regs;
>>  };
>> -#endif /* __LINUX_REGULATOR_rk808_H */
>> +#endif /* __LINUX_REGULATOR_RK808_H */

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
