Return-Path: <rtc-linux+bncBDS7HNEFSALRBPHB42XQKGQEFYIJL5Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c7si189871wiy.3.2015.09.16.11.11.07
        for <rtc-linux@googlegroups.com>;
        Wed, 16 Sep 2015 11:11:07 -0700 (PDT)
Date: Wed, 16 Sep 2015 20:10:57 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Ivan Grimaldi <grimaldi.ivan@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Mark Jackson <mpfj@mimc.co.uk>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH] Fixed ds1390_get_reg returned value
Message-ID: <20150916181057.GF4287@piout.net>
References: <CAO1575Wk_O6RYMGJSx2=54OYj-_fZXSGum5bZa8fF=cpf5d5Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAO1575Wk_O6RYMGJSx2=54OYj-_fZXSGum5bZa8fF=cpf5d5Gw@mail.gmail.com>
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

Your patch is not properly fomatted, it as probably been mangled by your
mailer can you resend it properly?

Thanks,

On 16/09/2015 at 17:51:17 +0200, Ivan Grimaldi wrote :
> spi_write_then_read puts in rx_buf the received data starting from the
> first byte of the rx_buf for n_rx bytes.
> 
> Signed-off-by: Ivan Grimaldi <grimaldi.ivan@gmail.com>
> ---
> diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
> index e67bfcb..a4303b4 100644
> --- a/drivers/rtc/rtc-ds1390.c
> +++ b/drivers/rtc/rtc-ds1390.c
> @@ -62,7 +62,7 @@ static int ds1390_get_reg(struct device *dev, unsigned
> char address,
>         if (status != 0)
>                 return status;
> 
> -       *data = chip->txrx_buf[1];
> +       *data = chip->txrx_buf[0];
> 
>         return 0;
>  }
> 
> -- 
> -- 
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
> --- 
> You received this message because you are subscribed to the Google Groups "rtc-linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

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
