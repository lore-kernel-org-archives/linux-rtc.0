Return-Path: <rtc-linux+bncBDS7HNEFSALRBDVXVK2AKGQEP2EKSBQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 202si2491571wmf.2.2016.01.04.08.19.26
        for <rtc-linux@googlegroups.com>;
        Mon, 04 Jan 2016 08:19:26 -0800 (PST)
Date: Mon, 4 Jan 2016 17:18:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: rtc-palmas: correct for bcd year
Message-ID: <20160104161853.GC32724@piout.net>
References: <1451508726-31769-1-git-send-email-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1451508726-31769-1-git-send-email-salyzyn@android.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 30/12/2015 at 12:51:45 -0800, Mark Salyzyn wrote :
> Replace bcd2bin and bin2bcd with one that maps years 1970 to 2129
> in a pattern that works with the underlying hardware.
> 
> The only transition that does not work correctly for this rtc clock
> is the transition from 2099 to 2100, it proceeds to 2000. The rtc
> clock retains and transitions the year correctly in all other
> circumstances.
> 

If that transition doesn't work, it is not useful to try to support
dates after 2099. Also, I'm concerned about the leap year handling in
the other case. What is done right now is probably the best however, I
couldn't find the datasheet to confirm.

> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> ---
>  drivers/rtc/rtc-palmas.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-palmas.c b/drivers/rtc/rtc-palmas.c
> index 7ea2c47..3e9663d 100644
> --- a/drivers/rtc/rtc-palmas.c
> +++ b/drivers/rtc/rtc-palmas.c
> @@ -45,6 +45,42 @@ struct palmas_rtc {
>  /* Total number of RTC registers needed to set time*/
>  #define PALMAS_NUM_TIME_REGS	(PALMAS_YEARS_REG - PALMAS_SECONDS_REG + 1)
>  
> +/*
> + * Special bin2bcd mapping to deal with bcd storage of year.
> + *
> + *   0-69                -> 0xD0
> + *  70-99  (1970 - 1999) -> 0xD0 - 0xF9 (correctly rolls to 0x00)
> + * 100-199 (2000 - 2099) -> 0x00 - 0x99 (does not roll to 0xA0 :-( )
> + * 200-229 (2100 - 2129) -> 0xA0 - 0xC9 (really for completeness)
> + * 230-                  -> 0xC9
> + *
> + * Confirmed: the only transition that does not work correctly for this rtc
> + * clock is the transition from 2099 to 2100, it proceeds to 2000. We will
> + * accept this issue since the clock retains and transitions the year correctly
> + * in all other conditions.
> + */
> +static unsigned char year_bin2bcd(int val)
> +{
> +	if (val < 70)
> +		return 0xD0;
> +	if (val < 100)
> +		return bin2bcd(val - 20) | 0x80; /* KISS leverage of bin2bcd */
> +	if (val >= 230)
> +		return 0xC9;
> +	if (val >= 200)
> +		return bin2bcd(val - 180) | 0x80;
> +	return bin2bcd(val - 100);
> +}
> +
> +static int year_bcd2bin(unsigned char val)
> +{
> +	if (val >= 0xD0)
> +		return bcd2bin(val & 0x7F) + 20;
> +	if (val >= 0xA0)
> +		return bcd2bin(val & 0x7F) + 180;
> +	return bcd2bin(val) + 100;
> +}
> +
>  static int palmas_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	unsigned char rtc_data[PALMAS_NUM_TIME_REGS];
> @@ -71,7 +107,7 @@ static int palmas_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	tm->tm_hour = bcd2bin(rtc_data[2]);
>  	tm->tm_mday = bcd2bin(rtc_data[3]);
>  	tm->tm_mon = bcd2bin(rtc_data[4]) - 1;
> -	tm->tm_year = bcd2bin(rtc_data[5]) + 100;
> +	tm->tm_year = year_bcd2bin(rtc_data[5]);
>  
>  	return ret;
>  }
> @@ -87,7 +123,7 @@ static int palmas_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	rtc_data[2] = bin2bcd(tm->tm_hour);
>  	rtc_data[3] = bin2bcd(tm->tm_mday);
>  	rtc_data[4] = bin2bcd(tm->tm_mon + 1);
> -	rtc_data[5] = bin2bcd(tm->tm_year - 100);
> +	rtc_data[5] = year_bin2bcd(tm->tm_year);
>  
>  	/* Stop RTC while updating the RTC time registers */
>  	ret = palmas_update_bits(palmas, PALMAS_RTC_BASE, PALMAS_RTC_CTRL_REG,
> @@ -142,7 +178,7 @@ static int palmas_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  	alm->time.tm_hour = bcd2bin(alarm_data[2]);
>  	alm->time.tm_mday = bcd2bin(alarm_data[3]);
>  	alm->time.tm_mon = bcd2bin(alarm_data[4]) - 1;
> -	alm->time.tm_year = bcd2bin(alarm_data[5]) + 100;
> +	alm->time.tm_year = year_bcd2bin(alarm_data[5]);
>  
>  	ret = palmas_read(palmas, PALMAS_RTC_BASE, PALMAS_RTC_INTERRUPTS_REG,
>  			&int_val);
> @@ -173,7 +209,7 @@ static int palmas_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  	alarm_data[2] = bin2bcd(alm->time.tm_hour);
>  	alarm_data[3] = bin2bcd(alm->time.tm_mday);
>  	alarm_data[4] = bin2bcd(alm->time.tm_mon + 1);
> -	alarm_data[5] = bin2bcd(alm->time.tm_year - 100);
> +	alarm_data[5] = year_bin2bcd(alm->time.tm_year);
>  
>  	ret = palmas_bulk_write(palmas, PALMAS_RTC_BASE,
>  		PALMAS_ALARM_SECONDS_REG, alarm_data, PALMAS_NUM_TIME_REGS);
> -- 
> 2.6.0.rc2.230.g3dd15c0
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
