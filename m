Return-Path: <rtc-linux+bncBDZKLXNI4ACBBJ5UVHFAKGQEONWLALI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz. [195.113.26.193])
        by gmr-mx.google.com with ESMTPS id 140si4850145wmr.2.2017.06.21.04.36.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jun 2017 04:36:07 -0700 (PDT)
Date: Wed, 21 Jun 2017 08:34:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Baruch Siach <baruch@tkos.co.il>,
	"patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	"x86@kernel.org" <x86@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Len Brown <len.brown@intel.com>,
	"linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
	Jason Cooper <jason@lakedaemon.net>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	John Stultz <john.stultz@linaro.org>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Barry Song <baohua@kernel.org>,
	Support Opensource <Support.Opensource@diasemi.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH 00/51] rtc: stop using rtc deprecated functions
Message-ID: <20170621063443.GA4862@localhost>
References: <20170620213507.urobmtg34vzubrdq@piout.net>
 <alpine.DEB.2.20.1706202343120.2157@nanos>
 <20170621075152.GA15996@amd>
 <20170621083907.y3gadsmsoufa5niv@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170621083907.y3gadsmsoufa5niv@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi!

> > > > I think tglx had a plan for offsetting the time at some point so 32-bit
> > > > platform can pass 2038 properly.
> > > 
> > > Yes, but there are still quite some issues to solve there:
> > > 
> > >      1) How do you tell the system that it should apply the offset in the
> > >      	first place, i.e at boot time before NTP or any other mechanism can
> > >      	correct it?
> > 
> > I'd not do offset. Instead, I'd select a threshold (perhaps year of
> > release of given kernel?) and
> > 
> > 	if (rtc_time < year_of_release_of_kernel)
> > 	   rtc_time += 0x100000000;
> > 
> > Ok, we'll have to move away from "rtc_time == 0 indicates zero", as
> > seen in some drivers.
> > 
> > >      2) Deal with creative vendors who have their own idea about the 'start
> > >      	of the epoch'
> > 
> > If someone uses different threshold, well, there will be
> > confusion. But only for users that have their rtc set to the past,
> > which is quite unusual.
> > 
> 
> Or not, having an RTC set in the past is actually quite common. I'd find
> it weird to have a new device boot and be set to a date in the future.

...but still better than board stuck in the past, no?

> Also note that the threshold or offset thing may seem like a good idea
> but fails with many RTCs because of how they handle leap years.

Well, you can still convert time from rtc to unix time, then do adjustment
there.

Anyway, I guess it would be cool for rtc drivers to annotate what limits
underlying storage has to the common code, so that we can do fixups once
per class, not once per driver.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
