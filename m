Return-Path: <rtc-linux+bncBDP47C6LHEIMF6UKZECRUBCSZ7OBC@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.zeus03.de (www.zeus03.de. [194.117.254.33])
        by gmr-mx.google.com with ESMTPS id f23si158928wme.0.2017.05.22.03.28.17
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 03:28:17 -0700 (PDT)
Date: Mon, 22 May 2017 12:28:12 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Mark Brown <broonie@kernel.org>
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
Subject: [rtc-linux] Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Message-ID: <20170522102812.GA1459@katana>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170522095243.ff5uygzzrvo57jkd@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
In-Reply-To: <20170522095243.ff5uygzzrvo57jkd@sirena.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Mon, May 22, 2017 at 10:52:43AM +0100, Mark Brown wrote:
> On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> > include/linux/i2c is not for client devices. Move the header file to a
> > more appropriate location.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks!

> I'm missing the rest of the series and/or the cover letter...

I meanwhile send cover letters only to all mailing lists involved. I
used to CC the individuals, too, until those messages were rejected
because the CC list grew too large :( And I really only CCed maintainers
then, no git history used.

If you were not CCed on the other patches, then you are likely not
listed as a maintainer for them?

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkivTgACgkQFA3kzBSg
KbaTdQ//X6Cza46bguYF00U+Vf7lEyTuUUuhl7rujtuXRrZTTNNJmQryjeAWa4ws
3tM5vJrZjpsdz8K1dAtyZC+Og/SsnkieakqAEPCyym0aE1Wyr3ynjL4DAgQB0nHG
AbBfLsgI2dTwBwkOJ8JwEFM9a6C7knsPdW/XyM9VfQNuC84stCSPqmzYJzxjkUjF
LtN1Wo9IRigyV9WpJXZeLUKanm5lsPvtHArK0cwWLfA3sdVo/xKYiznOJ91CkUxf
WUXe2jOihnra1lOm+HiMKtu1KlOPJ65Te5bACMtArVKIhP7bFqk8COcgh8YFzAeM
kei6j3pX8+jqoy/EELwdCGp0l9FiQSR7aeQmP2Vuc1l4l0iuafDQkjCwGqekdMjS
SUCE6GpmLTPL8x8H2PBX/YzUouHBpp5VlftFGe0t+T/KfIy6o+6KIc41qvrgfp4S
yyNF+Q85aMGI0NMlVmh6JENL4+XI17EgYfREWfL2IoeVl5URQbbN0XHxVnCZF5wY
IHMsbhUSnWb4OOakZnf9dEAKpuX9fHVhjY9dSWX1A3xrNY7SliAUPjei3sKXEiPw
20zSkk4F7qqyQd/Y5WzIOVlmmteoVlEQaCF0sqAxFILeHFX8yyl8BvDq+HPVu2Wo
7IX601Djf7wwU4+Ix1So9alvmVrM0mfW7O4eZHIEeblp18rs22Y=
=A/8Y
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
