Return-Path: <rtc-linux+bncBDKZNNNLXAHBBF6PQC2QKGQEVO5GAQQ@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id tn7si531134pac.1.2016.01.20.16.34.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 16:34:31 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1A00KJB1LEVY70@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 21 Jan 2016 00:34:26 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH 0/8] rtc: max77686: Extend driver and add
 max77802 support
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
 <20160121003047.GF3367@piout.net>
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 rtc-linux@googlegroups.com, Chanwoo Choi <cw00.choi@samsung.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A02791.9010409@samsung.com>
Date: Thu, 21 Jan 2016 09:34:25 +0900
MIME-version: 1.0
In-reply-to: <20160121003047.GF3367@piout.net>
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

On 21.01.2016 09:30, Alexandre Belloni wrote:
>> I believe all patches should go through the RTC tree with proper acks or
>> wait until the RTC patches land to pick the defconfig changes.
>>
> 
> I think Olof would prefer the last patches to go through arm-soc.

That would be preferred but merging them before the 5/8 would cause a
loss of functionality on these defconfigs making it non-bisectable
approach. I think it would be good to preserve bisectability in that
matter so either:
1. a tag from RTC on top of which these patches would be applied in arm-soc,
2. take them to RTC tree with our acks.

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
