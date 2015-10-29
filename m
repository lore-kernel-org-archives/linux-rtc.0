Return-Path: <rtc-linux+bncBDKZNNNLXAHBBHP2Y6YQKGQEFDGKCNQ@googlegroups.com>
Received: from mail-qg0-x22c.google.com (mail-qg0-x22c.google.com. [2607:f8b0:400d:c04::22c])
        by gmr-mx.google.com with ESMTPS id q68si65795ywf.0.2015.10.29.04.03.57
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2015 04:03:57 -0700 (PDT)
Received: by mail-qg0-x22c.google.com with SMTP id o38so30738818qge.0
        for <rtc-linux@googlegroups.com>; Thu, 29 Oct 2015 04:03:57 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <5631CF0A.90109@samsung.com>
References: <1446094723-6212-1-git-send-email-alim.akhtar@samsung.com>
	<1446094723-6212-5-git-send-email-alim.akhtar@samsung.com>
	<5631B487.3050501@samsung.com>
	<5631CF0A.90109@samsung.com>
Date: Thu, 29 Oct 2015 20:03:57 +0900
Message-ID: <CAJKOXPeJcjoGMqPhdOg-sH7xojF0m3bbTh0OqBEHTuo9sQrNug@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v4 4/4] drivers/rtc/rtc-s5m.c: add support for
 S2MPS15 RTC
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, lee.jones@linaro.org, broonie@kernel.org,
	linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
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

2015-10-29 16:47 GMT+09:00 Alim Akhtar <alim.akhtar@samsung.com>:
> Hello Krzysztof,
>
>
> On 10/29/2015 11:24 AM, Krzysztof Kozlowski wrote:
>>
>> On 29.10.2015 13:58, Alim Akhtar wrote:
>>>
>>> RTC found in s2mps15 is almost same as one found on s2mps14/13
>>> with few differences in RTC_UPDATE register fields, like
>>> bit fields are changed for WUDR and AUDR.
>>> This patch add required changes to enable s2mps15 rtc timer.
>>>
>>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> ---
>>>   drivers/rtc/rtc-s5m.c           |   20 ++++++++++++++++++--
>>>   include/linux/mfd/samsung/rtc.h |    4 ++++
>>>   2 files changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
>>> index f2504b4eef34..0d106a99958f 100644
>>> --- a/drivers/rtc/rtc-s5m.c
>>> +++ b/drivers/rtc/rtc-s5m.c
>>> @@ -188,6 +188,7 @@ static inline int
>>> s5m_check_peding_alarm_interrupt(struct s5m_rtc_info *info,
>>>                 ret = regmap_read(info->regmap, S5M_RTC_STATUS, &val);
>>>                 val &= S5M_ALARM0_STATUS;
>>>                 break;
>>> +       case S2MPS15X:
>>>         case S2MPS14X:
>>>         case S2MPS13X:
>>>                 ret = regmap_read(info->s5m87xx->regmap_pmic,
>>> S2MPS14_REG_ST2,
>>> @@ -223,6 +224,9 @@ static inline int s5m8767_rtc_set_time_reg(struct
>>> s5m_rtc_info *info)
>>>         if (info->device_type == S5M8763X || info->device_type ==
>>> S5M8767X)
>>>                 data |= S5M_RTC_TIME_EN_MASK;
>>>
>>> +       if (info->device_type == S2MPS15X)
>>> +               data |= S2MPS15_RTC_WUDR_MASK;
>>> +
>>
>>
>>
>> You are setting here bit 1 and bit 4. However vendor code sets only bit
>> 4 (called WUDR there). That's confusing. Why the difference? Or maybe I
>> am looking at wrong vendor tree (SM-G920F)?
>>
> Sorry, I don't have access to vendor code that you are looking into, so
> won't be able to comment on that.

Everyone have the access. It is on opensource.samsung.com, as required by GPL.

>
> I am testing this patch before sending them, what I have found is if you
> don't update WUDR the time does not changes in rtc.
> e.g.
> if you don't do above changes then you will see below:
> -----
> # date --set="Oct 29 14:10:40 2015" <update the a new date>
> Thu Oct 29 14:10:40 UTC 2015
> #
> # hwclock --systohc <copy system clock to hardware clock/rtc>
> # hwclock <read back hwclock>
> Thu Oct 29 12:52:32 2015  .922889 seconds
> ----
> which is not excepted.
>
> And with the above change I see:
>
> ----
>  # date --set="Oct 29 14:30:10 2015" <update the a new date>
> Thu Oct 29 14:30:10 UTC 2015
> # date
> Thu Oct 29 14:30:12 UTC 2015
> # hwclock --systohc <copy system clock to hardware clock/rtc>
> # hwclock <read back hwclock>
> Thu Oct 29 14:30:21 2015  .333006 seconds
> ----
>
> Which is as expected.

Okay, but I said that vendor is setting only WUDR which is bit 4. You
are setting bit 1 and bit 4. Your reply - about the need of setting
WUDR (bit 4 I guess) - does not explain my concerns. Do you have to
set bit 1?

>
>>>         ret = regmap_write(info->regmap, info->regs->rtc_udr_update,
>>> data);
>>>         if (ret < 0) {
>>>                 dev_err(info->dev, "failed to write update reg(%d)\n",
>>> ret);
>>> @@ -252,6 +256,9 @@ static inline int s5m8767_rtc_set_alarm_reg(struct
>>> s5m_rtc_info *info)
>>>         case S5M8767X:
>>>                 data &= ~S5M_RTC_TIME_EN_MASK;
>>>                 break;
>>> +       case S2MPS15X:
>>> +               data |= S2MPS15_RTC_AUDR_MASK;
>>> +               break;
>>>         case S2MPS14X:
>>>                 data |= S2MPS_RTC_RUDR_MASK;
>>>                 break;
>>
>>
>> Another difference: you are setting here exactly the same values as
>> S2MPS13 - bit 1 and bit 4. However vendor code sets only bit 4 (called
>> WUDR there)?
>>
> No they are not, AUDR on s2mps13 is bit:1 where as it is bit:4 on s2mps15.
>>
>> What exactly is necessary to update alarm and time registers on S2MPS15?
>>
> As explained above in example, it is required to update the 'write alarm
> buffer(AUDR)' and 'write time buffer(WUDR)' bits in-order to get rtc
> working.

For updating time and alarm registers? Or only for updating alarm registers?

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
