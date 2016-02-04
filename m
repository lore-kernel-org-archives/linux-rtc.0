Return-Path: <rtc-linux+bncBAABBHMCZ22QKGQEZGOCDCA@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id 12si1383805pfb.1.2016.02.04.08.49.33
        for <rtc-linux@googlegroups.com>;
        Thu, 04 Feb 2016 08:49:33 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH V3 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
To: Laxman Dewangan <ldewangan@nvidia.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com
References: <1454507233-9959-1-git-send-email-ldewangan@nvidia.com>
 <1454507233-9959-6-git-send-email-ldewangan@nvidia.com>
 <56B296F6.3060002@samsung.com> <56B2B17A.1000509@nvidia.com>
 <56B2BC7B.4070807@nvidia.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56B38116.2010302@osg.samsung.com>
Date: Thu, 4 Feb 2016 13:49:26 -0300
MIME-Version: 1.0
In-Reply-To: <56B2BC7B.4070807@nvidia.com>
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

On 02/03/2016 11:50 PM, Laxman Dewangan wrote:

[snip]

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
>
> Can you please also try to test in your setup which have MAX77802?
> On this, we do not create i2c client and do regmap_init_i2c. So may be it helps on narrow down the issue.
>

Sorry for the delay but I was busy with others tasks. I've tested it
on an Exynos5800 Peach Pi (which has a max77802) and I've the same
issue. The system doesn't suspend after the max77802-rc unbind.

As Krzysztof narrowed down, commenting the regmap_del_irq_chip() call
in the .remove callback makes it to not fail again.

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
