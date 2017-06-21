Return-Path: <rtc-linux+bncBDZKLXNI4ACBBGOLVDFAKGQERASD3ZI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz. [195.113.26.193])
        by gmr-mx.google.com with ESMTPS id s76si4554502wma.1.2017.06.21.00.51.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jun 2017 00:51:53 -0700 (PDT)
Date: Wed, 21 Jun 2017 09:51:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
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
Message-ID: <20170621075152.GA15996@amd>
References: <20170620213507.urobmtg34vzubrdq@piout.net>
 <alpine.DEB.2.20.1706202343120.2157@nanos>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
In-Reply-To: <alpine.DEB.2.20.1706202343120.2157@nanos>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

Hi!

> > I agree with that but not the android guys. They seem to mandate an RTC
> > that can store time from 01/01/1970. I don't know much more than that
> > because they never cared to explain why that was actually necessary
> > (apart from a laconic "this will result in a bad user experience")
> > 
> > I think tglx had a plan for offsetting the time at some point so 32-bit
> > platform can pass 2038 properly.
> 
> Yes, but there are still quite some issues to solve there:
> 
>      1) How do you tell the system that it should apply the offset in the
>      	first place, i.e at boot time before NTP or any other mechanism can
>      	correct it?

I'd not do offset. Instead, I'd select a threshold (perhaps year of
release of given kernel?) and

	if (rtc_time < year_of_release_of_kernel)
	   rtc_time += 0x100000000;

Ok, we'll have to move away from "rtc_time == 0 indicates zero", as
seen in some drivers.

>      2) Deal with creative vendors who have their own idea about the 'start
>      	of the epoch'

If someone uses different threshold, well, there will be
confusion. But only for users that have their rtc set to the past,
which is quite unusual.

									Pavel
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

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllKJZgACgkQMOfwapXb+vKcSACeKjx9YgZ8vE/6kkH+mZDPeoMx
BPIAnRnqcPYJuL+92glv1bkWRQ7bPmio
=FHDU
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
