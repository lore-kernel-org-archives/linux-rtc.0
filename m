Return-Path: <pebolle@tiscali.nl>
Message-ID: <1425286489.24292.79.camel@x220>
Subject: Re: [PATCH v2] rtc: add Abracon ABx80x driver
From: Paul Bolle <pebolle@tiscali.nl>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Date: Mon, 02 Mar 2015 09:54:49 +0100
In-Reply-To: <1425205635-3587-1-git-send-email-alexandre.belloni@free-electrons.com>
References: 
	<1425205635-3587-1-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <rtc-linux.googlegroups.com>

On Sun, 2015-03-01 at 11:27 +0100, Alexandre Belloni wrote:
> --- /dev/null
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -0,0 +1,193 @@
> +/*
> + * An I2C driver for the Abracon AB08xx
> + *
> + * Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */

This states the license is plain GPL v2

[...]

> +MODULE_LICENSE("GPL");

So you probably want
    MODULE_LICENSE("GPL v2");

here.


Paul Bolle
