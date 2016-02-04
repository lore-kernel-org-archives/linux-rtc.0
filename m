Return-Path: <rtc-linux+bncBD2OLRXW4ABBBJP6ZK2QKGQEXF6THCY@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id tn7si1241601pac.1.2016.02.03.19.01.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 19:01:57 -0800 (PST)
Message-ID: <56B2BC7B.4070807@nvidia.com>
Date: Thu, 4 Feb 2016 08:20:35 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, <lee.jones@linaro.org>,
	<alexandre.belloni@free-electrons.com>, <javier@osg.samsung.com>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH V3 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
References: <1454507233-9959-1-git-send-email-ldewangan@nvidia.com> <1454507233-9959-6-git-send-email-ldewangan@nvidia.com> <56B296F6.3060002@samsung.com> <56B2B17A.1000509@nvidia.com>
In-Reply-To: <56B2B17A.1000509@nvidia.com>
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

On Thursday 04 February 2016 07:33 AM, Laxman Dewangan wrote:
>
> On Thursday 04 February 2016 05:40 AM, Krzysztof Kozlowski wrote:
>> On 03.02.2016 22:47, Laxman Dewangan wrote:
>>>
>>> Changes from V2:
>>> - Taken care of missed sequence for removing the resource.
>>> - Fix the crash when doing unbind by using requested_threaded_irq()
>>>    instead of demv_requested_threaded_irq().
>>>
>>>   drivers/mfd/max77686.c               |  85 +-------------------
>>>   drivers/rtc/rtc-max77686.c           | 148 
>>> ++++++++++++++++++++++++++++++-----
>>>   include/linux/mfd/max77686-private.h |   3 -
>>>   3 files changed, 130 insertions(+), 106 deletions(-)
>>>
>> Looks good and works properly (RTC, unbind/rebind, wakealarm again)
>> but... after applying this patch the device cannot suspend to RAM after
>> unbind/rebind.
>>
>> Reproduce path, after booting:
>> $ echo max77686-rtc > /sys/bus/platform/drivers/max77686-rtc/unbind
>> $ echo max77686-rtc > /sys/bus/platform/drivers/max77686-rtc/bind
>> $ rtcwake -d rtc2 -m mem -s 5 -v
>> (or instead of rtcwake: echo mem > /sys/power/state)
>

Can you please also try to test in your setup which have MAX77802?
On this, we do not create i2c client and do regmap_init_i2c. So may be 
it helps on narrow down the issue.

>
> My device does not support suspend and hence I can nto test this part 
> and need your help to debug it.
>
> Few question to narrow down:
> 1. Have you try to bind/unbind mfd driver to make sure that there is 
> no inherent issue in the framework driver?
>
> 2. Does suspend entry and wake alarm work if you dont do unbind and 
> just bind it and enter into suspend?
>
> 3. Can you try locally to not use devm_regmap_init_i2c() and just use 
> the regmap_init_i2c() and proper removal of this from error path and 
> remove callback?
>
>
>
> Three things we are doing new on this movement, i2c client creating, 
> regmap_init and adding irq chip.
> And probably some issue on this calls?
> Let's try with not using devm_ * for this calls?
>
>

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
