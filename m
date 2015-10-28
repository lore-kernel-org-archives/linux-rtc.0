Return-Path: <rtc-linux+bncBDQ2L75W5QGBBI6VYCYQKGQE4QAE2DY@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id vy6si4519269pbc.1.2015.10.27.18.53.39
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 18:53:39 -0700 (PDT)
Date: Wed, 28 Oct 2015 10:53:23 +0900
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, lee.jones@linaro.org,
	mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Message-ID: <20151028015323.GZ28319@sirena.org.uk>
References: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
 <1445863883-5187-6-git-send-email-alim.akhtar@samsung.com>
 <56302514.4090407@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KQ2iXOoQ638mtNze"
In-Reply-To: <56302514.4090407@samsung.com>
Subject: [rtc-linux] Re: [PATCH v3 5/5] drivers/rtc/rtc-s5m.c: add support for
 S2MPS15 RTC
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--KQ2iXOoQ638mtNze
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Oct 28, 2015 at 10:29:56AM +0900, Krzysztof Kozlowski wrote:

> If that's true, then don't add new compatibles, new names etc. Re-use.
> No new code needed, no changes needed. Keep it simple.

Well, it depends - it can be useful to get the information about it
being a different part into DT so that if in future we realise that
there is some difference (perhaps a bug workaround even if the IP is
intended to be the same).  Though in the case of a MFD that information
can be obtained from the MFD for the device.

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

--KQ2iXOoQ638mtNze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMCqPAAoJECTWi3JdVIfQ4xYH/j4G3S5X7WjyczTIZ00O2321
T1RDXLoEYYjVS0AvRTNbR15/mFw2Zbm3Tpq14EpoWItBNP3VNmjknWH2N+3dEiFA
nD2xto1RCCzXb/4Vi908Y39rqEN2MRcjO4NtPh0ZEH3RnbKfCj4/X+F8Kv4MWVm3
4pBDefmn0JhyS1VxlVfPV5Ot/jApXZTei2OWI/iwBtATaIwa41z0EdWCUrAzONld
RQMmG8UK1NYbsED3bqiLtVatNED/oAlgaHGslxgA4pUbc52Jk7cS/cO3fK+RmOS/
Ji9IeIOfmWSgHMl0aqKiBBn8tQca5ou6q32rRgYiwLEorsE9Iq1+pKaWAbmtUzY=
=7yDC
-----END PGP SIGNATURE-----

--KQ2iXOoQ638mtNze--
