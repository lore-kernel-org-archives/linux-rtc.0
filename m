Return-Path: <rtc-linux+bncBDQ2L75W5QGBBJHT4O4AKGQEQT2P5QA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id d22si231124pfd.0.2016.04.21.09.02.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Apr 2016 09:02:43 -0700 (PDT)
Date: Thu, 21 Apr 2016 17:02:32 +0100
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
Message-ID: <20160421160232.GU3217@sirena.org.uk>
References: <1461244361-45686-1-git-send-email-w.egorov@phytec.de>
 <1461244361-45686-5-git-send-email-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fkX35UkdEibezs2J"
In-Reply-To: <1461244361-45686-5-git-send-email-w.egorov@phytec.de>
Subject: [rtc-linux] Re: [PATCH v2 4/7] regulator: rk808: Add regulator driver
 for RK818
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--fkX35UkdEibezs2J
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Apr 21, 2016 at 03:12:38PM +0200, Wadim Egorov wrote:
> Add support for the rk818 regulator. The regulator module consists
> of 4 DCDCs, 9 LDOs, 1 switch and 1 BOOST converter which is used to
> power OTG and HDMI5V.

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

--fkX35UkdEibezs2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXGPmXAAoJECTWi3JdVIfQ3w0H/A+ZTcyGxM8WpZfJGaJkczkE
5tO4SaQOojezvfRrd9Y5q8PRYljPpjMTCzqoxD94FC2pplzKBVqsLWeaPeUNqr/K
37FeCFl/8u2RjmkjD/Xav51ML44K1CzvYCndZJE3JfzmPhJy0mt6LO1imPKkhsf5
nVIErqORwxkzYF/baLLlI8Rmiqk4BWMgsyMuL1l0xIvNb8yLfKo9olDQGI3PsU0s
i7iXSiNgSbXTQ+BbCpADzT0i+VzCdpy5ELzgpejtQE5A2reUksuIprr8gsTuLiGS
axev5G24loRMkgdVb36SAfn2ndDQ+gFMJjiw7oxkcBMmFwaDro3ju80fJznJzNY=
=nc2X
-----END PGP SIGNATURE-----

--fkX35UkdEibezs2J--
