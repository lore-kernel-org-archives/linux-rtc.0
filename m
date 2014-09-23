Return-Path: <Nicolas.FERRE@atmel.com>
Message-ID: <54212C5E.3010301@atmel.com>
Date: Tue, 23 Sep 2014 10:16:30 +0200
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Boris BREZILLON <boris.brezillon@free-electrons.com>, "Jean-Christophe
 Plagniol-Villard" <plagnioj@jcrosoft.com>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>,
	Alessandro Zummo <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>,
	"Samuel Ortiz" <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>,
	Johan Hovold <jhovold@gmail.com>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, "Mark
 Rutland" <mark.rutland@arm.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/9] rtc: at91sam9: add DT support
References: <1411400563-570-1-git-send-email-boris.brezillon@free-electrons.com> <1411400563-570-5-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1411400563-570-5-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <rtc-linux.googlegroups.com>

On 22/09/2014 17:42, Boris BREZILLON :
> Add of_match_table to the existing driver so that rtt nodes defined in at91
> DTs can be attached to this driver.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/rtc/rtc-at91sam9.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> index 38a2693..d72c34d 100644
> --- a/drivers/rtc/rtc-at91sam9.c
> +++ b/drivers/rtc/rtc-at91sam9.c
> @@ -445,6 +445,14 @@ static int at91_rtc_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(at91_rtc_pm_ops, at91_rtc_suspend, at91_rtc_resume);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id at91_rtc_dt_ids[] = {
> +	{ .compatible = "atmel,at91sam9260-rtt" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, at91_rtc_dt_ids);
> +#endif
> +
>  static struct platform_driver at91_rtc_driver = {
>  	.probe		= at91_rtc_probe,
>  	.remove		= at91_rtc_remove,
> @@ -453,6 +461,7 @@ static struct platform_driver at91_rtc_driver = {
>  		.name	= "rtc-at91sam9",
>  		.owner	= THIS_MODULE,
>  		.pm	= &at91_rtc_pm_ops,
> +		.of_match_table = of_match_ptr(at91_rtc_dt_ids),
>  	},
>  };
>  
> 


-- 
Nicolas Ferre
