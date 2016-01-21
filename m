Return-Path: <rtc-linux+bncBAABBTPLQO2QKGQEXUHEMFY@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id jg4si184376pac.2.2016.01.21.07.14.21
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Jan 2016 07:14:21 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 7/8] ARM: exynos_defconfig: Remove MAX77802
 RTC Kconfig symbol
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
 <1453310088-29985-8-git-send-email-javier@osg.samsung.com>
 <56A03B3A.40709@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56A0F5C8.3050208@osg.samsung.com>
Date: Thu, 21 Jan 2016 12:14:16 -0300
MIME-Version: 1.0
In-Reply-To: <56A03B3A.40709@samsung.com>
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

Hello Krzysztof,

On 01/20/2016 10:58 PM, Krzysztof Kozlowski wrote:
> On 21.01.2016 02:14, Javier Martinez Canillas wrote:
>> The driver has been removed so the Kconfig symbol is not valid anymore.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>
>>   arch/arm/configs/exynos_defconfig | 1 -
>>   1 file changed, 1 deletion(-)
>
> The patch should go after merging rtc-max77802 into rtc-max77686 to
> preserve bisectability on defconfig.
>

That's correct, same for 8/8.
  
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Thanks.
  
> Best regards,
> Krzysztof
>

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
