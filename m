Return-Path: <rtc-linux+bncBCKMZDW5VIHBB7H2V6VAKGQEK7FEQGY@googlegroups.com>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net. [208.91.199.152])
        by gmr-mx.google.com with ESMTPS id k7si383232igu.0.2015.05.07.17.04.11
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 May 2015 17:04:12 -0700 (PDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YqVly-001uxc-Eh
	for rtc-linux@googlegroups.com; Fri, 08 May 2015 00:04:10 +0000
Message-ID: <554BFD75.1070601@roeck-us.net>
Date: Thu, 07 May 2015 17:04:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
CC: kernel@stlinux.com, devicetree@vger.kernel.org,
 daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
 a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 05/12] watchdog: st_wdt: Update IP layout
 information to include Clocksource
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org> <1431005924-21777-6-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431005924-21777-6-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 05/07/2015 06:38 AM, Lee Jones wrote:
> Initial submission adding support for this IP only included Watchdog and
> the Real-Time Clock.  Now the third (and final) device is enabled this
> trivial patch is required to update the comment in the Watchdog driver
> to encompass Clocksource.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/st_lpc_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
> index f32be15..6785afd 100644
> --- a/drivers/watchdog/st_lpc_wdt.c
> +++ b/drivers/watchdog/st_lpc_wdt.c
> @@ -197,7 +197,7 @@ static int st_wdog_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>
> -	/* LPC can either run in RTC or WDT mode */
> +	/* LPC can either run as a Clocksource or in RTC or WDT mode */
>   	if (mode != ST_LPC_MODE_WDT)
>   		return -ENODEV;
>
>

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
