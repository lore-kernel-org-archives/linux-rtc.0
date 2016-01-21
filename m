Return-Path: <rtc-linux+bncBAABBSXKQO2QKGQEOBE4EWY@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id r2si200173pfr.0.2016.01.21.07.12.09
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Jan 2016 07:12:09 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 5/8] rtc: max77686: Add max77802 support
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
 <1453310088-29985-6-git-send-email-javier@osg.samsung.com>
 <56A03AB7.3060109@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56A0F543.90105@osg.samsung.com>
Date: Thu, 21 Jan 2016 12:12:03 -0300
MIME-Version: 1.0
In-Reply-To: <56A03AB7.3060109@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Krzysztof,

Thanks a lot for your review.

On 01/20/2016 10:56 PM, Krzysztof Kozlowski wrote:
> On 21.01.2016 02:14, Javier Martinez Canillas wrote:
>> The MAX77686 and MAX77802 RTC IP blocks are very similar with only
>> these differences:
>>
>> 0) The RTC registers layout and addresses are different.
>>
>> 1) The MAX77686 use 1 bit of the sec/min/hour/etc registers as the
>>     alarm enable while MAX77802 has a separate register for that.
>>
>> 2) The MAX77686 RTCYEAR register valid values range is 0..99 while
>>     for MAX77802 is 0..199.
>>
>> 3) The MAX77686 has a separate I2C address for the RTC registers
>>     while the MAX77802 uses the same I2C address as the PMIC regs.
>>
>> 5) They minium delay before a RTC update (16ms vs 200 usecs).
>>
>> There are separate drivers for MAX77686 and MAX77802 RTC IP blocks
>> but the differences are not that big so the driver can be extended
>> to support both instead of duplicating a lot of code in 2 drivers.
>>
>> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>
>>   drivers/rtc/rtc-max77686.c | 176 ++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 128 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
>> index 7316e41820c7..7a144e7ecd27 100644
>> --- a/drivers/rtc/rtc-max77686.c
>> +++ b/drivers/rtc/rtc-max77686.c
>> @@ -1,5 +1,5 @@
>>   /*
>> - * RTC driver for Maxim MAX77686
>> + * RTC driver for Maxim MAX77686 and MAX77802
>>    *
>>    * Copyright (C) 2012 Samsung Electronics Co.Ltd
>>    *
>> @@ -43,6 +43,13 @@
>>
>>   #define REG_RTC_NONE			0xdeadbeef
>>
>> +/*
>> + * MAX77802 has separate register (RTCAE1) for alarm enable instead
>> + * using 1 bit from registers RTC{SEC,MIN,HOUR,DAY,MONTH,YEAR,DATE}
>> + * as in done in MAX77686.
>> + */
>> +#define ALARM_ENABLE_VALUE		0x77
>
> MAX77802_ALARM_ENABLE_VALUE
> (it is specific to 77802, right?)
>

Correct, although I guess other RTC in Maxim PMICs will need the same
value but we can stick to the convention of adding the prefix for the
first IP that needs it and the following can just use the same (as is
the case for max77686 macros used by max77802 code).

So yes, I'm adding a MAX77802 prefix to this.
  
