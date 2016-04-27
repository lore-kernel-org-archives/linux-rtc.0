Return-Path: <rtc-linux+bncBDQ2L75W5QGBBXEHQO4QKGQE64QUWTI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id ph3si1053393pac.1.2016.04.27.06.51.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Apr 2016 06:51:23 -0700 (PDT)
Date: Wed, 27 Apr 2016 14:50:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org, mark.rutland@arm.com,
	devicetree@vger.kernel.org, a.zummo@towertech.it,
	pawel.moll@arm.com, rtc-linux@googlegroups.com,
	ijc+devicetree@hellion.org.uk, mturquette@baylibre.com,
	sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, lgirdwood@gmail.com,
	alexandre.belloni@free-electrons.com, dianders@chromium.org,
	galak@codeaurora.org, zyw@rock-chips.com, lee.jones@linaro.org,
	linux-clk@vger.kernel.org
Message-ID: <20160427135048.GQ3217@sirena.org.uk>
References: <E1aukkg-0007km-6s@debutante>
 <2754883.PYP7KbpM33@diego>
 <57205DC2.7070506@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lC5mtDCkBY9vM1au"
In-Reply-To: <57205DC2.7070506@phytec.de>
Subject: [rtc-linux] Re: Applied "regulator: rk808: remove linear range
 definitions with a single range" to the regulator tree
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--lC5mtDCkBY9vM1au
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2016 at 08:35:46AM +0200, Wadim Egorov wrote:
> On 26.04.2016 21:33, Heiko St=C3=BCbner wrote:

> > with this patch applied, 4.6.0-rc5-next-20160426 fails to boot on=20
> > rk3288-veyron devices with the bug below. Reverting this one patch
> > results in the system booting again:

> This is because I missed to add the correct ops for LDO_REG3 in this patc=
h.

Any ETA on a fix or should I revert?

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--lC5mtDCkBY9vM1au
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIMO3AAoJECTWi3JdVIfQP58H/RIYe7XJNA5kA1cOquaaWbau
mPhq2KRpFNvY3jYlkmYkJ4kIDJogO1Ma0XjzCYqijsWQSDTRCoJGKX7cWpoWgNai
FJ8xeSP2aY6ma9Slc61DTFhg0XcPaj7DdORfwb9eMCnSa2anMcba7L14kpfV7JSN
tdxN/xe6xACfrs0P60m0CaIrPXxyfHY3Yr8tu1qOxE/IeOmVVDockzXT9pbiWui4
mftziiHYq0Gm1W6V4JcPw24h89rMyTyY2R5qPiqz0ASODqg76W/Ap/wlJ7lSzGKS
I5/hkegCu81rl4MWRNJ+HVe+9XPILq+289VcEgLULRPE76q18aXuofsDHShXHvE=
=eQgw
-----END PGP SIGNATURE-----

--lC5mtDCkBY9vM1au--
