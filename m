Return-Path: <rtc-linux+bncBD2OLRXW4ABBBIWV3G3AKGQETKED4DA@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id y20si2932600pfa.2.2016.03.01.20.22.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 20:22:57 -0800 (PST)
Message-ID: <56D667AC.5030400@nvidia.com>
Date: Wed, 2 Mar 2016 09:40:20 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	<alexandre.belloni@free-electrons.com>, <a.zummo@towertech.it>
CC: <cw00.choi@samsung.com>, <rtc-linux@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <javier@osg.samsung.com>, <rklein@nvidia.com>
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: max77686: Add support for
 MAX20024/MAX77620 RTC IP
References: <1456750705-13579-1-git-send-email-ldewangan@nvidia.com> <56D63A9C.20506@samsung.com> <56D64CAC.5030704@nvidia.com> <56D6636F.6090403@samsung.com>
In-Reply-To: <56D6636F.6090403@samsung.com>
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


On Wednesday 02 March 2016 09:22 AM, Krzysztof Kozlowski wrote:
> On 02.03.2016 11:15, Laxman Dewangan wrote:
>
>>>> (kernel_ulong_t)&max77802_drv_data, },
>>>> +    { "max77620-rtc", .driver_data =
>>>> (kernel_ulong_t)&max77620_drv_data, },
>>>> +    { "max20024-rtc", .driver_data =
>>>> (kernel_ulong_t)&max77620_drv_data, },
>>> There shouldn't be "max20024-rtc". This is exactly the same as
>>> "max77620-rtc" so re-use existing id. No point of duplicating device
>>> names for 100% compatible devices.
>>>
>>>
>> I am thinking that having compatible for each device which it supports
>> is better.
>>
>> In MFD, I have made all sub module of max20024 as max20024-<module>.
>> I have not mixed the sub module name for max20024 with max77620 module.
> The point of compatible is to be... compatible so you don't create
> compatibles for the same meaning!
>
> However this is actually not a compatible but a matching name... which
> should follow the same idea. You did not give any argument why this is
> better.

My point is that if any driver supporting the any devices then it should 
be there in their compatibility although other everything is same.

This way, it is easy to find that the driver is available for the device 
or not. Also easy way to tell that someone has invested time to find out 
the driver corresponding to device and he confirmed that this driver is 
compatible with that device.
Otherwise, it is difficult to quickly find out the driver whether this 
is available/support or not for given device.

Datasheet never says that this device is same as some other device and 
hence this is the only place to tell for SW guys.



> For me, code like this:
> { "max77802-rtc", .driver_data = (kernel_ulong_t)&max77802_drv_data, },
> { "max77620-rtc", .driver_data = (kernel_ulong_t)&max77620_drv_data, },
> { "max77621-rtc", .driver_data = (kernel_ulong_t)&max77620_drv_data, },
> { "max77622-rtc", .driver_data = (kernel_ulong_t)&max77620_drv_data, },
> { "max77623-rtc", .driver_data = (kernel_ulong_t)&max77620_drv_data, },
> { "max776xx-some-other-rtc", .driver_data =
> (kernel_ulong_t)&max77620_drv_data, },
> { "max77624-rtc", .driver_data = (kernel_ulong_t)&max77620_drv_data, },
>
> is useless, ridiculous and obfuscated. It is duplication of code just
> "because". The child driver is selected by matching mfd-cell or
> compatible. We are reusing child drivers so reuse under the same name.
>
> Best regards,
> Krzysztof
>
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
