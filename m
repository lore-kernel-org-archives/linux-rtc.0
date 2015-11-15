Return-Path: <rtc-linux+bncBCH4V2OOTYHBBBWKUGZAKGQE424H34A@googlegroups.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com. [2a00:1450:400c:c09::242])
        by gmr-mx.google.com with ESMTPS id a128si422283wma.2.2015.11.15.02.57.10
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Nov 2015 02:57:10 -0800 (PST)
Received: by mail-wm0-x242.google.com with SMTP id u63so17785102wmu.0
        for <rtc-linux@googlegroups.com>; Sun, 15 Nov 2015 02:57:10 -0800 (PST)
From: Hans Ulli Kroll <ulli.kroll@gmail.com>
Date: Sun, 15 Nov 2015 11:57:08 +0100 (CET)
To: Nizam Haider <nizamhaider786@gmail.com>
cc: ulli.kroll@googlemail.com, a.zummo@towertech.it,
    alexandre.belloni@free-electrons.com, linux-arm-kernel@lists.infradead.org,
    rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
    Nizam Haider <nijamh@cdac.in>
Subject: [rtc-linux] Re: [PATCH] Rtc: rtc-gemini.c: Remove unnecessary platform_set_drvdata()
In-Reply-To: <1447446089-2346-1-git-send-email-nizamhaider786@gmail.com>
Message-ID: <alpine.LNX.2.00.1511151156060.15993@T520.local>
References: <1447446089-2346-1-git-send-email-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Sat, 14 Nov 2015, Nizam Haider wrote:

> The driver core clears the driver data to NULL after device_release
> or on probe failure
> 
> Signed-off-by: Nizam Haider <nijamh@cdac.in>
> ---
>  drivers/rtc/rtc-gemini.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
> index e841846..f46b6d4 100644
> --- a/drivers/rtc/rtc-gemini.c
> +++ b/drivers/rtc/rtc-gemini.c
> @@ -156,7 +156,6 @@ static int gemini_rtc_remove(struct platform_device *pdev)
>  	struct gemini_rtc *rtc = platform_get_drvdata(pdev);
>  
>  	rtc_device_unregister(rtc->rtc_dev);
> -	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
>  }
> -- 
> 1.8.1.4
> 
> 

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
