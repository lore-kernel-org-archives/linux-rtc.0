Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60256 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbeHALKV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 1 Aug 2018 07:10:21 -0400
Date: Wed, 1 Aug 2018 10:25:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Tony Xie <tony.xie@rock-chips.com>
Cc: heiko@sntech.de, lee.jones@linaro.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v2 2/5] regulator: rk808: add RK809 and RK817 support.
Message-ID: <20180801092512.GA5509@sirena.org.uk>
References: <1533023850-29004-1-git-send-email-tony.xie@rock-chips.com>
 <1533023850-29004-3-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
In-Reply-To: <1533023850-29004-3-git-send-email-tony.xie@rock-chips.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 03:57:27PM +0800, Tony Xie wrote:

> +	default:
> +		pr_warn("%s ramp_delay: %d not supported, setting 10000\n",
> +			rdev->desc->name, ramp_delay);
> +	}

This looks mostly good but I notice that most of the prints in the
driver are pr_ rather than dev_ ones - using dev_ is better as it allows
people to see which device was affected.

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlthfHcACgkQJNaLcl1U
h9C8Igf/dgHh7kVnRuWvWyT7b/+8mMS+HNtVuTBMtiUf5textB9vCDqH+oOZoZE/
2PEPQccsJdhF2tkxfuArUQtY8lxO7BQFu3HFxD70ROweX9CfuvfnJBVDAw094Wx6
Z4G8HLLp0WqLiqSdGvASehN8jspMmWRkV4ucf6ED/yUjGKZMUf3ow7cwgfg2e6S/
It4Yp/5Z4QrXpQchKhRWYvJZ6xAbtGevKaEvjBWegj7L9vFJTZn1uSJJeDrrnste
b0I0q4MUN6cfgQwYFK8JeBLvJWkmAC4bBQYv0ulDzboDtRB5VcP6WnjnDiWHBCnj
G39mcKBy/R9YlALxB1kxGxp2Aj3Y9g==
=3sW2
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
