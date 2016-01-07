Return-Path: <rtc-linux+bncBDS7HNEFSALRBTN6XK2AKGQEYEXLAIY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v7si296581wmg.3.2016.01.07.09.24.28
        for <rtc-linux@googlegroups.com>;
        Thu, 07 Jan 2016 09:24:29 -0800 (PST)
Date: Thu, 7 Jan 2016 18:24:26 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH] rtc: fix rtc_time64_to_tm calculation
Message-ID: <20160107172426.GA3988@piout.net>
References: <1452168710-16317-1-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1452168710-16317-1-git-send-email-a.hajda@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/01/2016 at 13:11:50 +0100, Andrzej Hajda wrote :
> Type of local variable days has been changed recently to unsigned,
> but it can take negative values. As a result it works incorrectly for some
> arguments. The patch fixes it.
> 

Yeah, I was not planning to send that patch finally because it had more
issues than expected. What you did seems good, I'll have a closer look
when I'm back from vacations. My current internet access is too limited
to be able to pull/push anything with git.

> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2120705
> 
> Fixes: cab572b82c4b ('rtc: fix overflow and incorrect calculation in rtc_time64_to_tm')
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/rtc/rtc-lib.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
> index cf2b23c..6323d13 100644
> --- a/drivers/rtc/rtc-lib.c
> +++ b/drivers/rtc/rtc-lib.c
> @@ -54,7 +54,7 @@ void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
>  {
>  	unsigned int month, year;
>  	int secs;
> -	unsigned long days;
> +	unsigned long days, leaps;
>  
>  	/*
>  	 * time must be positive
> @@ -66,13 +66,16 @@ void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
>  	tm->tm_wday = (days + 4) % 7;
>  
>  	year = 1970 + days / 365;
> -	days -= (year - 1970) * 365
> -		+ LEAPS_THRU_END_OF(year - 1)
> -		- LEAPS_THRU_END_OF(1970 - 1);
> -	if (days < 0) {
> +	days -= (year - 1970) * 365;
> +	leaps = LEAPS_THRU_END_OF(year - 1) - LEAPS_THRU_END_OF(1970 - 1);
> +
> +	while (days < leaps) {
>  		year -= 1;
>  		days += 365 + is_leap_year(year);
>  	}
> +
> +	days -= leaps;
> +
>  	tm->tm_year = year - 1900;
>  	tm->tm_yday = days + 1;
>  
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
