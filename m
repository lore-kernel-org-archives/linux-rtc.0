Return-Path: <rtc-linux+bncBDQ2L75W5QGBB4MS4O2QKGQEL3WIVDA@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id 12si4127788pfb.1.2016.02.08.08.59.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Feb 2016 08:59:29 -0800 (PST)
Date: Mon, 8 Feb 2016 16:59:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: lee.jones@linaro.org, alexandre.belloni@free-electrons.com,
	k.kozlowski@samsung.com, javier@osg.samsung.com,
	gregkh@linuxfoundation.org, a.zummo@towertech.it,
	cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Message-ID: <20160208165912.GK7265@sirena.org.uk>
References: <1454769447-785-1-git-send-email-ldewangan@nvidia.com>
 <1454769447-785-2-git-send-email-ldewangan@nvidia.com>
 <20160208145550.GE7265@sirena.org.uk>
 <56B8C484.7000309@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pN9MePJoZbRKbUk1"
In-Reply-To: <56B8C484.7000309@nvidia.com>
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

--pN9MePJoZbRKbUk1
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Feb 08, 2016 at 10:08:28PM +0530, Laxman Dewangan wrote:
> On Monday 08 February 2016 08:25 PM, Mark Brown wrote:
> >On Sat, Feb 06, 2016 at 08:07:22PM +0530, Laxman Dewangan wrote:

> >>Before removing irq domains, it is require to unmap all
> >>mapped interrupt from that domain. Currently there is API
> >>to map the interrupt on chip as regmap_irq_get_virq() for
> >>creating mapping. Add equivalent API to dispose the mapped
> >>irq in irq domains.

> >This makes no sense to me.  Why would you ever want to unmap the
> >interrupts separately to destroying the domain

> This is the requirement from irq_domain_remove(). This is what we have in
> irq_domain_remove():
> kernel/irq/irqdomain.c

> I am adding the API equivalent to regmap_irq_get_virq() to unmap virtual irq
> here.

This does not explain why anyone would ever want to use this interface
(which was my question), why would anyone ever want to do this as a
separate step?

> >and why would you ever
> >want to destroy the domain without unmapping the interrupts?

> That's exactlly we are trying to do, unmap interrupt in client level before
> destroying domain.

Again, why would any client ever want to skip this step? 

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

--pN9MePJoZbRKbUk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuMlfAAoJECTWi3JdVIfQc3wH/2FjUQzwY5sqMGy73YvPz10D
lzxgxDTsgYrlcrC0xxEBTpxhpdhk7qN++fCs7ttLDAmTdP//QCGPTSzZozwMqZSI
wAMCXMcVJrplpyuB/4CYLhRHN0ig0pvf8ATIv6qD6DTX9fYjf2DI6YXIJnit5vk5
q/Rn36/sOcQIFZOCjOX0B32w1lNVJP3NqGRbQvCPSL2j/ouK2yZKk/nlOiV0xT5l
1pf6Ww4z1JcUUzjZpGKvy+mY26Da7pbzIWG8EkoPYefqr/GHBRK/yxlUNivJRlgi
k6K8ncz9HKJ9QT/kZVoZuQuRs6W9JGL4SHboQaTUWqhAYg7gsyq/uUaB5S4o6Xs=
=a332
-----END PGP SIGNATURE-----

--pN9MePJoZbRKbUk1--
