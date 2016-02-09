Return-Path: <rtc-linux+bncBDQ2L75W5QGBBZEE5C2QKGQEM4NRNXY@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id 12si4696343pfb.1.2016.02.09.07.14.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 07:14:44 -0800 (PST)
Date: Tue, 9 Feb 2016 15:14:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
	alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com,
	gregkh@linuxfoundation.org, a.zummo@towertech.it,
	cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Message-ID: <20160209151421.GF13270@sirena.org.uk>
References: <1455020907-4564-1-git-send-email-ldewangan@nvidia.com>
 <1455020907-4564-2-git-send-email-ldewangan@nvidia.com>
 <56B9E93A.2040903@osg.samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
In-Reply-To: <56B9E93A.2040903@osg.samsung.com>
Subject: [rtc-linux] Re: [PATCH V6 1/6] regmap: irq: dispose all virtual irq
 before removing domain
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Tue, Feb 09, 2016 at 10:27:22AM -0300, Javier Martinez Canillas wrote:

> I believe this patch could be picked separately and not made part of
> this series since is fixing a bug that happens on most drivers using
> the regmap-irq API. This will avoid cross-subsystem churn for people.

Yes, please don't mix things in when there are no dependencies.

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

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWugJMAAoJECTWi3JdVIfQQ8oH/RxY01MdOIZADvg0XQC1wORv
j2eFtpWC04ERc48ZOtnd6OLzwSZUtFkaq/zxUtIRVm43agyN0dyGkR34cdBCsnwV
Yl9ZkHxl/Btb8fMf5qLtbhs4ZIojLl/NfJjioRyK+aISLMEeGGrg/idsjeSYmhWx
FAkIMjQCE6zjPHl6+g6kluWmCs/XKjI+OUQuwfcX6ETGlT/jFIEcvKxB6+vWlk1j
XT9BWOqXE+RzZWtguplVXwlpKgEnH1An1Cw8Ne5oSdK8IysbENjRdE+vJmVMo8Z+
oCFnadKasUbkr4FWRG6LgauZ288pz+K6P2zYU6qUWodesxCtpuovX0r8I+eME7I=
=N3Vn
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
