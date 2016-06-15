Return-Path: <rtc-linux+bncBDA7X7F2WUEBBZHXQW5QKGQEBTJEOWQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lb0-x236.google.com (mail-lb0-x236.google.com. [2a00:1450:4010:c04::236])
        by gmr-mx.google.com with ESMTPS id y8si921152lbi.2.2016.06.15.09.01.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2016 09:01:39 -0700 (PDT)
Received: by mail-lb0-x236.google.com with SMTP id ak10so4287654lbc.3
        for <rtc-linux@googlegroups.com>; Wed, 15 Jun 2016 09:01:39 -0700 (PDT)
Date: Wed, 15 Jun 2016 17:02:19 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
	mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org,
	lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, dianders@chromium.org,
	zyw@rock-chips.com
Subject: [rtc-linux] Re: [PATCH v6 1/5] mfd: RK808: Add RK818 support
Message-ID: <20160615160219.GP4948@dell>
References: <1465803989-33632-1-git-send-email-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1465803989-33632-1-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 13 Jun 2016, Wadim Egorov wrote:

> The RK818 chip is a Power Management IC (PMIC) for multimedia and handhel=
d
> devices. It contains the following components:
>=20
> - Regulators
> - RTC
> - Clocking
> - Battery support
>=20
> Both RK808 and RK818 chips are using a similar register map,
> so we can reuse the RTC and Clocking functionality.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
> Changes since v5:
> - Few spell fixes in the commit description
> - Alignment fixes
> - Moved rk808_reg_data struct back to c file
> - Removed cells and pre_init_reg from the rk808 struct
> - Moved of_match_device and variant determination to probe
> ---
>  drivers/mfd/Kconfig       |   4 +-
>  drivers/mfd/rk808.c       | 225 +++++++++++++++++++++++++++++++++++++++-=
------
>  include/linux/mfd/rk808.h | 152 +++++++++++++++++++++++++++++--
>  3 files changed, 339 insertions(+), 42 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 1bcf601..d0b7ea3 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -839,13 +839,13 @@ config MFD_RC5T583
>  	  different functionality of the device.
> =20
>  config MFD_RK808
> -	tristate "Rockchip RK808 Power Management chip"
> +	tristate "Rockchip RK808/RK818 Power Management Chip"
>  	depends on I2C && OF
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
>  	help
> -	  If you say yes here you get support for the RK808
> +	  If you say yes here you get support for the RK808 and RK818
>  	  Power Management chips.
>  	  This driver provides common support for accessing the device
>  	  through I2C interface. The device supports multiple sub-devices
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index 49d7f62..66f7b08 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -1,11 +1,15 @@
>  /*
> - * MFD core driver for Rockchip RK808
> + * MFD core driver for Rockchip RK808/RK818
>   *
>   * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>   *
>   * Author: Chris Zhong <zyw@rock-chips.com>
>   * Author: Zhang Qing <zhangqing@rock-chips.com>
>   *
> + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
> + *
> + * Author: Wadim Egorov <w.egorov@phytec.de>
> + *
>   * This program is free software; you can redistribute it and/or modify =
it
>   * under the terms and conditions of the GNU General Public License,
>   * version 2, as published by the Free Software Foundation.
> @@ -22,6 +26,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/of_device.h>
> =20
>  struct rk808_reg_data {
>  	int addr;
> @@ -57,6 +62,14 @@ static bool rk808_is_volatile_reg(struct device *dev, =
unsigned int reg)
>  	return false;
>  }
> =20
> +static const struct regmap_config rk818_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D RK818_USB_CTRL_REG,
> +	.cache_type =3D REGCACHE_RBTREE,
> +	.volatile_reg =3D rk808_is_volatile_reg,
> +};
> +
>  static const struct regmap_config rk808_regmap_config =3D {
>  	.reg_bits =3D 8,
>  	.val_bits =3D 8,
> @@ -79,11 +92,21 @@ static const struct mfd_cell rk808s[] =3D {
>  	{
>  		.name =3D "rk808-rtc",
>  		.num_resources =3D ARRAY_SIZE(rtc_resources),
> -		.resources =3D &rtc_resources[0],
> +		.resources =3D rtc_resources,
>  	},
>  };
> =20
> -static const struct rk808_reg_data pre_init_reg[] =3D {
> +static const struct mfd_cell rk818s[] =3D {
> +	{ .name =3D "rk808-clkout", },
> +	{ .name =3D "rk808-regulator", },
> +	{
> +		.name =3D "rk808-rtc",
> +		.num_resources =3D ARRAY_SIZE(rtc_resources),
> +		.resources =3D rtc_resources,
> +	},
> +};
> +
> +static const struct rk808_reg_data rk808_pre_init_reg[] =3D {
>  	{ RK808_BUCK3_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_150MA },
>  	{ RK808_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_200MA },
>  	{ RK808_BOOST_CONFIG_REG, BOOST_ILMIN_MASK, BOOST_ILMIN_100MA },
> @@ -94,6 +117,24 @@ static const struct rk808_reg_data pre_init_reg[] =3D=
 {
>  						    VB_LO_SEL_3500MV },
>  };
> =20
> +static const struct rk808_reg_data rk818_pre_init_reg[] =3D {
> +	/* improve efficiency */
> +	{ RK818_BUCK2_CONFIG_REG, BUCK2_RATE_MASK,  BUCK_ILMIN_250MA },
> +	{ RK818_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_250MA },
> +	{ RK818_BOOST_CONFIG_REG, BOOST_ILMIN_MASK, BOOST_ILMIN_100MA },
> +	{ RK818_USB_CTRL_REG,	  RK818_USB_ILIM_SEL_MASK,
> +						    RK818_USB_ILMIN_2000MA },
> +	/* close charger when usb lower then 3.4V */
> +	{ RK818_USB_CTRL_REG,	  RK818_USB_CHG_SD_VSEL_MASK,
> +						    (0x7 << 4) },
> +	/* no action when vref */
> +	{ RK818_H5V_EN_REG,	  BIT(1),	    RK818_REF_RDY_CTRL },
> +	/* enable HDMI 5V */
> +	{ RK818_H5V_EN_REG,	  BIT(0),	    RK818_H5V_EN },
> +	{ RK808_VB_MON_REG,	  MASK_ALL,	    VB_LO_ACT |
> +						    VB_LO_SEL_3500MV },
> +};
> +
>  static const struct regmap_irq rk808_irqs[] =3D {
>  	/* INT_STS */
>  	[RK808_IRQ_VOUT_LO] =3D {
> @@ -136,6 +177,76 @@ static const struct regmap_irq rk808_irqs[] =3D {
>  	},
>  };
> =20
> +static const struct regmap_irq rk818_irqs[] =3D {
> +	/* INT_STS */
> +	[RK818_IRQ_VOUT_LO] =3D {
> +		.mask =3D RK818_IRQ_VOUT_LO_MSK,
> +		.reg_offset =3D 0,
> +	},
> +	[RK818_IRQ_VB_LO] =3D {
> +		.mask =3D RK818_IRQ_VB_LO_MSK,
> +		.reg_offset =3D 0,
> +	},
> +	[RK818_IRQ_PWRON] =3D {
> +		.mask =3D RK818_IRQ_PWRON_MSK,
> +		.reg_offset =3D 0,
> +	},
> +	[RK818_IRQ_PWRON_LP] =3D {
> +		.mask =3D RK818_IRQ_PWRON_LP_MSK,
> +		.reg_offset =3D 0,
> +	},
> +	[RK818_IRQ_HOTDIE] =3D {
> +		.mask =3D RK818_IRQ_HOTDIE_MSK,
> +		.reg_offset =3D 0,
> +	},
> +	[RK818_IRQ_RTC_ALARM] =3D {
> +		.mask =3D RK818_IRQ_RTC_ALARM_MSK,
> +		.reg_offset =3D 0,
> +	},
> +	[RK818_IRQ_RTC_PERIOD] =3D {
> +		.mask =3D RK818_IRQ_RTC_PERIOD_MSK,
> +		.reg_offset =3D 0,
> +	},
> +	[RK818_IRQ_USB_OV] =3D {
> +		.mask =3D RK818_IRQ_USB_OV_MSK,
> +		.reg_offset =3D 0,
> +	},
> +
> +	/* INT_STS2 */
> +	[RK818_IRQ_PLUG_IN] =3D {
> +		.mask =3D RK818_IRQ_PLUG_IN_MSK,
> +		.reg_offset =3D 1,
> +	},
> +	[RK818_IRQ_PLUG_OUT] =3D {
> +		.mask =3D RK818_IRQ_PLUG_OUT_MSK,
> +		.reg_offset =3D 1,
> +	},
> +	[RK818_IRQ_CHG_OK] =3D {
> +		.mask =3D RK818_IRQ_CHG_OK_MSK,
> +		.reg_offset =3D 1,
> +	},
> +	[RK818_IRQ_CHG_TE] =3D {
> +		.mask =3D RK818_IRQ_CHG_TE_MSK,
> +		.reg_offset =3D 1,
> +	},
> +	[RK818_IRQ_CHG_TS1] =3D {
> +		.mask =3D RK818_IRQ_CHG_TS1_MSK,
> +		.reg_offset =3D 1,
> +	},
> +	[RK818_IRQ_TS2] =3D {
> +		.mask =3D RK818_IRQ_TS2_MSK,
> +		.reg_offset =3D 1,
> +	},
> +	[RK818_IRQ_CHG_CVTLIM] =3D {
> +		.mask =3D RK818_IRQ_CHG_CVTLIM_MSK,
> +		.reg_offset =3D 1,
> +	},
> +	[RK818_IRQ_DISCHG_ILIM] =3D {
> +		.mask =3D RK818_IRQ_DISCHG_ILIM_MSK,
> +		.reg_offset =3D 1,
> +	},
> +};
> +
>  static struct regmap_irq_chip rk808_irq_chip =3D {
>  	.name =3D "rk808",
>  	.irqs =3D rk808_irqs,
> @@ -148,6 +259,18 @@ static struct regmap_irq_chip rk808_irq_chip =3D {
>  	.init_ack_masked =3D true,
>  };
> =20
> +static struct regmap_irq_chip rk818_irq_chip =3D {
> +	.name =3D "rk818",
> +	.irqs =3D rk818_irqs,
> +	.num_irqs =3D ARRAY_SIZE(rk818_irqs),
> +	.num_regs =3D 2,
> +	.irq_reg_stride =3D 2,
> +	.status_base =3D RK818_INT_STS_REG1,
> +	.mask_base =3D RK818_INT_STS_MSK_REG1,
> +	.ack_base =3D RK818_INT_STS_REG1,
> +	.init_ack_masked =3D true,
> +};
> +
>  static struct i2c_client *rk808_i2c_client;
>  static void rk808_device_shutdown(void)
>  {
> @@ -167,55 +290,99 @@ static void rk808_device_shutdown(void)
>  		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>  }
> =20
> +static const struct of_device_id rk808_of_match[] =3D {
> +	{ .compatible =3D "rockchip,rk808", .data =3D (void *) RK808_ID },
> +	{ .compatible =3D "rockchip,rk818", .data =3D (void *) RK818_ID },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rk808_of_match);
> +
>  static int rk808_probe(struct i2c_client *client,
>  		       const struct i2c_device_id *id)
>  {
>  	struct device_node *np =3D client->dev.of_node;
>  	struct rk808 *rk808;
> +	const struct of_device_id *match;
> +	const struct rk808_reg_data *pre_init_reg;
> +	const struct mfd_cell *cells;
> +	int nr_pre_init_regs;
> +	int nr_cells;
>  	int pm_off =3D 0;
>  	int ret;
>  	int i;
> =20
> -	if (!client->irq) {
> -		dev_err(&client->dev, "No interrupt support, no core IRQ\n");
> -		return -EINVAL;
> -	}
> -
>  	rk808 =3D devm_kzalloc(&client->dev, sizeof(*rk808), GFP_KERNEL);
>  	if (!rk808)
>  		return -ENOMEM;
> =20
> -	rk808->regmap =3D devm_regmap_init_i2c(client, &rk808_regmap_config);
> +	match =3D of_match_device(rk808_of_match, &client->dev);
> +	if (!match) {
> +		dev_err(&client->dev, "Unable to match OF ID\n");
> +		return -ENODEV;
> +	}
> +	rk808->variant =3D (long)match->data;
> +
> +	switch (rk808->variant) {
> +	case RK808_ID:
> +		rk808->regmap_cfg =3D &rk808_regmap_config;
> +		rk808->regmap_irq_chip =3D &rk808_irq_chip;
> +		pre_init_reg =3D rk808_pre_init_reg;
> +		nr_pre_init_regs =3D ARRAY_SIZE(rk808_pre_init_reg);
> +		cells =3D rk808s;
> +		nr_cells =3D ARRAY_SIZE(rk808s);
> +		break;
> +	case RK818_ID:
> +		rk808->regmap_cfg =3D &rk818_regmap_config;
> +		rk808->regmap_irq_chip =3D &rk818_irq_chip;
> +		pre_init_reg =3D rk818_pre_init_reg;
> +		nr_pre_init_regs =3D ARRAY_SIZE(rk818_pre_init_reg);
> +		cells =3D rk818s;
> +		nr_cells =3D ARRAY_SIZE(rk818s);
> +		break;
> +	default:
> +		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
> +			rk808->variant);
> +		return -EINVAL;
> +	}
> +
> +	rk808->i2c =3D client;
> +	i2c_set_clientdata(client, rk808);
> +
> +	rk808->regmap =3D devm_regmap_init_i2c(client, rk808->regmap_cfg);
>  	if (IS_ERR(rk808->regmap)) {
>  		dev_err(&client->dev, "regmap initialization failed\n");
>  		return PTR_ERR(rk808->regmap);
>  	}
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(pre_init_reg); i++) {
> -		ret =3D regmap_update_bits(rk808->regmap, pre_init_reg[i].addr,
> -					 pre_init_reg[i].mask,
> -					 pre_init_reg[i].value);
> -		if (ret) {
> -			dev_err(&client->dev,
> -				"0x%x write err\n", pre_init_reg[i].addr);
> -			return ret;
> -		}
> +	if (!client->irq) {
> +		dev_err(&client->dev, "No interrupt support, no core IRQ\n");
> +		return -EINVAL;
>  	}
> =20
>  	ret =3D regmap_add_irq_chip(rk808->regmap, client->irq,
>  				  IRQF_ONESHOT, -1,
> -				  &rk808_irq_chip, &rk808->irq_data);
> +				  rk808->regmap_irq_chip, &rk808->irq_data);
>  	if (ret) {
>  		dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
>  		return ret;
>  	}
> =20
> -	rk808->i2c =3D client;
> -	i2c_set_clientdata(client, rk808);
> +	for (i =3D 0; i < nr_pre_init_regs; i++) {
> +		ret =3D regmap_update_bits(rk808->regmap,
> +					pre_init_reg[i].addr,
> +					pre_init_reg[i].mask,
> +					pre_init_reg[i].value);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"0x%x write err\n",
> +				pre_init_reg[i].addr);
> +			return ret;
> +		}
> +	}
> =20
> -	ret =3D devm_mfd_add_devices(&client->dev, -1,
> -				   rk808s, ARRAY_SIZE(rk808s), NULL, 0,
> -				   regmap_irq_get_domain(rk808->irq_data));
> +	ret =3D devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
> +			      cells, nr_cells, NULL, 0,
> +			      regmap_irq_get_domain(rk808->irq_data));
>  	if (ret) {
>  		dev_err(&client->dev, "failed to add MFD devices %d\n", ret);
>  		goto err_irq;
> @@ -245,14 +412,9 @@ static int rk808_remove(struct i2c_client *client)
>  	return 0;
>  }
> =20
> -static const struct of_device_id rk808_of_match[] =3D {
> -	{ .compatible =3D "rockchip,rk808" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, rk808_of_match);
> -
>  static const struct i2c_device_id rk808_ids[] =3D {
>  	{ "rk808" },
> +	{ "rk818" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, rk808_ids);
> @@ -272,4 +434,5 @@ module_i2c_driver(rk808_i2c_driver);
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
>  MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
> -MODULE_DESCRIPTION("RK808 PMIC driver");
> +MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
> +MODULE_DESCRIPTION("RK808/RK818 PMIC driver");
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
> index 441b6ee..e5ae21d 100644
> --- a/include/linux/mfd/rk808.h
> +++ b/include/linux/mfd/rk808.h
> @@ -1,11 +1,15 @@
>  /*
> - * rk808.h for Rockchip RK808
> + * Register definitions for Rockchip's RK808/RK818 PMIC
>   *
>   * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>   *
>   * Author: Chris Zhong <zyw@rock-chips.com>
>   * Author: Zhang Qing <zhangqing@rock-chips.com>
>   *
> + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
> + *
> + * Author: Wadim Egorov <w.egorov@phytec.de>
> + *
>   * This program is free software; you can redistribute it and/or modify =
it
>   * under the terms and conditions of the GNU General Public License,
>   * version 2, as published by the Free Software Foundation.
> @@ -16,8 +20,8 @@
>   * more details.
>   */
> =20
> -#ifndef __LINUX_REGULATOR_rk808_H
> -#define __LINUX_REGULATOR_rk808_H
> +#ifndef __LINUX_REGULATOR_RK808_H
> +#define __LINUX_REGULATOR_RK808_H
> =20
>  #include <linux/regulator/machine.h>
>  #include <linux/regmap.h>
> @@ -28,7 +32,7 @@
> =20
>  #define RK808_DCDC1	0 /* (0+RK808_START) */
>  #define RK808_LDO1	4 /* (4+RK808_START) */
> -#define RK808_NUM_REGULATORS   14
> +#define RK808_NUM_REGULATORS	14
> =20
>  enum rk808_reg {
>  	RK808_ID_DCDC1,
> @@ -115,7 +119,92 @@ enum rk808_reg {
>  #define RK808_INT_STS_MSK_REG2	0x4f
>  #define RK808_IO_POL_REG	0x50
> =20
> -/* IRQ Definitions */
> +/* RK818 */
> +#define RK818_DCDC1			0
> +#define RK818_LDO1			4
> +#define RK818_NUM_REGULATORS		17
> +
> +enum rk818_reg {
> +	RK818_ID_DCDC1,
> +	RK818_ID_DCDC2,
> +	RK818_ID_DCDC3,
> +	RK818_ID_DCDC4,
> +	RK818_ID_BOOST,
> +	RK818_ID_LDO1,
> +	RK818_ID_LDO2,
> +	RK818_ID_LDO3,
> +	RK818_ID_LDO4,
> +	RK818_ID_LDO5,
> +	RK818_ID_LDO6,
> +	RK818_ID_LDO7,
> +	RK818_ID_LDO8,
> +	RK818_ID_LDO9,
> +	RK818_ID_SWITCH,
> +	RK818_ID_HDMI_SWITCH,
> +	RK818_ID_OTG_SWITCH,
> +};
> +
> +#define RK818_DCDC_EN_REG		0x23
> +#define RK818_LDO_EN_REG		0x24
> +#define RK818_SLEEP_SET_OFF_REG1	0x25
> +#define RK818_SLEEP_SET_OFF_REG2	0x26
> +#define RK818_DCDC_UV_STS_REG		0x27
> +#define RK818_DCDC_UV_ACT_REG		0x28
> +#define RK818_LDO_UV_STS_REG		0x29
> +#define RK818_LDO_UV_ACT_REG		0x2a
> +#define RK818_DCDC_PG_REG		0x2b
> +#define RK818_LDO_PG_REG		0x2c
> +#define RK818_VOUT_MON_TDB_REG		0x2d
> +#define RK818_BUCK1_CONFIG_REG		0x2e
> +#define RK818_BUCK1_ON_VSEL_REG		0x2f
> +#define RK818_BUCK1_SLP_VSEL_REG	0x30
> +#define RK818_BUCK2_CONFIG_REG		0x32
> +#define RK818_BUCK2_ON_VSEL_REG		0x33
> +#define RK818_BUCK2_SLP_VSEL_REG	0x34
> +#define RK818_BUCK3_CONFIG_REG		0x36
> +#define RK818_BUCK4_CONFIG_REG		0x37
> +#define RK818_BUCK4_ON_VSEL_REG		0x38
> +#define RK818_BUCK4_SLP_VSEL_REG	0x39
> +#define RK818_BOOST_CONFIG_REG		0x3a
> +#define RK818_LDO1_ON_VSEL_REG		0x3b
> +#define RK818_LDO1_SLP_VSEL_REG		0x3c
> +#define RK818_LDO2_ON_VSEL_REG		0x3d
> +#define RK818_LDO2_SLP_VSEL_REG		0x3e
> +#define RK818_LDO3_ON_VSEL_REG		0x3f
> +#define RK818_LDO3_SLP_VSEL_REG		0x40
> +#define RK818_LDO4_ON_VSEL_REG		0x41
> +#define RK818_LDO4_SLP_VSEL_REG		0x42
> +#define RK818_LDO5_ON_VSEL_REG		0x43
> +#define RK818_LDO5_SLP_VSEL_REG		0x44
> +#define RK818_LDO6_ON_VSEL_REG		0x45
> +#define RK818_LDO6_SLP_VSEL_REG		0x46
> +#define RK818_LDO7_ON_VSEL_REG		0x47
> +#define RK818_LDO7_SLP_VSEL_REG		0x48
> +#define RK818_LDO8_ON_VSEL_REG		0x49
> +#define RK818_LDO8_SLP_VSEL_REG		0x4a
> +#define RK818_BOOST_LDO9_ON_VSEL_REG	0x54
> +#define RK818_BOOST_LDO9_SLP_VSEL_REG	0x55
> +#define RK818_DEVCTRL_REG		0x4b
> +#define RK818_INT_STS_REG1		0X4c
> +#define RK818_INT_STS_MSK_REG1		0x4d
> +#define RK818_INT_STS_REG2		0x4e
> +#define RK818_INT_STS_MSK_REG2		0x4f
> +#define RK818_IO_POL_REG		0x50
> +#define RK818_H5V_EN_REG		0x52
> +#define RK818_SLEEP_SET_OFF_REG3	0x53
> +#define RK818_BOOST_LDO9_ON_VSEL_REG	0x54
> +#define RK818_BOOST_LDO9_SLP_VSEL_REG	0x55
> +#define RK818_BOOST_CTRL_REG		0x56
> +#define RK818_DCDC_ILMAX		0x90
> +#define RK818_USB_CTRL_REG		0xa1
> +
> +#define RK818_H5V_EN			BIT(0)
> +#define RK818_REF_RDY_CTRL		BIT(1)
> +#define RK818_USB_ILIM_SEL_MASK		0xf
> +#define RK818_USB_ILMIN_2000MA		0x7
> +#define RK818_USB_CHG_SD_VSEL_MASK	0x70
> +
> +/* RK808 IRQ Definitions */
>  #define RK808_IRQ_VOUT_LO	0
>  #define RK808_IRQ_VB_LO		1
>  #define RK808_IRQ_PWRON		2
> @@ -137,6 +226,43 @@ enum rk808_reg {
>  #define RK808_IRQ_PLUG_IN_INT_MSK	BIT(0)
>  #define RK808_IRQ_PLUG_OUT_INT_MSK	BIT(1)
> =20
> +/* RK818 IRQ Definitions */
> +#define RK818_IRQ_VOUT_LO	0
> +#define RK818_IRQ_VB_LO		1
> +#define RK818_IRQ_PWRON		2
> +#define RK818_IRQ_PWRON_LP	3
> +#define RK818_IRQ_HOTDIE	4
> +#define RK818_IRQ_RTC_ALARM	5
> +#define RK818_IRQ_RTC_PERIOD	6
> +#define RK818_IRQ_USB_OV	7
> +#define RK818_IRQ_PLUG_IN	8
> +#define RK818_IRQ_PLUG_OUT	9
> +#define RK818_IRQ_CHG_OK	10
> +#define RK818_IRQ_CHG_TE	11
> +#define RK818_IRQ_CHG_TS1	12
> +#define RK818_IRQ_TS2		13
> +#define RK818_IRQ_CHG_CVTLIM	14
> +#define RK818_IRQ_DISCHG_ILIM	7
> +
> +#define RK818_IRQ_VOUT_LO_MSK		BIT(0)
> +#define RK818_IRQ_VB_LO_MSK		BIT(1)
> +#define RK818_IRQ_PWRON_MSK		BIT(2)
> +#define RK818_IRQ_PWRON_LP_MSK		BIT(3)
> +#define RK818_IRQ_HOTDIE_MSK		BIT(4)
> +#define RK818_IRQ_RTC_ALARM_MSK		BIT(5)
> +#define RK818_IRQ_RTC_PERIOD_MSK	BIT(6)
> +#define RK818_IRQ_USB_OV_MSK		BIT(7)
> +#define RK818_IRQ_PLUG_IN_MSK		BIT(0)
> +#define RK818_IRQ_PLUG_OUT_MSK		BIT(1)
> +#define RK818_IRQ_CHG_OK_MSK		BIT(2)
> +#define RK818_IRQ_CHG_TE_MSK		BIT(3)
> +#define RK818_IRQ_CHG_TS1_MSK		BIT(4)
> +#define RK818_IRQ_TS2_MSK		BIT(5)
> +#define RK818_IRQ_CHG_CVTLIM_MSK	BIT(6)
> +#define RK818_IRQ_DISCHG_ILIM_MSK	BIT(7)
> +
> +#define RK818_NUM_IRQ		16
> +
>  #define RK808_VBAT_LOW_2V8	0x00
>  #define RK808_VBAT_LOW_2V9	0x01
>  #define RK808_VBAT_LOW_3V0	0x02
> @@ -191,9 +317,17 @@ enum {
>  	BOOST_ILMIN_250MA,
>  };
> =20
> +enum {
> +	RK808_ID,
> +	RK818_ID,
> +};
> +
>  struct rk808 {
> -	struct i2c_client *i2c;
> -	struct regmap_irq_chip_data *irq_data;
> -	struct regmap *regmap;
> +	struct i2c_client		*i2c;
> +	struct regmap_irq_chip_data	*irq_data;
> +	struct regmap			*regmap;
> +	long				variant;
> +	const struct regmap_config	*regmap_cfg;
> +	const struct regmap_irq_chip	*regmap_irq_chip;
>  };
> -#endif /* __LINUX_REGULATOR_rk808_H */
> +#endif /* __LINUX_REGULATOR_RK808_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
