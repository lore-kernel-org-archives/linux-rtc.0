Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36759 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdGEVN3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 5 Jul 2017 17:13:29 -0400
Date: Wed, 5 Jul 2017 23:13:27 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <mmayer@broadcom.com>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: brcmstb-waketimer: fix settime function
Message-ID: <20170705211327.guccztud22hcmfjy@piout.net>
References: <20170628200839.3114345-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170628200839.3114345-1-arnd@arndb.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 28/06/2017 at 22:07:34 +0200, Arnd Bergmann wrote:
> gcc warns about an unused variable in the new driver:
> 
> drivers/rtc/rtc-brcmstb-waketimer.c: In function 'brcmstb_waketmr_settime':
> drivers/rtc/rtc-brcmstb-waketimer.c:142:6: error: unused variable 'ret' [-Werror=unused-variable]
> 
> The same function also doesn't handle overflow correctly, this makes
> it return -EINVAL when passed a time that doesn't fit within the
> range of the register.
> 
> Fixes: 9f4ad359c801 ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-brcmstb-waketimer.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 

I've squashed it in the original commit, I hope this is fine for you.

> diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
> index 5dea6d0627d8..796ac792a381 100644
> --- a/drivers/rtc/rtc-brcmstb-waketimer.c
> +++ b/drivers/rtc/rtc-brcmstb-waketimer.c
> @@ -138,10 +138,12 @@ static int brcmstb_waketmr_settime(struct device *dev,
>  				   struct rtc_time *tm)
>  {
>  	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
> -	unsigned long sec;
> -	int ret;
> +	time64_t sec;
> +
> +	sec = rtc_tm_to_time64(tm);
>  
> -	rtc_tm_to_time(tm, &sec);
> +	if (sec > U32_MAX || sec < 0)
> +		return -EINVAL;
>  
>  	writel_relaxed(sec, timer->base + BRCMSTB_WKTMR_COUNTER);
>  
> @@ -152,14 +154,14 @@ static int brcmstb_waketmr_getalarm(struct device *dev,
>  				    struct rtc_wkalrm *alarm)
>  {
>  	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
> -	unsigned long sec;
> +	time64_t sec;
>  	u32 reg;
>  
>  	sec = readl_relaxed(timer->base + BRCMSTB_WKTMR_ALARM);
>  	if (sec != 0) {
>  		/* Alarm is enabled */
>  		alarm->enabled = 1;
> -		rtc_time_to_tm(sec, &alarm->time);
> +		rtc_time64_to_tm(sec, &alarm->time);
>  	}
>  
>  	reg = readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
> @@ -172,13 +174,16 @@ static int brcmstb_waketmr_setalarm(struct device *dev,
>  				     struct rtc_wkalrm *alarm)
>  {
>  	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
> -	unsigned long sec;
> +	time64_t sec;
>  
>  	if (alarm->enabled)
> -		rtc_tm_to_time(&alarm->time, &sec);
> +		sec = rtc_tm_to_time64(&alarm->time);
>  	else
>  		sec = 0;
>  
> +	if (sec > U32_MAX || sec < 0)
> +		return -EINVAL;
> +
>  	brcmstb_waketmr_set_alarm(timer, sec);
>  
>  	return 0;
> -- 
> 2.9.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
