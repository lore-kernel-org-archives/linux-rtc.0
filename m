Return-Path: <rtc-linux+bncBDQ2L75W5QGBBRV23G2AKGQEH46AYKQ@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id jj4si145652pac.2.2016.01.13.06.20.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Jan 2016 06:20:54 -0800 (PST)
Date: Wed, 13 Jan 2016 14:20:23 +0000
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
Message-ID: <20160113142023.GM6588@sirena.org.uk>
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com>
 <1452590273-16421-7-git-send-email-ldewangan@nvidia.com>
 <5695A854.60108@samsung.com>
 <5696378B.6070704@nvidia.com>
 <20160113115736.GJ6588@sirena.org.uk>
 <56963D8D.9060908@nvidia.com>
 <20160113123133.GK6588@sirena.org.uk>
 <5696451F.3000707@nvidia.com>
 <20160113130909.GL6588@sirena.org.uk>
 <56964CEF.3030900@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pU61X8j5lbVWa/m1"
In-Reply-To: <56964CEF.3030900@nvidia.com>
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

--pU61X8j5lbVWa/m1
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Jan 13, 2016 at 06:41:11PM +0530, Laxman Dewangan wrote:
> On Wednesday 13 January 2016 06:39 PM, Mark Brown wrote:

> >What is "it" and why can't we check what the current configuration is
> >while setting FPS to NONE?

> I will have platform specific data in callback of enable/disable only.
> Which call back do I need to set this? enable/disable or post register?

I'm sorry but I can't parse what you're saying here.

> >>I need to set the FPS src properly for each rails before callback happen
> >>from regulator init so that enable/disable/is_enable can handle it properly.

> >Why not just reorder the callback so it happens before the constraints
> >are applied?

> which callback I need to reorder for getting the context for configruation?

The existing call to parse the DT.

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

--pU61X8j5lbVWa/m1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWll0mAAoJECTWi3JdVIfQsukH/R+a9s1tTmf+1hQNVfXuJJ69
62Zs2B+zrBEa5Cp+NcaeXbM6RJT4zjzjBsen0c+qV4ebDWPdIjNGJus1sCKgKxF1
Uc5gU07Ht63Fved3Zp2RN19ZOKFih0PcoIZT/sN9eEpkFicoA45pEQhJuf8UDCry
EbCQyxrE+Io0DJCWkE02bu1lAUI09XwvZiW9WUPIQOttgLyzWh5KSeG1Wnf14JZ1
ETqIRllKLvcNOUdnIrXizckHC47hDKIeVT6FmcQrR92gXhLLiLH/cGU8oda2odnt
M0JgviMMTTnLWJemVPa/hAPUzjuy26m5KBCEcmh61QvavUwIkbHHwivzU3BVGWY=
=5Hxz
-----END PGP SIGNATURE-----

--pU61X8j5lbVWa/m1--
