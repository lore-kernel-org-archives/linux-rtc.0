Return-Path: <rtc-linux+bncBDKZNNNLXAHBB4PVQC2QKGQEGPCC73I@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id r2si3480936pfr.0.2016.01.20.17.57.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 17:57:04 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1A00IHP5F07D80@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 21 Jan 2016 01:57:00 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH 6/8] rtc: Remove Maxim 77802 driver
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
 <1453310088-29985-7-git-send-email-javier@osg.samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A03AEC.1090008@samsung.com>
Date: Thu, 21 Jan 2016 10:57:00 +0900
MIME-version: 1.0
In-reply-to: <1453310088-29985-7-git-send-email-javier@osg.samsung.com>
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
> The max77686 RTC driver now supports the max77802 RTC as
> well so there's no need to have a separate driver anymore.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/rtc/Kconfig        |  10 -
>  drivers/rtc/Makefile       |   1 -
>  drivers/rtc/rtc-max77802.c | 502 ---------------------------------------------
>  3 files changed, 513 deletions(-)
>  delete mode 100644 drivers/rtc/rtc-max77802.c
> 

Oh yes, I like removals so much! :)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

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
