Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, a.zummo@towertech.it, dan.carpenter@oracle.com, rtc-linux@googlegroups.com, kernel-janitors@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] rtc: at91rm9200: double locking bug in at91_rtc_interrupt()
Date: Wed, 18 Mar 2015 02:20:10 +0100
Message-ID: <3693407.VZtvM8ii87@vostro.rjw.lan>
In-Reply-To: <1426606690-18947-1-git-send-email-nicolas.ferre@atmel.com>
References: <20150315104837.GC20691@mwanda> <1426606690-18947-1-git-send-email-nicolas.ferre@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <rtc-linux.googlegroups.com>

On Tuesday, March 17, 2015 04:38:10 PM Nicolas Ferre wrote:
> From: Dan Carpenter <dan.carpenter@oracle.com>
> 
> There is a typo here so we deadlock.
> 
> Fixes: dd1f1f391dd7 ('rtc: at91rm9200: rework wakeup and interrupt handling')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reported-also-by: David Dueck <davidcdueck@googlemail.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Hi Andrew,
> 
> Can you please take care of this fix for 4.0?
> If you fee that I'd better take it myself please tell me.

The commit being fixed went in through my tree, so I'll take this one if that's
not a problem.

>  drivers/rtc/rtc-at91rm9200.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> index b4f7744f6751..b283a1a573b3 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -324,7 +324,7 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *dev_id)
>  
>  		ret = IRQ_HANDLED;
>  	}
> -	spin_lock(&suspended_lock);
> +	spin_unlock(&suspended_lock);
>  
>  	return ret;
>  }
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
