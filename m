Return-Path: <rtc-linux+bncBDS7HNEFSALRBCNN22ZAKGQE7KNU63Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id i77si98813wmf.1.2015.11.25.03.07.53
        for <rtc-linux@googlegroups.com>;
        Wed, 25 Nov 2015 03:07:53 -0800 (PST)
Date: Wed, 25 Nov 2015 12:07:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Vincent Donnefort <vdonnefort@gmail.com>,
	Yoann Sculo <yoann@printk.fr>
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: fix alarm reading at probe time
Message-ID: <20151125110753.GN3950@piout.net>
References: <1448395486-10514-1-git-send-email-simon.guinot@sequanux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448395486-10514-1-git-send-email-simon.guinot@sequanux.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 24/11/2015 at 21:04:46 +0100, Simon Guinot wrote :
> With the actual code, read_alarm() always returns -EINVAL when called
> during the RTC device registration. This prevents from retrieving an
> already configured alarm in hardware.
> 
> This patch fixes the issue by moving the HAS_ALARM bit configuration
> (if supported by the hardware) above the rtc_device_register() call.
> 

Sure, can you rebase on top of rtc-next and move the whole 'if
(want_irq)' block before devm_rtc_device_register()?

I think we also probably don't want to set
device_set_wakeup_capable(&client->dev, want_irq); when the IRQ request
fails.

> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>  drivers/rtc/rtc-ds1307.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 188006c55ce0..732d2afd6489 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -1139,6 +1139,8 @@ read_rtc:
>  	}
>  
>  	device_set_wakeup_capable(&client->dev, want_irq);
> +	if (want_irq)
> +		set_bit(HAS_ALARM, &ds1307->flags);
>  	ds1307->rtc = devm_rtc_device_register(&client->dev, client->name,
>  				rtc_ops, THIS_MODULE);
>  	if (IS_ERR(ds1307->rtc)) {
> @@ -1158,7 +1160,6 @@ read_rtc:
>  			goto no_irq;
>  		}
>  
> -		set_bit(HAS_ALARM, &ds1307->flags);
>  		dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
>  
>  		/* Currently supported by OF code only! */
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
