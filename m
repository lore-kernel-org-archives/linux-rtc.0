Date: Mon, 8 Jun 2015 17:42:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rnd4@dave-tech.it
Cc: r.cerrato@til-technologies.fr, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	Andrea Scian <andrea.scian@dave.eu>
Subject: Re: [rtc-linux] [PATCH] driver: rtc: pcf2127: use OFS flag to detect
 unreliable date and warn the user
Message-ID: <20150608154251.GC5222@piout.net>
References: <1432628260-24652-1-git-send-email-rnd4@dave-tech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432628260-24652-1-git-send-email-rnd4@dave-tech.it>
List-ID: <rtc-linux.googlegroups.com>

Hi,

This seems ok, a few comments below:

On 26/05/2015 at 10:17:40 +0200, rnd4@dave-tech.it wrote :
> From: Andrea Scian <andrea.scian@dave.eu>
> 
> I'm using PCF2127 in a custom ARM-based board and, by looking into PCF2127 datasheet 
> I've found that, in my understanding, it's wrong to say that the date in unreliable
> if BLF (battery low flag) is set but you should use OSF flag (seconds register) to
> check if oscillator, for any reason, stopped.
> Battery may be low (usually below 2V5 threshold) but the date may be anyway correct
> (tipically date is unreliable when input voltage is below 1V2).

typically -^

> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 1ee514a..2365788 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -59,7 +59,16 @@ static int pcf2127_get_datetime(struct i2c_client *client, struct rtc_time *tm)
>  	if (buf[PCF2127_REG_CTRL3] & 0x04) {
>  		pcf2127->voltage_low = 1;
>  		dev_info(&client->dev,
> -			"low voltage detected, date/time is not reliable.\n");
> +			"low voltage detected, check/replace RTC battery.\n");
> +	}
> +
> +	if (buf[PCF2127_REG_SC] & 0x80) {

Maybe use a define instead of 0x80, remember to use the BIT() macro.

> +		dev_warn(&client->dev,
> +			"oscillator stop detected, date/time is not reliable.\n");

I would return -EINVAL here because the result might still pass
rtc_valid_tm() but be outdated.

> +		/*
> +		 * no need clear the flag here,
> +		 * it will be cleared once the new date is saved
> +		 */
>  	}
>  
>  	dev_dbg(&client->dev,
> @@ -112,7 +121,7 @@ static int pcf2127_set_datetime(struct i2c_client *client, struct rtc_time *tm)
>  	buf[i++] = PCF2127_REG_SC;
>  
>  	/* hours, minutes and seconds */
> -	buf[i++] = bin2bcd(tm->tm_sec);
> +	buf[i++] = bin2bcd(tm->tm_sec);	/* this will also clear OFS flag */
>  	buf[i++] = bin2bcd(tm->tm_min);
>  	buf[i++] = bin2bcd(tm->tm_hour);
>  	buf[i++] = bin2bcd(tm->tm_mday);
> @@ -144,7 +153,7 @@ static int pcf2127_rtc_ioctl(struct device *dev,
>  	switch (cmd) {
>  	case RTC_VL_READ:
>  		if (pcf2127->voltage_low)
> -			dev_info(dev, "low voltage detected, date/time is not reliable.\n");
> +			dev_info(dev, "low voltage detected, check/replace battery\n");

I would also print a warning about OFS here.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
