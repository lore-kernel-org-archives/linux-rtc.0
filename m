Return-Path: <rtc-linux+bncBDQ2L75W5QGBBUHX3C2AKGQEZZ4HJMI@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id dz2si103160pab.1.2016.01.13.03.58.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Jan 2016 03:58:08 -0800 (PST)
Date: Wed, 13 Jan 2016 11:57:36 +0000
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
Message-ID: <20160113115736.GJ6588@sirena.org.uk>
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com>
 <1452590273-16421-7-git-send-email-ldewangan@nvidia.com>
 <5695A854.60108@samsung.com>
 <5696378B.6070704@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y23ShSVTng6i3e6h"
In-Reply-To: <5696378B.6070704@nvidia.com>
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

--y23ShSVTng6i3e6h
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Jan 13, 2016 at 05:09:55PM +0530, Laxman Dewangan wrote:

> Yaah, this is something new and I think Mark also wanted to do this cleanup
> on his comment. I did not understand it previously. Looks cool now.

I did, please don't just ignore review comments.

> However, I have requirement to configure PMIC with some inital setting based
> on init_data (parsed) before regulator registration happened. Once I move to
> this new mecahinsm, the inti_data parsing and regulator init happen in the
> same function. So I need to have one callback from regulator_register to
> driver.
> Something below. This will do the pre configuration before
> regulator_register happena dn machine constraint sets.

> I can not use the init_data->regulator_init() as I need to have the init
> data passed to the driver.

Why do you have this requirement?

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

--y23ShSVTng6i3e6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWljuvAAoJECTWi3JdVIfQ8wgH/1cr0ePAjPu5Hqbfs3MHF++o
yPxHIje7M4w3vA1WPCTVBAYrzy9HAM63VdMNph3w4K82TLArajbY+zzz3VRs9+/+
QUAqyPrMEZ5+r/mg66MPwLVLfyoYvBmv0w93AP64Ik/9a8NmLN4usmzJIdfJAGl1
wcYNQG/V2lTvRcJ/ypUZX3mEVQo34Sb+b5BkBU+ViugQ7jO87aAsvc3dGT0Srpsd
iYujuh74ZJZp//936UEKBFj/5m0sG6w0cLZ/o2MVO8Uk1kRQWYJEvomcJte/yEZM
oC0V65tUXqBWdKwVEVvQ6jGHzbwQkgTe38GElzbqR/Gbj03RjRkZJWrYSKOEMxY=
=nZQW
-----END PGP SIGNATURE-----

--y23ShSVTng6i3e6h--
