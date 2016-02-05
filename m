Return-Path: <rtc-linux+bncBDKZNNNLXAHBBV6UZ62QKGQEKFDA7MI@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id u66si1758560pfa.2.2016.02.04.16.18.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 16:18:30 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O2100MA9SUQGG30@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 05 Feb 2016 00:18:26 +0000 (GMT)
Subject: Re: [rtc-linux] Re: [PATCH v4 00/10] rtc: max77686: Extend driver and
 add max77802 support
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1453865806-4661-1-git-send-email-javier@osg.samsung.com>
 <20160131120525.GM20165@piout.net> <56ADF9D4.2050208@samsung.com>
 <20160204225655.GE4782@piout.net>
Cc: rtc-linux@googlegroups.com,
 Javier Martinez Canillas <javier@osg.samsung.com>, k.kozlowski.k@gmail.com,
 linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56B3EA4D.4010801@samsung.com>
Date: Fri, 05 Feb 2016 09:18:21 +0900
MIME-version: 1.0
In-reply-to: <20160204225655.GE4782@piout.net>
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

On 05.02.2016 07:56, Alexandre Belloni wrote:
> On 31/01/2016 at 21:11:00 +0900, Krzysztof Kozlowski wrote :
>> W dniu 31.01.2016 o 21:05, Alexandre Belloni pisze:
>>> Hi,
>>>
>>> On 27/01/2016 at 00:36:36 -0300, Javier Martinez Canillas wrote :
>>>> Hello,
>>>>
>>>> On a recent disussion [0] with Krzysztof Kozlowski and Laxman Dewangan,
>>>> we came to the conclusion that the max77686 and max77802 RTC are almost
>>>> the same with only a few differences so there shouldn't be two separate
>>>> drivers and is better to extend max77686 driver and delete rtc-max77802.
>>>>
>>>> By making the driver more generic, other RTC IP blocks from Maxim PMICs
>>>> could be supported as well like the max77620.
>>>>
>>>> This is a v4 of a series that do this, that address issues pointed out
>>>> in the latest version. The v1, v2 and v3 can be found at [1], [2], [3].
>>>>
>>>> I've tested this patch-set on an Exynos5800 Peach Pi Chromebook that has
>>>> a max77802 PMIC and the RTC was working correctly. Krzysztof Kozlowski
>>>> tested v3 on an max77686 but this version only has cosmetic changes so
>>>> it should not cause any functionality changes.
>>>>
>>>> [0]: http://www.spinics.net/lists/devicetree/msg110348.html
>>>> [1]: https://lwn.net/Articles/672568/
>>>> [2]: https://lkml.org/lkml/2016/1/25/767
>>>> [3]: https://lkml.org/lkml/2016/1/26/787
>>>>
>>>
>>> I've applied patches 1 to 8 and I'll discussed with Arnd and Olof about
>>> what I should do with the defconfig changes.
>>
>> To avoid conflicts they could go through samsung-soc tree. I could pick
>> them if you provide me a tag with rest of patchset (dependencies).
>>
>> Would that be okay for you?
>>
> 
> Let's do that, I've prepared a tag, rtc-max77686-4.6 with all the
> max77686 material collected until now.  If I need to rebase rtc-next,
> I'll rebase on top of that.

Thanks, I pulled the tag, applied patches #9 and #10 and pushed out to
the for-next.

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
