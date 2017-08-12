Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48186 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdHLVZI (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 12 Aug 2017 17:25:08 -0400
Date: Sat, 12 Aug 2017 23:25:05 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: at91rm9200: fix error return code in
 at91_rtc_probe()
Message-ID: <20170812212505.cd3gi52pmidyluzo@piout.net>
References: <20170809155244.GA25987@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170809155244.GA25987@embeddedgus>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 09/08/2017 at 10:52:44 -0500, Gustavo A. R. Silva wrote:
> platform_get_irq() returns an error code, but the at91rm9200 driver
> ignores it and always returns -ENXIO. This is not correct and,
> prevents -EPROBE_DEFER from being propagated properly.
> 
> Print and propagate the return value of platform_get_irq on failure.
> 
> This issue was detected with the help of Coccinelle.
> 

This will never happen and is not an actual issue. I will not take such
a patch until you
1/ prove there is an issue
2/ test your patch on real hardware

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/rtc/rtc-at91rm9200.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> index e221b78..09bc2e0 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -398,8 +398,8 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq resource defined\n");
> -		return -ENXIO;
> +		dev_err(&pdev->dev, "no irq resource defined: %d\n", irq);
> +		return irq;
>  	}
>  
>  	at91_rtc_regs = devm_ioremap(&pdev->dev, regs->start,
> -- 
> 2.5.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
