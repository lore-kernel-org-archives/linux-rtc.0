Return-Path: <rtc-linux+bncBAABBZFLRC2QKGQEJT3OHUI@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id r2si625868pfr.0.2016.01.22.03.43.32
        for <rtc-linux@googlegroups.com>;
        Fri, 22 Jan 2016 03:43:32 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH v2 02/10] rtc: max77686: Use ARRAY_SIZE()
 instead of current array length
To: Laxman Dewangan <ldewangan@nvidia.com>, linux-kernel@vger.kernel.org
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com>
 <1453407813-14646-3-git-send-email-javier@osg.samsung.com>
 <56A1F8BB.9090803@nvidia.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56A215DD.5030904@osg.samsung.com>
Date: Fri, 22 Jan 2016 08:43:25 -0300
MIME-Version: 1.0
In-Reply-To: <56A1F8BB.9090803@nvidia.com>
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

Thanks a lot for your feedback and acks.

On 01/22/2016 06:39 AM, Laxman Dewangan wrote:
>
> On Friday 22 January 2016 01:53 AM, Javier Martinez Canillas wrote:
>> It is better to use the ARRAY_SIZE() macro instead of the array length
>> to avoid bugs if the array is later changed and the length not updated.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>>
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
>
>
> Similar stuffs are there on multiple places:
> u8 data[RTC_NR_TIME];
>
> :::
> ret = regmap_bulk_read(info->max77686->rtc_regmap,
>                                   MAX77686_ALARM1_SEC, data, RTC_NR_TIME);
>
>
> Should we say:
> ret = regmap_bulk_read(info->max77686->rtc_regmap,
>                                   MAX77686_ALARM1_SEC, data, ARRAY_SIZE(data));
>

Very good point, I'll change those on this patch as well for v3.

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
