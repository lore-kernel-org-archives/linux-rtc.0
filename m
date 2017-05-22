Return-Path: <rtc-linux+bncBDQ2L75W5QGBB5EPRPEQKGQER6ZCFUA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id p63si2280235pfd.4.2017.05.22.04.13.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 04:13:56 -0700 (PDT)
Date: Mon, 22 May 2017 12:12:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Sebastian Reichel <sre@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-usb@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
	alsa-devel@alsa-project.org
Message-ID: <20170522111202.ho52rve7kwloytef@sirena.org.uk>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170522095243.ff5uygzzrvo57jkd@sirena.org.uk>
 <20170522102812.GA1459@katana>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3cgcyz2pgijsvimy"
In-Reply-To: <20170522102812.GA1459@katana>
Subject: [rtc-linux] Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--3cgcyz2pgijsvimy
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Mon, May 22, 2017 at 12:28:12PM +0200, Wolfram Sang wrote:

> If you were not CCed on the other patches, then you are likely not
> listed as a maintainer for them?

Right, but it does mean that the people who only get a subset of patches
are missing context for how things are expected to be handled.
Sometimes it's clear but often it isn't.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--3cgcyz2pgijsvimy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkix4EACgkQJNaLcl1U
h9AoyggAgaMjiKp5VVkDMDXvnk7mjJn0zZJkLTo8eRqXQezPfYpmF9xgddizz6aP
amhuCFkOGq/szuZvUiqRuuZVR927HUTth5jHEI5oXJlpSzkD9GFYWKFb5DEGk7z8
+PxlTwkovPNwkvLLRkPeYL1u3NxZoBQLflM5wU7L0F3xjIWeObAptv8O+LyUvt/A
v6SKbNM3qYATkx0KYyJk/MoQQRJqW8D7dfzPqZ/0qNucWnI+XpQHW3zD7f1YujYn
njy7ZP+ATutTod2ziOBAXUREZuMZCnY4xtyJvbMrUdcxlYYzqfvc5VswGE1V5Shq
R0sjq6K15NBdpTXTAv89glr1IEeaRA==
=Ko/9
-----END PGP SIGNATURE-----

--3cgcyz2pgijsvimy--
