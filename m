Return-Path: <rtc-linux+bncBAABBDEK222QKGQEPY7SIKI@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id jg4si2534930pac.2.2016.02.05.21.30.51
        for <rtc-linux@googlegroups.com>;
        Fri, 05 Feb 2016 21:30:51 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH V3 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
To: Laxman Dewangan <ldewangan@nvidia.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com
References: <1454507233-9959-1-git-send-email-ldewangan@nvidia.com>
 <1454507233-9959-6-git-send-email-ldewangan@nvidia.com>
 <56B296F6.3060002@samsung.com> <56B2B17A.1000509@nvidia.com>
 <56B2F6A2.5060103@samsung.com> <56B314F4.6010605@samsung.com>
 <56B4B38C.3030805@nvidia.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
Message-ID: <56B58501.603@osg.samsung.com>
Date: Sat, 6 Feb 2016 02:30:41 -0300
MIME-Version: 1.0
In-Reply-To: <56B4B38C.3030805@nvidia.com>
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

Sorry for not doing this before but today was a busy one.

On 02/05/2016 11:37 AM, Laxman Dewangan wrote:
> Hi Krzysztof, Javier,
>
> On Thursday 04 February 2016 02:38 PM, Krzysztof Kozlowski wrote:
>> On 04.02.2016 15:58, Krzysztof Kozlowski wrote:
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
> I am trying to reproduce this in my system but I am ending up with different issue as it need to enable the suspend.

Ok, no worries. I can of course help testing on my system.

> can you please help on following experiment:
> 1. In probe/init, do
>     regmap_add_irq_chip()
>    regmap_del_irq_chip() and then
>    regmap_add_irq_chip() and
> then without unbind()/bind(), working or not?
>
>    This is to make sure that it is universal issue rather than calling from remove callback only.
>

This works, the system can S2R successfully.
  
> 2. Do regmap_add_irq_chip() but dont do any interrupt registration i.e. comment regmap_irq_get_virq() and request_threaded_irq() and hence free_irq().
> Then do unbind/bind and then suspend.
>    To make sure that this happen when only we have client registered interrupt.
>

This works as well.
  
> 3. Extension of 2
> Do regmap_add_irq_chip(), call  regmap_irq_get_virq() for creating irq mapping but dont do any interrupt registration i.e. comment request_threaded_irq() and hence free_irq().
> Then do unbind/bind and then suspend.
>    To make sure that this happen when only we have client registered interrupt or with mapping also.
>

This fails, so the problem seems to be with the mapping.

So I tried another scenario:

4. Call regmap_del_irq_chip() just after regmap_irq_get_virq() and try to S2R
    without doing any unbind before.

    To test if this is a general issue with regmap_del_irq_chip() after doing
    the IRQ mapping and not something specific to the remove callback.

The machine failed to boot. So now at least we have narrowed down the issue.

I've looked at both regmap_irq_get_virq() and regmap_del_irq_chip() but I
couldn't find any obvious cause for the issue we are seeing. But it's late
Friday so probably I should just stop here and take a fresh look on Monday.

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
