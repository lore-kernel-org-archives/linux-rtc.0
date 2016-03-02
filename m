Return-Path: <rtc-linux+bncBDKZNNNLXAHBBMXW3C3AKGQE5BUQI7I@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id ui7si4801784pab.0.2016.03.01.17.00.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 17:00:33 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O3E00F8404TU260@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 02 Mar 2016 01:00:29 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: max77686: Use REGMAP_IRQ_REG for
 regmap-rtc-irqs initialisation
To: Laxman Dewangan <ldewangan@nvidia.com>,
 alexandre.belloni@free-electrons.com, a.zummo@towertech.it
References: <1456750705-13579-1-git-send-email-ldewangan@nvidia.com>
 <1456750705-13579-2-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, javier@osg.samsung.com, rklein@nvidia.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56D63B28.9030502@samsung.com>
Date: Wed, 02 Mar 2016 10:00:24 +0900
MIME-version: 1.0
In-reply-to: <1456750705-13579-2-git-send-email-ldewangan@nvidia.com>
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

On 29.02.2016 21:58, Laxman Dewangan wrote:
> use macro REGMAP_IRQ_REG from regmap.h to initialise the
> regmap irq table for max77686.

Why? Any benefits?

Best regards,
Krzysztof

> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/rtc/rtc-max77686.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index 39d529a..0cb422b 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -174,12 +174,12 @@ static const unsigned int max77686_map[REG_RTC_END] = {
>  
>  static const struct regmap_irq max77686_rtc_irqs[] = {
>  	/* RTC interrupts */
> -	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTC60S_MSK, },
> -	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTCA1_MSK, },
> -	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTCA2_MSK, },
> -	{ .reg_offset = 0, .mask = MAX77686_RTCINT_SMPL_MSK, },
> -	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTC1S_MSK, },
> -	{ .reg_offset = 0, .mask = MAX77686_RTCINT_WTSR_MSK, },
> +	REGMAP_IRQ_REG(0, 0, MAX77686_RTCINT_RTC60S_MSK),
> +	REGMAP_IRQ_REG(1, 0, MAX77686_RTCINT_RTCA1_MSK),
> +	REGMAP_IRQ_REG(2, 0, MAX77686_RTCINT_RTCA2_MSK),
> +	REGMAP_IRQ_REG(3, 0, MAX77686_RTCINT_SMPL_MSK),
> +	REGMAP_IRQ_REG(4, 0, MAX77686_RTCINT_RTC1S_MSK),
> +	REGMAP_IRQ_REG(5, 0, MAX77686_RTCINT_WTSR_MSK),
>  };
>  
>  static const struct regmap_irq_chip max77686_rtc_irq_chip = {
> 

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
