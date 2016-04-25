Return-Path: <rtc-linux+bncBDQ2L75W5QGBBU5M7G4AKGQERVF6LGA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id vo1si229578pab.2.2016.04.25.10.39.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 10:39:31 -0700 (PDT)
Date: Mon, 25 Apr 2016 18:39:11 +0100
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
Message-ID: <20160425173911.GQ3217@sirena.org.uk>
References: <1461590448-47685-1-git-send-email-w.egorov@phytec.de>
 <1461590448-47685-5-git-send-email-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XJ4udkfvZE/9uKZk"
In-Reply-To: <1461590448-47685-5-git-send-email-w.egorov@phytec.de>
Subject: [rtc-linux] Re: [PATCH v3 4/8] regulator: rk808: Migrate to regulator
 core's simplified DT parsing code
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--XJ4udkfvZE/9uKZk
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Apr 25, 2016 at 03:20:44PM +0200, Wadim Egorov wrote:
> A common simplified DT parsing code for regulators was introduced in
> commit a0c7b164ad11 ("regulator: of: Provide simplified DT parsing
> method")

This doesn't apply against current code, please check and resend.

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

--XJ4udkfvZE/9uKZk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXHlY9AAoJECTWi3JdVIfQtIIIAIcIQZNiiFuP2HZh1cEP+78I
qkiWJVI68xyQNROExsH6e7Bk/N99mteR/aIAHcntuVnMGopJu+tz7tydZdRsHSVr
ivvvZosoGnQVK+97qu7o75CIR2eC5nv4Bb9B1eZaYymR3mR77PnPjfCMnZsoCxKR
9Qo+m0lGxWv+9Lcf7o63SqDvree93Rht9re8ziqUcGy6dfm+W019J25wn9E2LUdZ
tlnUwBhSkW0QQKE8J98crWboqRvK12THKOtzCdxQM5Po78fwBOR9+4aWzGPShokH
gDcDodCElbZILaoMGnoT7LRZdZ2DNZSfxgl+ZnMOynW+cLeWdnsAa8J1BeUlHag=
=uieL
-----END PGP SIGNATURE-----

--XJ4udkfvZE/9uKZk--
