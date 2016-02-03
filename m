Return-Path: <rtc-linux+bncBDKZNNNLXAHBBLVKYW2QKGQE2MFPJOQ@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id u66si547911pfa.2.2016.02.02.17.17.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 02 Feb 2016 17:17:33 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1Y003Q7695JA80@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 03 Feb 2016 01:17:29 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH 4/4] rtc: max77686: move initialisation of rtc
 regmap, irq chip locally
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, javier@osg.samsung.com
References: <1454419012-18050-1-git-send-email-ldewangan@nvidia.com>
 <1454419012-18050-5-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com, Krzysztof Mazur <krzysiek@podlesie.net>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56B15528.6060209@samsung.com>
Date: Wed, 03 Feb 2016 10:17:28 +0900
MIME-version: 1.0
In-reply-to: <1454419012-18050-5-git-send-email-ldewangan@nvidia.com>
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

On 02.02.2016 22:16, Laxman Dewangan wrote:
> To make RTC block of MAX77686/MAX77802 as independent driver,
> move the registeration of i2c device, regmap for register access

s/registeration/registration/

> and irq_chip for interrupt support inside the RTC driver.
> Removed the same initialisation from mfd driver.

s/mfd/MFD/

I would expect here also information answering to the "why" question.
Why are you doing all of this? Why we want RTC driver to be independent?

> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Mazur <krzysiek@podlesie.net>
> CC: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>  drivers/mfd/max77686.c               |  82 +------------
>  drivers/rtc/Kconfig                  |   7 +-
>  drivers/rtc/rtc-max77686.c           | 225 ++++++++++++++++++++++++++++++++---
>  include/linux/mfd/max77686-private.h |  16 ---
>  4 files changed, 211 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
> index d959ebb..8254201 100644
> --- a/drivers/mfd/max77686.c
> +++ b/drivers/mfd/max77686.c
> @@ -116,11 +116,6 @@ static const struct regmap_config max77686_regmap_config = {
>  	.val_bits = 8,
>  };
>  
> -static const struct regmap_config max77686_rtc_regmap_config = {
> -	.reg_bits = 8,
> -	.val_bits = 8,
> -};
> -
>  static const struct regmap_config max77802_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -156,25 +151,6 @@ static const struct regmap_irq_chip max77686_irq_chip = {
>  	.num_irqs		= ARRAY_SIZE(max77686_irqs),
>  };
>  
> -static const struct regmap_irq max77686_rtc_irqs[] = {
> -	/* RTC interrupts */
> -	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTC60S_MSK, },
> -	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTCA1_MSK, },
> -	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTCA2_MSK, },
> -	{ .reg_offset = 0, .mask = MAX77686_RTCINT_SMPL_MSK, },
> -	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTC1S_MSK, },
> -	{ .reg_offset = 0, .mask = MAX77686_RTCINT_WTSR_MSK, },
> -};
> -
> -static const struct regmap_irq_chip max77686_rtc_irq_chip = {
> -	.name			= "max77686-rtc",
> -	.status_base		= MAX77686_RTC_INT,
> -	.mask_base		= MAX77686_RTC_INTM,
> -	.num_regs		= 1,
> -	.irqs			= max77686_rtc_irqs,
> -	.num_irqs		= ARRAY_SIZE(max77686_rtc_irqs),
> -};
> -
>  static const struct regmap_irq_chip max77802_irq_chip = {
>  	.name			= "max77802-pmic",
>  	.status_base		= MAX77802_REG_INT1,
> @@ -184,15 +160,6 @@ static const struct regmap_irq_chip max77802_irq_chip = {
>  	.num_irqs		= ARRAY_SIZE(max77686_irqs),
>  };
>  
> -static const struct regmap_irq_chip max77802_rtc_irq_chip = {
> -	.name			= "max77802-rtc",
> -	.status_base		= MAX77802_RTC_INT,
> -	.mask_base		= MAX77802_RTC_INTM,
> -	.num_regs		= 1,
> -	.irqs			= max77686_rtc_irqs, /* same masks as 77686 */
> -	.num_irqs		= ARRAY_SIZE(max77686_rtc_irqs),
> -};
> -
>  static const struct of_device_id max77686_pmic_dt_match[] = {
>  	{
>  		.compatible = "maxim,max77686",
> @@ -214,8 +181,6 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
>  	int ret = 0;
>  	const struct regmap_config *config;
>  	const struct regmap_irq_chip *irq_chip;
> -	const struct regmap_irq_chip *rtc_irq_chip;
> -	struct regmap **rtc_regmap;
>  	const struct mfd_cell *cells;
>  	int n_devs;
>  
> @@ -242,15 +207,11 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
>  	if (max77686->type == TYPE_MAX77686) {
>  		config = &max77686_regmap_config;
>  		irq_chip = &max77686_irq_chip;
> -		rtc_irq_chip = &max77686_rtc_irq_chip;
> -		rtc_regmap = &max77686->rtc_regmap;
>  		cells =  max77686_devs;
>  		n_devs = ARRAY_SIZE(max77686_devs);
>  	} else {
>  		config = &max77802_regmap_config;
>  		irq_chip = &max77802_irq_chip;
> -		rtc_irq_chip = &max77802_rtc_irq_chip;
> -		rtc_regmap = &max77686->regmap;
>  		cells =  max77802_devs;
>  		n_devs = ARRAY_SIZE(max77802_devs);
>  	}
> @@ -270,60 +231,25 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
>  		return -ENODEV;
>  	}
>  
> -	if (max77686->type == TYPE_MAX77686) {
> -		max77686->rtc = i2c_new_dummy(i2c->adapter, I2C_ADDR_RTC);
> -		if (!max77686->rtc) {
> -			dev_err(max77686->dev,
> -				"Failed to allocate I2C device for RTC\n");
> -			return -ENODEV;
> -		}
> -		i2c_set_clientdata(max77686->rtc, max77686);
> -
> -		max77686->rtc_regmap =
> -			devm_regmap_init_i2c(max77686->rtc,
> -					     &max77686_rtc_regmap_config);
> -		if (IS_ERR(max77686->rtc_regmap)) {
> -			ret = PTR_ERR(max77686->rtc_regmap);
> -			dev_err(max77686->dev,
> -				"failed to allocate RTC regmap: %d\n",
> -				ret);
> -			goto err_unregister_i2c;
> -		}
> -	}
> -
>  	ret = regmap_add_irq_chip(max77686->regmap, max77686->irq,
>  				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
>  				  IRQF_SHARED, 0, irq_chip,
>  				  &max77686->irq_data);
>  	if (ret) {
>  		dev_err(&i2c->dev, "failed to add PMIC irq chip: %d\n", ret);
> -		goto err_unregister_i2c;
> -	}
> -
> -	ret = regmap_add_irq_chip(*rtc_regmap, max77686->irq,
> -				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
> -				  IRQF_SHARED, 0, rtc_irq_chip,
> -				  &max77686->rtc_irq_data);
> -	if (ret) {
> -		dev_err(&i2c->dev, "failed to add RTC irq chip: %d\n", ret);
> -		goto err_del_irqc;
> +		return -ENODEV;

return ret;

>  	}
>  
>  	ret = mfd_add_devices(max77686->dev, -1, cells, n_devs, NULL, 0, NULL);
>  	if (ret < 0) {
>  		dev_err(&i2c->dev, "failed to add MFD devices: %d\n", ret);
> -		goto err_del_rtc_irqc;
> +		goto err_del_irqc;
>  	}
>  
>  	return 0;
>  
> -err_del_rtc_irqc:
> -	regmap_del_irq_chip(max77686->irq, max77686->rtc_irq_data);
>  err_del_irqc:
>  	regmap_del_irq_chip(max77686->irq, max77686->irq_data);
> -err_unregister_i2c:
> -	if (max77686->type == TYPE_MAX77686)
> -		i2c_unregister_device(max77686->rtc);
>  
>  	return ret;
>  }
> @@ -334,12 +260,8 @@ static int max77686_i2c_remove(struct i2c_client *i2c)
>  
>  	mfd_remove_devices(max77686->dev);
>  
> -	regmap_del_irq_chip(max77686->irq, max77686->rtc_irq_data);
>  	regmap_del_irq_chip(max77686->irq, max77686->irq_data);
>  
> -	if (max77686->type == TYPE_MAX77686)
> -		i2c_unregister_device(max77686->rtc);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index ec6a253..bdac624 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -325,14 +325,13 @@ config RTC_DRV_MAX8997
>  	  will be called rtc-max8997.
>  
>  config RTC_DRV_MAX77686
> -	tristate "Maxim MAX77686"
> -	depends on MFD_MAX77686

It still depends on some parent. Instantiating this without main MFD
probably would cause errors around max77686_init_rtc_regmap().

> +	tristate "Maxim MAX77686/MAX77802"
>  	help
>  	  If you say yes here you will get support for the
> -	  RTC of Maxim MAX77686 PMIC.
> +	  RTC of Maxim MAX77686/MAX77802 PMIC.
>  
>  	  This driver can also be built as a module. If so, the module
> -	  will be called rtc-max77686.
> +	  will be called rtc-max77686/MAX77802.

The name of module does not change.

>  
>  config RTC_DRV_RK808
>  	tristate "Rockchip RK808 RTC"
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index ab1f2cd..21a88e2 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -12,16 +12,100 @@
>   *
>   */
>  
> +#include <linux/i2c.h>
>  #include <linux/slab.h>
>  #include <linux/rtc.h>
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/mfd/max77686-private.h>

I think the include should remain. No need of duplicating here the
register addresses. Although we wnat the driver to be independent from
parent it is still coming from one parent or another.

>  #include <linux/irqdomain.h>
>  #include <linux/regmap.h>
>  
> +#define MAX77686_REG_STATUS2		0x07
> +
> +enum max77686_rtc_reg {
> +	MAX77686_RTC_INT		= 0x00,
> +	MAX77686_RTC_INTM		= 0x01,
> +	MAX77686_RTC_CONTROLM		= 0x02,
> +	MAX77686_RTC_CONTROL		= 0x03,
> +	MAX77686_RTC_UPDATE0		= 0x04,
> +	/* Reserved: 0x5 */
> +	MAX77686_WTSR_SMPL_CNTL		= 0x06,
> +	MAX77686_RTC_SEC		= 0x07,
> +	MAX77686_RTC_MIN		= 0x08,
> +	MAX77686_RTC_HOUR		= 0x09,
> +	MAX77686_RTC_WEEKDAY		= 0x0A,
> +	MAX77686_RTC_MONTH		= 0x0B,
> +	MAX77686_RTC_YEAR		= 0x0C,
> +	MAX77686_RTC_DATE		= 0x0D,
> +	MAX77686_ALARM1_SEC		= 0x0E,
> +	MAX77686_ALARM1_MIN		= 0x0F,
> +	MAX77686_ALARM1_HOUR		= 0x10,
> +	MAX77686_ALARM1_WEEKDAY		= 0x11,
> +	MAX77686_ALARM1_MONTH		= 0x12,
> +	MAX77686_ALARM1_YEAR		= 0x13,
> +	MAX77686_ALARM1_DATE		= 0x14,
> +	MAX77686_ALARM2_SEC		= 0x15,
> +	MAX77686_ALARM2_MIN		= 0x16,
> +	MAX77686_ALARM2_HOUR		= 0x17,
> +	MAX77686_ALARM2_WEEKDAY		= 0x18,
> +	MAX77686_ALARM2_MONTH		= 0x19,
> +	MAX77686_ALARM2_YEAR		= 0x1A,
> +	MAX77686_ALARM2_DATE		= 0x1B,
> +};
> +
> +enum max77802_rtc_reg {
> +	MAX77802_RTC_INT		= 0xC0,
> +	MAX77802_RTC_INTM		= 0xC1,
> +	MAX77802_RTC_CONTROLM		= 0xC2,
> +	MAX77802_RTC_CONTROL		= 0xC3,
> +	MAX77802_RTC_UPDATE0		= 0xC4,
> +	MAX77802_RTC_UPDATE1		= 0xC5,
> +	MAX77802_WTSR_SMPL_CNTL		= 0xC6,
> +	MAX77802_RTC_SEC		= 0xC7,
> +	MAX77802_RTC_MIN		= 0xC8,
> +	MAX77802_RTC_HOUR		= 0xC9,
> +	MAX77802_RTC_WEEKDAY		= 0xCA,
> +	MAX77802_RTC_MONTH		= 0xCB,
> +	MAX77802_RTC_YEAR		= 0xCC,
> +	MAX77802_RTC_DATE		= 0xCD,
> +	MAX77802_RTC_AE1		= 0xCE,
> +	MAX77802_ALARM1_SEC		= 0xCF,
> +	MAX77802_ALARM1_MIN		= 0xD0,
> +	MAX77802_ALARM1_HOUR		= 0xD1,
> +	MAX77802_ALARM1_WEEKDAY		= 0xD2,
> +	MAX77802_ALARM1_MONTH		= 0xD3,
> +	MAX77802_ALARM1_YEAR		= 0xD4,
> +	MAX77802_ALARM1_DATE		= 0xD5,
> +	MAX77802_RTC_AE2		= 0xD6,
> +	MAX77802_ALARM2_SEC		= 0xD7,
> +	MAX77802_ALARM2_MIN		= 0xD8,
> +	MAX77802_ALARM2_HOUR		= 0xD9,
> +	MAX77802_ALARM2_WEEKDAY		= 0xDA,
> +	MAX77802_ALARM2_MONTH		= 0xDB,
> +	MAX77802_ALARM2_YEAR		= 0xDC,
> +	MAX77802_ALARM2_DATE		= 0xDD,
> +
> +	MAX77802_RTC_END		= 0xDF,
> +};

All of these should come from existing max77686/max77802/max77620 headers.

> +
> +enum max77686_rtc_irq {
> +	MAX77686_RTCIRQ_RTC60S = 0,
> +	MAX77686_RTCIRQ_RTCA1,
> +	MAX77686_RTCIRQ_RTCA2,
> +	MAX77686_RTCIRQ_SMPL,
> +	MAX77686_RTCIRQ_RTC1S,
> +	MAX77686_RTCIRQ_WTSR,
> +};

ditto

> +
> +#define MAX77686_RTCINT_RTC60S_MSK	BIT(0)
> +#define MAX77686_RTCINT_RTCA1_MSK	BIT(1)
> +#define MAX77686_RTCINT_RTCA2_MSK	BIT(2)
> +#define MAX77686_RTCINT_SMPL_MSK	BIT(3)
> +#define MAX77686_RTCINT_RTC1S_MSK	BIT(4)
> +#define MAX77686_RTCINT_WTSR_MSK	BIT(5)

ditto

> +
>  /* RTC Control Register */
>  #define BCD_EN_SHIFT			0
>  #define BCD_EN_MASK			BIT(BCD_EN_SHIFT)
> @@ -68,8 +152,10 @@ struct max77686_rtc_driver_data {
>  	const unsigned int	*map;
>  	/* Has a separate alarm enable register? */
>  	bool			alarm_enable_reg;
> -	/* Has a separate I2C regmap for the RTC? */
> -	bool			separate_i2c_addr;
> +	/* I2C address for RTC block */
> +	u8			separate_i2c_addr;
> +	/* RTC IRQ CHIP for regmap */
> +	const struct regmap_irq_chip *rtc_irq_chip;
>  };
>  
>  struct max77686_rtc_info {
> @@ -82,7 +168,9 @@ struct max77686_rtc_info {
>  	struct regmap		*rtc_regmap;
>  
>  	const struct max77686_rtc_driver_data *drv_data;
> +	struct regmap_irq_chip_data *rtc_irq_data;
>  
> +	int rtc_irq;
>  	int virq;
>  	int rtc_24hr_mode;
>  };
> @@ -153,12 +241,32 @@ static const unsigned int max77686_map[REG_RTC_END] = {
>  	[REG_RTC_AE1]	     = REG_RTC_NONE,
>  };
>  
> +static const struct regmap_irq max77686_rtc_irqs[] = {
> +	/* RTC interrupts */
> +	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTC60S_MSK, },
> +	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTCA1_MSK, },
> +	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTCA2_MSK, },
> +	{ .reg_offset = 0, .mask = MAX77686_RTCINT_SMPL_MSK, },
> +	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTC1S_MSK, },
> +	{ .reg_offset = 0, .mask = MAX77686_RTCINT_WTSR_MSK, },
> +};
> +
> +static const struct regmap_irq_chip max77686_rtc_irq_chip = {
> +	.name		= "max77686-rtc",
> +	.status_base	= MAX77686_RTC_INT,
> +	.mask_base	= MAX77686_RTC_INTM,
> +	.num_regs	= 1,
> +	.irqs		= max77686_rtc_irqs,
> +	.num_irqs	= ARRAY_SIZE(max77686_rtc_irqs),
> +};
> +
>  static const struct max77686_rtc_driver_data max77686_drv_data = {
>  	.delay = 16000,
>  	.mask  = 0x7f,
>  	.map   = max77686_map,
>  	.alarm_enable_reg  = false,
> -	.separate_i2c_addr = true,
> +	.separate_i2c_addr = 0xC >> 1,

When the header will remain:
I2C_ADDR_RTC
(maybe it needs some prefix?)

> +	.rtc_irq_chip = &max77686_rtc_irq_chip,
>  };
>  
>  static const unsigned int max77802_map[REG_RTC_END] = {
> @@ -190,12 +298,22 @@ static const unsigned int max77802_map[REG_RTC_END] = {
>  	[REG_RTC_AE1]	     = MAX77802_RTC_AE1,
>  };
>  
> +static const struct regmap_irq_chip max77802_rtc_irq_chip = {
> +	.name		= "max77802-rtc",
> +	.status_base	= MAX77802_RTC_INT,
> +	.mask_base	= MAX77802_RTC_INTM,
> +	.num_regs	= 1,
> +	.irqs		= max77686_rtc_irqs, /* same masks as 77686 */
> +	.num_irqs	= ARRAY_SIZE(max77686_rtc_irqs),
> +};
> +
>  static const struct max77686_rtc_driver_data max77802_drv_data = {
>  	.delay = 200,
>  	.mask  = 0xff,
>  	.map   = max77802_map,
>  	.alarm_enable_reg  = true,
> -	.separate_i2c_addr = false,
> +	.separate_i2c_addr = 0,
> +	.rtc_irq_chip = &max77802_rtc_irq_chip,
>  };
>  
>  static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
> @@ -599,9 +717,65 @@ static int max77686_rtc_init_reg(struct max77686_rtc_info *info)
>  	return ret;
>  }
>  
> +static const struct regmap_config max77686_rtc_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
> +{
> +	struct device *parent = info->dev->parent;
> +	struct i2c_client *parent_i2c = to_i2c_client(parent);
> +	int ret;
> +
> +	info->rtc_irq =  parent_i2c->irq;

Double space.

> +
> +	info->regmap = dev_get_regmap(parent, NULL);
> +	if (!info->regmap) {
> +		dev_err(info->dev, "Failed to get rtc regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!info->drv_data->separate_i2c_addr) {
> +		info->rtc = parent_i2c;

I think it should remain NULL in such case. You won't be using it
anyway... but in case if you use it then it will be an error anyway
(like in error path below).

> +		goto add_rtc_irq;
> +	}
> +
> +	info->rtc = i2c_new_dummy(parent_i2c->adapter,
> +				info->drv_data->separate_i2c_addr);

Please align the argument on new line.

> +	if (!info->rtc) {
> +		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
> +		return -ENODEV;
> +	}
> +	i2c_set_clientdata(info->rtc, info);

No need for this. There is no getter. Removal of this could be a
separate patch (before this one).

> +
> +	info->rtc_regmap = devm_regmap_init_i2c(info->rtc,
> +						&max77686_rtc_regmap_config);
> +	if (IS_ERR(info->rtc_regmap)) {
> +		ret = PTR_ERR(info->rtc_regmap);
> +		dev_err(info->dev, "failed to allocate RTC regmap: %d\n", ret);

While moving the messages can you unify the capital letter style (e.g.
all of error msg starting with capital).

> +		goto err_unregister_i2c;
> +	}
> +
> +add_rtc_irq:
> +	ret = regmap_add_irq_chip(info->rtc_regmap, info->rtc_irq,
> +				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
> +				  IRQF_SHARED, 0, info->drv_data->rtc_irq_chip,
> +				  &info->rtc_irq_data);
> +	if (ret < 0) {
> +		dev_err(info->dev, "failed to add RTC irq chip: %d\n", ret);
> +		goto err_unregister_i2c;
> +	}
> +
> +	return 0;
> +
> +err_unregister_i2c:
> +	i2c_unregister_device(info->rtc);

That would unregister the parent. You are missing "if (separate)".

> +	return ret;
> +}
> +
>  static int max77686_rtc_probe(struct platform_device *pdev)
>  {
> -	struct max77686_dev *max77686 = dev_get_drvdata(pdev->dev.parent);
>  	struct max77686_rtc_info *info;
>  	const struct platform_device_id *id = platform_get_device_id(pdev);
>  	int ret;
> @@ -613,18 +787,16 @@ static int max77686_rtc_probe(struct platform_device *pdev)
>  
>  	mutex_init(&info->lock);
>  	info->dev = &pdev->dev;
> -	info->rtc = max77686->rtc;
>  	info->drv_data = (const struct max77686_rtc_driver_data *)
>  		id->driver_data;
>  
> -	info->regmap = max77686->regmap;
> -	info->rtc_regmap = (info->drv_data->separate_i2c_addr) ?
> -			    max77686->rtc_regmap : info->regmap;
> +	ret = max77686_init_rtc_regmap(info);
> +	if (ret < 0)
> +		return ret;
>  
>  	platform_set_drvdata(pdev, info);
>  
>  	ret = max77686_rtc_init_reg(info);
> -
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to initialize RTC reg:%d\n", ret);
>  		goto err_rtc;
> @@ -643,13 +815,7 @@ static int max77686_rtc_probe(struct platform_device *pdev)
>  		goto err_rtc;
>  	}
>  
> -	if (!max77686->rtc_irq_data) {
> -		ret = -EINVAL;
> -		dev_err(&pdev->dev, "No RTC regmap IRQ chip\n");
> -		goto err_rtc;
> -	}
> -
> -	info->virq = regmap_irq_get_virq(max77686->rtc_irq_data,
> +	info->virq = regmap_irq_get_virq(info->rtc_irq_data,
>  					 MAX77686_RTCIRQ_RTCA1);
>  	if (!info->virq) {
>  		ret = -ENXIO;
> @@ -659,14 +825,34 @@ static int max77686_rtc_probe(struct platform_device *pdev)
>  	ret = devm_request_threaded_irq(&pdev->dev, info->virq, NULL,
>  					max77686_rtc_alarm_irq, 0,
>  					"rtc-alarm1", info);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
>  			info->virq, ret);
> +		goto err_rtc;
> +	}
> +
> +	return 0;
>  
>  err_rtc:
> +	if (info->drv_data->separate_i2c_addr)
> +		i2c_unregister_device(info->rtc);
> +	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);

Cleanup in reverse-order of allocation. So first del irq_chip then
unregister i2c.

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
