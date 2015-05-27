Return-Path: <rtc-linux+bncBDS7HNEFSALRB24MS2VQKGQE7CPQ56Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q10si79515wiz.0.2015.05.27.01.55.07
        for <rtc-linux@googlegroups.com>;
        Wed, 27 May 2015 01:55:07 -0700 (PDT)
Date: Wed, 27 May 2015 10:55:06 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jan Kardell <jan.kardell@telliq.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Vincent Donnefort <vdonnefort@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: [rtc-linux] Re: [PATCH] rtc: pcf8563 fix: return -EINVAL if we read
 an invalid time.
Message-ID: <20150527085506.GM3199@piout.net>
References: <1432547474-3787-1-git-send-email-jan.kardell@telliq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432547474-3787-1-git-send-email-jan.kardell@telliq.com>
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

On 25/05/2015 at 11:51:14 +0200, Jan Kardell wrote :
> @@ -202,8 +202,9 @@ static int pcf8563_get_datetime(struct i2c_client *client, struct rtc_time *tm)
>  
>  	if (buf[PCF8563_REG_SC] & PCF8563_SC_LV) {
>  		pcf8563->voltage_low = 1;
> -		dev_info(&client->dev,
> +		dev_err(&client->dev,
>  			"low voltage detected, date/time is not reliable.\n");
> +		return -EINVAL;
>  	}
>  
>  	dev_dbg(&client->dev,
> @@ -234,11 +235,11 @@ static int pcf8563_get_datetime(struct i2c_client *client, struct rtc_time *tm)
>  		tm->tm_sec, tm->tm_min, tm->tm_hour,
>  		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
>  
> -	/* the clock can give out invalid datetime, but we cannot return
> -	 * -EINVAL otherwise hwclock will refuse to set the time on bootup.
> -	 */
> -	if (rtc_valid_tm(tm) < 0)
> +	err = rtc_valid_tm(tm);
> +	if (err < 0) {
>  		dev_err(&client->dev, "retrieved date/time is not valid.\n");
> +		return err;
> +	}

I would avoid dev_err and directly return rtc_valid_tm(tm) or you could
also return 0 and let the core do the rtc_valid_tm() check.

>  
>  	return 0;
>  }
> -- 
> 1.8.4.5
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
