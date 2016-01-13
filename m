Return-Path: <rtc-linux+bncBDQ2L75W5QGBBEUZ3G2AKGQENFRCFZQ@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id jj4si109062pac.2.2016.01.13.05.09.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Jan 2016 05:09:38 -0800 (PST)
Date: Wed, 13 Jan 2016 13:09:09 +0000
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
Message-ID: <20160113130909.GL6588@sirena.org.uk>
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com>
 <1452590273-16421-7-git-send-email-ldewangan@nvidia.com>
 <5695A854.60108@samsung.com>
 <5696378B.6070704@nvidia.com>
 <20160113115736.GJ6588@sirena.org.uk>
 <56963D8D.9060908@nvidia.com>
 <20160113123133.GK6588@sirena.org.uk>
 <5696451F.3000707@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GWLvvOwKrQC9aCO6"
In-Reply-To: <5696451F.3000707@nvidia.com>
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

--GWLvvOwKrQC9aCO6
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Jan 13, 2016 at 06:07:51PM +0530, Laxman Dewangan wrote:
> On Wednesday 13 January 2016 06:01 PM, Mark Brown wrote:

> >What is FPS_SRC and why is it set from init_data?  A driver should never
> >be looking at init_data.

> When FPS_SRC is set to NONE (this is needed from platform data) then based
> on constraint like boot enable/always enable, it need to be on desired
> state. Otherwise we may endup with disabling the rail when setting to NONE
> and create issue.

What is "it" and why can't we check what the current configuration is
while setting FPS to NONE?

> I need to set the FPS src properly for each rails before callback happen
> from regulator init so that enable/disable/is_enable can handle it properly.

Why not just reorder the callback so it happens before the constraints
are applied?

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

--GWLvvOwKrQC9aCO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWlkx0AAoJECTWi3JdVIfQH50H/2fuJLY76kSR7ePDsn6wPrIE
5srOQ0u5g8LLfdwt21pyjUHao8j/npEfiXpgYr6chcezHqYYtP5CEC7UDud8rmUa
CHmGucFHTytYS7W0d8XNdbONIcxUOtXN2Bui+SYvpONb2OUFe8elh8TW/hmz/NIo
iiWkRrnFLUc+Uf7dZw9RMsu0NXBU2VXqeCY1BN1fY7Sif/eWBf+YP4mpEdFj5l9+
ebmdPCrILWRDrzsEUrCuo0o2+saJaIWzGHv7gwOBu02Dh07zPVr+57fuAHdiBQmn
worPox87muri8Rq5sSENdP9mMa4dOsBf9FuZTNsVFRWVH6BkyFDNWsBvz4f1Cwo=
=MLnx
-----END PGP SIGNATURE-----

--GWLvvOwKrQC9aCO6--
