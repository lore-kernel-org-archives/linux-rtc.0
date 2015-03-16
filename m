Return-Path: <pebolle@tiscali.nl>
Message-ID: <1426500981.26437.24.camel@x220>
Subject: Re: [PATCH 2/2] rtc: add rtc-abx80x, a driver for the Abracon AB
 x80x i2c rtc
From: Paul Bolle <pebolle@tiscali.nl>
To: Philippe De Muyter <phdm@macqel.be>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Morton
	 <akpm@linux-foundation.org>, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, Arnd Bergmann
	 <arnd@arndb.de>
Date: Mon, 16 Mar 2015 11:16:21 +0100
In-Reply-To: <20150314124441.GA11905@frolo.macqel>
References: 
	<1426327546-8085-1-git-send-email-alexandre.belloni@free-electrons.com>
	 <1426327546-8085-3-git-send-email-alexandre.belloni@free-electrons.com>
	 <20150314124441.GA11905@frolo.macqel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <rtc-linux.googlegroups.com>

On Sat, 2015-03-14 at 13:44 +0100, Philippe De Muyter wrote:
> On Sat, Mar 14, 2015 at 11:05:46AM +0100, Alexandre Belloni wrote:
> > --- /dev/null
> > +++ b/drivers/rtc/rtc-abx80x.c
> > +/*
> > + * A driver for the I2C members of the Abracon AB x8xx RTC family,
> > + * and compatible: AB 1805 and AB 0805
> > + *
> > + * Copyright 2014-2015 Macq S.A.
> > + *
> > + * Author: Philippe De Muyter <phdm@macqel.be>
> > + * Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > 
> > +MODULE_LICENSE("GPL");
> 
> I'm fine with 'GPL', but someone suggested to change that to 'GPL v2' in my patch.

That someone was me. And my reasoning is that "GPL" is documented to
mean "GPL v2 or later", while "GPL v2" is documented to mean just that.
So "GPL v2" would match what is stated at the comment at the top of this
file.

Thanks,


Paul Bolle
