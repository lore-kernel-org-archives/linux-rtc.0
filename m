Return-Path: <rtc-linux+bncBDKZNNNLXAHBBWOVQC2QKGQESNW3D3Q@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id r2si3463988pfr.0.2016.01.20.16.48.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 16:48:24 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1A008RW28KQK70@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 21 Jan 2016 00:48:20 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH 0/8] rtc: max77686: Extend driver and add
 max77802 support
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A02AD4.40107@samsung.com>
Date: Thu, 21 Jan 2016 09:48:20 +0900
MIME-version: 1.0
In-reply-to: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
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

On 21.01.2016 02:14, Javier Martinez Canillas wrote:
> Hello,
> 
> On a recent disussion [0] with Krzysztof Kozlowski and Laxman Dewangan,
> we came to the conclusion that the max77686 and max77802 RTC are almost
> the same with only a few differences so there shouldn't be two separate
> drivers and is better to extend max77686 driver and delete rtc-max77802.
> 
> By making the driver more generic, other RTC IP blocks from Maxim PMICs
> could be supported as well like the max77620.
> 
> Patches #1 is just a trivial cleanup.
> 
> Patch #2 allows to support RTCs that need a shorter delay when updating
> the RTC.
> 
> Patch #3 adds a driver data structure to avoid hard-coding parameters
> specific to a certain RTC such as the needed delay and RTC register mask.
> 
> Patch #4 changes the driver to use a mapping table instead of using the
> max77686 registers offsets directly to allow supporting RTC with other
> registers addresses and layout.
> 
> Patch #5 Adds support for max77802 to max77686 RTC driver and patch #6
> removes the old driver since is not needed anymore.
> 
> Finally patch #7 and patch #8 removes the Kconfig symbol from defconfigs.
> 
> I've tested this patch-set on an Exynos5800 Peach Pi Chromebook that has
> a max77802 PMIC and the RTC was working correctly but I don't have a
> machine with max77686 so I will really appreaciate if someone can test
> that no regressions were introduced.
> 

Thanks for the submission. I like the approach. I'll start reviewing the
code and testing it... or maybe I'll wait with testing for v2 because I
already sent some comments. :)

Anyway I will provide later tested-by on max77686.

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
