Return-Path: <rtc-linux+bncBDS7HNEFSALRB2URQ6XAKGQEELFD4EY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id cj6si221871wib.1.2015.08.05.01.27.22
        for <rtc-linux@googlegroups.com>;
        Wed, 05 Aug 2015 01:27:22 -0700 (PDT)
Date: Wed, 5 Aug 2015 10:27:21 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [rtc-linux] Re: [PATCH 08/11] rtc: m48t59: clean up m48t59_nvram_read()/m48t59_nvram_write()
Message-ID: <20150805082721.GB3486@piout.net>
References: <1437947316-5652-1-git-send-email-vz@mleia.com>
 <1437947316-5652-9-git-send-email-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1437947316-5652-9-git-send-email-vz@mleia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 27/07/2015 at 00:48:33 +0300, Vladimir Zapolskiy wrote :
> @@ -365,11 +366,10 @@ static ssize_t m48t59_nvram_write(struct file *filp, struct kobject *kobj,
>  	ssize_t cnt = 0;
>  	unsigned long flags;
>  
> -	for (; size > 0 && pos < pdata->offset; cnt++, size--) {
> -		spin_lock_irqsave(&m48t59->lock, flags);
> +	spin_lock_irqsave(&m48t59->lock, flags);
> +
> +	for (; cnt < size; cnt++)
>  		M48T59_WRITE(*buf++, cnt);
> -		spin_unlock_irqrestore(&m48t59->lock, flags);
> -	}
>  

Isn't a spin_unlock_irqrestore() missing?

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
