Return-Path: <rtc-linux+bncBDKZNNNLXAHBBAGY3G3AKGQE2RAOZ7Q@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id yd9si4874353pab.1.2016.03.01.20.28.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 20:28:48 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O3E003YR9RVY180@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 02 Mar 2016 04:28:43 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: max77686: Add support for
 MAX20024/MAX77620 RTC IP
To: Laxman Dewangan <ldewangan@nvidia.com>,
 alexandre.belloni@free-electrons.com, a.zummo@towertech.it
References: <1456750705-13579-1-git-send-email-ldewangan@nvidia.com>
 <56D63A9C.20506@samsung.com> <56D64CAC.5030704@nvidia.com>
 <56D6636F.6090403@samsung.com> <56D667AC.5030400@nvidia.com>
Cc: cw00.choi@samsung.com, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, javier@osg.samsung.com, rklein@nvidia.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56D66BF6.60403@samsung.com>
Date: Wed, 02 Mar 2016 13:28:38 +0900
MIME-version: 1.0
In-reply-to: <56D667AC.5030400@nvidia.com>
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

On 02.03.2016 13:10, Laxman Dewangan wrote:
> 
> On Wednesday 02 March 2016 09:22 AM, Krzysztof Kozlowski wrote:
>> On 02.03.2016 11:15, Laxman Dewangan wrote:
>>
>>>>> (kernel_ulong_t)&max77802_drv_data, },
>>>>> +    { "max77620-rtc", .driver_data =
>>>>> (kernel_ulong_t)&max77620_drv_data, },
>>>>> +    { "max20024-rtc", .driver_data =
>>>>> (kernel_ulong_t)&max77620_drv_data, },
>>>> There shouldn't be "max20024-rtc". This is exactly the same as
>>>> "max77620-rtc" so re-use existing id. No point of duplicating device
>>>> names for 100% compatible devices.
>>>>
>>>>
>>> I am thinking that having compatible for each device which it supports
>>> is better.
>>>
>>> In MFD, I have made all sub module of max20024 as max20024-<module>.
>>> I have not mixed the sub module name for max20024 with max77620 module.
>> The point of compatible is to be... compatible so you don't create
>> compatibles for the same meaning!
>>
>> However this is actually not a compatible but a matching name... which
>> should follow the same idea. You did not give any argument why this is
>> better.
> 
> My point is that if any driver supporting the any devices then it should
> be there in their compatibility although other everything is same.

Nope. The driver can describe supported devices in comment, Kconfig,
module description, DT binding description but the compatible is one.
One compatible for all compatible devices.

> This way, it is easy to find that the driver is available for the device
> or not. Also easy way to tell that someone has invested time to find out
> the driver corresponding to device and he confirmed that this driver is
> compatible with that device.
> Otherwise, it is difficult to quickly find out the driver whether this
> is available/support or not for given device.

This is so specific, imaginated use case... Regular users don't write
DTS. This is strictly for developers and the engineer who develops
code/platforms using maxim devices has this problem? No way...

You want to create many artificial device ids for the same compatible
device just to make grepping easier for someone (I cannot even find out
for whom...)? Nooo, that is just wrong. These are the same
blocks/subdevices. They use the same driver. They should use the same
compatible or the same name of driver.

Best regards,
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
