Return-Path: <rtc-linux+bncBDQ2L75W5QGBBN7F3G2AKGQETJBDQTQ@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id 190si230297pfb.1.2016.01.13.07.52.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Jan 2016 07:52:23 -0800 (PST)
Date: Wed, 13 Jan 2016 15:51:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Message-ID: <20160113155154.GN6588@sirena.org.uk>
References: <5695A854.60108@samsung.com>
 <5696378B.6070704@nvidia.com>
 <20160113115736.GJ6588@sirena.org.uk>
 <56963D8D.9060908@nvidia.com>
 <20160113123133.GK6588@sirena.org.uk>
 <5696451F.3000707@nvidia.com>
 <20160113130909.GL6588@sirena.org.uk>
 <56964CEF.3030900@nvidia.com>
 <20160113142023.GM6588@sirena.org.uk>
 <56966242.4080601@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wCvMePosDEf3szVw"
In-Reply-To: <56966242.4080601@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V2 6/6] regulator: max77620: add regulator
 driver for max77620/max20024
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--wCvMePosDEf3szVw
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Jan 13, 2016 at 08:12:10PM +0530, Laxman Dewangan wrote:
> On Wednesday 13 January 2016 07:50 PM, Mark Brown wrote:
> >On Wed, Jan 13, 2016 at 06:41:11PM +0530, Laxman Dewangan wrote:
> >>On Wednesday 13 January 2016 06:39 PM, Mark Brown wrote:

> >>>What is "it" and why can't we check what the current configuration is
> >>>while setting FPS to NONE?

> >>I will have platform specific data in callback of enable/disable only.
> >>Which call back do I need to set this? enable/disable or post register?

> >I'm sorry but I can't parse what you're saying here.

> Here, before machine constraint applies, I need to configure FPS on desired
> source.

I'm a bit confused here - I had thought you needed things the other way
around?  Can you describe in concrete terms what you want to configure?

> >>>>I need to set the FPS src properly for each rails before callback happen
> >>>>from regulator init so that enable/disable/is_enable can handle it properly.

> >>>Why not just reorder the callback so it happens before the constraints
> >>>are applied?

> >>which callback I need to reorder for getting the context for configruation?
> >The existing call to parse the DT.

> Are we allow to do i2c transfer in the existing callback for parsing the DT?

Yes, of course.

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--wCvMePosDEf3szVw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWlnKZAAoJECTWi3JdVIfQuTAH/2xoPMUPjm/TIKnibYdD8Pas
DVtt7ufLP8+4/52m2te6EEtgHl1lFsqoTtvNyUMORjeY9Uv5aWXubNXFy2Je1vnr
xplbYaIWV6tVzuFsfQABE000P3HEarIxWvvZImRQ187g0VDjDmsLbI7XrzIDJofd
EdBeuCecL12RH1tOeQBUtagsZaWvMd1UWspmVUjmLp8MlrLVndHz6ZmkEIk17xdl
6SIya8u8IFyB3+URQ9aRwiSH5CE0Rsm7kRT/PThbXWwfnnMSCUZimi7/6mHqvrFO
OZS70XvOR+1n/ekkdPrd6YSWSsYenlfGy5H42muCLmw1VEbXdEK/uBHhoyG6D4k=
=rJk0
-----END PGP SIGNATURE-----

--wCvMePosDEf3szVw--
