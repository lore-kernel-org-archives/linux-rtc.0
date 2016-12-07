Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBBO6UDBAKGQEE66I4YY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d199si1005863wmd.1.2016.12.07.07.47.17
        for <rtc-linux@googlegroups.com>;
        Wed, 07 Dec 2016 07:47:17 -0800 (PST)
Date: Wed, 7 Dec 2016 16:47:16 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
	Juergen Borleis <jbe@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Fabio Estevam <fabio.estevam@nxp.com>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: imxdi: use the security violation interrupt
Message-ID: <20161207154716.5pkdctgnjhnuqp53@piout.net>
References: <1479560614-19293-1-git-send-email-martin@kaiser.cx>
 <1479560614-19293-2-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1479560614-19293-2-git-send-email-martin@kaiser.cx>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 19/11/2016 at 14:03:34 +0100, Martin Kaiser wrote :
> The DryIce chipset has a dedicated security violation interrupt that is
> triggered for security violations (if configured to do so). According to
> the publicly available imx258 reference manual, irq 56 is used for this
> interrupt.
> 
> Install a handler for the security violation interrupt. Move the code
> for handling security violations from the "normal" interrupt handler
> into the security violation interrupt handler.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  .../devicetree/bindings/rtc/imxdi-rtc.txt          |    4 +-
>  arch/arm/boot/dts/imx25.dtsi                       |    2 +-

This change should be in a separate patch.

> @@ -783,6 +801,9 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
>  	imxdi->irq = platform_get_irq(pdev, 0);
>  	if (imxdi->irq < 0)
>  		return imxdi->irq;
> +	imxdi->sec_irq = platform_get_irq(pdev, 1);
> +	if (imxdi->sec_irq < 0)
> +		return imxdi->sec_irq;
>  
>  	init_waitqueue_head(&imxdi->write_wait);
>  
> @@ -815,6 +836,13 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> +	rc = devm_request_irq(&pdev->dev, imxdi->sec_irq, dryice_sec_irq,
> +			IRQF_SHARED, pdev->name, imxdi);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "security violation interrupt not available.\n");
> +		goto err;

If you make that error fatal, it means that the DT ABI changed. I would
simply issue the warning and continue anyway.

> +	}
> +
>  	platform_set_drvdata(pdev, imxdi);
>  	imxdi->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
>  				  &dryice_rtc_ops, THIS_MODULE);
> -- 
> 1.7.10.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
