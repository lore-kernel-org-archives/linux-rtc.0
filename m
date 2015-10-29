Return-Path: <rtc-linux+bncBD747RFBYUPBBU45Y6YQKGQEYW7LHZQ@googlegroups.com>
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id sm2si51204pab.0.2015.10.29.00.46.27
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 29 Oct 2015 00:46:27 -0700 (PDT)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWZ032RJ1LDMA70@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 29 Oct 2015 16:46:25 +0900 (KST)
Message-id: <5631CF0A.90109@samsung.com>
Date: Thu, 29 Oct 2015 13:17:22 +0530
From: Alim Akhtar <alim.akhtar@samsung.com>
MIME-version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, lee.jones@linaro.org,
 broonie@kernel.org
Cc: linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH v4 4/4] drivers/rtc/rtc-s5m.c: add support for
 S2MPS15 RTC
References: <1446094723-6212-1-git-send-email-alim.akhtar@samsung.com>
 <1446094723-6212-5-git-send-email-alim.akhtar@samsung.com>
 <5631B487.3050501@samsung.com>
In-reply-to: <5631B487.3050501@samsung.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello Krzysztof,

On 10/29/2015 11:24 AM, Krzysztof Kozlowski wrote:
> On 29.10.2015 13:58, Alim Akhtar wrote:
>> RTC found in s2mps15 is almost same as one found on s2mps14/13
>> with few differences in RTC_UPDATE register fields, like
>> bit fields are changed for WUDR and AUDR.
>> This patch add required changes to enable s2mps15 rtc timer.
>>
>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>   drivers/rtc/rtc-s5m.c           |   20 ++++++++++++++++++--
>>   include/linux/mfd/samsung/rtc.h |    4 ++++
>>   2 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
>> index f2504b4eef34..0d106a99958f 100644
>> --- a/drivers/rtc/rtc-s5m.c
>> +++ b/drivers/rtc/rtc-s5m.c
>> @@ -188,6 +188,7 @@ static inline int s5m_check_peding_alarm_interrupt(struct s5m_rtc_info *info,
>>   		ret = regmap_read(info->regmap, S5M_RTC_STATUS, &val);
>>   		val &= S5M_ALARM0_STATUS;
>>   		break;
>> +	case S2MPS15X:
>>   	case S2MPS14X:
>>   	case S2MPS13X:
>>   		ret = regmap_read(info->s5m87xx->regmap_pmic, S2MPS14_REG_ST2,
>> @@ -223,6 +224,9 @@ static inline int s5m8767_rtc_set_time_reg(struct s5m_rtc_info *info)
>>   	if (info->device_type == S5M8763X || info->device_type == S5M8767X)
>>   		data |= S5M_RTC_TIME_EN_MASK;
>>
>> +	if (info->device_type == S2MPS15X)
>> +		data |= S2MPS15_RTC_WUDR_MASK;
>> +
>
>
> You are setting here bit 1 and bit 4. However vendor code sets only bit
> 4 (called WUDR there). That's confusing. Why the difference? Or maybe I
> am looking at wrong vendor tree (SM-G920F)?
>
Sorry, I don't have access to vendor code that you are looking into, so 
won't be able to comment on that.

I am testing this patch before sending them, what I have found is if you 
don't update WUDR the time does not changes in rtc.
e.g.
if you don't do above changes then you will see below:
-----
# date --set="Oct 29 14:10:40 2015" <update the a new date>
Thu Oct 29 14:10:40 UTC 2015
#
# hwclock --systohc <copy system clock to hardware clock/rtc>
# hwclock <read back hwclock>
Thu Oct 29 12:52:32 2015  .922889 seconds
----
which is not excepted.

And with the above change I see:

----
  # date --set="Oct 29 14:30:10 2015" <update the a new date>
Thu Oct 29 14:30:10 UTC 2015
# date
Thu Oct 29 14:30:12 UTC 2015
# hwclock --systohc <copy system clock to hardware clock/rtc>
# hwclock <read back hwclock>
Thu Oct 29 14:30:21 2015  .333006 seconds
----

Which is as expected.

>>   	ret = regmap_write(info->regmap, info->regs->rtc_udr_update, data);
>>   	if (ret < 0) {
>>   		dev_err(info->dev, "failed to write update reg(%d)\n", ret);
>> @@ -252,6 +256,9 @@ static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
>>   	case S5M8767X:
>>   		data &= ~S5M_RTC_TIME_EN_MASK;
>>   		break;
>> +	case S2MPS15X:
>> +		data |= S2MPS15_RTC_AUDR_MASK;
>> +		break;
>>   	case S2MPS14X:
>>   		data |= S2MPS_RTC_RUDR_MASK;
>>   		break;
>
> Another difference: you are setting here exactly the same values as
> S2MPS13 - bit 1 and bit 4. However vendor code sets only bit 4 (called
> WUDR there)?
>
No they are not, AUDR on s2mps13 is bit:1 where as it is bit:4 on s2mps15.
> What exactly is necessary to update alarm and time registers on S2MPS15?
>
As explained above in example, it is required to update the 'write alarm 
buffer(AUDR)' and 'write time buffer(WUDR)' bits in-order to get rtc 
working.

>> @@ -275,7 +282,6 @@ static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
>>   	if (info->device_type == S2MPS13X)
>>   		regmap_update_bits(info->regmap, info->regs->rtc_udr_update,
>>   				   S2MPS13_RTC_AUDR_MASK, 0);
>> -
>
> This is not related to the patch.
>
uhh...will change.
> Best regards,
> Krzysztof
>
Thanks again.
>
>>   	return ret;
>>   }
>>
>> @@ -317,7 +323,8 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>   	u8 data[info->regs->regs_count];
>>   	int ret;
>>
>> -	if (info->device_type == S2MPS14X || info->device_type == S2MPS13X) {
>> +	if (info->device_type == S2MPS15X || info->device_type == S2MPS14X ||
>> +			info->device_type == S2MPS13X) {
>>   		ret = regmap_update_bits(info->regmap,
>>   				info->regs->rtc_udr_update,
>>   				S2MPS_RTC_RUDR_MASK, S2MPS_RTC_RUDR_MASK);
>> @@ -339,6 +346,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>   		break;
>>
>>   	case S5M8767X:
>> +	case S2MPS15X:
>>   	case S2MPS14X:
>>   	case S2MPS13X:
>>   		s5m8767_data_to_tm(data, tm, info->rtc_24hr_mode);
>> @@ -366,6 +374,7 @@ static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>   		s5m8763_tm_to_data(tm, data);
>>   		break;
>>   	case S5M8767X:
>> +	case S2MPS15X:
>>   	case S2MPS14X:
>>   	case S2MPS13X:
>>   		ret = s5m8767_tm_to_data(tm, data);
>> @@ -414,6 +423,7 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>>   		break;
>>
>>   	case S5M8767X:
>> +	case S2MPS15X:
>>   	case S2MPS14X:
>>   	case S2MPS13X:
>>   		s5m8767_data_to_tm(data, &alrm->time, info->rtc_24hr_mode);
>> @@ -463,6 +473,7 @@ static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
>>   		break;
>>
>>   	case S5M8767X:
>> +	case S2MPS15X:
>>   	case S2MPS14X:
>>   	case S2MPS13X:
>>   		for (i = 0; i < info->regs->regs_count; i++)
>> @@ -508,6 +519,7 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
>>   		break;
>>
>>   	case S5M8767X:
>> +	case S2MPS15X:
>>   	case S2MPS14X:
>>   	case S2MPS13X:
>>   		data[RTC_SEC] |= ALARM_ENABLE_MASK;
>> @@ -548,6 +560,7 @@ static int s5m_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>>   		break;
>>
>>   	case S5M8767X:
>> +	case S2MPS15X:
>>   	case S2MPS14X:
>>   	case S2MPS13X:
>>   		s5m8767_tm_to_data(&alrm->time, data);
>> @@ -631,6 +644,7 @@ static int s5m8767_rtc_init_reg(struct s5m_rtc_info *info)
>>   		ret = regmap_raw_write(info->regmap, S5M_ALARM0_CONF, data, 2);
>>   		break;
>>
>> +	case S2MPS15X:
>>   	case S2MPS14X:
>>   	case S2MPS13X:
>>   		data[0] = (0 << BCD_EN_SHIFT) | (1 << MODEL24_SHIFT);
>> @@ -679,6 +693,7 @@ static int s5m_rtc_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>
>>   	switch (platform_get_device_id(pdev)->driver_data) {
>> +	case S2MPS15X:
>>   	case S2MPS14X:
>>   	case S2MPS13X:
>>   		regmap_cfg = &s2mps14_rtc_regmap_config;
>> @@ -805,6 +820,7 @@ static const struct platform_device_id s5m_rtc_id[] = {
>>   	{ "s5m-rtc",		S5M8767X },
>>   	{ "s2mps13-rtc",	S2MPS13X },
>>   	{ "s2mps14-rtc",	S2MPS14X },
>> +	{ "s2mps15-rtc",	S2MPS15X },
>>   	{ },
>>   };
>>   MODULE_DEVICE_TABLE(platform, s5m_rtc_id);
>> diff --git a/include/linux/mfd/samsung/rtc.h b/include/linux/mfd/samsung/rtc.h
>> index 29c30ac36020..0be45fccc52b 100644
>> --- a/include/linux/mfd/samsung/rtc.h
>> +++ b/include/linux/mfd/samsung/rtc.h
>> @@ -107,6 +107,10 @@ enum s2mps_rtc_reg {
>>   #define S2MPS_RTC_WUDR_MASK	(1 << S2MPS_RTC_WUDR_SHIFT)
>>   #define S2MPS13_RTC_AUDR_SHIFT	1
>>   #define S2MPS13_RTC_AUDR_MASK	(1 << S2MPS13_RTC_AUDR_SHIFT)
>> +#define S2MPS15_RTC_AUDR_SHIFT	4
>> +#define S2MPS15_RTC_AUDR_MASK	(1 << S2MPS15_RTC_AUDR_SHIFT)
>> +#define S2MPS15_RTC_WUDR_SHIFT	1
>> +#define S2MPS15_RTC_WUDR_MASK	(1 << S2MPS15_RTC_WUDR_SHIFT)
>>   #define S2MPS_RTC_RUDR_SHIFT	0
>>   #define S2MPS_RTC_RUDR_MASK	(1 << S2MPS_RTC_RUDR_SHIFT)
>>   #define RTC_TCON_SHIFT		1
>>
>
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
