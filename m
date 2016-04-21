Return-Path: <rtc-linux+bncBDQ2L75W5QGBBZPS4O4AKGQEWN3ANJQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id gg5si193669igb.0.2016.04.21.09.01.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Apr 2016 09:01:40 -0700 (PDT)
Date: Thu, 21 Apr 2016 17:01:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	mturquette@baylibre.com, sboyd@codeaurora.org, lee.jones@linaro.org,
	lgirdwood@gmail.com, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, dianders@chromium.org,
	zyw@rock-chips.com
Message-ID: <20160421160120.GT3217@sirena.org.uk>
References: <1461244361-45686-1-git-send-email-w.egorov@phytec.de>
 <1461244361-45686-4-git-send-email-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x735uyZ2C9eR7U1j"
In-Reply-To: <1461244361-45686-4-git-send-email-w.egorov@phytec.de>
Subject: [rtc-linux] Re: [PATCH v2 3/7] regulator: rk808: Migrate to regulator
 core's simplified DT parsing code
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--x735uyZ2C9eR7U1j
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Apr 21, 2016 at 03:12:37PM +0200, Wadim Egorov wrote:

> +static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
> +{
> +	unsigned int reg;
> +	int sel = regulator_map_voltage_linear(rdev, uv, uv);
> +
> +	if (sel < 0)
> +		return -EINVAL;
> +
> +	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
> +
> +	return regmap_update_bits(rdev->regmap, reg,
> +				  rdev->desc->vsel_mask,
> +				  sel);
> +}

This is fine but is adding a new feature and not part of the refactoring
that the changelog talked about so should be in a separate commit.

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

--x735uyZ2C9eR7U1j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXGPlKAAoJECTWi3JdVIfQqxcH/3zHYCsco7Um+vuiC3Tx+h+S
6zDWfQtNVsxmf75m9fTYsY91t1ub/SNY8DGvEeCPRffvVHxLQBaaKyW0HcaBvdS3
h2LOaXlJlTE5o3SnA/RVC7qM5OEGLU94oxa5x+j03MUbqMtm4ngDCe0LzFdGsq4a
2kaUCx35X9Kdy6N2pHPGxF3A0v+gqSnQ35L/JfUqAy0KhjdN/y0G2pZpfuxhM6+U
jniv0nasEatBpB6KZPSDqwjOMsNB9kPpBixRtTHksfPjZgCC8NqNT1eGEyJq8eOZ
QWZr6Is7zpwT388PaDDfwdpd9K758Jv15EnXDb+IF0Zxz0Mp4Ds3hPEUKJBNbFE=
=tDQJ
-----END PGP SIGNATURE-----

--x735uyZ2C9eR7U1j--
