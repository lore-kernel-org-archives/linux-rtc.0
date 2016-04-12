Return-Path: <rtc-linux+bncBDQ2L75W5QGBBCE5WG4AKGQEK43DQOY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id ph3si1767536pac.1.2016.04.11.18.25.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Apr 2016 18:25:28 -0700 (PDT)
Date: Tue, 12 Apr 2016 02:25:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Sergei Ianovich <ynvich@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Message-ID: <20160412012518.GQ3351@sirena.org.uk>
References: <1460300366-25248-1-git-send-email-akinobu.mita@gmail.com>
 <20160410151237.GD5377@piout.net>
 <1460301781.17404.171.camel@gmail.com>
 <20160410153855.GG5377@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FcSpk3Icpd/Pbul4"
In-Reply-To: <20160410153855.GG5377@piout.net>
Subject: [rtc-linux] Re: [PATCH 0/4] support control with using GPIO lines
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--FcSpk3Icpd/Pbul4
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sun, Apr 10, 2016 at 05:38:55PM +0200, Alexandre Belloni wrote:
> On 10/04/2016 at 18:23:01 +0300, Sergei Ianovich wrote :

> > No, unfortunately. I've investigated this possibility for my platform.
> > spi-gpio doesn't support LSB-first and 3-wire options. Adding support
> > there is a very big change. The best way to add GPIO support is to
> > create spi-gpio-3wire with LSB-first support.

> Mark, do you have nay opinion on that?

Three wire doesn't seem like it should be invasive, LSB is going to be a
lot more invasive though it seems reasonable to just do the reversal in
the driver for whatever device this is and let the SPI controller run
normally.  Or we could do that in the core with a pass over the data.

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

--FcSpk3Icpd/Pbul4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDE59AAoJECTWi3JdVIfQiT4H/jOMfyK1geaFwemu0XwrIyNx
mU081BmWCFGVjCRTCRbFBLfdWSEjznChfYE3UJhf81ZbTW/eSCSQPWF8u6sxS4+W
WcLT4EPrpXFX60I6BYLA4FcLpA9VbxVqKKD4nezykYhEwAQuYKMw04viWcjWukpe
rcC1toWWFAynKCZvsoOJvtYAluL5q9monZH5wkAmaqeeo8QzRJlhndoFAK/q68oA
5QMBAaZPASJqft7X5CBnoSsvqsuT5Q9jU+J7yPGYTdSOd7VeuPtoqxLzLMW2yW0R
HStlcj9N9WrwTDMJzCq56Pqakx4wJ8c9ryqe9L0neBHrCbzPenyGRJNx1yxvlg8=
=xrSK
-----END PGP SIGNATURE-----

--FcSpk3Icpd/Pbul4--
