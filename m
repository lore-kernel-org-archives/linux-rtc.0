Return-Path: <rtc-linux+bncBDMLN5HOIYIO7S52YICRUBFNQJ2IC@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailout4.samsung.com (mailout4.samsung.com. [203.254.224.34])
        by gmr-mx.google.com with ESMTPS id w2si8390720pfg.0.2016.12.12.05.28.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 05:28:15 -0800 (PST)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OI201YGQQQUCPA0@mailout4.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 12 Dec 2016 22:28:13 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Venkat Reddy Talla <vreddytalla@nvidia.com>
Cc: cw00.choi@samsung.com, krzk@kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com, ldewangan@nvidia.com
Subject: [rtc-linux] Re: [PATCH] rtc: max77683: avoid regmap bulk write for max77620
Date: Mon, 12 Dec 2016 14:28:11 +0100
Message-id: <2080923.yQbi47FubE@amdc3058>
In-reply-to: <1481543085-19540-1-git-send-email-vreddytalla@nvidia.com>
References: <1481543085-19540-1-git-send-email-vreddytalla@nvidia.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


Hi,

On Monday, December 12, 2016 05:14:45 PM Venkat Reddy Talla wrote:
> Adding support to avoid regmap bulk write for the
> devices which are not supported register bulk write.

What about register bulk reads done by the driver?

Do they also need a fixup?

> Max77620 RTC device does not support register bulk write
> so disabling regmap bulk write for max77620 rtc device
> and enabling only for max77683.
> 
> Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
> ---
>  drivers/rtc/rtc-max77686.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index 182fdd0..401ab25 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -84,6 +84,7 @@ struct max77686_rtc_driver_data {
>  	int			alarm_pending_status_reg;
>  	/* RTC IRQ CHIP for regmap */
>  	const struct regmap_irq_chip *rtc_irq_chip;
> +	bool avoid_rtc_bulk_write;

It should be grouped with other bool fields of this struct.

Reversing the logic would make it simpler and would make
the naming (rtc_bulk_write) consistent with other bool
fields in the struct.

>  };
>  
>  struct max77686_rtc_info {
> @@ -197,6 +198,7 @@ static const struct max77686_rtc_driver_data max77686_drv_data = {
>  	.alarm_pending_status_reg = MAX77686_REG_STATUS2,
>  	.rtc_i2c_addr = MAX77686_I2C_ADDR_RTC,
>  	.rtc_irq_chip = &max77686_rtc_irq_chip,
> +	.avoid_rtc_bulk_write = false,
>  };
>  
>  static const struct max77686_rtc_driver_data max77620_drv_data = {
> @@ -208,6 +210,7 @@ static const struct max77686_rtc_driver_data max77620_drv_data = {
>  	.alarm_pending_status_reg = MAX77686_INVALID_REG,
>  	.rtc_i2c_addr = MAX77620_I2C_ADDR_RTC,
>  	.rtc_irq_chip = &max77686_rtc_irq_chip,
> +	.avoid_rtc_bulk_write = true,
>  };
>  
>  static const unsigned int max77802_map[REG_RTC_END] = {
> @@ -259,6 +262,32 @@ static const struct max77686_rtc_driver_data max77802_drv_data = {
>  	.rtc_irq_chip = &max77802_rtc_irq_chip,
>  };
>  
> +static inline int _regmap_bulk_write(struct max77686_rtc_info *info,

rtc_regmap_bulk_write?

> +		unsigned int reg, void *val, int len)
> +{

Please keep arguments (except "info" one) in sync with regmap_bulk_write():

int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
		     size_t val_count)

> +	int ret = 0;
> +
> +	if (!info->drv_data->avoid_rtc_bulk_write) {
> +		/* RTC registers support sequential writing */
> +		ret = regmap_bulk_write(info->rtc_regmap, reg, val, len);
> +	} else {
> +		/* Power registers support register-data pair writing */

Hmn, maybe this can be handled be regmap_bulk_write() with proper
regmap setting (map->bus == NULL?), can anyone with more regmap
expertise comment on this?

> +		u8 *src = (u8 *)val;
> +		int i;
> +
> +		for (i = 0; i < len; i++) {
> +			ret = regmap_write(info->rtc_regmap, reg, *src++);
> +			if (ret < 0)
> +				break;
> +			reg++;
> +		}
> +	}
> +	if (ret < 0)
> +		dev_err(info->dev, "%s() failed, e %d\n", __func__, ret);

Not needed, upper layers already check ret < 0 cases.

> +	return ret;
> +}
> +
>  static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
>  				    struct max77686_rtc_info *info)
>  {
> @@ -383,7 +412,7 @@ static int max77686_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  
>  	mutex_lock(&info->lock);
>  
> -	ret = regmap_bulk_write(info->rtc_regmap,
> +	ret = _regmap_bulk_write(info,
>  				info->drv_data->map[REG_RTC_SEC],
>  				data, ARRAY_SIZE(data));
>  	if (ret < 0) {
> @@ -506,7 +535,7 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
>  		for (i = 0; i < ARRAY_SIZE(data); i++)
>  			data[i] &= ~ALARM_ENABLE_MASK;
>  
> -		ret = regmap_bulk_write(info->rtc_regmap, map[REG_ALARM1_SEC],
> +		ret = _regmap_bulk_write(info, map[REG_ALARM1_SEC],
>  					data, ARRAY_SIZE(data));
>  	}
>  
> @@ -558,7 +587,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
>  		if (data[RTC_DATE] & 0x1f)
>  			data[RTC_DATE] |= (1 << ALARM_ENABLE_SHIFT);
>  
> -		ret = regmap_bulk_write(info->rtc_regmap, map[REG_ALARM1_SEC],
> +		ret = _regmap_bulk_write(info, map[REG_ALARM1_SEC],
>  					data, ARRAY_SIZE(data));
>  	}
>  
> @@ -588,7 +617,7 @@ static int max77686_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	if (ret < 0)
>  		goto out;
>  
> -	ret = regmap_bulk_write(info->rtc_regmap,
> +	ret = _regmap_bulk_write(info,
>  				info->drv_data->map[REG_ALARM1_SEC],
>  				data, ARRAY_SIZE(data));
>  
> @@ -654,7 +683,7 @@ static int max77686_rtc_init_reg(struct max77686_rtc_info *info)
>  
>  	info->rtc_24hr_mode = 1;
>  
> -	ret = regmap_bulk_write(info->rtc_regmap,
> +	ret = _regmap_bulk_write(info,
>  				info->drv_data->map[REG_RTC_CONTROLM],
>  				data, ARRAY_SIZE(data));
>  	if (ret < 0) {

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
