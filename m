Return-Path: <rtc-linux+bncBDS7HNEFSALRBJEQQ6XAKGQEWRACD5A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bk2si221149wib.1.2015.08.05.01.24.03
        for <rtc-linux@googlegroups.com>;
        Wed, 05 Aug 2015 01:24:03 -0700 (PDT)
Date: Wed, 5 Aug 2015 10:24:03 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [rtc-linux] Re: [PATCH 05/11] rtc: ds1511: clean up ds1511_nvram_read()/ds1511_nvram_write()
Message-ID: <20150805082402.GA3486@piout.net>
References: <1437947316-5652-1-git-send-email-vz@mleia.com>
 <1437947316-5652-6-git-send-email-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1437947316-5652-6-git-send-email-vz@mleia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 27/07/2015 at 00:48:30 +0300, Vladimir Zapolskiy wrote :
> The change removes redundant sysfs binary file boundary checks, since
> this task is already done on caller side in fs/sysfs/file.c
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/rtc/rtc-ds1511.c | 38 ++++++++------------------------------
>  1 file changed, 8 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
> index 7415c2b..2213fab 100644
> --- a/drivers/rtc/rtc-ds1511.c
> +++ b/drivers/rtc/rtc-ds1511.c
> @@ -407,25 +407,14 @@ ds1511_nvram_read(struct file *filp, struct kobject *kobj,
>  {
>  	ssize_t count;
>  
> -	/*
> -	 * if count is more than one, turn on "burst" mode
> -	 * turn it off when you're done
> -	 */
> -	if (size > 1)
> -		rtc_write((rtc_read(RTC_CMD) | DS1511_BME), RTC_CMD);
> -
> -	if (pos > DS1511_RAM_MAX)
> -		pos = DS1511_RAM_MAX;
> -
> -	if (size + pos > DS1511_RAM_MAX + 1)
> -		size = DS1511_RAM_MAX - pos + 1;
> +	/* turn on "burst" mode, turn it off when you're done */
> +	rtc_write((rtc_read(RTC_CMD) | DS1511_BME), RTC_CMD);

That one feels wrong, you are now unconditionally using burst mode, this
was not the case before. If this has been tested and works, I'd ay that
this at least require a mention in the commit message.

>  
>  	rtc_write(pos, DS1511_RAMADDR_LSB);
> -	for (count = 0; size > 0; count++, size--)
> +	for (count = 0; count < size; count++)
>  		*buf++ = rtc_read(DS1511_RAMDATA);
>  
> -	if (count > 1)
> -		rtc_write((rtc_read(RTC_CMD) & ~DS1511_BME), RTC_CMD);
> +	rtc_write((rtc_read(RTC_CMD) & ~DS1511_BME), RTC_CMD);
>  
>  	return count;
>  }
> @@ -437,25 +426,14 @@ ds1511_nvram_write(struct file *filp, struct kobject *kobj,
>  {
>  	ssize_t count;
>  
> -	/*
> -	 * if count is more than one, turn on "burst" mode
> -	 * turn it off when you're done
> -	 */
> -	if (size > 1)
> -		rtc_write((rtc_read(RTC_CMD) | DS1511_BME), RTC_CMD);
> -
> -	if (pos > DS1511_RAM_MAX)
> -		pos = DS1511_RAM_MAX;
> -
> -	if (size + pos > DS1511_RAM_MAX + 1)
> -		size = DS1511_RAM_MAX - pos + 1;
> +	/* turn on "burst" mode, turn it off when you're done */
> +	rtc_write((rtc_read(RTC_CMD) | DS1511_BME), RTC_CMD);
>  
>  	rtc_write(pos, DS1511_RAMADDR_LSB);
> -	for (count = 0; size > 0; count++, size--)
> +	for (count = 0; count < size; count++)
>  		rtc_write(*buf++, DS1511_RAMDATA);
>  
> -	if (count > 1)
> -		rtc_write((rtc_read(RTC_CMD) & ~DS1511_BME), RTC_CMD);
> +	rtc_write((rtc_read(RTC_CMD) & ~DS1511_BME), RTC_CMD);
>  
>  	return count;
>  }
> -- 
> 2.1.4
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
