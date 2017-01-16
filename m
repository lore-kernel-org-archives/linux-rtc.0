Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB6UO6TBQKGQEZQKQCRA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e134si863190wmd.3.2017.01.16.09.48.41
        for <rtc-linux@googlegroups.com>;
        Mon, 16 Jan 2017 09:48:41 -0800 (PST)
Date: Mon, 16 Jan 2017 18:48:41 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/2] RTC: s35390a: implement ioctls
Message-ID: <20170116174841.csfttfimapvdemrm@piout.net>
References: <1484217818-27845-1-git-send-email-fabien.lahoudere@collabora.co.uk>
 <1484217818-27845-3-git-send-email-fabien.lahoudere@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1484217818-27845-3-git-send-email-fabien.lahoudere@collabora.co.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 12/01/2017 at 11:43:38 +0100, Fabien Lahoudere wrote :
> Implements RTC_VL_READ and RTC_VL_CLR ioctls.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
> ---
>  drivers/rtc/rtc-s35390a.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index ef4ada9..2bd8301 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
> @@ -121,7 +122,9 @@ static int s35390a_reset(struct s35390a *s35390a, char *status1)
>  		 * detection circuit is in operation.
>  		 */
>  		msleep(500);
> -	else if (!(*status1 & S35390A_FLAG_BLD))
> +	else if (*status1 & S35390A_FLAG_BLD)
> +		s35390a->lowvoltage = 1;
> +	else
>  		/*
>  		 * If both POC and BLD are unset everything is fine.
>  		 */
> @@ -393,12 +396,44 @@ static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	return s35390a_set_datetime(to_i2c_client(dev), tm);
>  }
>  
> +static int s35390a_rtc_ioctl(struct device *dev, unsigned int cmd,
> +			     unsigned long arg)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct s35390a *s35390a = i2c_get_clientdata(client);
> +	char sts;
> +	int err;
> +
> +	switch (cmd) {
> +	case RTC_VL_READ:

It seems wasteful to call s35390a_reset() every time. If
s35390a->lowvoltage is already set to 1 then you already have the answer
you need (and you already resetted the RTC)

> +		/* s35390a_reset set lowvoltage flag and init RTC if needed */
> +		err = s35390a_reset(s35390a, &sts);
> +		if (err < 0)
> +			return err;
> +		if (copy_to_user((void __user *)arg, &s35390a->lowvoltage,
> +				 sizeof(int)))
> +			return -EFAULT;
> +
> +	case RTC_VL_CLR:
> +		/* update flag and clear register */
> +		err = s35390a_reset(s35390a, &sts);
> +		if ((err == 1) || (err == 0))

Whatever the error, once the first s35390a_get_reg(), the POC and BLD
flags are lost. I would reset lowvoltage in every cases.


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
