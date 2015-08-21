Return-Path: <rtc-linux+bncBDEZ72H55YIBBKOM3OXAKGQEDU4OQUY@googlegroups.com>
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id fk4si750371pbc.2.2015.08.21.01.49.44
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 01:49:45 -0700 (PDT)
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NTF01UFGCIUOS60@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 21 Aug 2015 17:49:42 +0900 (KST)
Message-id: <55D6E627.8060908@samsung.com>
Date: Fri, 21 Aug 2015 17:49:43 +0900
From: Joonyoung Shim <jy0922.shim@samsung.com>
MIME-version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, a.zummo@towertech.it,
 sbkim73@samsung.com
Subject: [rtc-linux] Re: [PATCH] rtc: s5m: fix to update ctrl register
References: <1439455764-23526-1-git-send-email-jy0922.shim@samsung.com>
 <20150820231551.GE3769@piout.net> <55D67487.3040503@samsung.com>
 <55D67838.6080902@samsung.com> <55D67D14.9060809@samsung.com>
 <55D6CC1C.9040402@samsung.com> <55D6D24C.3010109@samsung.com>
In-reply-to: <55D6D24C.3010109@samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 08/21/2015 04:25 PM, Krzysztof Kozlowski wrote:
> On 21.08.2015 15:58, Joonyoung Shim wrote:
>> On 08/21/2015 10:21 AM, Krzysztof Kozlowski wrote:
>>> On 21.08.2015 10:00, Joonyoung Shim wrote:
>>>> On 08/21/2015 09:44 AM, Krzysztof Kozlowski wrote:
>>>>> On 21.08.2015 08:15, Alexandre Belloni wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 13/08/2015 at 17:49:24 +0900, Joonyoung Shim wrote :
>>>>>>> According to datasheet, the S2MPS13X and S2MPS14X should update write
>>>>>>> buffer via setting WUDR bit to high after ctrl register is updated.
>>>>>>>
>>>>>>> If not, ALARM interrupt of rtc-s5m doesn't happen first time when i use
>>>>>>> tools/testing/selftests/timers/rtctest.c test program and hour format is
>>>>>>> used to 12 hour mode in Odroid-XU3 board.
>>>>>>>
>>>>>>
>>>>>> >From what I understood, I should expect a v2 of tihat patch also setting
>>>>>> RUDR, is that right? OR would you prefer that I apply that one and then
>>>>>> fix RUDR in a following patch?
>>>>>
>>>>> Right, I would expect that as well... or a comment if this is not needed.
>>>>>
>>>>
>>>> Hmm, the driver only writes control register now, so i don't feel the
>>>> need of patch setting RUDR for control register.
>>>
>>> Yes, you're right. There is only regmap_write() (not
>>> remap_update_bits()) so your patch is completely fine. Thanks for
>>> explanation.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>
>>
>> Thanks for review.
>>
>> I found one more issue, the RTC doesn't keep time on Odroid-XU3 board
>> when i turn on board after power off even if RTC battery is connected.
>>
>> A difference with RTC driver of hardkernel kernel is that it sets
>> not only WUDR bit but also RUDR bit to high at the same time after
>> RTC_CTRL register is written. It's same with condition of only writing
>> ALARM registers like below description.
> 
> It seems that setting RUDR to high is needed...  but it shouldn't. For
> example in SM-G900H with S2MPS11 it is set before reading RTC_CTRL
> register. Mainline driver does not perform read.
> 
> Maybe RUDR is not set high properly before some next time read and your
> code is a coincidence, a work-around?

As you know, the driver sets RUDR bit to high always before reads time.
I'm not sure whether any delay time needs to guarantee that RUDR bit is
set properly, but it fails keeping time.

I tried setting RUDR bit to high after or before setting WUDR bit to
high for writing of RTC_CTRL register but it also fails keeping time.
If achieve keeping time, i should set WUDR & RUDR bits to high at the
same time.

I'm referring also rtc-sec driver source of SM-N910U_SEA(Samsung Note4)
from SM-N910U_SEA_KK_Opensource.zip file[1]. It also does the same
operation setting WUDR & RUDR bits to high for writing of RTC_CTRL
register.

[1] http://opensource.samsung.com/reception/receptionSub.do?method=sub&sub=F&searchValue=N910U

> 
> Best regards,
> Krzysztof
> 
>>
>> from S2MPS14 datasheet:
>> "3.  For write only Alarm 0&1 Registers (0x0B~0x18), set WUDR & RUDR
>> bits to high."
>>
>> So i tried it and it works well with keeping time. I'm not sure RTC of
>> S2MPS13 type also has a similar issue because it differs a little bit.
>>
>> from S2MPS13 datasheet:
>> "3.  For write only Alarm 0&1 Registers (0x0B~0x18), set WUDR & A_UDR
>> bits to high."
>>
>> If S2MPS13 also has same issue, we can fix the problem via just below
>> patch.
>>
>> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
>> index 8c70d78..bb8e888 100644
>> --- a/drivers/rtc/rtc-s5m.c
>> +++ b/drivers/rtc/rtc-s5m.c
>> @@ -635,6 +635,10 @@ static int s5m8767_rtc_init_reg(struct s5m_rtc_info *info)
>>  	case S2MPS13X:
>>  		data[0] = (0 << BCD_EN_SHIFT) | (1 << MODEL24_SHIFT);
>>  		ret = regmap_write(info->regmap, info->regs->ctrl, data[0]);
>> +		if (ret < 0)
>> +			break;
>> +
>> +		ret = s5m8767_rtc_set_alarm_reg(info);
>>  		break;
>>  
>>  	default:
>>
>> But i can't find any reasonable reason about this fix from datasheet,
>>
>> Thanks.
>>
>>> Best regards,
>>> Krzysztof
>>>
>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>>
>>>>>>
>>>>>>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>>>>>>> Cc: <stable@vger.kernel.org>
>>>>>>
>>>>>> can you update the stable tag with the kernel version introducing the
>>>>>> issue?
>>>>
>>>> Sure, i think it should be v3.16.
>>>>
>>>>>>
>>>>>>> ---
>>>>>>>  drivers/rtc/rtc-s5m.c | 12 ++++++++++++
>>>>>>>  1 file changed, 12 insertions(+)
>>>>>>
>>>>>>> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
>>>>>>> index 8c70d78..03828bb 100644
>>>>>>> --- a/drivers/rtc/rtc-s5m.c
>>>>>>> +++ b/drivers/rtc/rtc-s5m.c
>>>>>>> @@ -635,6 +635,18 @@ static int s5m8767_rtc_init_reg(struct s5m_rtc_info *info)
>>>>>>>  	case S2MPS13X:
>>>>>>>  		data[0] = (0 << BCD_EN_SHIFT) | (1 << MODEL24_SHIFT);
>>>>>>>  		ret = regmap_write(info->regmap, info->regs->ctrl, data[0]);
>>>>>>> +		if (ret < 0)
>>>>>>> +			break;
>>>>>>> +
>>>>>>> +		ret = regmap_update_bits(info->regmap,
>>>>>>> +				info->regs->rtc_udr_update,
>>>>>>> +				info->regs->rtc_udr_mask,
>>>>>>> +				info->regs->rtc_udr_mask);
>>>>>>
>>>>>> Very small indentation issue here, it should be aligned with the open
>>>>>> parenthesis.
>>>>
>>>> OK, i will.
>>>>
>>>> Thanks.
>>>>
>>>
>>>
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
