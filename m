Return-Path: <rtc-linux+bncBDQ2L75W5QGBBI4HQO4QKGQE3KTIKJA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id ph3si1052036pac.1.2016.04.27.06.50.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Apr 2016 06:50:27 -0700 (PDT)
Date: Wed, 27 Apr 2016 14:50:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Sergei Ianovich <ynvich@gmail.com>, rtc-linux@googlegroups.com,
	"open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>
Message-ID: <20160427135012.GP3217@sirena.org.uk>
References: <1460300366-25248-1-git-send-email-akinobu.mita@gmail.com>
 <20160410151237.GD5377@piout.net>
 <1460301781.17404.171.camel@gmail.com>
 <20160410153855.GG5377@piout.net>
 <20160412012518.GQ3351@sirena.org.uk>
 <CAC5umyguFq7vBenkJYM8AWCNJ3oGBKzKAMHHMsO=+OFHtE4b0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2NUUivEUh6/D4/qT"
In-Reply-To: <CAC5umyguFq7vBenkJYM8AWCNJ3oGBKzKAMHHMsO=+OFHtE4b0A@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 0/4] support control with using GPIO lines
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--2NUUivEUh6/D4/qT
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Apr 27, 2016 at 04:53:18AM +0900, Akinobu Mita wrote:

> For the read data transfer, the address/command byte is sent on the
> rising edge of the first eight SCLK cycles and the read data byte is
> transmitted on the falling edge of the next eight SCL cycles.

That's an innovative and exciting hardware design :/  Definitely doesn't
seem to correspond too closely to any SPI mode I can think of.

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

--2NUUivEUh6/D4/qT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIMOUAAoJECTWi3JdVIfQSdUH/jFLq+UE3JQuAprUW68kzyK6
7apF+0wyC5vc+5HGoJqhHrqqTEFh9bMfMbmEUrsNAz3pj5hV7gDmw8D3QKBE3JAN
ZMHAZFInMZ0v5iOBhU5bAlsmj24krdTjUwSN4+ApQNEAJ/AJSnr514WThUxNiXP0
sUV4fKM06FYWiM4t4pZnvR0ksUgL7aASKdwoQfkLOfi6kGrCtliAjBJhNRk2waxF
/OD+8+DGniJ6RA2Y53DXyKtAt7Fqov9fNtBrqGDc8UlMV/VP9RZSpjGeJAx3L7dB
E7Kq1Zw1oFdCE+sMmPgXVv3lJVobaqsL/SvETgmqKRS8I1bZ7Nt3K2UufDe4hM8=
=2PZU
-----END PGP SIGNATURE-----

--2NUUivEUh6/D4/qT--
