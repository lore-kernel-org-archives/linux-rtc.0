Return-Path: <linux-rtc-owner@vger.kernel.org>
Date: Wed, 31 May 2017 03:29:04 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: David Lowe <dave-lowe@ntlworld.com>
Cc: rtc-linux <rtc-linux@googlegroups.com>, linux-rtc@vger.kernel.org
Subject: Re: [Patch] rtc: rtc-ds1307: enable support for mcp794xx as a wakeup
 source without IRQ
Message-ID: <20170531012904.ijxsrgf6kb27rzpk@piout.net>
References: <20170422182800.460265ba@pixelzero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170422182800.460265ba@pixelzero>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <rtc-linux.googlegroups.com>

On 22/04/2017 at 18:28:00 +0100, David Lowe wrote:
> This patch extends the fixes for ds1337, ds1339, ds3231 in 8bc2a40730ec
> to mcp794xx devices, so that those parts can similarly be used as a wakeup
> source without an IRQ to the processor.
> 
> Tested on Raspberry Pi ZeroW with MCP79400.
> 
> Signed-off-by: David Lowe <dave-lowe@ntlworld.com>
> ---
> --- a/drivers/rtc/rtc-ds1307.c	2017-03-28 16:16:38.158076224 +0100
> +++ b/drivers/rtc/rtc-ds1307.c	2017-03-28 16:16:52.248431799 +0100
> @@ -1487,7 +1487,8 @@ static int ds1307_probe(struct i2c_clien
>  		break;
>  	case mcp794xx:
>  		rtc_ops = &mcp794xx_rtc_ops;
> -		if (ds1307->client->irq > 0 && chip->alarm) {
> +		if (chip->alarm && (ds1307->client->irq > 0 ||
> +						ds1307_can_wakeup_device)) {
>  			irq_handler = mcp794xx_irq;
>  			want_irq = true;
>  		}

I applied it now but it didn't applied cleanly. Can you check tomorrow's
linux-next?

Thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
