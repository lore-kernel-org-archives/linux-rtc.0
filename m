Return-Path: <rtc-linux+bncBDXMLNOH5ANRB37VTPAQKGQEJPUVUKQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id gg10si3999587pac.1.2016.11.12.03.20.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Nov 2016 03:20:15 -0800 (PST)
Date: Sat, 12 Nov 2016 12:20:10 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, linux-omap@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: rtc-twl: use irq_of_parse_and_map helper
Message-ID: <20161112112009.34gwcedl57v77ng5@earth>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478945246-32056-4-git-send-email-Nicolae_Rosia@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vr2xnynlu3eayejn"
In-Reply-To: <1478945246-32056-4-git-send-email-Nicolae_Rosia@mentor.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--vr2xnynlu3eayejn
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

> Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
> ---
>  drivers/rtc/Kconfig   | 2 +-
>  drivers/rtc/rtc-twl.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)


This patch is missing long description. I would have patched it the
other way around. There is no reason to use irq_of_parse_and_map if
generic platform_get_irq can be used.

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

--vr2xnynlu3eayejn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlgm+ucACgkQ2O7X88g7
+pq3Uw/+I7VKFgSzpOlI+Y4WHX+xUm7fF+RcV5mert6L1IqQbnTwJa/f7vmzb77k
GBf1H0dwkA+AD12jkChXRYG7bfw2qiSgWBhKEO0sEEzxiAYCNBnQ+BF4OV3Hs0O7
CUSG4yfI7V66sL93yRz3xJ1YzJ2sXlUFR2eMQyzgVoKmve4Dbrhhi3hBGLf1eT45
ar3B6if+Qjz0jWicphWAtFXlJ33SOITNa9iNSDq8UNa6dvLnBsQN4u1NbFLHVWZQ
odPqfj7nL3hyl6BJCMBzL3rMhQL9Z1u9O0pAzYVw/3cwpgVJBsfyCqllwZObLAyw
SJRO9Byrea8PujFFuAa86Ydew59UgqOwQEafXzq48TqUB5sH9tUoaHK4E78jJ14B
xkW2aCd+LU6aSqfs8RCyXh8GIsbv3G6CgVeTdeSReEnutONsEgTufZj0W3vJHDII
T4fuAaaKQuCR8mXxOkN8sg+ajYQirJhYxi/4R3+sT3vbbaZEnEkspHuJ3Sny/6ta
dlbRoCq6beo0wXF5lpeG91MdnJ5Dv1eyp2jX5SGhDm0mC0p/+qQmNlGw61DhqgJl
5Q3V8Ngt7cLJNKp/IpDKgAFe3Yjkefj6txPhD/8BFm1qiNK8CbihXiu5fsux8m88
pDFmGQojD0T12MQriqBSnhFTWeFLbY+yDOJU8gUT1qqqQZGYGmU=
=t3di
-----END PGP SIGNATURE-----

--vr2xnynlu3eayejn--
