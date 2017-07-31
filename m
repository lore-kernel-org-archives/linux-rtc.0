Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBYXQ7TFQKGQEDSO3TQY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 74si61131wmu.5.2017.07.31.07.02.10
        for <rtc-linux@googlegroups.com>;
        Mon, 31 Jul 2017 07:02:10 -0700 (PDT)
Date: Mon, 31 Jul 2017 16:02:00 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [RFC] rtc: ds1307: add square wave output from ds1308
Message-ID: <20170731140200.4h4wych32hdj7pu6@piout.net>
References: <20170731133013.22347-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170731133013.22347-1-sean.nyekjaer@prevas.dk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Sean,

The mailing list address changed, can you resend there. Also, please
copy the CCF maintainers.

A quick comment below:

On 31/07/2017 at 15:30:13 +0200, Sean Nyekjaer wrote:
> -	ret = ds3231_clks_register(ds1307);
>  	if (ret) {
>  		dev_warn(ds1307->dev, "unable to register clock device %d\n",
>  			 ret);
> @@ -1545,6 +1708,11 @@ static int ds1307_probe(struct i2c_client *client,
>  		}
>  		break;
>  	case ds_1308:
> +		/* disable sqw when driven from battery backup */
> +		if (ds1307->regs[DS1307_REG_CONTROL] & DS1308_BIT_BBCLK)
> +			i2c_smbus_write_byte_data(client, DS1307_REG_CONTROL,
> +					ds1307->regs[DS1307_REG_CONTROL]
> +					& ~DS1308_BIT_BBCLK);

That should not be needed, the CCF will disable any unused clock.

>  	case ds_1338:
>  		/* clock halted?  turn it on, so clock can tick. */
>  		if (tmp & DS1307_BIT_CH)
> -- 
> 2.13.3
> 

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
