Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBF54S7FQKGQET5RX66A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id r131si433439wmg.3.2017.07.12.01.30.15
        for <rtc-linux@googlegroups.com>;
        Wed, 12 Jul 2017 01:30:15 -0700 (PDT)
Date: Wed, 12 Jul 2017 10:30:15 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 08/22] rtc: ds1305: stop using rtc
 deprecated functions
Message-ID: <20170712083015.jbdh4e47agxuqt5d@piout.net>
References: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org>
 <1499846682-14093-9-git-send-email-benjamin.gaignard@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <1499846682-14093-9-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Well, again, please don't.

I'll be randomly taking this one as an example.

That RTC will fail in 2100, 6 years before rtc_tm_to_time begins to be
an issue.

Once again, your patch hides the fact that there is an issue. There is
no other way than reading the datasheet and actually think about what
your are doing instead of using sed/coccinelle/whatever.

On 12/07/2017 at 10:04:28 +0200, Benjamin Gaignard wrote:
> rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> rely on 32bits variables and that will make rtc break in y2038/2016.
> Stop using those two functions to safer 64bits ones.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> CC: Alessandro Zummo <a.zummo@towertech.it>
> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: rtc-linux@googlegroups.com
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/rtc/rtc-ds1305.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
> index 72b2293..b41168b 100644
> --- a/drivers/rtc/rtc-ds1305.c
> +++ b/drivers/rtc/rtc-ds1305.c
> @@ -324,23 +324,20 @@ static int ds1305_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  {
>  	struct ds1305	*ds1305 = dev_get_drvdata(dev);
>  	struct spi_device *spi = ds1305->spi;
> -	unsigned long	now, later;
> +	unsigned long long now, later;
>  	struct rtc_time	tm;
>  	int		status;
>  	u8		buf[1 + DS1305_ALM_LEN];
>  
>  	/* convert desired alarm to time_t */
> -	status = rtc_tm_to_time(&alm->time, &later);
> -	if (status < 0)
> -		return status;
> +	later = rtc_tm_to_time64(&alm->time);
>  
>  	/* Read current time as time_t */
>  	status = ds1305_get_time(dev, &tm);
>  	if (status < 0)
>  		return status;
> -	status = rtc_tm_to_time(&tm, &now);
> -	if (status < 0)
> -		return status;
> +
> +	now = rtc_tm_to_time64(&tm);
>  
>  	/* make sure alarm fires within the next 24 hours */
>  	if (later <= now)
> -- 
> 1.9.1
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
