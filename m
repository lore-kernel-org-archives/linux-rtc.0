Return-Path: <rtc-linux+bncBDKZNNNLXAHBBMGT6G2AKGQEA2A5QFI@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id 190si2262200pfb.1.2016.01.17.20.27.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 17 Jan 2016 20:27:28 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1400IKTSDNM130@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 18 Jan 2016 04:27:23 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V2 5/6] rtc: max77xxx: add RTC driver for
 Maxim MAX77xxx series RTC IP
To: Javier Martinez Canillas <javier@dowhile0.org>,
 Laxman Dewangan <ldewangan@nvidia.com>
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com>
 <1452590273-16421-6-git-send-email-ldewangan@nvidia.com>
 <569594F0.4020007@samsung.com> <5695CD73.5010709@nvidia.com>
 <5695D268.3060705@samsung.com> <5695D1AF.9000806@nvidia.com>
 <5696665A.5030508@nvidia.com> <5696F0C4.1060904@samsung.com>
 <5696F7F8.108@samsung.com> <56978BA1.9050409@nvidia.com>
 <CABxcv=kqQc1DNmMJ1PAQkB7d=w9V4-85kJXtOXRPpwpXn7to8A@mail.gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Courbot <gnurou@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux GPIO List <linux-gpio@vger.kernel.org>, rtc-linux@googlegroups.com,
 Stephen Warren <swarren@nvidia.com>, Thierry Reding <treding@nvidia.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <569C699F.10407@samsung.com>
Date: Mon, 18 Jan 2016 13:27:11 +0900
MIME-version: 1.0
In-reply-to: <CABxcv=kqQc1DNmMJ1PAQkB7d=w9V4-85kJXtOXRPpwpXn7to8A@mail.gmail.com>
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

On 15.01.2016 10:50, Javier Martinez Canillas wrote:
> Hello,
> 
> On Thu, Jan 14, 2016 at 8:50 AM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>> On Thursday 14 January 2016 06:50 AM, Krzysztof Kozlowski wrote:
>>> On 14.01.2016 09:50, Krzysztof Kozlowski wrote:
> 
> [snip]
> 
>>>>
>>>> The max77802 does exactly the same (BTW, these should be merged as
>>>> well... I'll add this to the TODO list) so I think this is necessary.
>>>
>>> How about merging max77802 to max77686 first? The only differences I
>>> found are:
>>> 1. It uses main MFD/PMIC regmap.
>>>     This can be solved as part of decoupling code. The driver will get
>>> MFD's regmap and set up its own (only on max77686). The max77802 will
>>> only use parent's regmap.
>>>
>>> 2. It has different register address.
>>>     We need a register-layout/configuration structure. The logic is the
>>> same except few differences (e.g. presence of MAX77802_RTC_AE1).
>>>
>>> It may be easier to merge them now, before adding support for max77620?
> 
> Agreed.
> 
> When I originally posted the max77802 support, I had separate MFD,
> RTC, regulator and clock drivers and the feedback (IIRC) was that the
> MFD and clock blocks were too similar to the max77686 so I extended
> those drivers instead of adding new ones. But that the RTC and
> regulator blocks were different so a separate driver was justified...
> but it's true that are not that different and rtc-max77686 could be
> extended and rtc-max77802 removed.

Great!

> 
> In fact, the ChromiumOS vendor tree has a single RTC driver for both
> max77686 and max77802:
> 
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/drivers/rtc/rtc-max77xxx.c
> 
>>> I could handle this probably next week or in the following week
>>> (assuming someone would test max77802 because I don't have the hardware).
>>>
> 
> I could also work on this next week if you want. After all I feel
> guilty for the code duplication :-)

So feel free to take that job from me. :) I will happily do the testing
and provide complains (I mean, comments).

> 
>>> Anyway I think we should develop these RTC patches having this in mind:
>>> merge all of them.
>>>
>>
>> I think we can do the merging of max77802 and max77686 at second step.
>>
>> At first, lets decouple the rtc-max77686.c with its mfd driver. This will
>> give better picture how will it be done.
> 
> I don't quite understand what you mean by decoupling here, the
> max77686 MFD driver today is not highly coupled to their cells devices
> drivers since it supports both max77802 and max77686 already. Yes,
> some changes will be needed but I think those should be small.

The decoupling needed is to move RTC-related stuff (i2c_new_dummy and
regmap) entirely to RTC driver. This work is independent of which driver
will be merged to rtc-max77xxx first.

> 
>> Once this is there then max77620 can use this and in parallel, can be work
>> for max77802 to use the same driver.
>>
>>
>> Let's first conclude and get accpepted for max77686 and max77620 as both of
>> us have related HW to verify the changes.
>>
> 
> I agree with Krzysztof that merging first before extending makes more
> sense but I don't have a strong opinion on this and can be done as a
> followup as well.

AFAIR, Javier have max77802 on Chromebook, right?

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
