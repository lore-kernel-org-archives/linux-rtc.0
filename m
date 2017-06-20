Return-Path: <rtc-linux+bncBDZKLXNI4ACBBRVZU3FAKGQE6MKYZEI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz. [195.113.26.193])
        by gmr-mx.google.com with ESMTPS id s76si4286416wma.1.2017.06.20.15.08.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 15:08:06 -0700 (PDT)
Date: Wed, 21 Jun 2017 00:08:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	"linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
	"adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ingo Molnar <mingo@redhat.com>, Jason Cooper <jason@lakedaemon.net>,
	John Stultz <john.stultz@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Michael Chan <michael.chan@broadcom.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Support Opensource <Support.Opensource@diasemi.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Barry Song <baohua@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 00/51] rtc: stop using rtc deprecated functions
Message-ID: <20170620220805.GA11195@amd>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <20170620100348.zh4ygvjjgnhxvmvl@piout.net>
 <20170620121011.GA13221@amd>
 <20170620122400.sm7qqvwyj6cuzarw@piout.net>
 <20170620132620.GA16881@amd>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD96FCD@SW-EX-MBX02.diasemi.com>
 <20170620134458.GA10104@amd>
 <20170620134827.ubvzhh25klaotupv@piout.net>
 <CA+M3ks68+z6nDtYM8CDpso7SxjB6Nt5E=rOc1yxx=kDz6PUeVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
In-Reply-To: <CA+M3ks68+z6nDtYM8CDpso7SxjB6Nt5E=rOc1yxx=kDz6PUeVQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

Hi!

> >> > This is it.
> >> > https://patchwork.kernel.org/patch/6219401/
> >>
> >> Thanks.
> >>
> >> Yes, that's argument against changing rtc _drivers_ for hardware that
> >> can not do better than 32bit. For generic code (such as 44/51 sysfs,
> >> 51/51 suspend test), the change still makes sense.
> 
> What I had in mind when writing those patches was to remove the limitations
> coming from those functions usage, even more since they been marked has
> deprecated.
> 
> I agree that will change nothing of hardware limitation but at least
> the limit will
> not come from the framework.

> > Yes, we agree on that but I won't cherry pick working patches from a 51
> > patches series.

Well, it would be actually nice for you to do the cherry
picking. That's something maintainers do, because it is hard for
contributors to guess maintainer's taste.

Anyway, it looks like someone should go through all the RTC drivers,
and document their limitations of each driver (date in future when
hardware ceases to be useful). If Benjamin has time to do that, I
guess that removes all the objections to the series.

Regards,
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

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllJnMUACgkQMOfwapXb+vIDOQCfQnx1NT5fMvO6eGcya2neg3Lo
GpwAnjYOvRGs1DnaiYvc81U6VGXY+VxJ
=OI7P
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
