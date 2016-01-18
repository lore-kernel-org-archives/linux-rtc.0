Return-Path: <rtc-linux+bncBD2OLRXW4ABBBINN6O2AKGQEAKFU3GA@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id i25si2331197pfj.2.2016.01.18.04.12.17
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 04:12:17 -0800 (PST)
Message-ID: <569CD427.3090106@nvidia.com>
Date: Mon, 18 Jan 2016 17:31:43 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Javier Martinez Canillas
	<javier@dowhile0.org>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, "Mark
 Rutland" <mark.rutland@arm.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Linus
 Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Lee
 Jones <lee.jones@linaro.org>, "Mark Brown" <broonie@kernel.org>, Alessandro
 Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel
	<linux-kernel@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, Stephen Warren <swarren@nvidia.com>, Thierry
 Reding <treding@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V2 5/6] rtc: max77xxx: add RTC driver for
 Maxim MAX77xxx series RTC IP
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com> <1452590273-16421-6-git-send-email-ldewangan@nvidia.com> <569594F0.4020007@samsung.com> <5695CD73.5010709@nvidia.com> <5695D268.3060705@samsung.com> <5695D1AF.9000806@nvidia.com> <5696665A.5030508@nvidia.com> <5696F0C4.1060904@samsung.com> <5696F7F8.108@samsung.com> <56978BA1.9050409@nvidia.com> <CABxcv=kqQc1DNmMJ1PAQkB7d=w9V4-85kJXtOXRPpwpXn7to8A@mail.gmail.com> <569C699F.10407@samsung.com>
In-Reply-To: <569C699F.10407@samsung.com>
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


On Monday 18 January 2016 09:57 AM, Krzysztof Kozlowski wrote:
> On 15.01.2016 10:50, Javier Martinez Canillas wrote:
>> Hello,
>>
>> On Thu, Jan 14, 2016 at 8:50 AM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>>> On Thursday 14 January 2016 06:50 AM, Krzysztof Kozlowski wrote:
>>>> On 14.01.2016 09:50, Krzysztof Kozlowski wrote:
>> [snip]
>>
>>>>> The max77802 does exactly the same (BTW, these should be merged as
>>>>> well... I'll add this to the TODO list) so I think this is necessary.
>>>> How about merging max77802 to max77686 first? The only differences I
>>>> found are:
>>>> 1. It uses main MFD/PMIC regmap.
>>>>      This can be solved as part of decoupling code. The driver will get
>>>> MFD's regmap and set up its own (only on max77686). The max77802 will
>>>> only use parent's regmap.
>>>>
>>>> 2. It has different register address.
>>>>      We need a register-layout/configuration structure. The logic is the
>>>> same except few differences (e.g. presence of MAX77802_RTC_AE1).
>>>>
>>>> It may be easier to merge them now, before adding support for max77620?
>> Agreed.
>>
>> When I originally posted the max77802 support, I had separate MFD,
>> RTC, regulator and clock drivers and the feedback (IIRC) was that the
>> MFD and clock blocks were too similar to the max77686 so I extended
>> those drivers instead of adding new ones. But that the RTC and
>> regulator blocks were different so a separate driver was justified...
>> but it's true that are not that different and rtc-max77686 could be
>> extended and rtc-max77802 removed.
> Great!
>
>> In fact, the ChromiumOS vendor tree has a single RTC driver for both
>> max77686 and max77802:
>>
>> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/drivers/rtc/rtc-max77xxx.c
>>
>>>> I could handle this probably next week or in the following week
>>>> (assuming someone would test max77802 because I don't have the hardware).
>>>>
>> I could also work on this next week if you want. After all I feel
>> guilty for the code duplication :-)
> So feel free to take that job from me. :) I will happily do the testing
> and provide complains (I mean, comments).
>

Hi Javier,
If you can provide the patch for moving MAX77802 to MAX77686 then I can 
create the other change to move the regmap and i2c dummy client for rtc 
of max77686 to rtc driver from core on top of your change. This will  
completely decouple the rtc driver from core and so will be easy to use 
for other chip MAX77620.

Thanks,
Laxman

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
