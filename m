Return-Path: <rtc-linux+bncBDQ2L75W5QGBBMPR224QKGQEVOOIMSI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id 17si3213141pfw.0.2016.05.13.04.21.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 May 2016 04:21:21 -0700 (PDT)
Date: Fri, 13 May 2016 12:20:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org,
	lee.jones@linaro.org, lgirdwood@gmail.com, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, dianders@chromium.org,
	zyw@rock-chips.com
Message-ID: <20160513112055.GE22038@sirena.org.uk>
References: <1462886340-7893-1-git-send-email-w.egorov@phytec.de>
 <1462886340-7893-4-git-send-email-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
In-Reply-To: <1462886340-7893-4-git-send-email-w.egorov@phytec.de>
Subject: [rtc-linux] Re: [PATCH v5 3/6] regulator: rk808: Add regulator driver
 for RK818
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Tue, May 10, 2016 at 03:18:57PM +0200, Wadim Egorov wrote:
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

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNbiWAAoJECTWi3JdVIfQ82IH/0WRYTRTlQk/OPon4FIaa0IO
oBFGlMS/tz6UgBysOleM8JPoDrX4wKImWQHYurbJ8IGOqpGfScZ7o1g5h79t05RQ
HABbHNz+BDHg49foowhQGAKBW7enpzIkKEbsXEj/Bt76g5l3Mdoj9Gzn6HuJILM4
HmGm05lSdLtxJE1zXZXcl74MqAWRgbVA9jw+KoHOMnSumLLHso1vue5A+UtvJImE
Q5J9L1BGjCyxXfGXWq7JAFtBcPPokFv/A3vbdsLMlHfFHYkZLHR74IAXWM2IIiSh
NoaM234W/hluaDT+P4ftX45ZInqqo6S8KbEznQsTAuKMWopfgeu2L27C4vqbXBg=
=hJT+
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
