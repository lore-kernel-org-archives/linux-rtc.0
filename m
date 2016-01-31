Return-Path: <rtc-linux+bncBDKZNNNLXAHBBW7TW62QKGQEGQMTRZA@googlegroups.com>
Received: from mail-pf0-x22e.google.com (mail-pf0-x22e.google.com. [2607:f8b0:400e:c00::22e])
        by gmr-mx.google.com with ESMTPS id jg4si2895430pac.2.2016.01.31.04.11.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2016 04:11:07 -0800 (PST)
Received: by mail-pf0-x22e.google.com with SMTP id 65so67643813pfd.2
        for <rtc-linux@googlegroups.com>; Sun, 31 Jan 2016 04:11:07 -0800 (PST)
Sender: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: [PATCH v4 00/10] rtc: max77686: Extend driver and
 add max77802 support
To: rtc-linux@googlegroups.com,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1453865806-4661-1-git-send-email-javier@osg.samsung.com>
 <20160131120525.GM20165@piout.net>
Cc: k.kozlowski.k@gmail.com, linux-kernel@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi.shyti@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Laxman Dewangan
 <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-ID: <56ADF9D4.2050208@samsung.com>
Date: Sun, 31 Jan 2016 21:11:00 +0900
MIME-Version: 1.0
In-Reply-To: <20160131120525.GM20165@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

W dniu 31.01.2016 o 21:05, Alexandre Belloni pisze:
> Hi,
> 
> On 27/01/2016 at 00:36:36 -0300, Javier Martinez Canillas wrote :
>> Hello,
>>
>> On a recent disussion [0] with Krzysztof Kozlowski and Laxman Dewangan,
>> we came to the conclusion that the max77686 and max77802 RTC are almost
>> the same with only a few differences so there shouldn't be two separate
>> drivers and is better to extend max77686 driver and delete rtc-max77802.
>>
>> By making the driver more generic, other RTC IP blocks from Maxim PMICs
>> could be supported as well like the max77620.
>>
>> This is a v4 of a series that do this, that address issues pointed out
>> in the latest version. The v1, v2 and v3 can be found at [1], [2], [3].
>>
>> I've tested this patch-set on an Exynos5800 Peach Pi Chromebook that has
>> a max77802 PMIC and the RTC was working correctly. Krzysztof Kozlowski
>> tested v3 on an max77686 but this version only has cosmetic changes so
>> it should not cause any functionality changes.
>>
>> [0]: http://www.spinics.net/lists/devicetree/msg110348.html
>> [1]: https://lwn.net/Articles/672568/
>> [2]: https://lkml.org/lkml/2016/1/25/767
>> [3]: https://lkml.org/lkml/2016/1/26/787
>>
> 
> I've applied patches 1 to 8 and I'll discussed with Arnd and Olof about
> what I should do with the defconfig changes.

To avoid conflicts they could go through samsung-soc tree. I could pick
them if you provide me a tag with rest of patchset (dependencies).

Would that be okay for you?

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
