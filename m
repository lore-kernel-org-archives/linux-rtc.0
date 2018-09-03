Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47534 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeICSBe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 3 Sep 2018 14:01:34 -0400
Date: Mon, 3 Sep 2018 14:41:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Tony Xie <tony.xie@rock-chips.com>
Cc: heiko@sntech.de, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v4 2/5] regulator: rk808: add RK809 and RK817 support.
Message-ID: <20180903134101.GK10302@sirena.org.uk>
References: <1535968829-19418-1-git-send-email-tony.xie@rock-chips.com>
 <1535968829-19418-3-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQ77YLfPrO/qF/pM"
In-Reply-To: <1535968829-19418-3-git-send-email-tony.xie@rock-chips.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


--LQ77YLfPrO/qF/pM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 06:00:26PM +0800, Tony Xie wrote:

>     Add support for the rk809 and rk817 regulator driver.
>     Their specifications are as follows=EF=BC=9A
>     1. The RK809 and RK809 consist of 5 DCDCs, 9 LDOs
>        and have the same registers for these components except dcdc5.
>     2. The dcdc5 is a boost dcdc for RK817 and is a buck for RK809.
>     3. The RK817 has one switch but The Rk809 has two.
>=20
>     The output voltages are configurable and are meant to supply power
>     to the main processor and other components.

Acked-by: Mark Brown <broonie@kernel.org>

--LQ77YLfPrO/qF/pM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNOewACgkQJNaLcl1U
h9ADqAf/ZUW93wVRWWiEtL3ZAFgbG3LHT8YSwyDBGPd7zduqbrKn2VqLjdPMXVy/
aYXWD9347vawBVYwgds0Gu9/tHUNjZSfcyGDc0PVffN8Qy2iXFJmw8jK7skkchwx
KbgUcTUz0fD1489R6VPhsUvFxLIdayLi+Qcvy8w0Tthf+8BGoM90QRirGGoLq9Tv
z23z31c4TtsIrn9dMKRi8boRrTYRR+XXJqY+nNxg/Ft/Jr6aUUrjDKb8zT6G/wt5
gzoCGbQHitXeTLubD9X+9FSFG+6/i2skIt6Wlo6TS7KDRGhwU4woQYjsmEJVtCtV
R9ioVbUHtpfsp0dAS97EDfhC1uttig==
=xh3s
-----END PGP SIGNATURE-----

--LQ77YLfPrO/qF/pM--
