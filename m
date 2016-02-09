Return-Path: <rtc-linux+bncBDQ2L75W5QGBBOU2462QKGQEAZIBBNQ@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id ff2si2267928pad.2.2016.02.09.03.27.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 03:27:53 -0800 (PST)
Date: Tue, 9 Feb 2016 11:27:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, lee.jones@linaro.org,
	alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com,
	javier@osg.samsung.com, gregkh@linuxfoundation.org,
	a.zummo@towertech.it, cw00.choi@samsung.com,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Message-ID: <20160209112728.GB13270@sirena.org.uk>
References: <1454769447-785-1-git-send-email-ldewangan@nvidia.com>
 <1454769447-785-2-git-send-email-ldewangan@nvidia.com>
 <20160208145550.GE7265@sirena.org.uk>
 <56B8C484.7000309@nvidia.com>
 <20160208165912.GK7265@sirena.org.uk>
 <56B8C8B4.4050207@nvidia.com>
 <20160208181908.GM7265@sirena.org.uk>
 <56B97632.1000208@nvidia.com>
 <56B9AC8C.2020209@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
In-Reply-To: <56B9AC8C.2020209@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V4 1/6] regmap: irq: add apis to unmap the
 mapped irq
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--U+BazGySraz5kW0T
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Tue, Feb 09, 2016 at 02:38:28PM +0530, Laxman Dewangan wrote:
> On Tuesday 09 February 2016 10:46 AM, Laxman Dewangan wrote:

> >Do we need to dispose all virtual irq in regmap_del_irq_chip() before
> >actually removing domain?
> >This means we need to store the created virq  in regmap_irq_chip_data for
> >disposing it when removing the irq domain.

> It is easy for me to communicate through code to avoid any confusion. So do
> you want to say as follows? In this case, there is no need of any new API.

Something like that, yes.  Documentation/SubmittingPatches please...

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

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuc0fAAoJECTWi3JdVIfQc7UH/iJXS6hfLnpTzur/cYtPn03T
oKFd9RwySbW9Sdk0Y5KH9+cpfkAzbkuHIDBUrY00OANLrIYmJgGQb+S/nTmK57xQ
Dvd8dF9zHk/r4SihsEq51vVDqEy4BGBt51rfmXqdMZ28TOZBf9zEoHV83v5V9atM
X04WYDPqnJc5ENxlY1jF3RBwn/tsvHrze5q5/ad+1cVpLx+5/iT0ZZAE6LzIiBMh
2ivhSRvTPwk+npfptk+v467b8bmfZJykEQOMbyjIm76I3nx65twrq9hjbqZ7gS5/
oD46fKL6utDEu5jcxfGwK2M9n6asOJe6ayi3KS7ZA8O2+pWEVkhkfx4c5cBvxlI=
=wi8Z
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
