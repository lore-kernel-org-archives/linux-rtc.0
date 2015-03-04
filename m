Date: Wed, 4 Mar 2015 10:06:01 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Philippe De Muyter <phdm@macqel.be>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH v2] rtc: add Abracon ABx80x driver
Message-ID: <20150304090601.GC3989@piout.net>
References: <1425205635-3587-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150302155337.7876cfb631552427187c4c0a@linux-foundation.org>
 <20150303011116.GW4094@piout.net>
 <20150303122012.177eee47ba703bd73780b741@linux-foundation.org>
 <20150303205032.GF3892@piout.net>
 <20150304085242.GA24471@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150304085242.GA24471@frolo.macqel>
List-ID: <rtc-linux.googlegroups.com>

On 04/03/2015 at 09:52:42 +0100, Philippe De Muyter wrote :
> > > And is the naming in Philippe's driver appropriate?  If it supports the
> > > AB1801 (for example) then why is it described as an "abx805" driver?
> > 
> > The real naming is in the form ABx8yz. With:
> > 
> > x: 0 or 1, indicate the presence of the reset management
> > y: 0 or 1: 0 is i2c, 1 is spi
> > z: [1-5]: different amount of on chip SRAM. From what I understand, only
> > ABx8y5 are actually recommended for new designs.
> 
> My driver is based on the datashet called 'AB18X5 Real-Time Clock with
> Power Management Family', which calls the parts 'AB18X5 family' with X
> being '0' for I2c parts and '1' for SPI parts.
> 
> As the part I have and the driver I wrote are I2C, not SPI, I fixed the
> 'X' as 0 in the name of the driver.
> 
> The datasheet lists only one part as being 'software and pin compatible'
> with the 'AB1805': the 'AB0805', hence the 'x' in the name I choose : abx805.
> 

The "AB08XX Real-Time Clock Family" document states that they are all
software and pin compatible (including the AB18xx).

> Actually, my driver is used in production and works fine, because the
> default(reset) value of the 12/24 mode bit is '24 hour mode' and the
> default value of the 'write RTC bit' enables writing.  There is
> no real need to play with them.
> 

I know this is unlikely to happen but what if someone messes with the
RTC in the bootloader?

> > 
> > What I like in Philippe's driver is the info printed at probe time and
> > the support for trickle charging. However, I wouldn't enable it
> > unconditionally.
> 
> My hardware colleagues told me that the only way to enable the 'ultra low-power'
> functionality is enabling the trickle charger.  And the 'ultra low-power'
> functionality is the reason we choose that chip, so I would at least
> keep that as the default behaviour.
> 

My concern is that you have a static configuration. I would expose a
sysfs interface to configure the diode, resistor and enable/disable the
trickle charger. Would that work for you?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
