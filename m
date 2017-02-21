Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBAWIWLCQKGQEMMO3DBY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v70si1209211wmf.0.2017.02.21.12.33.05
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Feb 2017 12:33:05 -0800 (PST)
Date: Tue, 21 Feb 2017 21:33:05 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Phil Reid <preid@electromag.com.au>
Cc: a.zummo@towertech.it, akinobu.mita@gmail.com,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: ds3232: Call device_init_wakeup
 before device_register
Message-ID: <20170221203305.mkcqv3g4wbbm5js6@piout.net>
References: <1487295898-90177-1-git-send-email-preid@electromag.com.au>
 <1487295898-90177-4-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1487295898-90177-4-git-send-email-preid@electromag.com.au>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 17/02/2017 at 09:44:58 +0800, Phil Reid wrote:
> The wakealarm attribute is currently not exposed in the sysfs interface
> as the device has not been set as doing wakealarm when device_register
> is called. Changing the order of the calls fixes that problem. Interrupts
> are cleared in check_rtc_status prior to requesting the interrupt.
> 

This basically revert b4b77f3c280e38cec178f81d7a4d7e65f4045913 So I'm
not sure this is sufficient to ensure the IRQ will never fire.

(I don't know whether this was a real bug or something reported by a
static analysis tool).

> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  drivers/rtc/rtc-ds3232.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
> index 60de3a0..ce943d0 100644
> --- a/drivers/rtc/rtc-ds3232.c
> +++ b/drivers/rtc/rtc-ds3232.c
> @@ -363,11 +363,6 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
>  	if (ret)
>  		return ret;
>  
> -	ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
> -						THIS_MODULE);
> -	if (IS_ERR(ds3232->rtc))
> -		return PTR_ERR(ds3232->rtc);
> -
>  	if (ds3232->irq > 0) {
>  		ret = devm_request_threaded_irq(dev, ds3232->irq, NULL,
>  						ds3232_irq,
> @@ -380,6 +375,11 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
>  			device_init_wakeup(dev, 1);
>  	}
>  
> +	ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
> +		THIS_MODULE);
> +	if (IS_ERR(ds3232->rtc))
> +		return PTR_ERR(ds3232->rtc);
> +
>  	return 0;
>  }
>  
> -- 
> 1.8.3.1
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