>> +
>>   enum {
>>   	RTC_SEC = 0,
>>   	RTC_MIN,
>> @@ -58,6 +65,10 @@ struct rtc_driver_data {
>>   	unsigned long		delay;
>>   	int			mask;
>>   	const unsigned int	*map;
>> +	/* Has a separate alarm enable register? */
>> +	bool			rtcae;
>> +	/* Has a separate I2C regmap for the RTC? */
>> +	bool			rtcrm;
>
> Both members are a tongue twisters. :)
>

They are indeed!
  
> 'rtcae' you are mostly using in an inverted way (!rtcae) so how about:
> 'alarm_enable_bit'?
>

I'll better use alarm_enable_reg since is about having a separate alarm
enable register and not a bit (in fact max77686 is the one that uses 1
bit of each sec/min/hour/etc registers to encode the alarm enable info).

> 'rtcrm' - 'separate_i2c_addr'?
>

Agreed.
  
> By the way, I was thinking that you would do decoupling of i2c and
> regmap here. It is not required (more useful for Laxman's patch) but it
> might by a part of these series.
>

I prefer to stick with our plan with Laxman that I should merge max77686
and max77802 drivers and he would do the I2C decoupling on top of that.

I could do the I2C decoupling in this series but that would mean touching
the MFD driver and if possible I try to avoid cross-subsystems series.

>>   };
>>
>>   struct max77686_rtc_info {
>> @@ -108,6 +119,8 @@ enum rtc_reg {
>>   	REG_ALARM2_MONTH,
>>   	REG_ALARM2_YEAR,
>>   	REG_ALARM2_DATE,
>> +	REG_RTC_AE1,
>> +	REG_RTC_AE2,
>>   	REG_RTC_END,
>>   };
>>
>> @@ -120,13 +133,36 @@ static const unsigned int max77686_map[REG_RTC_END] = {
>>   	MAX77686_ALARM1_WEEKDAY, MAX77686_ALARM1_MONTH, MAX77686_ALARM1_YEAR,
>>   	MAX77686_ALARM1_DATE, MAX77686_ALARM2_SEC, MAX77686_ALARM2_MIN,
>>   	MAX77686_ALARM2_HOUR, MAX77686_ALARM2_WEEKDAY, MAX77686_ALARM2_MONTH,
>> -	MAX77686_ALARM2_YEAR, MAX77686_ALARM2_DATE,
>> +	MAX77686_ALARM2_YEAR, MAX77686_ALARM2_DATE, REG_RTC_NONE, REG_RTC_NONE,
>>   };
>>
>>   static const struct rtc_driver_data max77686_drv_data = {
>>   	.delay = 1600,
>>   	.mask  = 0x7f,
>>   	.map   = max77686_map,
>> +	.rtcae = false,
>> +	.rtcrm = true,
>> +};
>> +
>> +static const unsigned int max77802_map[REG_RTC_END] = {
>> +	MAX77802_RTC_CONTROLM, MAX77802_RTC_CONTROL, MAX77802_RTC_UPDATE0,
>> +	REG_RTC_NONE, MAX77802_WTSR_SMPL_CNTL, MAX77802_RTC_SEC,
>> +	MAX77802_RTC_MIN, MAX77802_RTC_HOUR, MAX77802_RTC_WEEKDAY,
>> +	MAX77802_RTC_MONTH, MAX77802_RTC_YEAR, MAX77802_RTC_DATE,
>> +	MAX77802_ALARM1_SEC, MAX77802_ALARM1_MIN, MAX77802_ALARM1_HOUR,
>> +	MAX77686_ALARM1_WEEKDAY, MAX77802_ALARM1_MONTH, MAX77802_ALARM1_YEAR,
>> +	MAX77802_ALARM1_DATE, MAX77802_ALARM1_SEC, MAX77802_ALARM1_MIN,
>> +	MAX77802_ALARM1_HOUR, MAX77802_ALARM1_WEEKDAY, MAX77802_ALARM1_MONTH,
>> +	MAX77802_ALARM1_YEAR, MAX77802_ALARM1_DATE, MAX77802_RTC_AE1,
>> +	MAX77802_RTC_AE2,
>> +};
>> +
>> +static const struct rtc_driver_data max77802_drv_data = {
>> +	.delay = 200,
>> +	.mask  = 0xff,
>> +	.map   = max77802_map,
>> +	.rtcae = true,
>> +	.rtcrm = false,
>>   };
>>
>>   static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
>> @@ -148,12 +184,20 @@ static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
>>   	tm->tm_wday = ffs(data[RTC_WEEKDAY] & mask) - 1;
>>   	tm->tm_mday = data[RTC_DATE] & 0x1f;
>>   	tm->tm_mon = (data[RTC_MONTH] & 0x0f) - 1;
>> -	tm->tm_year = (data[RTC_YEAR] & mask) + 100;
>> +	tm->tm_year = data[RTC_YEAR] & mask;
>>   	tm->tm_yday = 0;
>>   	tm->tm_isdst = 0;
>> +
>> +	/*
>> +	 * MAX77686 uses 1 bit from sec/min/hour/etc RTC registers and the
>> +	 * year values are just 0..99 so add 100 to support up to 2099.
>> +	 */
>> +	if (!info->drv_data->rtcae)
>> +		tm->tm_year += 100;
>>   }
>>
>> -static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data)
>> +static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data,
>> +				   struct max77686_rtc_info *info)
>>   {
>>   	data[RTC_SEC] = tm->tm_sec;
>>   	data[RTC_MIN] = tm->tm_min;
>> @@ -161,13 +205,19 @@ static int max77686_rtc_tm_to_data(struct rtc_time *tm, u8 *data)
>>   	data[RTC_WEEKDAY] = 1 << tm->tm_wday;
>>   	data[RTC_DATE] = tm->tm_mday;
>>   	data[RTC_MONTH] = tm->tm_mon + 1;
>> -	data[RTC_YEAR] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
>>
>> -	if (tm->tm_year < 100) {
>> -		pr_warn("RTC cannot handle the year %d.  Assume it's 2000.\n",
>> -			1900 + tm->tm_year);
>> -		return -EINVAL;
>> +	if (!info->drv_data->rtcae) {
>> +		data[RTC_YEAR] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
>> +
>> +		if (tm->tm_year < 100) {
>> +			pr_warn("RTC can't handle year %d. Assume it's 2000.\n",
>> +				1900 + tm->tm_year);
>
> Maybe in a separate patch use dev_warn()? It wasn't possible before
> because you need 'info' argument but it is possible.
>

Agreed, I'll add as another patch after this one in v2.
  
>> +			return -EINVAL;
>> +		}
>> +	} else {
>> +		data[RTC_YEAR] = tm->tm_year;
>>   	}
>> +
>>   	return 0;
>>   }
>>
>> @@ -232,7 +282,7 @@ static int max77686_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>   	u8 data[RTC_NR_TIME];
>>   	int ret;
>>
>> -	ret = max77686_rtc_tm_to_data(tm, data);
>> +	ret = max77686_rtc_tm_to_data(tm, data, info);
>>   	if (ret < 0)
>>   		return ret;
>>
>> @@ -279,11 +329,24 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>>   	max77686_rtc_data_to_tm(data, &alrm->time, info);
>>
>>   	alrm->enabled = 0;
>> -	for (i = 0; i < RTC_NR_TIME; i++) {
>> -		if (data[i] & ALARM_ENABLE_MASK) {
>> -			alrm->enabled = 1;
>> -			break;
>> +
>> +	if (!info->drv_data->rtcae) {
>> +		for (i = 0; i < RTC_NR_TIME; i++) {
>> +			if (data[i] & ALARM_ENABLE_MASK) {
>> +				alrm->enabled = 1;
>> +				break;
>> +			}
>>   		}
>> +	} else {
>> +		ret = regmap_read(info->max77686->regmap,
>> +				  map[REG_RTC_AE1], &val);
>> +		if (ret < 0) {
>> +			dev_err(info->dev, "%s:%d fail to read alarm enable(%d)\n",
>> +				__func__, __LINE__, ret);
>
> I don't like the func/LINE. I know that driver is using them already but
> I think it is better not to add new usages of it.
>

Fair enough, I'll remove it.
  
>> +			goto out;
>
> Actually I think there is a bug here already. The function will always
> return '0'. Instead the 'out' label should return 'ret'. Can you fix it
> in separate patch (with reported-by :) )?
>

Nice catch, I'll add a bugfix as another patch at the start of the series.
  
>> +		}
>> +		if (val)
>> +			alrm->enabled = 1;
>>   	}
>>
>>   	alrm->pending = 0;
>> @@ -316,21 +379,27 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
>>   	if (ret < 0)
>>   		goto out;
>>
>> -	ret = regmap_bulk_read(info->max77686->rtc_regmap,
>> -			       map[REG_ALARM1_SEC], data, RTC_NR_TIME);
>> -	if (ret < 0) {
>> -		dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
>> +	if (!info->drv_data->rtcae) {
>> +		ret = regmap_bulk_read(info->max77686->rtc_regmap,
>> +				       map[REG_ALARM1_SEC], data, RTC_NR_TIME);
>> +		if (ret < 0) {
>> +			dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
>>   				__func__, ret);
>> -		goto out;
>> -	}
>> +			goto out;
>> +		}
>>
>> -	max77686_rtc_data_to_tm(data, &tm, info);
>> +		max77686_rtc_data_to_tm(data, &tm, info);
>>
>> -	for (i = 0; i < RTC_NR_TIME; i++)
>> -		data[i] &= ~ALARM_ENABLE_MASK;
>> +		for (i = 0; i < RTC_NR_TIME; i++)
>> +			data[i] &= ~ALARM_ENABLE_MASK;
>> +
>> +		ret = regmap_bulk_write(info->max77686->rtc_regmap,
>> +					map[REG_ALARM1_SEC], data, RTC_NR_TIME);
>> +	} else {
>> +		ret = regmap_write(info->max77686->regmap,
>> +				   map[REG_RTC_AE1], 0);
>> +	}
>>
>> -	ret = regmap_bulk_write(info->max77686->rtc_regmap,
>> -				map[REG_ALARM1_SEC], data, RTC_NR_TIME);
>>   	if (ret < 0) {
>>   		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
>>   				__func__, ret);
>> @@ -356,29 +425,35 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
>>   	if (ret < 0)
>>   		goto out;
>>
>> -	ret = regmap_bulk_read(info->max77686->rtc_regmap,
>> -			       map[REG_ALARM1_SEC], data, RTC_NR_TIME);
>> -	if (ret < 0) {
>> -		dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
>> +	if (!info->drv_data->rtcae) {
>> +		ret = regmap_bulk_read(info->max77686->rtc_regmap,
>> +				       map[REG_ALARM1_SEC], data, RTC_NR_TIME);
>> +		if (ret < 0) {
>> +			dev_err(info->dev, "%s: fail to read alarm reg(%d)\n",
>>   				__func__, ret);
>> -		goto out;
>> -	}
>> -
>> -	max77686_rtc_data_to_tm(data, &tm, info);
>> +			goto out;
>> +		}
>>
>> -	data[RTC_SEC] |= (1 << ALARM_ENABLE_SHIFT);
>> -	data[RTC_MIN] |= (1 << ALARM_ENABLE_SHIFT);
>> -	data[RTC_HOUR] |= (1 << ALARM_ENABLE_SHIFT);
>> -	data[RTC_WEEKDAY] &= ~ALARM_ENABLE_MASK;
>> -	if (data[RTC_MONTH] & 0xf)
>> -		data[RTC_MONTH] |= (1 << ALARM_ENABLE_SHIFT);
>> -	if (data[RTC_YEAR] & info->drv_data->mask)
>> -		data[RTC_YEAR] |= (1 << ALARM_ENABLE_SHIFT);
>> -	if (data[RTC_DATE] & 0x1f)
>> -		data[RTC_DATE] |= (1 << ALARM_ENABLE_SHIFT);
>> +		max77686_rtc_data_to_tm(data, &tm, info);
>> +
>> +		data[RTC_SEC] |= (1 << ALARM_ENABLE_SHIFT);
>> +		data[RTC_MIN] |= (1 << ALARM_ENABLE_SHIFT);
>> +		data[RTC_HOUR] |= (1 << ALARM_ENABLE_SHIFT);
>> +		data[RTC_WEEKDAY] &= ~ALARM_ENABLE_MASK;
>> +		if (data[RTC_MONTH] & 0xf)
>> +			data[RTC_MONTH] |= (1 << ALARM_ENABLE_SHIFT);
>> +		if (data[RTC_YEAR] & info->drv_data->mask)
>> +			data[RTC_YEAR] |= (1 << ALARM_ENABLE_SHIFT);
>> +		if (data[RTC_DATE] & 0x1f)
>> +			data[RTC_DATE] |= (1 << ALARM_ENABLE_SHIFT);
>> +
>> +		ret = regmap_bulk_write(info->max77686->rtc_regmap,
>> +					map[REG_ALARM1_SEC], data, RTC_NR_TIME);
>> +	} else {
>> +		ret = regmap_write(info->max77686->regmap,
>> +				   map[REG_RTC_AE1], ALARM_ENABLE_VALUE);
>> +	}
>>
>> -	ret = regmap_bulk_write(info->max77686->rtc_regmap,
>> -				map[REG_ALARM1_SEC], data, RTC_NR_TIME);
>>   	if (ret < 0) {
>>   		dev_err(info->dev, "%s: fail to write alarm reg(%d)\n",
>>   				__func__, ret);
>> @@ -396,7 +471,7 @@ static int max77686_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>>   	u8 data[RTC_NR_TIME];
>>   	int ret;
>>
>> -	ret = max77686_rtc_tm_to_data(&alrm->time, data);
>> +	ret = max77686_rtc_tm_to_data(&alrm->time, data, info);
>>   	if (ret < 0)
>>   		return ret;
>>
>> @@ -490,6 +565,7 @@ static int max77686_rtc_probe(struct platform_device *pdev)
>>   {
>>   	struct max77686_dev *max77686 = dev_get_drvdata(pdev->dev.parent);
>>   	struct max77686_rtc_info *info;
>> +	const struct platform_device_id *id = pdev->id_entry;
>>   	int ret;
>>
>>   	dev_info(&pdev->dev, "%s\n", __func__);
>> @@ -503,7 +579,10 @@ static int max77686_rtc_probe(struct platform_device *pdev)
>>   	info->dev = &pdev->dev;
>>   	info->max77686 = max77686;
>>   	info->rtc = max77686->rtc;
>> -	info->drv_data = (struct rtc_driver_data *)pdev->id_entry->driver_data;
>
> Comment for previous patch: use platform_get_device_id(pdev).
>

Ok.
  
> Best regards,
> Krzysztof
>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

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
