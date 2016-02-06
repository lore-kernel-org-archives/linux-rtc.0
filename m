Return-Path: <rtc-linux+bncBD2OLRXW4ABBB5FK222QKGQEJH577TI@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id 12si2376303pfb.1.2016.02.05.22.40.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 22:40:52 -0800 (PST)
Message-ID: <56B592C5.3040208@nvidia.com>
Date: Sat, 6 Feb 2016 11:59:25 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Javier Martinez Canillas <javier@osg.samsung.com>, Krzysztof Kozlowski
	<k.kozlowski@samsung.com>, <lee.jones@linaro.org>,
	<alexandre.belloni@free-electrons.com>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH V3 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
References: <1454507233-9959-1-git-send-email-ldewangan@nvidia.com> <1454507233-9959-6-git-send-email-ldewangan@nvidia.com> <56B296F6.3060002@samsung.com> <56B2B17A.1000509@nvidia.com> <56B2F6A2.5060103@samsung.com> <56B314F4.6010605@samsung.com> <56B4B38C.3030805@nvidia.com> <56B58501.603@osg.samsung.com>
In-Reply-To: <56B58501.603@osg.samsung.com>
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

Hi Javier,
'
On Saturday 06 February 2016 11:00 AM, Javier Martinez Canillas wrote:
> Hello Laxman,
>
> Sorry for not doing this before but today was a busy one.
>

Thanks for testing.


> On 02/05/2016 11:37 AM, Laxman Dewangan wrote:
>> Hi Krzysztof, Javier,
>>
>
>> 3. Extension of 2
>> Do regmap_add_irq_chip(), call  regmap_irq_get_virq() for creating 
>> irq mapping but dont do any interrupt registration i.e. comment 
>> request_threaded_irq() and hence free_irq().
>> Then do unbind/bind and then suspend.
>>    To make sure that this happen when only we have client registered 
>> interrupt or with mapping also.
>>
>
> This fails, so the problem seems to be with the mapping.
>
> So I tried another scenario:
>
> 4. Call regmap_del_irq_chip() just after regmap_irq_get_virq() and try 
> to S2R
>    without doing any unbind before.
>
>    To test if this is a general issue with regmap_del_irq_chip() after 
> doing
>    the IRQ mapping and not something specific to the remove callback.
>
> The machine failed to boot. So now at least we have narrowed down the 
> issue.
>
> I've looked at both regmap_irq_get_virq() and regmap_del_irq_chip() but I
> couldn't find any obvious cause for the issue we are seeing. But it's 
> late
> Friday so probably I should just stop here and take a fresh look on 
> Monday.
>

So the issue is that when we create mapping, we can not delete the irq_chip.

I saw one function from irq framework irq_dispose_mapping(unsigned int 
virq).

So we need to dispose the mapping before deleting irq chip.


Becasue it is reproduced in normal boot also if we do create mapping and 
delete the irq chip data, I will also be able to validate if I get some 
time on weekend.

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
