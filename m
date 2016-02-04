Return-Path: <rtc-linux+bncBAABBZMXZ22QKGQEY7X6GPI@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id tn7si1554982pac.1.2016.02.04.09.35.33
        for <rtc-linux@googlegroups.com>;
        Thu, 04 Feb 2016 09:35:33 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH V3 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
To: Laxman Dewangan <ldewangan@nvidia.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com
References: <1454507233-9959-1-git-send-email-ldewangan@nvidia.com>
 <1454507233-9959-6-git-send-email-ldewangan@nvidia.com>
 <56B296F6.3060002@samsung.com> <56B2B17A.1000509@nvidia.com>
 <56B2F6A2.5060103@samsung.com> <56B314F4.6010605@samsung.com>
 <56B3242E.1060504@nvidia.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
Message-ID: <56B38BDC.8070706@osg.samsung.com>
Date: Thu, 4 Feb 2016 14:35:24 -0300
MIME-Version: 1.0
In-Reply-To: <56B3242E.1060504@nvidia.com>
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

Hello Laxman,

On 02/04/2016 07:13 AM, Laxman Dewangan wrote:
>
> On Thursday 04 February 2016 02:38 PM, Krzysztof Kozlowski wrote:
>> On 04.02.2016 15:58, Krzysztof Kozlowski wrote:
>>> On 04.02.2016 11:03, Laxman Dewangan wrote:
>>>> 3. Can you try locally to not use devm_regmap_init_i2c() and just use
>>>> the regmap_init_i2c() and proper removal of this from error path and
>>>> remove callback?
>>> I'll try to find some time for that. Maybe tomorrow.
>> regmap_init_i2c does not help. However helps commenting out the:
>>     regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
>> from remove() callback.
>>
>>
>
> Thanks for debugging.  I do not see anything on regmap_del_irq_chip() which can be suspected. Is this because of sharing interrupt between mfd and rtc driver?

I don't think so, as long as all the callers pass the IRQF_SHARED flag,
there shouldn't be issues if different drivers call request / free irq.

AFAIK the only thing to take into account is that all callers should
pass a non-NULL cookie (the void * parameter in request and free irq)
so the kernel has a way to differentiate at request / free time.

And this is the case for regmap irq since the regmap_irq_chip_data *
that is passed to regmap_{add,del}_irq_chip() is used as the cookie.

>
> What is your suggestion here?  Should we avoid this inside RTC driver (creating this in mfd) and pass this information to the rtc driver using customized platform driver?
>

That wouldn't be the right approach IMHO, that would just mask the real
issue by making the call to regmap_del_irq_chip() to never happen since
the MFD device is not usually unbound due regulators being too critical.

I think we should find the real cause why this is happening and fix it.

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
