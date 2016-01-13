Return-Path: <rtc-linux+bncBDQ2L75W5QGBBP4H3G2AKGQE5D3WNHQ@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id dz2si117575pab.1.2016.01.13.04.31.59
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Jan 2016 04:31:59 -0800 (PST)
Date: Wed, 13 Jan 2016 12:31:33 +0000
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
Message-ID: <20160113123133.GK6588@sirena.org.uk>
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com>
 <1452590273-16421-7-git-send-email-ldewangan@nvidia.com>
 <5695A854.60108@samsung.com>
 <5696378B.6070704@nvidia.com>
 <20160113115736.GJ6588@sirena.org.uk>
 <56963D8D.9060908@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AC4h36899OtEuhrO"
In-Reply-To: <56963D8D.9060908@nvidia.com>
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

--AC4h36899OtEuhrO
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Jan 13, 2016 at 05:35:33PM +0530, Laxman Dewangan wrote:
> On Wednesday 13 January 2016 05:27 PM, Mark Brown wrote:

> >>Something below. This will do the pre configuration before
> >>regulator_register happena dn machine constraint sets.
> >>I can not use the init_data->regulator_init() as I need to have the init
> >>data passed to the driver.

> >Why do you have this requirement?

> This is require to
> - configure FPS_SRC based on platform data for each rail,
>     - If FPS_SRC enabled then enable it always.
>     - If FPS_SRC is disabled (NONE) then based on init data constraint,
>       set it to desired state.

What is FPS_SRC and why is it set from init_data?  A driver should never
be looking at init_data.

> - Power mode and slew rate init based on default configuration from the
> register if platform does not want to set it.

Same here, why is init_data needed here?

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

--AC4h36899OtEuhrO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWlkOlAAoJECTWi3JdVIfQsmcH/A2kZO2AMtyRc04tc5ijA0kJ
q0+Ky136KnvM4WjRCQu7dJZ2SvUK92m2E50KBdQ8fZOvn5lAc5dVelriuxjgzw8Z
1X7CabcprWF7g3Y+TPg5X+V5Sej4qZqPWoVncaE1eBkkijAJbW4eK++VqY9HQihT
9R4jdK3GmxyPuXRY2fU4+9HDMN3DmSWOXo86m2e/gPNQ7BXk0Z+D/5bjOry/yv6h
5up9LTCoRiEd880F3UDziwwqA7HERmFmK7eDz3lLi8fzdepAi/c3JwxEegfxnDTt
u5WIpL3CHy5HjbV+7XkKx3mnLi+wHAA/9aI/F9s4TGyaAfCml771C5zYDHIq1U0=
=5pwb
-----END PGP SIGNATURE-----

--AC4h36899OtEuhrO--
