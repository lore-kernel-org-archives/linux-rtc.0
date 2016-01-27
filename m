Return-Path: <rtc-linux+bncBDKZNNNLXAHBB7EMUG2QKGQEI7VWQLA@googlegroups.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id jg4si488873pac.2.2016.01.26.20.24.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 20:24:27 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1L00KCUG8NZA00@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 27 Jan 2016 04:24:23 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v4 07/10] rtc: max77686: Fix unsupported year message
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453865806-4661-1-git-send-email-javier@osg.samsung.com>
 <1453865806-4661-8-git-send-email-javier@osg.samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A84673.5040806@samsung.com>
Date: Wed, 27 Jan 2016 13:24:19 +0900
MIME-version: 1.0
In-reply-to: <1453865806-4661-8-git-send-email-javier@osg.samsung.com>
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

On 27.01.2016 12:36, Javier Martinez Canillas wrote:
> The max77686 RTC only supports a range of 99 years so instead of using
> year 1900 as the base, the year 2000 is used. This means that 1900 to
> 1999 are unsupported years.
> 
> The driver was printing a warning for those values but was returning a
> error so for consistency, print an error message instead and don't say
> that a year 2000 is assumed, since the year is not set.
> 
> Also, it is better to use dev_* log functions instead of pr_* to print
> information about the device in the kernel log in a standardized way.
> 
> This also allows to remove the local pr_fmt() defined macro.
> 
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
> Changes in v4:
> - Use dev_err() instead of dev_warn() and change message.
>   Suggested by Krzysztof Kozlowski and Andi Shyti.
> - Change subject line and commit message of patch #7.
> - Removed Laxman Dewangan's Acked-by tag since the patch changed.
> 
> Changes in v3:
> - Add Laxman Dewangan's Acked-by tag to patch #7.
> 
> Changes in v2: None
> 
>  drivers/rtc/rtc-max77686.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

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
