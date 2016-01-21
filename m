Return-Path: <rtc-linux+bncBAABBYHAQO2QKGQEHTHS3WI@googlegroups.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id jg4si170114pac.2.2016.01.21.06.51.11
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Jan 2016 06:51:11 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 0/8] rtc: max77686: Extend driver and add
 max77802 support
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
 <20160121003047.GF3367@piout.net> <56A02791.9010409@samsung.com>
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 rtc-linux@googlegroups.com, Chanwoo Choi <cw00.choi@samsung.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <56A0F053.6070405@osg.samsung.com>
Date: Thu, 21 Jan 2016 11:50:59 -0300
MIME-Version: 1.0
In-Reply-To: <56A02791.9010409@samsung.com>
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

Hello,

On 01/20/2016 09:34 PM, Krzysztof Kozlowski wrote:
> On 21.01.2016 09:30, Alexandre Belloni wrote:
>>> I believe all patches should go through the RTC tree with proper acks or
>>> wait until the RTC patches land to pick the defconfig changes.
>>>
>>
>> I think Olof would prefer the last patches to go through arm-soc.
>
> That would be preferred but merging them before the 5/8 would cause a
> loss of functionality on these defconfigs making it non-bisectable

Exactly, that's why I suggested merging all through RTC with proper acks.

> approach. I think it would be good to preserve bisectability in that
> matter so either:
> 1. a tag from RTC on top of which these patches would be applied in arm-soc,

I didn't suggest that option because I thought it would be a lot of burden
for such a trivial change.

> 2. take them to RTC tree with our acks.
>

Or another option is to not pick the defconfig changes and I can repost
those again once the RTC changes land into mainline.

But of course if up to you to decide since I'm not a maintainer :)
  
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
