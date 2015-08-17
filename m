Return-Path: <rtc-linux+bncBDKZNNNLXAHBBZFUYWXAKGQE365WNMA@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id qa1si1358206pdb.1.2015.08.16.20.52.04
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 16 Aug 2015 20:52:04 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NT700BV4K2NM600@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 17 Aug 2015 04:51:59 +0100 (BST)
Message-id: <55D15A5A.4010203@samsung.com>
Date: Mon, 17 Aug 2015 12:51:54 +0900
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
MIME-version: 1.0
To: Joonyoung Shim <jy0922.shim@samsung.com>, rtc-linux@googlegroups.com
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com, sbkim73@samsung.com
Subject: Re: [rtc-linux] [PATCH] rtc: s5m: fix to update ctrl register
References: <1439455764-23526-1-git-send-email-jy0922.shim@samsung.com>
 <55CC6B28.5010707@samsung.com> <55D13D49.1040504@samsung.com>
 <55D14033.1000000@samsung.com> <55D146D3.3000500@samsung.com>
In-reply-to: <55D146D3.3000500@samsung.com>
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

On 17.08.2015 11:28, Joonyoung Shim wrote:
> On 08/17/2015 11:00 AM, Krzysztof Kozlowski wrote:
>> On 17.08.2015 10:47, Joonyoung Shim wrote:
>>> Hi,
>>>
>>> On 08/13/2015 07:02 PM, Krzysztof Kozlowski wrote:
>>>> W dniu 13.08.2015 o 17:49, Joonyoung Shim pisze:
>>>>> According to datasheet, the S2MPS13X and S2MPS14X should update write
>>>>> buffer via setting WUDR bit to high after ctrl register is updated.
>>>>
>>>> Hi,
>>>>
>>>> I cannot find this information in S2MPS14 datasheet. On which page is it?
>>>>
>>>
>>> I got below information from S2MPS14_Data Sheet_REV0.1 document.
>>>
>>> 5.2.2.3 RTC_UPDATE
>>> ...
>>>
>>> NOTE: 
>>> 1.  For write Time Registers (0x00, 0x04~0x0A) & Alarm 0&1 Registers 
>>> (0x0B~0x18), set WUDR bit to high.
>>
>> Right, I have too but it does not say anything about control register.
>> It mentions only time, alarm 0 and alarm 1 registers, not control.
>>
> 
> Address 0x00 is RTC_CTRL, so i don't know what you say.

Ah, I see now!
You're right, the datasheet mentions control register as time register.

In this case before reading the RUDR should be set high (for all
S2MPS1[134]).

BR,
Krzysztof

> 
>>>
>>>>
>>>>>
>>>>> If not, ALARM interrupt of rtc-s5m doesn't happen first time when i use
>>>>> tools/testing/selftests/timers/rtctest.c test program and hour format is
>>>>> used to 12 hour mode in Odroid-XU3 board.
>>>>
>>>> Two questions here:
>>>> 1. Earlier you mentioned S2MPS1[34], now Odroid XU3 which has S2MPS11.
>>>> Are you sure that this applies to all of them (S2MPS11, S2MPS13 and
>>>> S2MP14)? There are some minor differences between them so I would not be
>>>> surprised if only some of them required this action.
>>>>
>>>
>>> I'm not sure about that because i don't have S2MPS11 datasheet. I just
>>> got the information that S2MPS11 also use S2MPS14 rtc from sec-core mfd
>>> driver,
>>
>> Yeah, I added it. But these RTC modules are slightly different,
>> especially S2MPS14, so you cannot assume that they are the same after
>> looking at mainline code.
>>
> 
> OK, could you check this issue from different things?
> 
> Thanks.
> 
>>>
>>> static const struct mfd_cell s2mps11_devs[] = {                                                                       
>>>         {                                                                                                             
>>>                 .name = "s2mps11-pmic",                                                                               
>>>         }, {                                                                                                          
>>>                 .name = "s2mps14-rtc",                                                                                
>>>         }, {                                                                                                          
>>>                 .name = "s2mps11-clk",                                                                                
>>>                 .of_compatible = "samsung,s2mps11-clk",                                                               
>>>         }                                                                                                             
>>> };
>>>
>>>> 2. The driver operates in 24-hour omode. Actually it sets the 24-hour
>>>> mode just before your new regmap_update_bits() call. What do you mean by
>>>> 12-hour mode?
>>>>
>>>
>>> RTC_CTRL register value is 0 until write buffer is updated, so it is
>>> used to 12-hour mode.
>>
>> I mean what do you have in mind by saying:
>> "... and hour format is used to 12 hour mode in Odroid-XU3 board."
>> The hour format is set by driver to 24h mode.
>>
>>
>>>
>>>>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>>>>> Cc: <stable@vger.kernel.org>
>>>>
>>>> Thanks for putting a cc-stable tag. How far this should be ported? If
>>>> this is needed only for S2MPS11 then v4.1. If all of them then probably
>>>> for earlier version?
>>>>
>>>
>>> If find exact version, i think it will be a version after below commit
>>> was applied.
>>>
>>> The commit 0c5deb1ea92f("rtc: s5m: add support for S2MPS14 RTC")
>>>
>>> $ git name-rev 0c5deb1ea92f
>>> 0c5deb1ea92f tags/v3.16-rc1~53^2~1
>>
>> Hmmm... I am not against the patch (especially that it matches source
>> code of SM-G900H with S2MPS11) but I have doubts about affected
>> chipsets. My Odroid (probably because of bootloader), S2MPS13 and
>> S2MPS14 do not need it. This confuses me...
>>
>> Best regards,
>> Krzysztof
>>
>>>
>>> Thanks.
>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>>> ---
>>>>>  drivers/rtc/rtc-s5m.c | 12 ++++++++++++
>>>>>  1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
>>>>> index 8c70d78..03828bb 100644
>>>>> --- a/drivers/rtc/rtc-s5m.c
>>>>> +++ b/drivers/rtc/rtc-s5m.c
>>>>> @@ -635,6 +635,18 @@ static int s5m8767_rtc_init_reg(struct s5m_rtc_info *info)
>>>>>  	case S2MPS13X:
>>>>>  		data[0] = (0 << BCD_EN_SHIFT) | (1 << MODEL24_SHIFT);
>>>>>  		ret = regmap_write(info->regmap, info->regs->ctrl, data[0]);
>>>>> +		if (ret < 0)
>>>>> +			break;
>>>>> +
>>>>> +		ret = regmap_update_bits(info->regmap,
>>>>> +				info->regs->rtc_udr_update,
>>>>> +				info->regs->rtc_udr_mask,
>>>>> +				info->regs->rtc_udr_mask);
>>>>> +		if (ret < 0)
>>>>> +			break;
>>>>> +
>>>>> +		ret = s5m8767_wait_for_udr_update(info);
>>>>> +
>>>>>  		break;
>>>>>  
>>>>>  	default:
>>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
