Return-Path: <rtc-linux+bncBD2OLRXW4ABBBG77Y62QKGQE7W2YZDA@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id ui7si847426pab.0.2016.02.03.05.24.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 05:24:42 -0800 (PST)
Message-ID: <56B1FCF3.2040307@nvidia.com>
Date: Wed, 3 Feb 2016 18:43:23 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, <lee.jones@linaro.org>,
	<alexandre.belloni@free-electrons.com>, <javier@osg.samsung.com>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH V2 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
References: <1454491848-26551-1-git-send-email-ldewangan@nvidia.com> <1454491848-26551-6-git-send-email-ldewangan@nvidia.com> <56B1DA31.7070109@samsung.com> <56B1E2F3.9010502@samsung.com>
In-Reply-To: <56B1E2F3.9010502@samsung.com>
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


On Wednesday 03 February 2016 04:52 PM, Krzysztof Kozlowski wrote:
> On 03.02.2016 19:45, Krzysztof Kozlowski wrote:
>> On 03.02.2016 18:30, Laxman Dewangan wrote:
>>>   
>>>   err_rtc:
>>> +	if (info->rtc)
>>> +		i2c_unregister_device(info->rtc);
>>> +	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
>>> +
>> You should clean up in reverse order of allocation, so first
>> regmap_del_irq_chip then i2c_unregister_device. This
>> is a common pattern of cleaning up. Sometimes such order
>> is even necessary because of dependencies between
>> components... which is not a case here but still the
>> natural way is reversing the allocation code.

I made the change in other place (remove callback) but not this place. 
It is just missed by me. my bad..
Will do in next patch.

>> [   88.296055] [<c00eaa6c>] (do_filp_open) from [<c00dc29c>] (do_sys_open+0x114/0x1c0)
>> [   88.303699] [<c00dc29c>] (do_sys_open) from [<c000f8c0>] (ret_fast_syscall+0x0/0x3c)
>> [   88.311419] Code: e7905003 e3550000 0a00001f e5943014 (e7950003)
>> [   88.317573] ---[ end trace 9502799e3ea05a80 ]---
> However removal of "remove" callback helps... which could be expected...
> maybe it is not an error of the driver itself?


OK, looked it and found that we are registering the chip_irq as normal 
and interrupt as devm_*.
So when we remove, we delete the regmap_irq_chip first and then free 
irq. That is creating issue.

It seems I can not use the devm_requested_irq_thread() and need to use 
requested_irq_thread()  for proper sequence of freeing it.

Otherwise we need to add the devm_regmap_add_irq_chip() first and then 
use it.

I am spinning the series to use the requested_thread_irq() only to avoid 
unbind issue.


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
