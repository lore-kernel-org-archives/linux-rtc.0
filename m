Return-Path: <rtc-linux+bncBDQ2L75W5QGBBRWXQO4QKGQE3MN7XTQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id vo1si776139pab.2.2016.04.27.09.41.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Apr 2016 09:41:41 -0700 (PDT)
Date: Wed, 27 Apr 2016 17:41:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Wadim Egorov <w.egorov@phytec.de>, linux-rockchip@lists.infradead.org,
	mark.rutland@arm.com, devicetree@vger.kernel.org,
	a.zummo@towertech.it, pawel.moll@arm.com,
	rtc-linux@googlegroups.com, ijc+devicetree@hellion.org.uk,
	mturquette@baylibre.com, sboyd@codeaurora.org,
	linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	lgirdwood@gmail.com, alexandre.belloni@free-electrons.com,
	dianders@chromium.org, galak@codeaurora.org, zyw@rock-chips.com,
	lee.jones@linaro.org, linux-clk@vger.kernel.org
Message-ID: <20160427164114.GD3217@sirena.org.uk>
References: <E1aukkg-0007km-6s@debutante>
 <57205DC2.7070506@phytec.de>
 <20160427135048.GQ3217@sirena.org.uk>
 <13413437.Ipf2eOczfj@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A5Bs66j+yxxuoNFj"
In-Reply-To: <13413437.Ipf2eOczfj@diego>
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

--A5Bs66j+yxxuoNFj
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2016 at 03:56:56PM +0200, Heiko St=C3=BCbner wrote:
> Am Mittwoch, 27. April 2016, 14:50:48 schrieb Mark Brown:

> > Any ETA on a fix or should I revert?

> I guess
> 	[PATCH v4 1/7] regulator: rk808: Add rk808_reg_ops_ranges for LDO3
> from yesterday [0] might be the fix? At least it fits Wadim's description=
 above=20
> but I haven't had time to test it yet.

Oh, probably yeah.  It's easier if fixes are pulled out of serieses.

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

--A5Bs66j+yxxuoNFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIOupAAoJECTWi3JdVIfQ1ggH/jyCbSBG8TE/QrmwRhZYcSQz
K7uuKzfMUzBYn/TEXRrgE6sJdIb661aYpiGP9if/M3q98vytdidRcrZo8xkrXZpW
cXVRPHMSKi2kuit39nF2sSyVwtaWcoyicyLm/WhzaRYG6mRHespMixK4syf4Gu5z
ODwmOn5JzoGzdM+pwwx0yY6b1+xLnLP5tTdPlkSvCH9rHkk82MtAh3pKtg0hCcCh
kJN3a8x13ZU74qUK11opGcvP2TZ+0Gf5uX/UdmK5k7mfFs7UFGewdDx63tSwKu7L
QAHkmXcg5Xpwe38FCoglKe7DjrXjOBJACRi2UIHwvqFJiatnssYLFusXsWOk7MU=
=1PPO
-----END PGP SIGNATURE-----

--A5Bs66j+yxxuoNFj--
