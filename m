Return-Path: <rtc-linux+bncBDS7HNEFSALRBK7FQOZQKGQE5LRM4TQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id g21si68931wmd.3.2015.12.03.17.55.55
        for <rtc-linux@googlegroups.com>;
        Thu, 03 Dec 2015 17:55:55 -0800 (PST)
Date: Fri, 4 Dec 2015 02:55:54 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sasha Levin <sasha.levin@oracle.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: fix overflow and incorrect calculation
 in rtc_time64_to_tm
Message-ID: <20151204015554.GB3515@piout.net>
References: <1449187944-11730-1-git-send-email-sasha.levin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1449187944-11730-1-git-send-email-sasha.levin@oracle.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 03/12/2015 at 19:12:24 -0500, Sasha Levin wrote :
> At some point after humans go extinct and robots cotrol the world, dividing
> he time64_t by 86400 to extract the days will overflow a 32bit integer,
> leading to incorrect conversion into rtc_time in rtc_time64_to_tm().
> 

And at that time, the robots won't care about 32bit platforms :)

> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
> ---
>  drivers/rtc/rtc-lib.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
> index e6bfb9c..459cd4d 100644
> --- a/drivers/rtc/rtc-lib.c
> +++ b/drivers/rtc/rtc-lib.c
> @@ -54,11 +54,11 @@ void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
>  {
>  	unsigned int month, year;
>  	unsigned long secs;
> -	int days;
> +	time64_t days;
>  
>  	/* time must be positive */
>  	days = div_s64(time, 86400);
> -	secs = time - (unsigned int) days * 86400;
> +	secs = time - days * 86400;
>  
>  	/* day of the week, 1970-01-01 was a Thursday */
>  	tm->tm_wday = (days + 4) % 7;
> -- 
> 1.7.10.4
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
