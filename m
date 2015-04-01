Return-Path: <rtc-linux+bncBDS7HNEFSALRBBV75WUAKGQEENW7PSY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f5si565951wix.1.2015.03.31.20.01.25
        for <rtc-linux@googlegroups.com>;
        Tue, 31 Mar 2015 20:01:25 -0700 (PDT)
Date: Wed, 1 Apr 2015 05:01:24 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: hctosys: use function name in the
 error log
Message-ID: <20150401030124.GO3849@piout.net>
References: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
 <1427576976-22353-3-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1427576976-22353-3-git-send-email-aaro.koskinen@iki.fi>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 28/03/2015 at 23:09:36 +0200, Aaro Koskinen wrote :
> Use function name in the error log instead of __FILE__.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/rtc/hctosys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/hctosys.c b/drivers/rtc/hctosys.c
> index 6c719f2..7748a61 100644
> --- a/drivers/rtc/hctosys.c
> +++ b/drivers/rtc/hctosys.c
> @@ -33,7 +33,7 @@ static int __init rtc_hctosys(void)
>  
>  	if (rtc == NULL) {
>  		pr_err("%s: unable to open rtc device (%s)\n",
> -			__FILE__, CONFIG_RTC_HCTOSYS_DEVICE);
> +			__func__, CONFIG_RTC_HCTOSYS_DEVICE);
>  		goto err_open;
>  	}
>  
> -- 
> 2.2.0
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
