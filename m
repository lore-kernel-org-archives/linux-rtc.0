Return-Path: <ulli.kroll@googlemail.com>
Date: Thu, 27 Apr 2017 06:22:54 +0200 (CEST)
From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
To: Pan Bian <bianpan201602@163.com>
cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
    Alessandro Zummo <a.zummo@towertech.it>,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
    linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: Re: [PATCH 1/1] rtc: gemini: add return value validation
In-Reply-To: <1492951687-16777-1-git-send-email-bianpan201602@163.com>
Message-ID: <alpine.LNX.2.00.1704270620490.16259@T520>
References: <1492951687-16777-1-git-send-email-bianpan201602@163.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <rtc-linux.googlegroups.com>

HI Pan,

On Sun, 23 Apr 2017, Pan Bian wrote:

> From: Pan Bian <bianpan2016@163.com>
> 
> Function devm_ioremap() will return a NULL pointer if it fails to remap
> IO address, and its return value should be validated before it is used.
> However, in function gemini_rtc_probe(), its return value is not
> checked. This may result in bad memory access bugs on future access,
> e.g. calling the function gemini_rtc_read_time().
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/rtc/rtc-gemini.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
> index ccf0dba..5279390 100644
> --- a/drivers/rtc/rtc-gemini.c
> +++ b/drivers/rtc/rtc-gemini.c
> @@ -139,6 +139,8 @@ static int gemini_rtc_probe(struct platform_device *pdev)
>  
>  	rtc->rtc_base = devm_ioremap(dev, res->start,
>  				     resource_size(res));
> +	if (!rtc->rtc_base)
> +		return -ENOMEM;
>  
>  	ret = devm_request_irq(dev, rtc->rtc_irq, gemini_rtc_interrupt,
>  			       IRQF_SHARED, pdev->name, dev);
> -- 
> 1.9.1
> 
> 
> 

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
