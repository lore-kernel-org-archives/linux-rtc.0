Return-Path: <rtc-linux+bncBD2OLRXW4ABBB47QX22AKGQETDNAXVY@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id dz2si5321745pab.1.2016.01.08.05.24.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2016 05:24:03 -0800 (PST)
Message-ID: <568FB613.4000706@nvidia.com>
Date: Fri, 8 Jan 2016 18:43:55 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	<rtc-linux@googlegroups.com>
CC: <k.kozlowski.k@gmail.com>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, <linus.walleij@linaro.org>, <gnurou@gmail.com>,
	<lee.jones@linaro.org>, <broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>, <lgirdwood@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <swarren@nvidia.com>, <treding@nvidia.com>,
	Chaitanya Bandi <bandik@nvidia.com>
Subject: Re: [rtc-linux] [PATCH 5/6] rtc: max77620: add support for
 max77620/max20024 RTC driver
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com> <1452177524-23192-6-git-send-email-ldewangan@nvidia.com> <CAJKOXPd938soaa5M0GFo5HpVCYzAS1w8j8Hko3Ja9mx47NYkEQ@mail.gmail.com> <568F8D7E.10500@nvidia.com> <568FB423.7030108@samsung.com>
In-Reply-To: <568FB423.7030108@samsung.com>
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


On Friday 08 January 2016 06:35 PM, Krzysztof Kozlowski wrote:
> W dniu 08.01.2016 o 19:20, Laxman Dewangan pisze:
>> Hi Krzysztof,
>> Thanks for review.
>>
>> Accepted most of review comment and will update in next patch.
>>
>> Answer to query:
>>
>>
>> On Friday 08 January 2016 07:33 AM, Krzysztof Kozlowski wrote:
>>
> Actually the MFD and other subsystems are quite decoupled already and
> support sharing drivers for common IP block. The problem is that we
> develop drivers in a coupled way. This is not only issue of this
> particular set of drivers. Others were developed in a same way.
>
> So instead I would be happy to see this driver developed in the
> decoupled way so existing RTC driver could be reused. If this requires
> changing existing MFD driver like max77686 then please go ahead. I may
> provide testing for that purpose. Something similar I made recently to
> the max77693 and max77843. Both devices have different parent MFD
> drivers but share some of the specific subsystem drivers: regulator and
> input/haptic.
I replied on other thread. I can decouple the RTC driver for max77620 
and will be available for review.
If it looks fine then we can modify the max6868 mfd driver to use this 
new driver for test purpose.


>>
>> For this, RTC alarm interrupt need to be EARLY_RESUME.
> Okay, this is quite common issue and I think this can be solved by
> disabling the IRQ in suspend:
> http://lxr.free-electrons.com/source/drivers/mfd/max77843.c#L205
>
> IMHO this would be preferred way because you won't be moving device
> suspend/resume callbacks to a syscore level.

I will try for disable_irq() in suspend and enable_irq() in resume.
I hope this will not affect the wakeup property from suspend.

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
