Return-Path: <rtc-linux+bncBAABB75XRC2QKGQEAM4PMQY@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id ui7si642046pab.0.2016.01.22.04.09.35
        for <rtc-linux@googlegroups.com>;
        Fri, 22 Jan 2016 04:09:35 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH v2 10/10] ARM: multi_v7_defconfig: Remove
 MAX77802 RTC Kconfig symbol
To: Laxman Dewangan <ldewangan@nvidia.com>, linux-kernel@vger.kernel.org
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com>
 <1453407813-14646-11-git-send-email-javier@osg.samsung.com>
 <56A1FD25.7020008@nvidia.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56A21BF8.8000901@osg.samsung.com>
Date: Fri, 22 Jan 2016 09:09:28 -0300
MIME-Version: 1.0
In-Reply-To: <56A1FD25.7020008@nvidia.com>
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

On 01/22/2016 06:57 AM, Laxman Dewangan wrote:
>
> On Friday 22 January 2016 01:53 AM, Javier Martinez Canillas wrote:
>> The driver has been removed so the Kconfig symbol is not valid anymore.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>>
>> ---
>>
>> Changes in v2:
>> - Add Krzysztof Kozlowski's Reviewed-by tag to patch #10.
>>
>>   arch/arm/configs/multi_v7_defconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 314f6be2dca2..bdb42c09332c 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -664,7 +664,6 @@ CONFIG_RTC_DRV_MAX8907=y
>>   CONFIG_RTC_DRV_MAX8997=m
>>   CONFIG_RTC_DRV_MAX77686=y
>>   CONFIG_RTC_DRV_RK808=m
>> -CONFIG_RTC_DRV_MAX77802=m
>
> Do you need to make
>
> CONFIG_RTC_DRV_MAX77686=m
>

Yes we should, the RTC_DRV_MAX778686 Kconfig symbol was enabled in multi_v7
before the "build as much as possible as a module" policy was asked so got
enabled built-in. The RTC_DRV_MAX77802 was introduced later so it was asked
to be built as a module instead.

I think we could do that as a separate patch though, once this series land.

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
