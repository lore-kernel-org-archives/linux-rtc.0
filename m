Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBRXZ5XDQKGQEPXSPIKY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f136si16323wme.1.2017.04.22.08.54.46
        for <rtc-linux@googlegroups.com>;
        Sat, 22 Apr 2017 08:54:46 -0700 (PDT)
Date: Sat, 22 Apr 2017 17:54:45 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: David Lowe <dave-lowe@ntlworld.com>
Cc: rtc-linux <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [Patch] rtc: rtc-ds1307: enable support for mcp794xx
 as a wakeup source without IRQ
Message-ID: <20170422155445.jvuulnh6hhv4ii6s@piout.net>
References: <20170328182204.4fda934e@pixelzero>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170328182204.4fda934e@pixelzero>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 28/03/2017 at 18:22:04 +0100, David Lowe wrote:
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
> +
> ds1307_can_wakeup_device)) { irq_handler = mcp794xx_irq;

This seems right but your mailer as mangled the patch. Can you resend?

>  			want_irq = true;
>  		}

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
