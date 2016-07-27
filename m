Return-Path: <rtc-linux+bncBDQ2L75W5QGBBSMD4S6AKGQER2ENRVI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id yt6si1721432pac.2.2016.07.27.11.47.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jul 2016 11:47:37 -0700 (PDT)
Date: Wed, 27 Jul 2016 19:47:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Sergei Ianovich <ynvich@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Message-ID: <20160727184723.GZ11806@sirena.org.uk>
References: <1467026362-29446-1-git-send-email-akinobu.mita@gmail.com>
 <1467026362-29446-2-git-send-email-akinobu.mita@gmail.com>
 <1467028249.3182.11.camel@gmail.com>
 <20160627124432.GI29249@piout.net>
 <1467040517.3182.34.camel@gmail.com>
 <20160719151314.GH7132@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Er97KPJOrxRt+yKZ"
In-Reply-To: <20160719151314.GH7132@piout.net>
Subject: [rtc-linux] Re: [PATCH v2 1/2] rtc: ds1302: add register access
 abstraction layer
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--Er97KPJOrxRt+yKZ
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Tue, Jul 19, 2016 at 05:13:14PM +0200, Alexandre Belloni wrote:

> Ok, seeing that, now I'm thinking that switching the ds1302 driver to
> spi was a mistake and bitbanging in the driver was the right thing to
> do.
> What you introduced are two drivers instead of one and the abstraction
> is actually getting worse.

> So I'm thinking the best solution is to write a proper driver bitbanging
> microwire (maybe in the SPI subsystem) that everybody could use,
> including old architectures.

That seems to make sense to me.  We could probably accomodate in SPI,
the programming model should be very similar so the microwire bit could
be hidden in the driver.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--Er97KPJOrxRt+yKZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmQG2AAoJECTWi3JdVIfQn2cH/03oacarRiEE29pto/RFuf0D
UTULip7IsS4B4+2/4cb3YDSPBwA6xVo9J4U/Skw54OJogsMhpESulmdqyS+TB23t
2e5c5YRWc6txNVejAwp6iOYMTJypueJCoLcJH5Q4EPT5stCAtlZkcpt/HKZA+JOK
66aogWisx10pylsqDLYPrQGX1hp2ln1xWxZsxk7Iamex2wzQD3N9Rm9FJK3T/CVx
Fz9zJzzqqrNWqshcUZ+xt2Us6kgen2eHtfyMD0SjefWgyhKrDMkCZosN/TSapa4H
49ugbRwZwJHm+n8+PeZg2E6IYTSxAgYqdpNCIA2vgzyJfM3QwhGZYFBW1quPNdY=
=A7ou
-----END PGP SIGNATURE-----

--Er97KPJOrxRt+yKZ--
