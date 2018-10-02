Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:55868 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeJBP4i (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 2 Oct 2018 11:56:38 -0400
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: mv: let the core handle invalid alarms
References: <20181001220525.6735-1-alexandre.belloni@bootlin.com>
Date: Tue, 02 Oct 2018 11:14:09 +0200
In-Reply-To: <20181001220525.6735-1-alexandre.belloni@bootlin.com> (Alexandre
        Belloni's message of "Tue, 2 Oct 2018 00:05:25 +0200")
Message-ID: <87efd8ogm6.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Alexandre,
 
 On mar., oct. 02 2018, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Instead of lying to the core when the alarm is invalid, let it handle that
> by returning the error.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>  (on Armada 375 DB)

Gregory

> ---
>  drivers/rtc/rtc-mv.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
> index 4b198b3778d3..e7f14bd12fe3 100644
> --- a/drivers/rtc/rtc-mv.c
> +++ b/drivers/rtc/rtc-mv.c
> @@ -125,13 +125,9 @@ static int mv_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  	/* hw counts from year 2000, but tm_year is relative to 1900 */
>  	alm->time.tm_year = bcd2bin(year) + 100;
>  
> -	if (rtc_valid_tm(&alm->time) < 0) {
> -		dev_err(dev, "retrieved alarm date/time is not valid.\n");
> -		rtc_time_to_tm(0, &alm->time);
> -	}
> -
>  	alm->enabled = !!readl(ioaddr + RTC_ALARM_INTERRUPT_MASK_REG_OFFS);
> -	return 0;
> +
> +	return rtc_valid_tm(&alm->time);
>  }
>  
>  static int mv_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> -- 
> 2.19.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
