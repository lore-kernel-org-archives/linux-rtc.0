Return-Path: <rtc-linux+bncBDQ2L75W5QGBBKUYWS5QKGQES7JH64I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id c11si575758pfc.2.2016.06.24.03.32.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2016 03:32:10 -0700 (PDT)
Date: Fri, 24 Jun 2016 11:31:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: dmitry.torokhov@gmail.com, andy.gross@linaro.org,
	david.brown@linaro.org, lee.jones@linaro.org, lgirdwood@gmail.com,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	rtc-linux@googlegroups.com
Message-ID: <20160624103148.GZ28202@sirena.org.uk>
References: <1466759887-25394-1-git-send-email-narmstrong@baylibre.com>
 <1466759887-25394-6-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XUd+PsnCfaVdInSg"
In-Reply-To: <1466759887-25394-6-git-send-email-narmstrong@baylibre.com>
Subject: [rtc-linux] Re: [PATCH v2 5/5] regulator: qcom_rpm-regulator: Add
 support for pm8018 rpm regulator
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--XUd+PsnCfaVdInSg
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, Jun 24, 2016 at 11:18:07AM +0200, Neil Armstrong wrote:
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

--XUd+PsnCfaVdInSg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXbQu6AAoJECTWi3JdVIfQ3wAH/1ymlahXuo3OFvyyUzE9G4RY
kpG5W+Io9FQyHeCSZ47X9/v4I6O/Eb3FpXpeOrMiTl/oLbQG+dJVXCQxurfF37Mk
ohKRlFoKUd3gt0VvDdMuVbaxkYEatP/KdhHoU8eCX+BzSo+3D7QLBgJwxbjFLkW+
QLtLG14n0+S1QXEMxxabgVohYadmLlgib4T2ApClmDk0XcEpBIc8kLt58E9G6BQX
in0l8ElfmXP5P39QF4D9XrHFfFkWezqFWDHQYvcpedItwP0lSTJrW/ibCV2ASqro
hl7ExGwZtiEcqxAJy1dbyp92LLcPO3c42Dmp9h9M7YEwSeb/sEh7zSsbVijHAx4=
=DAAY
-----END PGP SIGNATURE-----

--XUd+PsnCfaVdInSg--
