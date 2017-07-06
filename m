Date: Thu, 6 Jul 2017 11:55:27 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH 2/2] rtc: ds1307: disable square wave output
 from ds1308
Message-ID: <20170706095527.pqkrzlkhontn5jik@piout.net>
References: <20170608103655.20043-1-sean.nyekjaer@prevas.dk>
 <20170608103655.20043-2-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170608103655.20043-2-sean.nyekjaer@prevas.dk>
List-ID: <rtc-linux.googlegroups.com>

Hi,

On 08/06/2017 at 12:36:55 +0200, Sean Nyekjaer wrote:
> Disable sqw output from ds1308 in order to reduce
> the power consumption by ~50%.
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> ---
>  drivers/rtc/rtc-ds1307.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index a4ef03ad9395..8d9f25a3c757 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -78,6 +78,7 @@ enum ds_type {
>  #	define DS1307_BIT_OUT		0x80
>  #	define DS1338_BIT_OSF		0x20
>  #	define DS1307_BIT_SQWE		0x10
> +#	define DS1308_BIT_BBCLK		0x04
>  #	define DS1307_BIT_RS1		0x02
>  #	define DS1307_BIT_RS0		0x01
>  #define DS1337_REG_CONTROL	0x0e
> @@ -1454,6 +1455,11 @@ static int ds1307_probe(struct i2c_client *client,
>  		}
>  		break;
>  	case ds_1308:
> +		/* disable sqw when driven from battery backup */
> +		if (ds1307->regs[DS1307_REG_CONTROL] & DS1308_BIT_BBCLK)
> +			i2c_smbus_write_byte_data(client, DS1307_REG_CONTROL,
> +					ds1307->regs[DS1307_REG_CONTROL]
> +					& ~DS1338_BIT_BBCLK);

This should be done using the common clock framework, please have a look
at what is done for the ds3231 in ds1307_clks_register.

>  	case ds_1338:
>  		/* clock halted?  turn it on, so clock can tick. */
>  		if (tmp & DS1307_BIT_CH)
> -- 
> 2.13.0
> 
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
Embedded Linux and Kernel engineering
http://free-electrons.com
