Date: Mon, 22 Sep 2014 17:04:18 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] rtc: at91sam9: replace devm_ioremap by
 devm_ioremap_resource
Message-ID: <20140922150418.GA3026@piout.net>
References: <1411377058-26155-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411377058-26155-4-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411377058-26155-4-git-send-email-boris.brezillon@free-electrons.com>
List-ID: <rtc-linux.googlegroups.com>

On 22/09/2014 at 11:10:52 +0200, Boris Brezillon wrote :
> Replace devm_ioremap calls by devm_ioremap_resource which already check
> resource consistency (resource != NULL) and print an error in case of
> failure.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/rtc/rtc-at91sam9.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> index 74a9ca0..38a2693 100644
> --- a/drivers/rtc/rtc-at91sam9.c
> +++ b/drivers/rtc/rtc-at91sam9.c
> @@ -306,18 +306,11 @@ static const struct rtc_class_ops at91_rtc_ops = {
>   */
>  static int at91_rtc_probe(struct platform_device *pdev)
>  {
> -	struct resource	*r, *r_gpbr;
> +	struct resource	*r;
>  	struct sam9_rtc	*rtc;
>  	int		ret, irq;
>  	u32		mr;
>  
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	r_gpbr = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!r || !r_gpbr) {
> -		dev_err(&pdev->dev, "need 2 ressources\n");
> -		return -ENODEV;
> -	}
> -
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		dev_err(&pdev->dev, "failed to get interrupt resource\n");
> @@ -335,18 +328,16 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  		device_init_wakeup(&pdev->dev, 1);
>  
>  	platform_set_drvdata(pdev, rtc);
> -	rtc->rtt = devm_ioremap(&pdev->dev, r->start, resource_size(r));
> -	if (!rtc->rtt) {
> -		dev_err(&pdev->dev, "failed to map registers, aborting.\n");
> -		return -ENOMEM;
> -	}
>  
> -	rtc->gpbr = devm_ioremap(&pdev->dev, r_gpbr->start,
> -				resource_size(r_gpbr));
> -	if (!rtc->gpbr) {
> -		dev_err(&pdev->dev, "failed to map gpbr registers, aborting.\n");
> -		return -ENOMEM;
> -	}
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	rtc->rtt = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(rtc->rtt))
> +		return PTR_ERR(rtc->rtt);
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	rtc->gpbr = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(rtc->gpbr))
> +		return PTR_ERR(rtc->rtt);
>  
>  	mr = rtt_readl(rtc, MR);
>  
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
