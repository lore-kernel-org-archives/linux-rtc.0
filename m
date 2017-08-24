Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52985 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753771AbdHXVTl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 24 Aug 2017 17:19:41 -0400
Date: Thu, 24 Aug 2017 23:19:40 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        David Lowe <dave-lowe@ntlworld.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Marek Vasut <marex@denx.de>, Tin Huynh <tnhuynh@apm.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] rtc: ds1307: add basic support for ds1341 chip
Message-ID: <20170824211940.3hxktw4slodvxcul@piout.net>
References: <20170824063211.27635-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170824063211.27635-1-nikita.yoush@cogentembedded.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 24/08/2017 at 09:32:11 +0300, Nikita Yushchenko wrote:
> This adds support for reading and writing date/time from/to ds1341 chip.
> 
> ds1341 chip has other features - alarms, input clock (can be used instead
> of intercal oscillator for better accuracy), output clock ("square wave
> generation"). However, not all of that is available at the same time.
> Same chip pins, CLKIN/nINTA and SQW/nINTB, can be used either for
> input/output clocks, or for alarm interrupts. Role of these pins on
> particular board depends on hardware wiring.
> 
> We can add device tree properties that describe if each of pins is wired
> as clock, or as interrupt, or left unconnected, and enable support for
> corresponding functionality based on that. But that is cumbersome, requires
> hardware for testing, and has to deal with bit enabling/disabling output
> clock also affects which pins alarm interrupts are routed to.
> 
> Another factor is that there are hardware setups (i.e. ZII RDU2) that
> power DS1341 from SuperCap, which makes power saving critical. For such
> setups, kernel driver should leave register bits that control mentioned
> pins in the state configured by bootloader.
> 
> Given all that, it was decided to limit support to "only date/time" for
> now. That is enough for common use case. Full (and cumbersome)
> implementation can be added later if ever needed.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Aleksander Morgado <aleksander@aleksander.es>
> ---
>  drivers/rtc/Kconfig      | 10 +++++-----
>  drivers/rtc/rtc-ds1307.c | 13 +++++++++++++
>  2 files changed, 18 insertions(+), 5 deletions(-)

I've applied but...

> @@ -1323,6 +1334,7 @@ static int ds1307_probe(struct i2c_client *client,
>  	static const int	bbsqi_bitpos[] = {
>  		[ds_1337] = 0,
>  		[ds_1339] = DS1339_BIT_BBSQI,
> +		[ds_1341] = 0,
>  		[ds_3231] = DS3231_BIT_BBSQW,
>  	};
>  	const struct rtc_class_ops *rtc_ops = &ds13xx_rtc_ops;

I had to remove that change following http://patchwork.ozlabs.org/patch/787009/

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
