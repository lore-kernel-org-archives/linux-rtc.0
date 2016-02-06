Return-Path: <rtc-linux+bncBAABBOW5262QKGQEWDGEDMI@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id r2si2842826pfr.0.2016.02.06.05.01.45
        for <rtc-linux@googlegroups.com>;
        Sat, 06 Feb 2016 05:01:45 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH V3 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
To: Laxman Dewangan <ldewangan@nvidia.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com
References: <1454507233-9959-1-git-send-email-ldewangan@nvidia.com>
 <1454507233-9959-6-git-send-email-ldewangan@nvidia.com>
 <56B296F6.3060002@samsung.com> <56B2B17A.1000509@nvidia.com>
 <56B2F6A2.5060103@samsung.com> <56B314F4.6010605@samsung.com>
 <56B4B38C.3030805@nvidia.com> <56B58501.603@osg.samsung.com>
 <56B592C5.3040208@nvidia.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
Message-ID: <56B5EEB0.3040505@osg.samsung.com>
Date: Sat, 6 Feb 2016 10:01:36 -0300
MIME-Version: 1.0
In-Reply-To: <56B592C5.3040208@nvidia.com>
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

On 02/06/2016 03:29 AM, Laxman Dewangan wrote:
> Hi Javier,
> '
> On Saturday 06 February 2016 11:00 AM, Javier Martinez Canillas wrote:
>> Hello Laxman,
>>
>> Sorry for not doing this before but today was a busy one.
>>
>
> Thanks for testing.
>
>
>> On 02/05/2016 11:37 AM, Laxman Dewangan wrote:
>>> Hi Krzysztof, Javier,
>>>
>>
>>> 3. Extension of 2
>>> Do regmap_add_irq_chip(), call  regmap_irq_get_virq() for creating irq mapping but dont do any interrupt registration i.e. comment request_threaded_irq() and hence free_irq().
>>> Then do unbind/bind and then suspend.
>>>    To make sure that this happen when only we have client registered interrupt or with mapping also.
>>>
>>
>> This fails, so the problem seems to be with the mapping.
>>
>> So I tried another scenario:
>>
>> 4. Call regmap_del_irq_chip() just after regmap_irq_get_virq() and try to S2R
>>    without doing any unbind before.
>>
>>    To test if this is a general issue with regmap_del_irq_chip() after doing
>>    the IRQ mapping and not something specific to the remove callback.
>>
>> The machine failed to boot. So now at least we have narrowed down the issue.
>>
>> I've looked at both regmap_irq_get_virq() and regmap_del_irq_chip() but I
>> couldn't find any obvious cause for the issue we are seeing. But it's late
>> Friday so probably I should just stop here and take a fresh look on Monday.
>>
>
> So the issue is that when we create mapping, we can not delete the irq_chip.
>
> I saw one function from irq framework irq_dispose_mapping(unsigned int virq).
>
> So we need to dispose the mapping before deleting irq chip.
>
>
> Becasue it is reproduced in normal boot also if we do create mapping and delete the irq chip data, I will also be able to validate if I get some time on weekend.
>

Thanks, that was it! I was searching yesterday for the regmap_irq_get_virq()
counterpart and did not find it, but I was looking at include/linux/regmap.h
and didn't think about looking at include/linux/irqdomain.h.

Maybe we should add a regmap_irq_put_virq() that's just a wrapper around
irq_dispose_mapping() to make the API consistent and avoid this confusion?
I see that most drivers don't dispose the mapping on their error/remove path.

Anyways, with this patch on top of yours 5/5 my system is able to suspend
after an unbind again:

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 45d639674c0b..8ea6d601482a 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -765,6 +765,7 @@ static int max77686_rtc_remove(struct platform_device *pdev)
  	struct max77686_rtc_info *info = platform_get_drvdata(pdev);
  
  	free_irq(info->virq, info);
+	irq_dispose_mapping(info->virq);
  	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
  	if (info->rtc)
  		i2c_unregister_device(info->rtc);

This is a bug in the current MFD driver though so I would include it as
a separate patch prior to your patch that moves the regmap and i2c init
to the RTC driver.

When posting your new revsion feel free to add my {Reviewed,Tested}-by
tags for $SUBJECT and the new bugfix patch.

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
