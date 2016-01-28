Return-Path: <rtc-linux+bncBDQ2L75W5QGBBLOIVK2QKGQE4KHQPNA@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id r2si1799929pfr.0.2016.01.28.15.28.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jan 2016 15:28:45 -0800 (PST)
Date: Fri, 29 Jan 2016 00:28:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
	k.kozlowski@samsung.com
Message-ID: <20160128232817.GH4130@sirena.org.uk>
References: <1453988274-28052-1-git-send-email-ldewangan@nvidia.com>
 <1453988274-28052-8-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2oox5VnwalALFvA7"
In-Reply-To: <1453988274-28052-8-git-send-email-ldewangan@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V6 7/8] DT: regulator: add DT binding doc for
 regulator of PMIC max77620/max20024
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--2oox5VnwalALFvA7
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Jan 28, 2016 at 07:07:53PM +0530, Laxman Dewangan wrote:
> Maxim Semiconductor's PMIC MAX77620/MAX20024 has multiple
> DCDCs and LDOs.

Please use subject lines matching the style for the subsystem.  I'm
fairly sure I've mentioned this before and really if your subject lines
don't visually resemble anything else in the directory that ought to be
a warning sign.

> +- maxim,disable-active-discharge:    boolean, Disable active discharge.

That's something I've seen other regulators do, can we make it a
standard property with an op?

> +max77620@3c {
> +	regulators {
> +		in-ldo0-1-supply = <&max77620_sd2>;
> +		in-ldo7-8-supply = <&max77620_sd2>;

I'd expect any supplies for the device to be at the device level,
including supplies used by regulators.

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

--2oox5VnwalALFvA7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqqQQAAoJECTWi3JdVIfQ7wQIAIYk6ZkTOPNOCsbPz8ruY17f
hTnw2UWK1JXkW8rcR0d//LER/ATrYfF6bv+CjwUf8DYUVx2UD/o6WQKH67cItf/p
rDJEpFOXedtBBO2sLVm+nzbjJwSuya1aM4lAJ0hmv8Nq0s0DwYDd95pp2vai807j
XEUg9M4+uX4aTzN15bDPyPDKfu36zs5NF+MZ3bTwIuwwpDihpfYPt/F1P54J2m31
OuxyRi3992+hMj9I2F3JMB7nG1fXO3vX02xcX4cUwYXffaJgJ8aAwk5OX25WDnBM
u2KIo09vfKyRKWD6GyuIbWiAVbtNqQSy9xK3J9gM6YqWb4eDK+kmuziJtH+QToA=
=S+ho
-----END PGP SIGNATURE-----

--2oox5VnwalALFvA7--
