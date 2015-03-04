Date: Wed, 4 Mar 2015 11:38:14 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Philippe De Muyter <phdm@macqel.be>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH v2] rtc: add Abracon ABx80x driver
Message-ID: <20150304103814.GE3989@piout.net>
References: <1425205635-3587-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150302155337.7876cfb631552427187c4c0a@linux-foundation.org>
 <20150303011116.GW4094@piout.net>
 <20150303122012.177eee47ba703bd73780b741@linux-foundation.org>
 <20150303205032.GF3892@piout.net>
 <20150304085242.GA24471@frolo.macqel>
 <20150304090601.GC3989@piout.net>
 <20150304095556.GA790@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150304095556.GA790@frolo.macqel>
List-ID: <rtc-linux.googlegroups.com>

On 04/03/2015 at 10:55:56 +0100, Philippe De Muyter wrote :
> > The "AB08XX Real-Time Clock Family" document states that they are all
> > software and pin compatible (including the AB18xx).
> 
> Which part(s) do you really have ?  Mine is a 1805.  Do all the parts have
> the trickle charger ?  As I don't know, I prefer not to pretend that the
> driver supports those chips.
> 

I have the AB0805. The trickle charger is not available on ABx8x1 and
ABx8x3.

> > > My hardware colleagues told me that the only way to enable the 'ultra low-power'
> > > functionality is enabling the trickle charger.  And the 'ultra low-power'
> > > functionality is the reason we choose that chip, so I would at least
> > > keep that as the default behaviour.
> > > 
> > 
> > My concern is that you have a static configuration. I would expose a
> > sysfs interface to configure the diode, resistor and enable/disable the
> > trickle charger. Would that work for you?
> 
> I think a 'of_xxx' dts/dtb description is the way to go, but I did not want to
> introduce unnecessaty complexity without knowing other usages.  My hardware
> colleagues followed the recommended design from Abracon.
> 

Yeah, I'm not sure about the DT description, some may argue this is
configuration. But I guess it actually depends on the battery you are
using so that could count as hardware description.

I'll use:
 abracon,tc-diode = "(standard|schottky)"
 abracon,tc-resistor = <(0|3|6|11)>

If both are defined and valid, I'll enable the trickle charger with the
provided configuration in probe().

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
