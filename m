Return-Path: <rtc-linux+bncBDQ2L75W5QGBBLOYR65QKGQEWIRNKHQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id un17si3180582pab.0.2016.06.17.05.25.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2016 05:25:16 -0700 (PDT)
Date: Fri, 17 Jun 2016 13:24:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: dmitry.torokhov@gmail.com, andy.gross@linaro.org,
	david.brown@linaro.org, lee.jones@linaro.org, lgirdwood@gmail.com,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	rtc-linux@googlegroups.com
Message-ID: <20160617122457.GM26099@sirena.org.uk>
References: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
 <1466158929-19524-6-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xtx0sNU5lZ46KfgK"
In-Reply-To: <1466158929-19524-6-git-send-email-narmstrong@baylibre.com>
Subject: [rtc-linux] Re: [PATCH 5/5] regulator: qcom_rpm-regulator: Add
 support for pm8018 rpm regulator
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, Jun 17, 2016 at 12:22:09PM +0200, Neil Armstrong wrote:
> In order to support eh Qualcomm MDM9615 SoC, add support for the
> PM8018 RPM regulator in the qcom_rpm-regulator driver.

Acked-by: Mark Brown <broonie@kernel.org>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--xtx0sNU5lZ46KfgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY+wYAAoJECTWi3JdVIfQmfkH/0RTy6OM0sA2hE2YgQGCF0i9
UM1BwPSA68E01Y3NCnuOw+jvuAdQ8AKf7TGlGNaxX8FFHyZFGq/gjVvxk8K7i2s7
x8Os6BDYtvLzwXO9tH2CiDZnR1AhFRHhk76b1K0GvcBi5gMaIa78LuoEUbwne1hv
AU2SSr1ou94Vk3jWI2bRvMxtS5wJpn2dnreNjAJt6Zf6WvOXf62tPFaaInOw87IN
GH+ylt5VljACIo8wCrKQrwGtloOoBuA2lbXn7hEMmXbXTrX7EbZhZ4iF6xNKnN3O
scmwMA23nWB9g2x8YcZZp6UtgRlt/cJGWHXlcW3pckoKOu9Jzjxy8+6Tlcja9fo=
=y5Dx
-----END PGP SIGNATURE-----

--xtx0sNU5lZ46KfgK--
