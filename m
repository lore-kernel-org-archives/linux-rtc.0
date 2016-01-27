Return-Path: <rtc-linux+bncBDKZNNNLXAHBBCWGUC2QKGQEBSWRH5A@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id jg4si435426pac.2.2016.01.26.17.53.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 17:53:14 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1L006J398L2ZA0@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 27 Jan 2016 01:53:09 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v3 05/10] rtc: max77686: Add an indirection
 level to access RTC registers
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
 <1453836020-29579-6-git-send-email-javier@osg.samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56A82301.1000301@samsung.com>
Date: Wed, 27 Jan 2016 10:53:05 +0900
MIME-version: 1.0
In-reply-to: <1453836020-29579-6-git-send-email-javier@osg.samsung.com>
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
> The max77686 driver is generic enough that can be used for other
> Maxim RTC IP blocks but these might not have the same registers
> layout so instead of accessing the registers directly, add a map
> to translate offsets to the real registers addresses for each IP.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
> 
> ---
> 
> Changes in v3:
> - Add Laxman Dewangan's Acked-by tag to patch #5.
> 
> Changes in v2:
> - Rename rtc_reg to max77686_rtc_reg_offset. Suggested by Krzysztof Kozlowski.
> - Comment what's mapped by max77686_map. Suggested by Krzysztof Kozlowski.
> - Use max77686_map array indexes in init. Suggested by Krzysztof Kozlowski.
> - Remove REG_RTC_UPDATE1 since is not used by neither max77686 nor max77802.
> 
>  drivers/rtc/rtc-max77686.c | 90 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 80 insertions(+), 10 deletions(-)
> 

Thanks for changes, looks good now.

Tested on Trats2 (max77686):
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

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
