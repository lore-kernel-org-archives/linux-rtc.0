Return-Path: <rtc-linux+bncBDQ2L75W5QGBB2VG2S4AKGQENSNANQY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id d22si2709526pfd.0.2016.04.18.10.03.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Apr 2016 10:03:38 -0700 (PDT)
Date: Mon, 18 Apr 2016 18:03:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, mturquette@baylibre.com,
	sboyd@codeaurora.org, lee.jones@linaro.org, lgirdwood@gmail.com,
	a.zummo@towertech.it, dianders@chromium.org, zyw@rock-chips.com,
	arnd@arndb.de, k.kozlowski@samsung.com, javier@osg.samsung.com,
	kgene@kernel.org, olof@lixom.net, geert+renesas@glider.be,
	sjoerd.simons@collabora.co.uk, treding@nvidia.com,
	public_timo.s@silentcreek.de
Message-ID: <20160418170311.GK3217@sirena.org.uk>
References: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
 <1460711790-22646-4-git-send-email-w.egorov@phytec.de>
 <20160415102602.GE3217@sirena.org.uk>
 <20160415162406.GD25196@piout.net>
 <57148C05.4090900@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3NJww9yp20AXRsxZ"
In-Reply-To: <57148C05.4090900@phytec.de>
Subject: [rtc-linux] Re: [PATCH 3/6] regulator: rk808: Make rk808 generic,
 rename rk808-regulator.c
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--3NJww9yp20AXRsxZ
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Apr 18, 2016 at 09:25:57AM +0200, Wadim Egorov wrote:

> It seems this topic has been already discussed here [1].
> So the right solution is just to rename the rk808 struct in rk808.h,
> don't touch the driver names and config options and naming the
> additional RK818 PMIC in the Kconfig?

Something like that, yes.  If it's really useful for clarification some
renaming of code might be useful.

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

--3NJww9yp20AXRsxZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFRNMAAoJECTWi3JdVIfQ9ucH/2UcY+YmZyUcGyDgMIayC9dd
ua6QDXSgx1W/VNkI+ddPNUHgaIjG4uor6mhhRIE7ltFkVWcyoCqzhnArzPP6GYAX
WXTLm5BetM6vv2gnJXXnUmFWG9TlXa+7uTbR7QdANPdP1Qk3URHecS0O4W8gNyoI
0pA/4ndRrs9q2Gq23W+810jCyl/M26uO7f6xdRir8hugCJWnJgXzQ2VWI55uhRXR
r5Z3wqhnhIPmu0W9y3r0yfND7Fw0NiJOL+lzXNVH1gJYK0zK9JKtrrqAR1tD+7Eh
pv4G1G9N7NnreQcwC3ijQ9UFVyXQ74dGEUL3EGT+7DvmYIVcGVFqbRQAmD/Uvjg=
=/lfo
-----END PGP SIGNATURE-----

--3NJww9yp20AXRsxZ--
