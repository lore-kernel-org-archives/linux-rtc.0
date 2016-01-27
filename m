Return-Path: <rtc-linux+bncBDKZNNNLXAHBBY6NUC2QKGQEC3UK45Y@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id r2si476568pfr.0.2016.01.26.18.09.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 18:09:39 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1L004OE9ZZSUA0@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 27 Jan 2016 02:09:35 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v3 08/10] rtc: Remove Maxim 77802 driver
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
 <1453836020-29579-9-git-send-email-javier@osg.samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A826DA.1080707@samsung.com>
Date: Wed, 27 Jan 2016 11:09:30 +0900
MIME-version: 1.0
In-reply-to: <1453836020-29579-9-git-send-email-javier@osg.samsung.com>
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

On 27.01.2016 04:20, Javier Martinez Canillas wrote:
> The max77686 RTC driver now supports the max77802 RTC as
> well so there's no need to have a separate driver anymore.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
> 
> ---
> 
> Changes in v3:
> - Add Laxman Dewangan's Acked-by tag to patch #8.
> 
> Changes in v2:
> - Add Krzysztof Kozlowski's Reviewed-by tag to patch #8.
> 
>  drivers/rtc/Kconfig        |  10 -
>  drivers/rtc/Makefile       |   1 -
>  drivers/rtc/rtc-max77802.c | 502 ---------------------------------------------
>  3 files changed, 513 deletions(-)
>  delete mode 100644 drivers/rtc/rtc-max77802.c
> 

FWIW, this also (surprise!) works on max77686:
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

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
