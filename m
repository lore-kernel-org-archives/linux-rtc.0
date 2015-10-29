Return-Path: <rtc-linux+bncBDKZNNNLXAHBBHUJZCYQKGQEGK2HLXA@googlegroups.com>
Received: from mail-qk0-x234.google.com (mail-qk0-x234.google.com. [2607:f8b0:400d:c09::234])
        by gmr-mx.google.com with ESMTPS id y206si61892ywd.6.2015.10.29.04.35.58
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2015 04:35:58 -0700 (PDT)
Received: by mail-qk0-x234.google.com with SMTP id l190so15540055qkb.2
        for <rtc-linux@googlegroups.com>; Thu, 29 Oct 2015 04:35:58 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <563200F2.4010202@samsung.com>
References: <1446094723-6212-1-git-send-email-alim.akhtar@samsung.com>
	<1446094723-6212-5-git-send-email-alim.akhtar@samsung.com>
	<5631B487.3050501@samsung.com>
	<5631CF0A.90109@samsung.com>
	<CAJKOXPeJcjoGMqPhdOg-sH7xojF0m3bbTh0OqBEHTuo9sQrNug@mail.gmail.com>
	<563200F2.4010202@samsung.com>
Date: Thu, 29 Oct 2015 20:35:58 +0900
Message-ID: <CAJKOXPeefkJHs=34z__K1ON4vk9iXAix8QWOMrWczO7ATzAaiA@mail.gmail.com>
Subject: Re: [rtc-linux] Re: [PATCH v4 4/4] drivers/rtc/rtc-s5m.c: add support
 for S2MPS15 RTC
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: rtc-linux@googlegroups.com
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, lee.jones@linaro.org, broonie@kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-10-29 20:20 GMT+09:00 Alim Akhtar <alim.akhtar@samsung.com>:
>>> I am testing this patch before sending them, what I have found is if you
>>> don't update WUDR the time does not changes in rtc.
>>> e.g.
>>> if you don't do above changes then you will see below:
>>> -----
>>> # date --set="Oct 29 14:10:40 2015" <update the a new date>
>>> Thu Oct 29 14:10:40 UTC 2015
>>> #
>>> # hwclock --systohc <copy system clock to hardware clock/rtc>
>>> # hwclock <read back hwclock>
>>> Thu Oct 29 12:52:32 2015  .922889 seconds
>>> ----
>>> which is not excepted.
>>>
>>> And with the above change I see:
>>>
>>> ----
>>>   # date --set="Oct 29 14:30:10 2015" <update the a new date>
>>> Thu Oct 29 14:30:10 UTC 2015
>>> # date
>>> Thu Oct 29 14:30:12 UTC 2015
>>> # hwclock --systohc <copy system clock to hardware clock/rtc>
>>> # hwclock <read back hwclock>
>>> Thu Oct 29 14:30:21 2015  .333006 seconds
>>> ----
>>>
>>> Which is as expected.
>>
>>
>> Okay, but I said that vendor is setting only WUDR which is bit 4. You
>
> bit:4 is AUDR (for alarm). not WUDR and bit: 1 is WDUR(for timer)

Damn, the mismatch in names is confusing. The vendor sets WUDR which
on S2MPS15 is bit 1.

You are setting bit 1 (okay) and bit 4. This is different which makes
me asking questions.

>>
>> are setting bit 1 and bit 4. Your reply - about the need of setting
>> WUDR (bit 4 I guess) - does not explain my concerns. Do you have to
>> set bit 1?
>>
> Yes, I think we need to set both for timer and alarm.
> I have send you a snapshot of the rtc_update register in UM via internal
> email. PTAL.

Okay, I will take a look when I get to the office tomorrow.

>
>>>
>>>>>          ret = regmap_write(info->regmap, info->regs->rtc_udr_update,
>>>>> data);
>>>>>          if (ret < 0) {
>>>>>                  dev_err(info->dev, "failed to write update reg(%d)\n",
>>>>> ret);
>>>>> @@ -252,6 +256,9 @@ static inline int s5m8767_rtc_set_alarm_reg(struct
>>>>> s5m_rtc_info *info)
>>>>>          case S5M8767X:
>>>>>                  data &= ~S5M_RTC_TIME_EN_MASK;
>>>>>                  break;
>>>>> +       case S2MPS15X:
>>>>> +               data |= S2MPS15_RTC_AUDR_MASK;
>>>>> +               break;
>>>>>          case S2MPS14X:
>>>>>                  data |= S2MPS_RTC_RUDR_MASK;
>>>>>                  break;
>>>>
>>>>
>>>>
>>>> Another difference: you are setting here exactly the same values as
>>>> S2MPS13 - bit 1 and bit 4. However vendor code sets only bit 4 (called
>>>> WUDR there)?
>>>>
>>> No they are not, AUDR on s2mps13 is bit:1 where as it is bit:4 on
>>> s2mps15.
>>>>
>>>>
>>>> What exactly is necessary to update alarm and time registers on S2MPS15?
>>>>
>>> As explained above in example, it is required to update the 'write alarm
>>> buffer(AUDR)' and 'write time buffer(WUDR)' bits in-order to get rtc
>>> working.
>>
>>
>> For updating time and alarm registers? Or only for updating alarm
>> registers?
>>
> example was only for the timer register.
>

Anyway setting alarm above is strange. You are setting bit 4 twice. One as:
  data |= info->regs->rtc_udr_mask;
and then:
  case S2MPS15X:
    data |= S2MPS15_RTC_AUDR_MASK;

Yeah, I know this is misleading. Could you document expected behavior
exactly somewhere in the code or in the commit message? "bit fields
are changed for WUDR and AUDR." seems not enough. Instead I would be
happy to see a statement: "to set time registers, AUDR and WUDR must
be set, to set alarm ....  etc. where AUDR and WUDR on S2MPS15 are
reversed"

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
