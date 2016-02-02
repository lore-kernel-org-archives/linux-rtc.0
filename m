Return-Path: <rtc-linux+bncBDKZNNNLXAHBB54FYW2QKGQEOEJBNNA@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id jg4si462945pac.2.2016.02.02.15.59.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 02 Feb 2016 15:59:50 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1Y003AA2NMJA80@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 02 Feb 2016 23:59:46 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH 2/4] rtc: max77686: use rtc regmap to access
 RTC registers
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, javier@osg.samsung.com
References: <1454419012-18050-1-git-send-email-ldewangan@nvidia.com>
 <1454419012-18050-3-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56B142F2.30206@samsung.com>
Date: Wed, 03 Feb 2016 08:59:46 +0900
MIME-version: 1.0
In-reply-to: <1454419012-18050-3-git-send-email-ldewangan@nvidia.com>
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

On 02.02.2016 22:16, Laxman Dewangan wrote:
> rtc_regmap should be used to access all RTC regsiters instead
> of parent regmap regardless of what chip or property have it.
> 
> This makes the register access uniform and extendible for other
> chips.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>  drivers/rtc/rtc-max77686.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)


Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Tested on Trats2/max77686:
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
