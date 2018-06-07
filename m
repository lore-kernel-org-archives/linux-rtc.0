Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34254 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934706AbeFGOru (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 7 Jun 2018 10:47:50 -0400
Date: Thu, 7 Jun 2018 16:43:31 +0200 (CEST)
From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] rtc: ftrtc010: switch to devm_rtc_allocate_device
In-Reply-To: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
Message-ID: <alpine.LNX.2.00.1806071643190.3181@T420s>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, 4 Jun 2018, Alexandre Belloni wrote:

> Switch to devm_rtc_allocate_device/rtc_register_device. This allow or
> further improvement and simplifies ftrtc010_rtc_remove().
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-ftrtc010.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index af8d6beae20c..165d0b62db00 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -166,14 +166,18 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
>  	if (!rtc->rtc_base)
>  		return -ENOMEM;
>  
> +	rtc->rtc_dev = devm_rtc_allocate_device(dev);
> +	if (IS_ERR(rtc->rtc_dev))
> +		return PTR_ERR(rtc->rtc_dev);
> +
> +	rtc->rtc_dev->ops = &ftrtc010_rtc_ops;
> +
>  	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
>  			       IRQF_SHARED, pdev->name, dev);
>  	if (unlikely(ret))
>  		return ret;
>  
> -	rtc->rtc_dev = rtc_device_register(pdev->name, dev,
> -					   &ftrtc010_rtc_ops, THIS_MODULE);
> -	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
> +	return rtc_register_device(rtc->rtc_dev);
>  }
>  
>  static int ftrtc010_rtc_remove(struct platform_device *pdev)
> @@ -184,7 +188,6 @@ static int ftrtc010_rtc_remove(struct platform_device *pdev)
>  		clk_disable_unprepare(rtc->extclk);
>  	if (!IS_ERR(rtc->pclk))
>  		clk_disable_unprepare(rtc->pclk);
> -	rtc_device_unregister(rtc->rtc_dev);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
> 

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
