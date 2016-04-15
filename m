Return-Path: <rtc-linux+bncBDS7HNEFSALRBBFQYW4AKGQEXAGL5PQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k143si1400994wmg.1.2016.04.15.14.07.16
        for <rtc-linux@googlegroups.com>;
        Fri, 15 Apr 2016 14:07:16 -0700 (PDT)
Date: Fri, 15 Apr 2016 23:07:15 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: stmp3xxx: check for failure
Message-ID: <20160415210715.GF25196@piout.net>
References: <1460392435-23803-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1460392435-23803-1-git-send-email-sudipm.mukherjee@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 11/04/2016 at 22:03:55 +0530, Sudip Mukherjee wrote :
> stmp3xxx_wdt_register() can fail as platform_device_alloc() or
> platform_device_add() can fail. Lets check for the return value from
> both platform_device_alloc() and platform_device_add() and return the
> error value accordingly which is now propagated from probe.
> 

Well, this may have been intentional. The RTC doesn't need the watchdog
driver to be present to work correctly. However, I agree that failing
silently is not nice.

Did you have any particular issue? Maybe simply adding a dev_err() or
two would be fine.

> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/rtc/rtc-stmp3xxx.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
> index ca54d03..e02e827 100644
> --- a/drivers/rtc/rtc-stmp3xxx.c
> +++ b/drivers/rtc/rtc-stmp3xxx.c
> @@ -105,20 +105,22 @@ static struct stmp3xxx_wdt_pdata wdt_pdata = {
>  	.wdt_set_timeout = stmp3xxx_wdt_set_timeout,
>  };
>  
> -static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
> +static int stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
>  {
>  	struct platform_device *wdt_pdev =
>  		platform_device_alloc("stmp3xxx_rtc_wdt", rtc_pdev->id);
>  
> -	if (wdt_pdev) {
> -		wdt_pdev->dev.parent = &rtc_pdev->dev;
> -		wdt_pdev->dev.platform_data = &wdt_pdata;
> -		platform_device_add(wdt_pdev);
> -	}
> +	if (!wdt_pdev)
> +		return -ENOMEM;
> +
> +	wdt_pdev->dev.parent = &rtc_pdev->dev;
> +	wdt_pdev->dev.platform_data = &wdt_pdata;
> +	return platform_device_add(wdt_pdev);
>  }
>  #else
> -static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
> +static int stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
>  {
> +	return 0;
>  }
>  #endif /* CONFIG_STMP3XXX_RTC_WATCHDOG */
>  
> @@ -357,8 +359,7 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	stmp3xxx_wdt_register(pdev);
> -	return 0;
> +	return stmp3xxx_wdt_register(pdev);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 1.9.1
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
