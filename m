Return-Path: <rtc-linux+bncBDQ2L75W5QGBBVXBX22AKGQETIETPSA@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id a76si297016pfj.2.2016.01.08.04.51.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Jan 2016 04:51:34 -0800 (PST)
Date: Fri, 8 Jan 2016 12:51:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
	lee.jones@linaro.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, swarren@nvidia.com, treding@nvidia.com,
	Chaitanya Bandi <bandik@nvidia.com>
Message-ID: <20160108125117.GM6588@sirena.org.uk>
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>
 <1452177524-23192-6-git-send-email-ldewangan@nvidia.com>
 <CAJKOXPd938soaa5M0GFo5HpVCYzAS1w8j8Hko3Ja9mx47NYkEQ@mail.gmail.com>
 <568F8D7E.10500@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XZn3P0VKTizxZG2b"
In-Reply-To: <568F8D7E.10500@nvidia.com>
Subject: Re: [rtc-linux] [PATCH 5/6] rtc: max77620: add support for
 max77620/max20024 RTC driver
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--XZn3P0VKTizxZG2b
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, Jan 08, 2016 at 03:50:46PM +0530, Laxman Dewangan wrote:

> Yaah, that is the issue on IP based PMIC system and it happen with the Maxim
> and TI.
> The MFD and its sub module drivers are too much couped  and hence dificult
> to use the IP driver across PMIC. For almost all Maxim PMIC, we end up of
> same type of RTC driver.

> Probably, we need to enhance the mfd sub system to allow sub module driver
> to decoupe from its APIs.

Could you be more specific about the issues here please?  I can't think
of any barriers and you've not mentioned any barriers...

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

--XZn3P0VKTizxZG2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWj7DEAAoJECTWi3JdVIfQgFIH/26MBEPgSRynUZFlJHbdiig5
2NisJbsGLrhNLUG7PcVoNt8dIjsHlt8f6JsZqhoxm+kwd/fwc02lAceRtXlrcluW
BWw0xQkHLi8haOnZQmECd/J7vLyyWIAWhtuqY/pWOMi1IsChAG5kIhpDurWu9nos
DGWqXBuTQ23qQyisC+FlgViaEiwwl6Db27BAHHMkTQ51bxXVmuzHZmY5PkIvMkR8
r2WuaXJQSmjMR+srmTwMjApQs0c/HYVYIiIaQn7Tihl3+AGbkk6JgR7JgMhBeSjw
+IWkMZ57Q17/7zBfpVIJFcbTaFnWSaQsk5t9KB7h8QscuRLSgwfWf3ctUmZG36c=
=QLbi
-----END PGP SIGNATURE-----

--XZn3P0VKTizxZG2b--
