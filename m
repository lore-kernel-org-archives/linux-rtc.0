Return-Path: <rtc-linux+bncBDS7HNEFSALRBTEAUC3QKGQE6OPAJ5Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si770977wmd.1.2016.03.15.05.30.03
        for <rtc-linux@googlegroups.com>;
        Tue, 15 Mar 2016 05:30:03 -0700 (PDT)
Date: Tue, 15 Mar 2016 13:20:05 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Stefan Christ <s.christ@phytec.de>
Cc: rtc-linux@googlegroups.com, a.zummo@towertech.it
Subject: [rtc-linux] Re: [PATCH] drivers/rtc/rtc-m41t80.c: avoid out of range
 year values
Message-ID: <20160315122005.GA20227@piout.net>
References: <1457438210-5394-1-git-send-email-s.christ@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1457438210-5394-1-git-send-email-s.christ@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 08/03/2016 at 12:56:50 +0100, Stefan Christ wrote :
> Avoid saving an out of range year value to the RTC. Reading that value
> from the RTC again returns a totally wrong time value. For Example
> 
>     $ timedatectl set-ntp no
>     $ timedatectl set-time "1990-01-01 12:12:00"
>     # Reboot
>     rtc-m41t80 0-0068: setting system clock to 2090-01-01 12:12:35 UTC (3786955955)
> 
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> ---
>  drivers/rtc/rtc-m41t80.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
> index a82937e..ae8bfae 100644
> --- a/drivers/rtc/rtc-m41t80.c
> +++ b/drivers/rtc/rtc-m41t80.c
> @@ -176,7 +176,13 @@ static int m41t80_set_datetime(struct i2c_client *client, struct rtc_time *tm)
>  		bin2bcd(tm->tm_mday) | (buf[M41T80_REG_DAY] & ~0x3f);
>  	buf[M41T80_REG_MON] =
>  		bin2bcd(tm->tm_mon + 1) | (buf[M41T80_REG_MON] & ~0x1f);
> +
>  	/* assume 20YY not 19YY */
> +	if (!(100 <= tm->tm_year && tm->tm_year <= 199)) {

This introduces a checkpatch warning, can you fix that and resend 

> +		dev_err(&client->dev, "Year must be between 2000 and 2099. It's %d.\n",
> +					tm->tm_year + 1900);

This is not properly aligned.

> +		return -EINVAL;
> +	}
>  	buf[M41T80_REG_YEAR] = bin2bcd(tm->tm_year % 100);
>  
>  	if (i2c_transfer(client->adapter, msgs, 1) != 1) {
> -- 
> 1.9.1
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
