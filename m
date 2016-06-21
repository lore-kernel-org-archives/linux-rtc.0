Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBWO5U25QKGQE7EVMMAI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a186si153057wma.1.2016.06.21.14.17.13
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Jun 2016 14:17:13 -0700 (PDT)
Date: Tue, 21 Jun 2016 23:17:12 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, cphealy@gmail.com
Subject: [rtc-linux] Re: [PATCH v2 02/17] RTC: ds1307: Disable square wave and
 timers as default
Message-ID: <20160621211712.GZ5809@piout.net>
References: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/06/2016 at 00:22:35 -0700, Andrey Smirnov wrote :
> Disable square wave and timers as default for DS1337/39/41 and
> DS3231. The rationale being that configuring a chip this way puts it
> into a known state with lower power consumption. While it is not very
> likely it is still possible that the code controlling RTCs that ran
> before this driver configured it to produce square wave and left it in
> such a state.
> 

The main issue being that if it has been configured that way (from the
bootloader for example). It is probably necessary for the board. There
may be users of that clock and this patch definitively breaks them.
The proper way of doing that is to add CCF support in the driver. See:
http://patchwork.ozlabs.org/patch/576201/

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 7e65e2e..c618c22 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -1320,19 +1320,17 @@ static int ds1307_probe(struct i2c_client *client,
>  			ds1307->regs[0] &= ~DS1337_BIT_nEOSC;
>  
>  		/*
> -		 * Using IRQ or defined as wakeup-source?
>  		 * Disable the square wave and both alarms.
>  		 * For some variants, be sure alarms can trigger when we're
>  		 * running on Vbackup (BBSQI/BBSQW)
>  		 */
> -		if (chip->alarm && (ds1307->client->irq > 0 ||
> -						ds1307_can_wakeup_device)) {
> -			ds1307->regs[0] |= DS1337_BIT_INTCN
> -					| bbsqi_bitpos[ds1307->type];
> -			ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
> +		ds1307->regs[0] |= DS1337_BIT_INTCN
> +			| bbsqi_bitpos[ds1307->type];
> +		ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
>  
> +		if (chip->alarm && (ds1307->client->irq > 0 ||
> +				    ds1307_can_wakeup_device))
>  			want_irq = true;
> -		}
>  
>  		i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL,
>  							ds1307->regs[0]);
> -- 
> 2.5.5
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
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
