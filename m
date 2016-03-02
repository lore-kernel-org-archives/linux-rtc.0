Return-Path: <rtc-linux+bncBDKZNNNLXAHBBJPV3C3AKGQE3WJIURA@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id ui7si4800780pab.0.2016.03.01.16.58.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 16:58:13 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O3E003QO00WYH70@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 02 Mar 2016 00:58:08 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: max77686: Add support for
 MAX20024/MAX77620 RTC IP
To: Laxman Dewangan <ldewangan@nvidia.com>,
 alexandre.belloni@free-electrons.com, a.zummo@towertech.it
References: <1456750705-13579-1-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, javier@osg.samsung.com, rklein@nvidia.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56D63A9C.20506@samsung.com>
Date: Wed, 02 Mar 2016 09:58:04 +0900
MIME-version: 1.0
In-reply-to: <1456750705-13579-1-git-send-email-ldewangan@nvidia.com>
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

On 29.02.2016 21:58, Laxman Dewangan wrote:
> Maxim Semiconductor's PMIC MAX77686 has RTC IP which is
> reused in the MAX77620/MAX20024 PMICs.
> 
> Add support for these devices in MAX77686 RTC driver. This
> device does not have RTC alarm pending status outside of
> RTC IP. The RTC IP is having separate I2C address for its
> register access.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/rtc/Kconfig        |  4 ++--
>  drivers/rtc/rtc-max77686.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 08df14b..1c8dadc 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -326,10 +326,10 @@ config RTC_DRV_MAX8997
>  
>  config RTC_DRV_MAX77686
>  	tristate "Maxim MAX77686"
> -	depends on MFD_MAX77686
> +	depends on MFD_MAX77686 || MFD_MAX77620
>  	help
>  	  If you say yes here you will get support for the
> -	  RTC of Maxim MAX77686 PMIC.
> +	  RTC of Maxim MAX77686/MAX77620/MAX77802 PMIC.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-max77686.
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index 5e924f3..39d529a 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -24,8 +24,15 @@
>  #include <linux/regmap.h>
>  
>  #define MAX77686_I2C_ADDR_RTC		(0x0C >> 1)
> +#define MAX77620_I2C_ADDR_RTC		0x68
>  #define MAX77686_INVALID_I2C_ADDR	(-1)
>  
> +/* Alarm pending register */
> +#define MAX77696_INVALID_REG		(-1)
MAX77686
...but actually why not using just 0x0 (remove it completely)? See
comment later.

> +#define MAX77686_RTC_ALARM_PENDING_STATUS_REG	MAX77686_REG_STATUS2
> +#define MAX77802_RTC_ALARM_PENDING_STATUS_REG	MAX77686_REG_STATUS2
> +#define MAX77620_RTC_ALARM_PENDING_STATUS_REG	MAX77696_INVALID_REG

These defines look useless. Just use directly the register.

