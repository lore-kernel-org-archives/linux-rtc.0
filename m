Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41687 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbdFERAF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 5 Jun 2017 13:00:05 -0400
Date: Mon, 5 Jun 2017 19:00:03 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 1/4] rtc: ds1307: make definition of ds1307_of_match
 more compact
Message-ID: <20170605170003.uzkjihrbz2rbetjx@piout.net>
References: <a8dce195-b22a-47ce-992d-6437ce4e8297@gmail.com>
 <5b8af62b-24a4-0a05-26c7-6be893297f9c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5b8af62b-24a4-0a05-26c7-6be893297f9c@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 05/06/2017 at 17:57:22 +0200, Heiner Kallweit wrote:
> Make the definition of ds1307_of_match more compact. This makes the
> code better readable and more in line with the definition of
> ds1307_id and ds1307_acpi_ids.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v2:
> - no changes
> v3:
> - add reviewed-by

Well, I don't like it, and I don't think it actually improves
readability. My experience shows that the opposite of this patch is
quite often necessary.

> ---
>  drivers/rtc/rtc-ds1307.c | 70 ++++++++++--------------------------------------
>  1 file changed, 14 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index a2649385..b960ec3f 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -198,62 +198,20 @@ MODULE_DEVICE_TABLE(i2c, ds1307_id);
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id ds1307_of_match[] = {
> -	{
> -		.compatible = "dallas,ds1307",
> -		.data = (void *)ds_1307
> -	},
> -	{
> -		.compatible = "dallas,ds1337",
> -		.data = (void *)ds_1337
> -	},
> -	{
> -		.compatible = "dallas,ds1338",
> -		.data = (void *)ds_1338
> -	},
> -	{
> -		.compatible = "dallas,ds1339",
> -		.data = (void *)ds_1339
> -	},
> -	{
> -		.compatible = "dallas,ds1388",
> -		.data = (void *)ds_1388
> -	},
> -	{
> -		.compatible = "dallas,ds1340",
> -		.data = (void *)ds_1340
> -	},
> -	{
> -		.compatible = "maxim,ds3231",
> -		.data = (void *)ds_3231
> -	},
> -	{
> -		.compatible = "st,m41t0",
> -		.data = (void *)m41t00
> -	},
> -	{
> -		.compatible = "st,m41t00",
> -		.data = (void *)m41t00
> -	},
> -	{
> -		.compatible = "microchip,mcp7940x",
> -		.data = (void *)mcp794xx
> -	},
> -	{
> -		.compatible = "microchip,mcp7941x",
> -		.data = (void *)mcp794xx
> -	},
> -	{
> -		.compatible = "pericom,pt7c4338",
> -		.data = (void *)ds_1307
> -	},
> -	{
> -		.compatible = "epson,rx8025",
> -		.data = (void *)rx_8025
> -	},
> -	{
> -		.compatible = "isil,isl12057",
> -		.data = (void *)ds_1337
> -	},
> +	{ .compatible = "dallas,ds1307",	.data = (void *)ds_1307 },
> +	{ .compatible = "dallas,ds1337",	.data = (void *)ds_1337 },
> +	{ .compatible = "dallas,ds1338",	.data = (void *)ds_1338 },
> +	{ .compatible = "dallas,ds1339",	.data = (void *)ds_1339 },
> +	{ .compatible = "dallas,ds1388",	.data = (void *)ds_1388 },
> +	{ .compatible = "dallas,ds1340",	.data = (void *)ds_1340 },
> +	{ .compatible = "maxim,ds3231",		.data = (void *)ds_3231 },
> +	{ .compatible = "st,m41t0",		.data = (void *)m41t00 },
> +	{ .compatible = "st,m41t00",		.data = (void *)m41t00 },
> +	{ .compatible = "microchip,mcp7940x",	.data = (void *)mcp794xx },
> +	{ .compatible = "microchip,mcp7941x",	.data = (void *)mcp794xx },
> +	{ .compatible = "pericom,pt7c4338",	.data = (void *)ds_1307 },
> +	{ .compatible = "epson,rx8025",		.data = (void *)rx_8025 },
> +	{ .compatible = "isil,isl12057",	.data = (void *)ds_1337 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ds1307_of_match);
> -- 
> 2.13.0
> 
> 
> 
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
