Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBH7AU25QKGQE35GH3DA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f4si207768wmg.0.2016.06.21.14.22.39
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Jun 2016 14:22:39 -0700 (PDT)
Date: Tue, 21 Jun 2016 23:22:38 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, cphealy@gmail.com
Subject: [rtc-linux] Re: [PATCH v2 13/17] RTC: ds1307: Report oscillator
 problems more intelligently
Message-ID: <20160621212238.GA5809@piout.net>
References: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
 <1466493770-11895-12-git-send-email-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466493770-11895-12-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/06/2016 at 00:22:46 -0700, Andrey Smirnov wrote :
> Report oscillator problems more intelligently, by printing more
> information about what cause the issue and not yelling "SET TIME!" at
> the user.
> 

Well, the proper way of doing that is to ensure that -EINVAL is returned
when reading the time until it has been set once instead of starting the
oscillator and forgetting about that useful information.

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 2af9c00..2169e5b 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -1424,6 +1424,19 @@ static int ds1307_chip_configure(const struct ds1307 *ds1307)
>  	return 0;
>  }
>  
> +static void ds1307_report_clock_halt(const struct ds1307 *ds1307)
> +{
> +	dev_warn(&ds1307->client->dev, "RTC's oscillator is turned off. "
> +		 "Turning it on. Please set time");
> +}
> +
> +static void ds1307_report_oscillator_fault(const struct ds1307 *ds1307)
> +{
> +	dev_warn(&ds1307->client->dev, "RTC's reported oscillator fault. "
> +		 "Clearing the fault flag and re-reading RTC status. "
> +		 "Please set time");
> +}
> +
>  static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
>  {
>  	int tmp, retries;
> @@ -1453,7 +1466,7 @@ static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
>  			if (tmp & DS1307_BIT_CH) {
>  				i2c_smbus_write_byte_data(client,
>  							  DS1307_REG_SECS, 0);
> -				dev_warn(&client->dev, "SET TIME!\n");
> +				ds1307_report_clock_halt(ds1307);
>  				continue;
>  			}
>  			break;
> @@ -1469,15 +1482,17 @@ static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
>  							  DS1307_REG_CONTROL,
>  							  regs[DS1307_REG_CONTROL]
>  							  & ~DS1338_BIT_OSF);
> -				dev_warn(&client->dev, "SET TIME!\n");
> +				ds1307_report_oscillator_fault(ds1307);
>  				continue;
>  			}
>  			break;
>  		case ds_1340:
>  			/* clock halted?  turn it on, so clock can tick. */
> -			if (tmp & DS1340_BIT_nEOSC)
> +			if (tmp & DS1340_BIT_nEOSC) {
>  				i2c_smbus_write_byte_data(client,
>  							  DS1307_REG_SECS, 0);
> +				ds1307_report_clock_halt(ds1307);
> +			}
>  
>  			tmp = i2c_smbus_read_byte_data(client, DS1340_REG_FLAG);
>  			if (tmp < 0) {
> @@ -1489,7 +1504,7 @@ static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
>  			if (tmp & DS1340_BIT_OSF) {
>  				i2c_smbus_write_byte_data(client,
>  							  DS1340_REG_FLAG, 0);
> -				dev_warn(&client->dev, "SET TIME!\n");
> +				ds1307_report_oscillator_fault(ds1307);
>  			}
>  			return 0;
>  
> @@ -1500,6 +1515,9 @@ static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
>  							  DS1307_REG_WDAY,
>  							  regs[DS1307_REG_WDAY]
>  							  | MCP794XX_BIT_VBATEN);
> +				dev_warn(&client->dev,
> +					 "battery backup was disabled. "
> +					 "Re-enabling it\n");
>  			}
>  
>  			/* clock halted?  turn it on, so clock can tick. */
> @@ -1507,7 +1525,7 @@ static int ds1307_chip_sanity_check(const struct ds1307 *ds1307)
>  				i2c_smbus_write_byte_data(client,
>  							  DS1307_REG_SECS,
>  							  MCP794XX_BIT_ST);
> -				dev_warn(&client->dev, "SET TIME!\n");
> +				ds1307_report_clock_halt(ds1307);
>  				continue;
>  			}
>  
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
