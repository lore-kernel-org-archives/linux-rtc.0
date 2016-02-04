Return-Path: <rtc-linux+bncBDKZNNNLXAHBB7NJZS2QKGQEVBQWFJQ@googlegroups.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id jg4si1273505pac.2.2016.02.04.01.08.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 01:08:13 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O2000L46MPKZL10@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 04 Feb 2016 09:08:08 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V3 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, javier@osg.samsung.com
References: <1454507233-9959-1-git-send-email-ldewangan@nvidia.com>
 <1454507233-9959-6-git-send-email-ldewangan@nvidia.com>
 <56B296F6.3060002@samsung.com> <56B2B17A.1000509@nvidia.com>
 <56B2F6A2.5060103@samsung.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56B314F4.6010605@samsung.com>
Date: Thu, 04 Feb 2016 18:08:04 +0900
MIME-version: 1.0
In-reply-to: <56B2F6A2.5060103@samsung.com>
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

On 04.02.2016 15:58, Krzysztof Kozlowski wrote:
> On 04.02.2016 11:03, Laxman Dewangan wrote:
>>
>> On Thursday 04 February 2016 05:40 AM, Krzysztof Kozlowski wrote:
>>> On 03.02.2016 22:47, Laxman Dewangan wrote:
>>>>
>>>> Changes from V2:
>>>> - Taken care of missed sequence for removing the resource.
>>>> - Fix the crash when doing unbind by using requested_threaded_irq()
>>>>    instead of demv_requested_threaded_irq().
>>>>
>>>>   drivers/mfd/max77686.c               |  85 +-------------------
>>>>   drivers/rtc/rtc-max77686.c           | 148
>>>> ++++++++++++++++++++++++++++++-----
>>>>   include/linux/mfd/max77686-private.h |   3 -
>>>>   3 files changed, 130 insertions(+), 106 deletions(-)
>>>>
>>> Looks good and works properly (RTC, unbind/rebind, wakealarm again)
>>> but... after applying this patch the device cannot suspend to RAM after
>>> unbind/rebind.
>>>
>>> Reproduce path, after booting:
>>> $ echo max77686-rtc > /sys/bus/platform/drivers/max77686-rtc/unbind
>>> $ echo max77686-rtc > /sys/bus/platform/drivers/max77686-rtc/bind
>>> $ rtcwake -d rtc2 -m mem -s 5 -v
>>> (or instead of rtcwake: echo mem > /sys/power/state)
>>
>>
>> My device does not support suspend and hence I can nto test this part
>> and need your help to debug it.
>>
>> Few question to narrow down:
>> 1. Have you try to bind/unbind mfd driver to make sure that there is no
>> inherent issue in the framework driver?
> 
> That might be tricky... there are also regulator and clock drivers.  I
> would have to disable them... It might take me some time to prepare an
> environment for this.
> 
>>
>> 2. Does suspend entry and wake alarm work if you dont do unbind and just
>> bind it and enter into suspend?
> If by "just bind" you mean bind during system boot, then answer is yes.
> Without the unbind+bind, the system suspends correctly.
> 
> Without your patch, system suspends correctly always (no rebind, rebind
> etc.).
> 
> Actually I don't have to re-bind the RTC. Just:
> $ echo max77686-rtc > /sys/bus/platform/drivers/max77686-rtc/unbind
> $ echo mem > /sys/power/state
> triggers the issue.
> 
>>
>> 3. Can you try locally to not use devm_regmap_init_i2c() and just use
>> the regmap_init_i2c() and proper removal of this from error path and
>> remove callback?
> 
> I'll try to find some time for that. Maybe tomorrow.

regmap_init_i2c does not help. However helps commenting out the:
	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
from remove() callback.

BR,
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