> +
>  /* RTC Control Register */
>  #define BCD_EN_SHIFT			0
>  #define BCD_EN_MASK			BIT(BCD_EN_SHIFT)
> @@ -74,6 +81,10 @@ struct max77686_rtc_driver_data {
>  	bool			alarm_enable_reg;
>  	/* I2C address for RTC block */
>  	int			rtc_i2c_addr;
> +	/* RTC interrupt via platform resource */
> +	bool rtc_irq_from_platform;

Make indentation consistent.

> +	/* Pending alarm status register */
> +	int alarm_pending_status_reg;

ditto

>  	/* RTC IRQ CHIP for regmap */
>  	const struct regmap_irq_chip *rtc_irq_chip;
>  };
> @@ -185,10 +196,23 @@ static const struct max77686_rtc_driver_data max77686_drv_data = {
>  	.mask  = 0x7f,
>  	.map   = max77686_map,
>  	.alarm_enable_reg  = false,
> +	.rtc_irq_from_platform = false,
> +	.alarm_pending_status_reg = MAX77686_RTC_ALARM_PENDING_STATUS_REG,

Just:
.alarm_pending_status_reg = MAX77686_REG_STATUS2

>  	.rtc_i2c_addr = MAX77686_I2C_ADDR_RTC,
>  	.rtc_irq_chip = &max77686_rtc_irq_chip,
>  };
>  
> +static const struct max77686_rtc_driver_data max77620_drv_data = {
> +	.delay = 16000,
> +	.mask  = 0x7f,
> +	.map   = max77686_map,
> +	.alarm_enable_reg  = false,
> +	.rtc_irq_from_platform = true,
> +	.alarm_pending_status_reg = MAX77620_RTC_ALARM_PENDING_STATUS_REG,

Just skip the alarm_pending_status_reg (so it will be 0x0) and check for
non-zero value later?

It might be a little bit non consistent approach to how we map RTC
registers (REG_RTC_NONE)... so I don't have strong feelings about this.


> +	.rtc_i2c_addr = MAX77620_I2C_ADDR_RTC,
> +	.rtc_irq_chip = &max77686_rtc_irq_chip,
> +};
> +
>  static const unsigned int max77802_map[REG_RTC_END] = {
>  	[REG_RTC_CONTROLM]   = MAX77802_RTC_CONTROLM,
>  	[REG_RTC_CONTROL]    = MAX77802_RTC_CONTROL,
> @@ -232,6 +256,8 @@ static const struct max77686_rtc_driver_data max77802_drv_data = {
>  	.mask  = 0xff,
>  	.map   = max77802_map,
>  	.alarm_enable_reg  = true,
> +	.rtc_irq_from_platform = false,
> +	.alarm_pending_status_reg = MAX77802_RTC_ALARM_PENDING_STATUS_REG,
>  	.rtc_i2c_addr = MAX77686_INVALID_I2C_ADDR,
>  	.rtc_irq_chip = &max77802_rtc_irq_chip,
>  };
> @@ -427,9 +453,15 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	}
>  
>  	alrm->pending = 0;
> -	ret = regmap_read(info->regmap, MAX77686_REG_STATUS2, &val);
> +
> +	if (info->drv_data->alarm_pending_status_reg == MAX77696_INVALID_REG)
> +		goto out;
> +
> +	ret = regmap_read(info->regmap,
> +			  info->drv_data->alarm_pending_status_reg, &val);
>  	if (ret < 0) {
> -		dev_err(info->dev, "Fail to read status2 reg(%d)\n", ret);
> +		dev_err(info->dev,
> +			"Fail to read alarm pending status reg(%d)\n", ret);
>  		goto out;
>  	}
>  
> @@ -648,7 +680,13 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
>  	struct i2c_client *parent_i2c = to_i2c_client(parent);
>  	int ret;
>  
> -	info->rtc_irq = parent_i2c->irq;
> +	if (info->drv_data->rtc_irq_from_platform) {
> +		struct platform_device *pdev = to_platform_device(info->dev);
> +
> +		info->rtc_irq = platform_get_irq(pdev, 0);

It may return -ERRNO. What happens then?

> +	} else {
> +		info->rtc_irq =  parent_i2c->irq;
> +	}
>  
>  	info->regmap = dev_get_regmap(parent, NULL);
>  	if (!info->regmap) {
> @@ -802,6 +840,8 @@ static SIMPLE_DEV_PM_OPS(max77686_rtc_pm_ops,
>  static const struct platform_device_id rtc_id[] = {
>  	{ "max77686-rtc", .driver_data = (kernel_ulong_t)&max77686_drv_data, },
>  	{ "max77802-rtc", .driver_data = (kernel_ulong_t)&max77802_drv_data, },
> +	{ "max77620-rtc", .driver_data = (kernel_ulong_t)&max77620_drv_data, },
> +	{ "max20024-rtc", .driver_data = (kernel_ulong_t)&max77620_drv_data, },

There shouldn't be "max20024-rtc". This is exactly the same as
"max77620-rtc" so re-use existing id. No point of duplicating device
names for 100% compatible devices.

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
