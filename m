Return-Path: <rtc-linux+bncBDQ2L75W5QGBBCOZ4K2QKGQEM6MT2WY@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id ui7si4393920pab.0.2016.02.08.06.56.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Feb 2016 06:56:09 -0800 (PST)
Date: Mon, 8 Feb 2016 14:55:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: lee.jones@linaro.org, alexandre.belloni@free-electrons.com,
	k.kozlowski@samsung.com, javier@osg.samsung.com,
	gregkh@linuxfoundation.org, a.zummo@towertech.it,
	cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Message-ID: <20160208145550.GE7265@sirena.org.uk>
References: <1454769447-785-1-git-send-email-ldewangan@nvidia.com>
 <1454769447-785-2-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
In-Reply-To: <1454769447-785-2-git-send-email-ldewangan@nvidia.com>
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

--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sat, Feb 06, 2016 at 08:07:22PM +0530, Laxman Dewangan wrote:

> Before removing irq domains, it is require to unmap all
> mapped interrupt from that domain. Currently there is API
> to map the interrupt on chip as regmap_irq_get_virq() for
> creating mapping. Add equivalent API to dispose the mapped
> irq in irq domains.

This makes no sense to me.  Why would you ever want to unmap the
interrupts separately to destroying the domain and why would you ever
want to destroy the domain without unmapping the interrupts?

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

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuKx2AAoJECTWi3JdVIfQxiwH/jAuFQBdbAAeYzqrLh20S0k0
WjVD3YictKbY7mpH1v6THpnuRi0eR09D0rWaCrhmAZloPGSbpL7W3x7im4mEXvCM
gEN04Hj5laJHlSLkeEO6sDfG542P3Gss54r5lEmMv4+a/0P/lJifWbZkwINxnj/L
/FMsDVNhZxbLfY0uzJoHujtfcB5U4GPnQUV3Yg1B43JKpOwDl8cdoU+rENMTKkK9
VgZZm3zqO/0fVfaaUF0SqP38YHUoEEjWF7bhM4qy3XOBBWg0lOX6Mf5TboP06dsa
mz6qqW5NVCBCQkRpAtCGtq3fyPVqJAYEhalwtCwpbMM0cFhwtZzeoLZ28QTOpak=
=V2MG
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
