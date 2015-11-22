Return-Path: <rtc-linux+bncBDQ2L75W5QGBBOMEY6ZAKGQE2I6JPIA@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id fg10si671238pad.0.2015.11.22.05.25.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 22 Nov 2015 05:25:13 -0800 (PST)
Date: Sun, 22 Nov 2015 13:24:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: lee.jones@linaro.org, k.kozlowski@samsung.com,
	alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
	Thomas Abraham <thomas.ab@samsung.com>
Message-ID: <20151122132455.GP26072@sirena.org.uk>
References: <1448015873-8743-1-git-send-email-alim.akhtar@samsung.com>
 <1448015873-8743-3-git-send-email-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e2bLSPRkEYxxSNev"
In-Reply-To: <1448015873-8743-3-git-send-email-alim.akhtar@samsung.com>
Subject: [rtc-linux] Re: [RESEND PATCH v5 2/3] regulator: s2mps11: add support
 for S2MPS15 regulators
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--e2bLSPRkEYxxSNev
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, Nov 20, 2015 at 04:07:52PM +0530, Alim Akhtar wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> The S2MPS15 PMIC is similar in functionality to S2MPS11/14 PMIC. It contains
> 27 LDO and 10 Buck regulators and allows programming these regulators via a
> I2C interface. This patch adds initial support for LDO/Buck regulators of
> S2MPS15 PMIC.

Acked-by: Mark Brown <broonie@kernel.org>

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

--e2bLSPRkEYxxSNev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWUcImAAoJECTWi3JdVIfQRfsH/0z7aVPEZ/0UewsXS6a1T+ck
ZY5lIkR3J2SVWgNHkrJaXT+5sZGsq/gdpWCUsT1MCEXmNii8E9PporqFPS4OVwKf
maBUu9zWAupBmXdf8YoXCq1DYE/GWDxp0nU/ouMn5O9MwQpyefNdsU3Vz8z/K2kx
e5TLMvmWH8bDCR1H07GpSMD6Sc3DF9m2PGWMQZ9seS3GazuWZe0Es/Ut2XJUB8GW
I4MbCekgdq3i6ehct/lx4ou4iLfuQn0wigDwlbvSLTXb3hDNZZbUmRAS0WvVCISU
gbAT0cV2ah1/W8vTIvrpaBGnwTli2w7VGK3QYBHClq5bEhieSkIvNPr0WgkvdRI=
=U7YO
-----END PGP SIGNATURE-----

--e2bLSPRkEYxxSNev--
