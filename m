Return-Path: <rtc-linux+bncBDMNDFPOUYMRBJHR4PBAKGQELYUJ4LQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id p138si1585983wme.1.2016.12.20.01.23.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2016 01:23:48 -0800 (PST)
Message-ID: <1482225821.2293.43.camel@pengutronix.de>
Subject: [rtc-linux] Re: [PATCH v2] rtc: imxdi: use the security violation interrupt
From: Lucas Stach <l.stach@pengutronix.de>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Juergen
 Borleis <jbe@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Date: Tue, 20 Dec 2016 10:23:41 +0100
In-Reply-To: <1482187289-19272-1-git-send-email-martin@kaiser.cx>
References: <1479560614-19293-1-git-send-email-martin@kaiser.cx>
	 <1482187289-19272-1-git-send-email-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Am Montag, den 19.12.2016, 23:41 +0100 schrieb Martin Kaiser:
> The DryIce chipset has a dedicated security violation interrupt that is
> triggered for security violations (if configured to do so).  According
> to the publicly available imx258 reference manual, irq 56 is used for
> this interrupt.
> 
> Install a handler for the security violation interrupt if an irq for
> this is provided by platform data / device tree. Move the code for
> handling security violations from the "normal" interrupt handler into
> the security violation interrupt handler.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
>   - make sec_irq optional to avoid breaking the Device Tree ABI
>   - removed the Device Tree bindings, I'll prepare a separate patch for them

Please submit the binding as a separate patch in the same series.
Otherwise you are building de-facto DT bindings by changing the driver.

> 
>  drivers/rtc/rtc-imxdi.c |   68 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 50 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
> index 67b56b8..ec6077a0 100644
> --- a/drivers/rtc/rtc-imxdi.c
> +++ b/drivers/rtc/rtc-imxdi.c
> @@ -109,6 +109,7 @@
>   * @rtc: pointer to rtc struct
>   * @ioaddr: IO registers pointer
>   * @irq: dryice normal interrupt
> + * @sec_irq: dryice security violation interrupt

This isn't used outside the probe routine, so doesn't need to be saved
in the driver data.

>   * @clk: input reference clock
>   * @dsr: copy of the DSR register
>   * @irq_lock: interrupt enable register (DIER) lock
> @@ -121,6 +122,7 @@ struct imxdi_dev {
>  	struct rtc_device *rtc;
>  	void __iomem *ioaddr;
>  	int irq;
> +	int sec_irq;
>  	struct clk *clk;
>  	u32 dsr;
>  	spinlock_t irq_lock;
> @@ -688,24 +690,6 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
>  	dier = readl(imxdi->ioaddr + DIER);
>  	dsr = readl(imxdi->ioaddr + DSR);
>  
> -	/* handle the security violation event */
> -	if (dier & DIER_SVIE) {
> -		if (dsr & DSR_SVF) {
> -			/*
> -			 * Disable the interrupt when this kind of event has
> -			 * happened.
> -			 * There cannot be more than one event of this type,
> -			 * because it needs a complex state change
> -			 * including a main power cycle to get again out of
> -			 * this state.
> -			 */
> -			di_int_disable(imxdi, DIER_SVIE);
> -			/* report the violation */
> -			di_report_tamper_info(imxdi, dsr);
> -			rc = IRQ_HANDLED;
> -		}
> -	}
> -
>  	/* handle write complete and write error cases */
>  	if (dier & DIER_WCIE) {
>  		/*If the write wait queue is empty then there is no pending
> @@ -743,6 +727,40 @@ static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
>  }
>  
>  /*
> + * dryice security violation interrupt handler
> + */
> +static irqreturn_t dryice_sec_irq(int irq, void *dev_id)
> +{
> +	struct imxdi_dev *imxdi = dev_id;
> +	u32 dsr, dier;
> +	irqreturn_t rc = IRQ_NONE;
> +
> +	dier = readl(imxdi->ioaddr + DIER);
> +	dsr = readl(imxdi->ioaddr + DSR);
> +
> +	/* handle the security violation event */
> +	if (dier & DIER_SVIE) {
> +		if (dsr & DSR_SVF) {
> +			/*
> +			 * Disable the interrupt when this kind of event has
> +			 * happened.
> +			 * There cannot be more than one event of this type,
> +			 * because it needs a complex state change
> +			 * including a main power cycle to get again out of
> +			 * this state.
> +			 */
> +			di_int_disable(imxdi, DIER_SVIE);
> +			/* report the violation */
> +			di_report_tamper_info(imxdi, dsr);
> +			rc = IRQ_HANDLED;
> +		}
> +	}
> +
> +	return rc;
> +}

This separate handler isn't needed. It is reading the same IRQ status
register, so you can just leave the code as is and request the sec-irq
with the same "dryice_norm_irq" handler.

> +
> +
> +/*
>   * post the alarm event from user context so it can sleep
>   * on the write completion.
>   */
> @@ -783,6 +801,13 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
>  	imxdi->irq = platform_get_irq(pdev, 0);
>  	if (imxdi->irq < 0)
>  		return imxdi->irq;

Insert blank line for better legibility.

> +	/* the 2nd irq is the security violation irq
> +	   make this optional, don't break the device tree ABI */
> +	rc = platform_get_irq(pdev, 1);
> +	if (rc > 0)
> +		imxdi->sec_irq = rc;
> +	else
> +		imxdi->sec_irq = IRQ_NOTCONNECTED;
>  
>  	init_waitqueue_head(&imxdi->write_wait);
>  
> @@ -815,6 +840,13 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> +	rc = devm_request_irq(&pdev->dev, imxdi->sec_irq, dryice_sec_irq,
> +			IRQF_SHARED, pdev->name, imxdi);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "security violation interrupt not available.\n");
> +		/* this is not an error, see above */
> +	}
> +
Please just fold this into the "if (rc > 0)" path above.

>  	platform_set_drvdata(pdev, imxdi);
>  	imxdi->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
>  				  &dryice_rtc_ops, THIS_MODULE);

Regards,
Lucas

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
