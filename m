Return-Path: <rtc-linux+bncBDQ2L75W5QGBBNVY4O2QKGQESV7QIYA@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id ff2si1782828pad.2.2016.02.08.10.19.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Feb 2016 10:19:33 -0800 (PST)
Date: Mon, 8 Feb 2016 18:19:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, lee.jones@linaro.org,
	alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com,
	javier@osg.samsung.com, gregkh@linuxfoundation.org,
	a.zummo@towertech.it, cw00.choi@samsung.com,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Message-ID: <20160208181908.GM7265@sirena.org.uk>
References: <1454769447-785-1-git-send-email-ldewangan@nvidia.com>
 <1454769447-785-2-git-send-email-ldewangan@nvidia.com>
 <20160208145550.GE7265@sirena.org.uk>
 <56B8C484.7000309@nvidia.com>
 <20160208165912.GK7265@sirena.org.uk>
 <56B8C8B4.4050207@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F7w+4yMapWozG0Ib"
In-Reply-To: <56B8C8B4.4050207@nvidia.com>
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

--F7w+4yMapWozG0Ib
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Feb 08, 2016 at 10:26:20PM +0530, Laxman Dewangan wrote:
> Adding Thomas in the discussion.

> >This does not explain why anyone would ever want to use this interface
> >(which was my question), why would anyone ever want to do this as a
> >separate step?

> OK, so you want to say that irq_domain_remove() should take care of doing
> unmap also?

My main focus is on the regmap-irq interface you are trying to add - why
would a user of this interface want to do this as a separate step (which
would require changing all the existing users...)?  We're providing an
interface to get the virq mapped to a particular interrupt in the
device, it's not obvious that that is an allocation and it certainly
wasn't the intention (this code predates us using domains).

> So fix need to go in the irq_domain_remove() to unamp before actually
> destroying the irq domain?

That's one option, but you could also do this at the regmap-irq level.

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

--F7w+4yMapWozG0Ib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuNwbAAoJECTWi3JdVIfQO18H/3hiMKQ+QTM4waCBdJpIUpGm
B0qZ5belH10BZbpD8mKfKDbvwqudDCsK+5UJcBrhchkp7cT+IITBuyhJ8JAGWVpG
bm850l2vQYaKCvARp0BmplppMe3FZTwYj1ASWYGBR/xMxBT1f0AyqlHYQKBQj8HG
tKPlSMORwCI6kT/jqZ6FHIWjYk7/wxrYnnaiyqRfgIa6xNcLuer5wD8L2WCpPdLt
svqcLULXDiJ7RRPcRybg1FT+Av2KLK0u28mUNvaOBvlBJLU+FriAYhc+Pd6YYBks
MBb7GTJNbT3CvPI0RWWvh3/bi4nOp/7sbqjRcf05MVjNCEXxEicVSrMIdhzuJoQ=
=gC49
-----END PGP SIGNATURE-----

--F7w+4yMapWozG0Ib--
