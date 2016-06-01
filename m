Return-Path: <rtc-linux+bncBDS7HNEFSALRBBNFXO5AKGQE3CVH6KI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id l184si1506706wmg.2.2016.06.01.05.18.13
        for <rtc-linux@googlegroups.com>;
        Wed, 01 Jun 2016 05:18:13 -0700 (PDT)
Date: Wed, 1 Jun 2016 14:18:02 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, nm@ti.com, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: Fix relying on reset value for weekday
Message-ID: <20160601121802.GF4249@piout.net>
References: <1464778147-22075-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1464778147-22075-1-git-send-email-j-keerthy@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 01/06/2016 at 16:19:07 +0530, Keerthy wrote :
> The reset value of weekday is 0x1. This is wrong since
> the reset values of the day/month/year make up to Jan 1 2001.
> When computed weekday comes out to be Monday. On a scale
> of 1-7(Sunday - Saturday) it should be 0x2. So we should not
> be relying on the reset value.
> 

Hum, what are the chances that the reset value is actually the correct
date/time?
Won't that be corrected after the first call to set_time? Until then,
the date is not correct so, do we care anyway?

Maybe I'm missing something here.

> Hence compute the wday using the current date/month/year values.
> Check if reset wday is any different from the computed wday,
> If different then set the wday which we computed using
> date/month/year values.
> 
> Document Referred:
> http://ww1.microchip.com/downloads/en/DeviceDoc/20002266F.pdf
> 
> Fixes: 1d1945d261a2af "drivers/rtc/rtc-ds1307.c: add alarm support for mcp7941x chips"
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 821d9c0..d9045cc 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -602,6 +602,8 @@ static const struct rtc_class_ops ds13xx_rtc_ops = {
>   * Alarm support for mcp794xx devices.
>   */
>  
> +#define MCP794XX_REG_WEEKDAY		0x3
> +#define MCP794XX_REG_WEEKDAY_WDAY_MASK	0x7
>  #define MCP794XX_REG_CONTROL		0x07
>  #	define MCP794XX_BIT_ALM0_EN	0x10
>  #	define MCP794XX_BIT_ALM1_EN	0x20
> @@ -1231,13 +1233,16 @@ static int ds1307_probe(struct i2c_client *client,
>  {
>  	struct ds1307		*ds1307;
>  	int			err = -ENODEV;
> -	int			tmp;
> +	int			tmp, wday;
>  	struct chip_desc	*chip = &chips[id->driver_data];
>  	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
>  	bool			want_irq = false;
>  	bool			ds1307_can_wakeup_device = false;
>  	unsigned char		*buf;
>  	struct ds1307_platform_data *pdata = dev_get_platdata(&client->dev);
> +	struct rtc_time		tm;
> +	unsigned long		timestamp;
> +
>  	irq_handler_t	irq_handler = ds1307_irq;
>  
>  	static const int	bbsqi_bitpos[] = {
> @@ -1526,6 +1531,27 @@ read_rtc:
>  				bin2bcd(tmp));
>  	}
>  
> +	/*
> +	 * Some IPs have weekday reset value = 0x1 which might not correct
> +	 * hence compute the wday using the current date/month/year values
> +	 */
> +	ds1307_get_time(&client->dev, &tm);
> +	wday = tm.tm_wday;
> +	timestamp = rtc_tm_to_time64(&tm);
> +	rtc_time64_to_tm(timestamp, &tm);
> +
> +	/*
> +	 * Check if reset wday is different from the computed wday
> +	 * If different then set the wday which we computed using
> +	 * timestamp
> +	 */
> +	if (wday != tm.tm_wday) {
> +		wday = i2c_smbus_read_byte_data(client, MCP794XX_REG_WEEKDAY);
> +		wday = wday & ~MCP794XX_REG_WEEKDAY_WDAY_MASK;
> +		wday = wday | (tm.tm_wday + 1);
> +		i2c_smbus_write_byte_data(client, MCP794XX_REG_WEEKDAY, wday);
> +	}
> +
>  	if (want_irq) {
>  		device_set_wakeup_capable(&client->dev, true);
>  		set_bit(HAS_ALARM, &ds1307->flags);
> -- 
> 1.9.1

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
