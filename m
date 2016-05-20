Return-Path: <rtc-linux+bncBDS7HNEFSALRBZVD724QKGQEBDYDSJY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a124si16736wme.0.2016.05.20.15.38.30
        for <rtc-linux@googlegroups.com>;
        Fri, 20 May 2016 15:38:30 -0700 (PDT)
Date: Sat, 21 May 2016 00:38:29 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joshua Kinard <kumba@gentoo.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/1] rtc: ds1685: correct check of day of month
Message-ID: <20160520223829.GA4963@piout.net>
References: <1463598569-4329-1-git-send-email-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1463598569-4329-1-git-send-email-xypron.glpk@gmx.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 18/05/2016 at 21:09:29 +0200, Heinrich Schuchardt wrote :
> Operator ! has a higher priority than &&.
> (!(mday >= 1) && (mday <= 31)) is false for mday == 32.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/rtc/rtc-ds1685.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index b3ce3c6..b4fae3c 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -389,7 +389,7 @@ ds1685_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	ds1685_rtc_end_data_access(rtc);
>  
>  	/* Check month date. */
> -	if (!(mday >= 1) && (mday <= 31))
> +	if ((mday < 1) || (mday > 31))
>  		return -EDOM;
>  

This is a good catch but I think this also breaks the bcd_mode == 1
case because the test happens after the bin2bcd conversion. Can you
check/fix? 

>  	/*
> @@ -461,7 +461,7 @@ ds1685_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  				     RTC_MDAY_BCD_MASK);
>  
>  	/* Check the month date for validity. */
> -	if (!(mday >= 1) && (mday <= 31))
> +	if ((mday < 1) || (mday > 31))
>  		return -EDOM;
>  
>  	/*

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
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
