Return-Path: <rtc-linux+bncBAABBQ7DQO2QKGQENUIBPUI@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id jg4si173570pac.2.2016.01.21.06.57.07
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Jan 2016 06:57:07 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 4/8] rtc: max77686: Add an indirection level
 to access RTC registers
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
 <1453310088-29985-5-git-send-email-javier@osg.samsung.com>
 <56A02EEF.2060604@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56A0F1BD.3010203@osg.samsung.com>
Date: Thu, 21 Jan 2016 11:57:01 -0300
MIME-Version: 1.0
In-Reply-To: <56A02EEF.2060604@samsung.com>
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

On 01/20/2016 10:05 PM, Krzysztof Kozlowski wrote:
> On 21.01.2016 02:14, Javier Martinez Canillas wrote:
>> The max77686 driver is generic enough that can be used for other
>> Maxim RTC IP blocks but these might not have the same registers
>> layout so instead of accessing the registers directly, add a map
>> to translate offsets to the real registers addresses for each IP.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>
>>   drivers/rtc/rtc-max77686.c | 75 +++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 65 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
>> index 441d163dcbeb..7316e41820c7 100644
>> --- a/drivers/rtc/rtc-max77686.c
>> +++ b/drivers/rtc/rtc-max77686.c
>> @@ -41,6 +41,8 @@
>>   #define ALARM_ENABLE_SHIFT		7
>>   #define ALARM_ENABLE_MASK		(1 << ALARM_ENABLE_SHIFT)
>>
>> +#define REG_RTC_NONE			0xdeadbeef
>> +
>>   enum {
>>   	RTC_SEC = 0,
>>   	RTC_MIN,
>> @@ -55,6 +57,7 @@ enum {
>>   struct rtc_driver_data {
>>   	unsigned long		delay;
>>   	int			mask;
>> +	const unsigned int	*map;
>>   };
>>
>>   struct max77686_rtc_info {
>> @@ -77,9 +80,53 @@ enum MAX77686_RTC_OP {
>>   	MAX77686_RTC_READ,
>>   };
>>
>> +/* These are not registers but just offsets that are mapped to addresses */
>> +enum rtc_reg {
>
> enum max77686_rtc_reg_offset?
>

Agreed.
  
>> +	REG_RTC_CONTROLM = 0,
>> +	REG_RTC_CONTROL,
>> +	REG_RTC_UPDATE0,
>> +	REG_RTC_UPDATE1,
>> +	REG_WTSR_SMPL_CNTL,
>> +	REG_RTC_SEC,
>> +	REG_RTC_MIN,
>> +	REG_RTC_HOUR,
>> +	REG_RTC_WEEKDAY,
>> +	REG_RTC_MONTH,
>> +	REG_RTC_YEAR,
>> +	REG_RTC_DATE,
>> +	REG_ALARM1_SEC,
>> +	REG_ALARM1_MIN,
>> +	REG_ALARM1_HOUR,
>> +	REG_ALARM1_WEEKDAY,
>> +	REG_ALARM1_MONTH,
>> +	REG_ALARM1_YEAR,
>> +	REG_ALARM1_DATE,
>> +	REG_ALARM2_SEC,
>> +	REG_ALARM2_MIN,
>> +	REG_ALARM2_HOUR,
>> +	REG_ALARM2_WEEKDAY,
>> +	REG_ALARM2_MONTH,
>> +	REG_ALARM2_YEAR,
>> +	REG_ALARM2_DATE,
>> +	REG_RTC_END,
>> +};
>> +
>
> A short comment what is mapped into what would be appreciated.
>

Ok, added such comment for v2.
  
>> +static const unsigned int max77686_map[REG_RTC_END] = {
>> +	MAX77686_RTC_CONTROLM, MAX77686_RTC_CONTROL, MAX77686_RTC_UPDATE0,
>> +	REG_RTC_NONE, MAX77686_WTSR_SMPL_CNTL, MAX77686_RTC_SEC,
>> +	MAX77686_RTC_MIN, MAX77686_RTC_HOUR, MAX77686_RTC_WEEKDAY,
>> +	MAX77686_RTC_MONTH, MAX77686_RTC_YEAR, MAX77686_RTC_DATE,
>> +	MAX77686_ALARM1_SEC, MAX77686_ALARM1_MIN, MAX77686_ALARM1_HOUR,
>> +	MAX77686_ALARM1_WEEKDAY, MAX77686_ALARM1_MONTH, MAX77686_ALARM1_YEAR,
>> +	MAX77686_ALARM1_DATE, MAX77686_ALARM2_SEC, MAX77686_ALARM2_MIN,
>> +	MAX77686_ALARM2_HOUR, MAX77686_ALARM2_WEEKDAY, MAX77686_ALARM2_MONTH,
>> +	MAX77686_ALARM2_YEAR, MAX77686_ALARM2_DATE,
>> +};
>
> It is difficult to check for mistakes here. I would prefer direct mapping:
> 	[REG_RTC_CONTROLM] = MAX77686_RTC_CONTROLM,
> 	....
>

Right, that's a very good idea.
  
>
> Rest looks good but I did not check the correctness of mapping above.
>

Great, thanks.
  
> BR,
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
