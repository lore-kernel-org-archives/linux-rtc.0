Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBQEXW27AKGQEH3ECXMQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id y7si805858wmd.0.2016.09.05.08.14.07
        for <rtc-linux@googlegroups.com>;
        Mon, 05 Sep 2016 08:14:07 -0700 (PDT)
Date: Mon, 5 Sep 2016 17:14:07 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Axel Lin <axel.lin@ingics.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Oleksij Rempel <linux@rempel-privat.de>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: asm9260: Fix missing spin_lock_init for priv->lock
Message-ID: <20160905151407.sojyribngqka6k4k@piout.net>
References: <1473087671-8866-1-git-send-email-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1473087671-8866-1-git-send-email-axel.lin@ingics.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

This is already solved by: http://patchwork.ozlabs.org/patch/664582/

On 05/09/2016 at 23:01:11 +0800, Axel Lin wrote :
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/rtc/rtc-asm9260.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
> index 5219916..72a036f 100644
> --- a/drivers/rtc/rtc-asm9260.c
> +++ b/drivers/rtc/rtc-asm9260.c
> @@ -269,6 +269,7 @@ static int asm9260_rtc_probe(struct platform_device *pdev)
>  
>  	priv->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, priv);
> +	spin_lock_init(&priv->lock);
>  
>  	irq_alarm = platform_get_irq(pdev, 0);
>  	if (irq_alarm < 0) {
> -- 
> 2.7.4
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
