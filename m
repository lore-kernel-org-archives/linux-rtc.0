Return-Path: <rtc-linux+bncBDKZNNNLXAHBB7WIUC2QKGQE3VS2Z3Y@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id u66si49069pfa.2.2016.01.26.17.59.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 17:59:26 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1L004K09IXTDA0@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 27 Jan 2016 01:59:21 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v3 06/10] rtc: max77686: Add max77802 support
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
 <1453836020-29579-7-git-send-email-javier@osg.samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A82475.1040602@samsung.com>
Date: Wed, 27 Jan 2016 10:59:17 +0900
MIME-version: 1.0
In-reply-to: <1453836020-29579-7-git-send-email-javier@osg.samsung.com>
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

On 27.01.2016 04:20, Javier Martinez Canillas wrote:
> The MAX77686 and MAX77802 RTC IP blocks are very similar with only
> these differences:
> 
> 0) The RTC registers layout and addresses are different.
> 
> 1) The MAX77686 use 1 bit of the sec/min/hour/etc registers as the
>    alarm enable while MAX77802 has a separate register for that.
> 
> 2) The MAX77686 RTCYEAR register valid values range is 0..99 while
>    for MAX77802 is 0..199.
> 
> 3) The MAX77686 has a separate I2C address for the RTC registers
>    while the MAX77802 uses the same I2C address as the PMIC regs.
> 
> 5) The minimum delay before a RTC update (16 msecs vs 200 usecs).
> 
> There are separate drivers for MAX77686 and MAX77802 RTC IP blocks
> but the differences are not that big so the driver can be extended
> to support both instead of duplicating a lot of code in 2 drivers.
> 
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
> 
> ---
> 
> Changes in v3:
> - Add Laxman Dewangan's Acked-by tag to patch #6.
> 
> Changes in v2:
> - Add a MAX77802 prefix to ALARM_ENABLE_VALUE. Suggested by Krzysztof Kozlowski.
> - Rename .rtcae to .alarm_enable_reg and .rtcrm to .separate_i2c_addr.
>   Suggested by Krzysztof Kozlowski.
> - Don't use func and LINE in error messages. Suggested by Krzysztof Kozlowski.
> - Remove REG_RTC_AE2 since is not used by neither max77686 nor max77802.
> - Check if REG_RTC_AE1 has a valid address before accessing it.
> 
>  drivers/rtc/rtc-max77686.c | 208 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 162 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index 1f501b6fc314..09fc73016d3a 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -1,5 +1,5 @@
>  /*
> - * RTC driver for Maxim MAX77686
> + * RTC driver for Maxim MAX77686 and MAX77802
>   *
>   * Copyright (C) 2012 Samsung Electronics Co.Ltd
>   *
> @@ -41,6 +41,15 @@
>  #define ALARM_ENABLE_SHIFT		7
>  #define ALARM_ENABLE_MASK		(1 << ALARM_ENABLE_SHIFT)
>  
> +#define REG_RTC_NONE			0xdeadbeef
> +
> +/*
> + * MAX77802 has separate register (RTCAE1) for alarm enable instead
> + * using 1 bit from registers RTC{SEC,MIN,HOUR,DAY,MONTH,YEAR,DATE}
> + * as in done in MAX77686.
> + */
> +#define MAX77802_ALARM_ENABLE_VALUE	0x77
> +
>  enum {
>  	RTC_SEC = 0,
>  	RTC_MIN,
> @@ -59,6 +68,10 @@ struct max77686_rtc_driver_data {
>  	u8			mask;
>  	/* Registers offset to I2C addresses map */
>  	const unsigned int	*map;
> +	/* Has a separate alarm enable register? */
> +	bool			alarm_enable_reg;
> +	/* Has a separate I2C regmap for the RTC? */
> +	bool			separate_i2c_addr;
>  };
>  
>  struct max77686_rtc_info {
> @@ -108,6 +121,7 @@ enum max77686_rtc_reg_offset {
>  	REG_ALARM2_MONTH,
>  	REG_ALARM2_YEAR,
>  	REG_ALARM2_DATE,
> +	REG_RTC_AE1,
>  	REG_RTC_END,
>  };
>  
> @@ -138,12 +152,52 @@ static const unsigned int max77686_map[REG_RTC_END] = {
>  	[REG_ALARM2_MONTH]   = MAX77686_ALARM2_MONTH,
>  	[REG_ALARM2_YEAR]    = MAX77686_ALARM2_YEAR,
>  	[REG_ALARM2_DATE]    = MAX77686_ALARM2_DATE,
> +	[REG_RTC_AE1]	     = REG_RTC_NONE,
>  };
>  
>  static const struct max77686_rtc_driver_data max77686_drv_data = {
>  	.delay = 16000,
>  	.mask  = 0x7f,
>  	.map   = max77686_map,
> +	.alarm_enable_reg  = false,
> +	.separate_i2c_addr = true,
> +};
> +
> +static const unsigned int max77802_map[REG_RTC_END] = {
> +	[REG_RTC_CONTROLM]   = MAX77802_RTC_CONTROLM,
> +	[REG_RTC_CONTROL]    = MAX77802_RTC_CONTROL,
> +	[REG_RTC_UPDATE0]    = MAX77802_RTC_UPDATE0,
> +	[REG_WTSR_SMPL_CNTL] = MAX77802_WTSR_SMPL_CNTL,
> +	[REG_RTC_SEC]        = MAX77802_RTC_SEC,
> +	[REG_RTC_MIN]        = MAX77802_RTC_MIN,
> +	[REG_RTC_HOUR]       = MAX77802_RTC_HOUR,
> +	[REG_RTC_WEEKDAY]    = MAX77802_RTC_WEEKDAY,
> +	[REG_RTC_MONTH]      = MAX77802_RTC_MONTH,
> +	[REG_RTC_YEAR]       = MAX77802_RTC_YEAR,
> +	[REG_RTC_DATE]       = MAX77802_RTC_DATE,
> +	[REG_ALARM1_SEC]     = MAX77802_ALARM1_SEC,
> +	[REG_ALARM1_MIN]     = MAX77802_ALARM1_MIN,
> +	[REG_ALARM1_HOUR]    = MAX77802_ALARM1_HOUR,
> +	[REG_ALARM1_WEEKDAY] = MAX77802_ALARM1_WEEKDAY,
> +	[REG_ALARM1_MONTH]   = MAX77802_ALARM1_MONTH,
> +	[REG_ALARM1_YEAR]    = MAX77802_ALARM1_YEAR,
> +	[REG_ALARM1_DATE]    = MAX77802_ALARM1_DATE,
> +	[REG_ALARM2_SEC]     = MAX77802_ALARM2_SEC,
> +	[REG_ALARM2_MIN]     = MAX77802_ALARM2_MIN,
> +	[REG_ALARM2_HOUR]    = MAX77802_ALARM2_HOUR,
> +	[REG_ALARM2_WEEKDAY] = MAX77802_ALARM2_WEEKDAY,
> +	[REG_ALARM2_MONTH]   = MAX77802_ALARM2_MONTH,
> +	[REG_ALARM2_YEAR]    = MAX77802_ALARM2_YEAR,
> +	[REG_ALARM2_DATE]    = MAX77802_ALARM2_DATE,
> +	[REG_RTC_AE1]	     = MAX77802_RTC_AE1,
> +};
> +
> +static const struct max77686_rtc_driver_data max77802_drv_data = {
> +	.delay = 200,
> +	.mask  = 0xff,
> +	.map   = max77802_map,
> +	.alarm_enable_reg  = true,
> +	.separate_i2c_addr = false,
>  };
>  
>  static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
> @@ -165,12 +219,20 @@ static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
>  	tm->tm_wday = ffs(data[RTC_WEEKDAY] & mask) - 1;
>  	tm->tm_mday = data[RTC_DATE] & 0x1f;
>  	tm->tm_mon = (data[RTC_MONTH] & 0x0f) - 1;
> -	tm->tm_year = (data[RTC_YEAR] & mask) + 100;
> +	tm->tm_year = data[RTC_YEAR] & mask;
>  	tm->tm_yday = 0;
>  	tm->tm_isdst = 0;
> +
> +	/*
> +	 * MAX77686 uses 1 bit from sec/min/hour/etc RTC registers and the
> +	 * year values are just 0..99 so add 100 to support up to 2099.
> +	 */
> +	if (!info->drv_data->alarm_enable_reg)
> +		tm->tm_year += 100;
>  }
>  
> -static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data)
> +static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data,
> +				   struct max77686_rtc_info *info)
>  {
>  	data[RTC_SEC] = tm->tm_sec;
>  	data[RTC_MIN] = tm->tm_min;
> @@ -178,13 +240,19 @@ static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data)
>  	data[RTC_WEEKDAY] = 1 << tm->tm_wday;
>  	data[RTC_DATE] = tm->tm_mday;
>  	data[RTC_MONTH] = tm->tm_mon + 1;
> -	data[RTC_YEAR] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
>  
> -	if (tm->tm_year < 100) {
> -		pr_warn("RTC cannot handle the year %d.  Assume it's 2000.\n",
> -			1900 + tm->tm_year);
> -		return -EINVAL;
> +	if (!info->drv_data->alarm_enable_reg) {

I don't like all these inverted checks. They are error-prone. This is
why I propose different name. However since you want to stick to this
name of this property, then easier to read would be:

if (info->drv_data->alarm_enable_reg) {
	data[RTC_YEAR] = tm->tm_year;
} else {
	max77686-stuff...
}
Can you reverse it here and in other places?

The patch beside that is okay and works fine:

Tested on Trats2 (max77686):
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

BR,
Krzysztof

> +		data[RTC_YEAR] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
> +
> +		if (tm->tm_year < 100) {
> +			pr_warn("RTC can't handle year %d. Assume it's 2000.\n",
> +				1900 + tm->tm_year);
> +			return -EINVAL;
> +		}
> +	} else {
> +		data[RTC_YEAR] = tm->tm_year;
>  	}
> +
>  	return 0;
>  }
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
