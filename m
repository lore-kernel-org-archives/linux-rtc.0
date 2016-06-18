Return-Path: <rtc-linux+bncBDQ2L75W5QGBB253SS5QKGQEPTCLNCI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id tp10si5944833pac.2.2016.06.18.03.09.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jun 2016 03:09:47 -0700 (PDT)
Date: Sat, 18 Jun 2016 10:47:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, dmitry.torokhov@gmail.com,
	andy.gross@linaro.org, david.brown@linaro.org, lee.jones@linaro.org,
	lgirdwood@gmail.com, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, rtc-linux@googlegroups.com
Message-ID: <20160618094718.GR26099@sirena.org.uk>
References: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
 <1466158929-19524-6-git-send-email-narmstrong@baylibre.com>
 <20160617165352.GA1256@tuxbot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phbq2bkSb+hZnunM"
In-Reply-To: <20160617165352.GA1256@tuxbot>
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


--phbq2bkSb+hZnunM
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, Jun 17, 2016 at 09:53:52AM -0700, Bjorn Andersson wrote:
> On Fri 17 Jun 03:22 PDT 2016, Neil Armstrong wrote:

> > +	{ "dig_corner", QCOM_RPM_VOLTAGE_CORNER, &pm8018_corner,
> > +						      "vdd_dig_corner" },
> > +
> > +	{ }
> > +};

> We have discussed the corners for a long time and I think we've
> concluded that they should be exposed as something like an OPP. What we
> have agreed on is that they should not be exposed as a regulator with
> voltages 1-4uV.

Oops, missed this - yes, that needs to go as it's definitely a complete
abuse of the API.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--phbq2bkSb+hZnunM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXZRilAAoJECTWi3JdVIfQY80H/1ivWNpPRnt2FJlX1ib3VwyJ
o6NL9+DqffRIIj4VN4lZJUiIXmHUbGy9OjiVdac29rA4QHicwz27jj1OQ1DsNQ+i
EdoR7STzH3e3YvwQBrSZzFoD0C2AXXaWPWLB5UbtA2s7Lcg3LPWuTQc2MazVYuLS
h4zyNZhWYzHRdr5Jm4EsXCbLbESjNWqLow/Wh+tI0szCVDiOnD4bSEzA0C2CmRwB
UJKtFyZeUPjE1Fozbu3FWB+T2g3ck+S40OkkIoWSArHxxlDzYY06/xUiEZXWDk2O
k6cD1Q5D1cM/q+j5M+KWhQ+rpa0q5+ToKHEcBf/1mJr8319IzgvpEF/zsuDqul8=
=DTu4
-----END PGP SIGNATURE-----

--phbq2bkSb+hZnunM--
