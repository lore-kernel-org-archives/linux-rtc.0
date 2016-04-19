Return-Path: <rtc-linux+bncBDS7HNEFSALRBXPJ3K4AKGQEI46Y2LQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e78si115160wmc.3.2016.04.19.15.44.44
        for <rtc-linux@googlegroups.com>;
        Tue, 19 Apr 2016 15:44:44 -0700 (PDT)
Date: Wed, 20 Apr 2016 00:44:43 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Martin Kepplinger <martink@posteo.de>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc-pcf2123: use sign_extend32() for sign extension
Message-ID: <20160419224443.GI29844@piout.net>
References: <1460974664-7525-1-git-send-email-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1460974664-7525-1-git-send-email-martink@posteo.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Please always include a commit message else, I'm fine with the patch.

On 18/04/2016 at 12:17:44 +0200, Martin Kepplinger wrote :
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  drivers/rtc/rtc-pcf2123.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
> index f22e060..b4478cc 100644
> --- a/drivers/rtc/rtc-pcf2123.c
> +++ b/drivers/rtc/rtc-pcf2123.c
> @@ -96,7 +96,7 @@
>  #define CD_TMR_TE		BIT(3)	/* Countdown timer enable */
>  
>  /* PCF2123_REG_OFFSET BITS */
> -#define OFFSET_SIGN_BIT		BIT(6)	/* 2's complement sign bit */
> +#define OFFSET_SIGN_BIT		6	/* 2's complement sign bit */
>  #define OFFSET_COARSE		BIT(7)	/* Coarse mode offset */
>  #define OFFSET_STEP		(2170)	/* Offset step in parts per billion */
>  
> @@ -217,7 +217,7 @@ static int pcf2123_read_offset(struct device *dev, long *offset)
>  	if (reg & OFFSET_COARSE)
>  		reg <<= 1; /* multiply by 2 and sign extend */
>  	else
> -		reg |= (reg & OFFSET_SIGN_BIT) << 1; /* sign extend only */
> +		reg = sign_extend32(reg, OFFSET_SIGN_BIT);
>  
>  	*offset = ((long)reg) * OFFSET_STEP;
>  
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
