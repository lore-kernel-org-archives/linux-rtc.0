Return-Path: <rtc-linux+bncBDZOX5PQ7YDBBCX2RLEQKGQECJK3RVA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id e187si643101wma.0.2017.05.22.03.27.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 03:27:22 -0700 (PDT)
Date: Mon, 22 May 2017 12:27:19 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-usb@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	alsa-devel@alsa-project.org, Wim Van Sebroeck <wim@iguana.be>,
	Thierry Reding <thierry.reding@gmail.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lee Jones <lee.jones@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Russell King <linux@armlinux.org.uk>,
	Kishon Vijay Abraham I <kishon@ti.com>, linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-input@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	Felipe Balbi <balbi@kernel.org>, linux-gpio@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-arm-kernel@lists.infradead.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Jingoo Han <jingoohan1@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [rtc-linux] Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Message-ID: <20170522102719.yzqujz327hv5zu7r@earth>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tjpa2ifnbroetnta"
In-Reply-To: <20170521220212.1404-4-wsa@the-dreams.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--tjpa2ifnbroetnta
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

Hi,

On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> [...]
>  drivers/power/supply/twl4030_charger.c  | 2 +-
> [...]

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--tjpa2ifnbroetnta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkivQQACgkQ2O7X88g7
+pr+JBAAgfqciZwOxlKdgg1Ffp+cnY74bMb+kL52A5+T4mkbwSyRNm944UI4PbYg
y4k137b5tcH/YyF66lqI+C3pXQzbrMBvO0rLfqHCB0HKRd7akG8AKSwhe7TA52MH
zt58f9un02aqyyNceNOzr/jg2DAFCQP3q/w3ZscyoehFC2rezpCbX8Vb2PTu81hR
9STMybSMS0K/B1D9X5gmBIhZ8ofTPDZDirPUNgdn4zD26iNsEnWbPc/5qCL2ecFU
H9RWUUmUdkYxtyjmWVa2fktT66VYhq4Ku6BiD8E6f7qwtQ+WqjVglTLx6s+PdxWI
tbgbf/6BVLw+ogSIvEuDdXlZeZVM7e4qUjcRw6FnzsqgyBDMbB+SqIpnbRYHUwsH
Y4Jh6yD9M6X0YA71B7i2nkUIRoYFmEzRI+Evk5vchFTZIyW5V4nu95BcsgTH/ZVZ
le93GTruiQSSZkLS471xqZ+XCgSMIE052sJLhLRjzT+PjLqs3F0b8fpg53/wITcJ
Rr06jGF/k0YdgpBGHexUiA+3frXdkdY5bx9wKh9C7y1JnjR6ZME4FN2rhkecZHX2
VxwW9ra2g9wdJn0SL/eZNtb79FKNCigQik5grIG7kw55bdybGXgGZMHRvYbN91eU
wccj0CYykJ9wKuRfttth4jVCwoMV1vt2TvYcrUfMv9eTEd7VeTU=
=JcW1
-----END PGP SIGNATURE-----

--tjpa2ifnbroetnta--
