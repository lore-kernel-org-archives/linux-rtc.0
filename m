Return-Path: <rtc-linux+bncBDS7HNEFSALRB2HK32ZQKGQE4NJ27JY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 192si373618wmk.1.2015.12.21.00.16.40
        for <rtc-linux@googlegroups.com>;
        Mon, 21 Dec 2015 00:16:40 -0800 (PST)
Date: Mon, 21 Dec 2015 09:16:39 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Julius Werner <jwerner@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Doug Anderson <dianders@chromium.org>,
	Sonny Rao <sonnyrao@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCHv3] RTC: RK808: Compensate for Rockchip
 calendar deviation on November 31st
Message-ID: <20151221081639.GF3541@piout.net>
References: <CAODwPW_5WaLpqUeuJ0QhW=itgVq7iN_H3QH9_WzrVfsK+L-Rbg@mail.gmail.com>
 <1450220569-10670-1-git-send-email-jwerner@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1450220569-10670-1-git-send-email-jwerner@chromium.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 15/12/2015 at 15:02:49 -0800, Julius Werner wrote :
> In A.D. 1582 Pope Gregory XIII found that the existing Julian calendar
> insufficiently represented reality, and changed the rules about
> calculating leap years to account for this. Similarly, in A.D. 2013
> Rockchip hardware engineers found that the new Gregorian calendar still
> contained flaws, and that the month of November should be counted up to
> 31 days instead. Unfortunately it takes a long time for calendar changes
> to gain widespread adoption, and just like more than 300 years went by
> before the last Protestant nation implemented Greg's proposal, we will
> have to wait a while until all religions and operating system kernels
> acknowledge the inherent advantages of the Rockchip system. Until then
> we need to translate dates read from (and written to) Rockchip hardware
> back to the Gregorian format.
> 
> This patch works by defining Jan 1st, 2016 as the arbitrary anchor date
> on which Rockchip and Gregorian calendars are in sync. From that we can
> translate arbitrary later dates back and forth by counting the number
> of November/December transitons since the anchor date to determine the
> offset between the calendars. We choose this method (rather than trying
> to regularly "correct" the date stored in hardware) since it's the only
> way to ensure perfect time-keeping even if the system may be shut down
> for an unknown number of years. The drawback is that other software
> reading the same hardware (e.g. mainboard firmware) must use the same
> translation convention (including the same anchor date) to be able to
> read and write correct timestamps from/to the RTC.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>

I forgot to inform you but I've applied it and it landed in 4.4-rc6.


> ---
>  drivers/rtc/rtc-rk808.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
> index 91ca0bc..35c9aad 100644
> --- a/drivers/rtc/rtc-rk808.c
> +++ b/drivers/rtc/rtc-rk808.c
> @@ -56,6 +56,42 @@ struct rk808_rtc {
>  	int irq;
>  };
>  
> +/*
> + * The Rockchip calendar used by the RK808 counts November with 31 days. We use
> + * these translation functions to convert its dates to/from the Gregorian
> + * calendar used by the rest of the world. We arbitrarily define Jan 1st, 2016
> + * as the day when both calendars were in sync, and treat all other dates
> + * relative to that.
> + * NOTE: Other system software (e.g. firmware) that reads the same hardware must
> + * implement this exact same conversion algorithm, with the same anchor date.
> + */
> +static time64_t nov2dec_transitions(struct rtc_time *tm)
> +{
> +	return (tm->tm_year + 1900) - 2016 + (tm->tm_mon + 1 > 11 ? 1 : 0);
> +}
> +
> +static void rockchip_to_gregorian(struct rtc_time *tm)
> +{
> +	/* If it's Nov 31st, rtc_tm_to_time64() will count that like Dec 1st */
> +	time64_t time = rtc_tm_to_time64(tm);
> +	rtc_time64_to_tm(time + nov2dec_transitions(tm) * 86400, tm);
> +}
> +
> +static void gregorian_to_rockchip(struct rtc_time *tm)
> +{
> +	time64_t extra_days = nov2dec_transitions(tm);
> +	time64_t time = rtc_tm_to_time64(tm);
> +	rtc_time64_to_tm(time - extra_days * 86400, tm);
> +
> +	/* Compensate if we went back over Nov 31st (will work up to 2381) */
> +	if (nov2dec_transitions(tm) < extra_days) {
> +		if (tm->tm_mon + 1 == 11)
> +			tm->tm_mday++;	/* This may result in 31! */
> +		else
> +			rtc_time64_to_tm(time - (extra_days - 1) * 86400, tm);
> +	}
> +}
> +
>  /* Read current time and date in RTC */
>  static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
>  {
> @@ -101,9 +137,10 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
>  	tm->tm_mon = (bcd2bin(rtc_data[4] & MONTHS_REG_MSK)) - 1;
>  	tm->tm_year = (bcd2bin(rtc_data[5] & YEARS_REG_MSK)) + 100;
>  	tm->tm_wday = bcd2bin(rtc_data[6] & WEEKS_REG_MSK);
> +	rockchip_to_gregorian(tm);
>  	dev_dbg(dev, "RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
>  		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
> -		tm->tm_wday, tm->tm_hour , tm->tm_min, tm->tm_sec);
> +		tm->tm_wday, tm->tm_hour, tm->tm_min, tm->tm_sec);
>  
>  	return ret;
>  }
> @@ -116,6 +153,10 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	u8 rtc_data[NUM_TIME_REGS];
>  	int ret;
>  
> +	dev_dbg(dev, "set RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
> +		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
> +		tm->tm_wday, tm->tm_hour, tm->tm_min, tm->tm_sec);
> +	gregorian_to_rockchip(tm);
>  	rtc_data[0] = bin2bcd(tm->tm_sec);
>  	rtc_data[1] = bin2bcd(tm->tm_min);
>  	rtc_data[2] = bin2bcd(tm->tm_hour);
> @@ -123,9 +164,6 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	rtc_data[4] = bin2bcd(tm->tm_mon + 1);
>  	rtc_data[5] = bin2bcd(tm->tm_year - 100);
>  	rtc_data[6] = bin2bcd(tm->tm_wday);
> -	dev_dbg(dev, "set RTC date/time %4d-%02d-%02d(%d) %02d:%02d:%02d\n",
> -		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
> -		tm->tm_wday, tm->tm_hour , tm->tm_min, tm->tm_sec);
>  
>  	/* Stop RTC while updating the RTC registers */
>  	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
> @@ -170,6 +208,7 @@ static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	alrm->time.tm_mday = bcd2bin(alrm_data[3] & DAYS_REG_MSK);
>  	alrm->time.tm_mon = (bcd2bin(alrm_data[4] & MONTHS_REG_MSK)) - 1;
>  	alrm->time.tm_year = (bcd2bin(alrm_data[5] & YEARS_REG_MSK)) + 100;
> +	rockchip_to_gregorian(&alrm->time);
>  
>  	ret = regmap_read(rk808->regmap, RK808_RTC_INT_REG, &int_reg);
>  	if (ret) {
> @@ -227,6 +266,7 @@ static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  		alrm->time.tm_mday, alrm->time.tm_wday, alrm->time.tm_hour,
>  		alrm->time.tm_min, alrm->time.tm_sec);
>  
> +	gregorian_to_rockchip(&alrm->time);
>  	alrm_data[0] = bin2bcd(alrm->time.tm_sec);
>  	alrm_data[1] = bin2bcd(alrm->time.tm_min);
>  	alrm_data[2] = bin2bcd(alrm->time.tm_hour);
> -- 
> 2.1.2
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
