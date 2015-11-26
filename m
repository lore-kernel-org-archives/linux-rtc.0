Return-Path: <rtc-linux+bncBDS7HNEFSALRBA5Y3OZAKGQEACD4NGI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e201si56058wma.3.2015.11.26.02.16.34
        for <rtc-linux@googlegroups.com>;
        Thu, 26 Nov 2015 02:16:34 -0800 (PST)
Date: Thu, 26 Nov 2015 11:16:34 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	patches@opensource.wolfsonmicro.com
Subject: [rtc-linux] Re: [PATCH] rtc: rx8581: adding Device Tree support
Message-ID: <20151126101634.GR3950@piout.net>
References: <1448531917-14994-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448531917-14994-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
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

On 26/11/2015 at 09:58:37 +0000, Piotr Stankiewicz wrote :
> Signed-off-by: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
> ---
>  drivers/rtc/rtc-rx8581.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
> index 161e25d0..a4c86c5 100644
> --- a/drivers/rtc/rtc-rx8581.c
> +++ b/drivers/rtc/rtc-rx8581.c
> @@ -312,9 +312,18 @@ static const struct i2c_device_id rx8581_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, rx8581_id);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id rx8581_of_match[] = {
> +	{ .compatible = "epson,rx8581"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rx8581_of_match);
> +#endif
> +

Is that necessary? epson,rx8581 is already matching the only
i2c_device_id of this driver.

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
