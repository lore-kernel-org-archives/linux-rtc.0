Return-Path: <rtc-linux+bncBAABBSPCQO2QKGQEGUOENWQ@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id 190si211786pfb.1.2016.01.21.06.55.05
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Jan 2016 06:55:05 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 3/8] rtc: max77686: Use a driver data struct
 instead hard-coded values
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
 <1453310088-29985-4-git-send-email-javier@osg.samsung.com>
 <56A02A25.9050905@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56A0F144.9020808@osg.samsung.com>
Date: Thu, 21 Jan 2016 11:55:00 -0300
MIME-Version: 1.0
In-Reply-To: <56A02A25.9050905@samsung.com>
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

On 01/20/2016 09:45 PM, Krzysztof Kozlowski wrote:
> On 21.01.2016 02:14, Javier Martinez Canillas wrote:
>> The driver has some hard-coded values such as the minimum delay needed
>> before a RTC update or the mask used for the sec/min/hour/etc registers.
>>
>> Use a data structure that contains these values and pass as driver data
>> using the platform device ID table for each device.
>>
>> This allows to make the driver's ops callbacks more generic so other RTC
>> that are similar but don't have the same values can also be supported.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>
>>   drivers/rtc/rtc-max77686.c | 47 +++++++++++++++++++++++++++++-----------------
>>   1 file changed, 30 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
>> index ae4d61e7ce4b..441d163dcbeb 100644
>> --- a/drivers/rtc/rtc-max77686.c
>> +++ b/drivers/rtc/rtc-max77686.c
>> @@ -41,8 +41,6 @@
>>   #define ALARM_ENABLE_SHIFT		7
>>   #define ALARM_ENABLE_MASK		(1 << ALARM_ENABLE_SHIFT)
>>
>> -#define MAX77686_RTC_UPDATE_DELAY	16000
>> -
>>   enum {
>>   	RTC_SEC = 0,
>>   	RTC_MIN,
>> @@ -54,6 +52,11 @@ enum {
>>   	RTC_NR_TIME
>>   };
>>
>> +struct rtc_driver_data {
>
> 1. This is only local structure so maybe: max77686_rtc_driver_data?
>

Agreed.

> 2. Can you put here a comment explaining the purpose of this delay
> (quite generic name) and used units?
>
>> +	unsigned long		delay;
>
> A comment here - what 'mask'? Generic name so explanation would be welcomed.
>
>> +	int			mask;
>
> I think this should be u8 to avoid early promotions to int. It is used
> directly with other u8 values. At the end effect of operation is
> promoted to int anyway but using only u8 for operations looks more
> consistent to me.
>

Ok, I added comments for these two fields and used u8 for mask instead.
  
>> +};
>> +
>>   struct max77686_rtc_info {
>>   	struct device		*dev;
>>   	struct max77686_dev	*max77686;
>> @@ -63,6 +66,8 @@ struct max77686_rtc_info {
>>
>>   	struct regmap		*regmap;
>>
>> +	struct rtc_driver_data	*drv_data;
>
> That may be pointer to const data. Actually not "may be" but
> even "should be" because you allocate later really a const data and you
> are discarding const-ness with cast.
>

Agreed, I missed that before.
  
>> +
>>   	int virq;
>>   	int rtc_24hr_mode;
>>   };
>> @@ -72,12 +77,19 @@ enum MAX77686_RTC_OP {
>>   	MAX77686_RTC_READ,
>>   };
>>
>> +static const struct rtc_driver_data max77686_drv_data = {
>> +	.delay = 1600,
>> +	.mask  = 0x7f,
>> +};
>> +
>>   static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
>> -				   int rtc_24hr_mode)
>> +				    struct max77686_rtc_info *info)
>>   {
>> -	tm->tm_sec = data[RTC_SEC] & 0x7f;
>> -	tm->tm_min = data[RTC_MIN] & 0x7f;
>> -	if (rtc_24hr_mode)
>> +	int mask = info->drv_data->mask;
>> +
>> +	tm->tm_sec = data[RTC_SEC] & mask;
>> +	tm->tm_min = data[RTC_MIN] & mask;
>> +	if (info->rtc_24hr_mode)
>>   		tm->tm_hour = data[RTC_HOUR] & 0x1f;
>>   	else {
>>   		tm->tm_hour = data[RTC_HOUR] & 0x0f;
>> @@ -86,10 +98,10 @@ static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
>>   	}
>>
>>   	/* Only a single bit is set in data[], so fls() would be equivalent */
>> -	tm->tm_wday = ffs(data[RTC_WEEKDAY] & 0x7f) - 1;
>> +	tm->tm_wday = ffs(data[RTC_WEEKDAY] & mask) - 1;
>>   	tm->tm_mday = data[RTC_DATE] & 0x1f;
>>   	tm->tm_mon = (data[RTC_MONTH] & 0x0f) - 1;
>> -	tm->tm_year = (data[RTC_YEAR] & 0x7f) + 100;
>> +	tm->tm_year = (data[RTC_YEAR] & mask) + 100;
>>   	tm->tm_yday = 0;
>>   	tm->tm_isdst = 0;
>>   }
>> @@ -117,6 +129,7 @@ static int max77686_rtc_update(struct max77686_rtc_info *info,
>>   {
>>   	int ret;
>>   	unsigned int data;
>> +	unsigned long delay = info->drv_data->delay;
>>
>>   	if (op == MAX77686_RTC_WRITE)
>>   		data = 1 << RTC_UDR_SHIFT;
>> @@ -129,9 +142,8 @@ static int max77686_rtc_update(struct max77686_rtc_info *info,
>>   		dev_err(info->dev, "%s: fail to write update reg(ret=%d, data=0x%x)\n",
>>   				__func__, ret, data);
>>   	else {
>> -		/* Minimum 16ms delay required before RTC update. */
>> -		usleep_range(MAX77686_RTC_UPDATE_DELAY,
>> -			     MAX77686_RTC_UPDATE_DELAY * 2);
>> +		/* Minimum delay required before RTC update. */
>> +		usleep_range(delay, delay * 2);
>>   	}
>>
>>   	return ret;
>> @@ -156,7 +168,7 @@ static int max77686_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>   		goto out;
>>   	}
>>
>> -	max77686_rtc_data_to_tm(data, tm, info->rtc_24hr_mode);
>> +	max77686_rtc_data_to_tm(data, tm, info);
>>
>>   	ret = rtc_valid_tm(tm);
>>
>> @@ -213,7 +225,7 @@ static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>>   		goto out;
>>   	}
>>
>> -	max77686_rtc_data_to_tm(data, &alrm->time, info->rtc_24hr_mode);
>> +	max77686_rtc_data_to_tm(data, &alrm->time, info);
>>
>>   	alrm->enabled = 0;
>>   	for (i = 0; i < RTC_NR_TIME; i++) {
>> @@ -260,7 +272,7 @@ static int max77686_rtc_stop_alarm(struct max77686_rtc_info *info)
>>   		goto out;
>>   	}
>>
>> -	max77686_rtc_data_to_tm(data, &tm, info->rtc_24hr_mode);
>> +	max77686_rtc_data_to_tm(data, &tm, info);
>>
>>   	for (i = 0; i < RTC_NR_TIME; i++)
>>   		data[i] &= ~ALARM_ENABLE_MASK;
>> @@ -299,7 +311,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
>>   		goto out;
>>   	}
>>
>> -	max77686_rtc_data_to_tm(data, &tm, info->rtc_24hr_mode);
>> +	max77686_rtc_data_to_tm(data, &tm, info);
>>
>>   	data[RTC_SEC] |= (1 << ALARM_ENABLE_SHIFT);
>>   	data[RTC_MIN] |= (1 << ALARM_ENABLE_SHIFT);
>> @@ -307,7 +319,7 @@ static int max77686_rtc_start_alarm(struct max77686_rtc_info *info)
>>   	data[RTC_WEEKDAY] &= ~ALARM_ENABLE_MASK;
>>   	if (data[RTC_MONTH] & 0xf)
>>   		data[RTC_MONTH] |= (1 << ALARM_ENABLE_SHIFT);
>> -	if (data[RTC_YEAR] & 0x7f)
>> +	if (data[RTC_YEAR] & info->drv_data->mask)
>>   		data[RTC_YEAR] |= (1 << ALARM_ENABLE_SHIFT);
>>   	if (data[RTC_DATE] & 0x1f)
>>   		data[RTC_DATE] |= (1 << ALARM_ENABLE_SHIFT);
>> @@ -436,6 +448,7 @@ static int max77686_rtc_probe(struct platform_device *pdev)
>>   	info->dev = &pdev->dev;
>>   	info->max77686 = max77686;
>>   	info->rtc = max77686->rtc;
>> +	info->drv_data = (struct rtc_driver_data *)pdev->id_entry->driver_data;
>
> That cast dropping constness is bad.
>

Agreed, fixed.
  
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
