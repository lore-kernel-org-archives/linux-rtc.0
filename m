Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285D63B4EA4
	for <linux-rtc@vger.kernel.org>; Tue, 25 Aug 2026 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686753; cv=none; b=XuypGOtahL6/bjqlfYO5eyjRBxhlPJGw1LLYduq9jS1/STwENpUCBQJgERnBPZti5hUY9EjVCHbghAd8AIY/Cjnbc+6GdpJ4ZJ1qdaEDC8P73yl6qYDc4neItGrPL5DBzCGnAp4S55kzc+KsYiXyaN9AZj8fgjUKKlmE8EiE0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686753; c=relaxed/simple;
	bh=wJlIrnPa1ELGKttibf10LQqW1x5icmf3RZbUmWgO0eE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U51W7TYts5Asi/Gj3D3nxRbwwxZFcqt056QQJCrFeJj1uk7t4sNp1aOR6XLd3VDjaLZLIUPkzxAvSVdKIz1pVRb/kwtLHucj8r95j647mZOqGllMS+TMHoNj6399FLR297Z4grEpNDFftTwXO6IlxKyHiH/UFV5VDC5MrQ2XrUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ZjV769av; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ZjV769av"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E0A0D240104
	for <linux-rtc@vger.kernel.org>; Tue, 25 Aug 2026 21:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1787686749;
	bh=u8kvdAmzPEum42wdXGKSH8TfZE8hg9/yVfvI2oRJMLA=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=ZjV769avtv2aKu/6SniJd1+SrDT332Xx5cS87vedsN5uH0w7HJ6uQskpcNH0a9/vD
	 tkm14i1KYL58gbEOIsKOYXoZatkgH8ZD4oc/bynbbTD7Dstf/y3sMPdz6bS9R+uJwm
	 Yf7zbRqk07oVT892vRUZysMEesu1ri8xDXk9ucgtFryUNFM3whQZsusbVrpXNwLSSf
	 jMqf8aqvhWEi2lniyz0QSNMWc0puoFxcE46h56vg8FubFiZgAhta4fcLxQci9PZPzW
	 Nrpfw5iE5n48bEHCf7ao9saKY6kkZRxvCgkWsU7z3IUcrTvzvJMH6R50g23mpZPpRN
	 Y7rmDEhQej2EA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hTylJ6cG7z9rxL;
	Tue, 25 Aug 2026 21:39:08 +0200 (CEST)
Message-ID: <b40173948eb2150fcac0983b13781a3f7690488b.camel@posteo.de>
Subject: Re: [PATCH v6 5/6] rtc: s35390a: Add pinctrl
From: Markus Probst <markus.probst@posteo.de>
To: Linus Walleij <linusw@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org,
 	robh@kernel.org
Date: Tue, 25 Aug 2026 19:39:09 +0000
In-Reply-To: <CAD++jLnpzMs5h-k49HQ_asppECRMm1wGQK8X+vTmiC+S70fZgw@mail.gmail.com>
References: <20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de>
	 <20260824-rtc_s35390a_int1-v6-5-df96569e3412@posteo.de>
	 <20260823222611.B176B1F000E9@smtp.kernel.org>
	 <CAD++jLnpzMs5h-k49HQ_asppECRMm1wGQK8X+vTmiC+S70fZgw@mail.gmail.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-b4D/z1X2q9gJ4181j8By"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-b4D/z1X2q9gJ4181j8By
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-08-25 at 21:28 +0200, Linus Walleij wrote:
> On Mon, Aug 24, 2026 at 12:26=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>=20
> > >  config RTC_DRV_S35390A
> > >       tristate "Seiko Instruments S-35390A"
> > > +     depends on PINCTRL
> >=20
> > [Severity: High]
> > Will this unconditional dependency cause the RTC driver to be silently =
dropped
> > on platforms without PINCTRL enabled?
>=20
> Maybe just select PINCTRL then, it's a valid point.
There are no stubs in the include headers for this case, so then it
would be a linking error on build.

Thanks
- Markus Probst


>=20
> > > +     err =3D pinctrl_enable(pctl);
> > > +     if (err)
> > > +             return dev_err_probe(dev, err, "pinctrl enable failed\n=
");
> > > +
> > > +     /* If no pinmux function is defined in DT, fallback to previous=
 behaviour */
> > > +     fallback[0] =3D S35390A_FUNC_IGNORE;
> > > +     fallback[1] =3D S35390A_FUNC_WAKEUP;
> > > +
> > > +     for (i =3D 0; i < ARRAY_SIZE(s35390a_pin_groups); i++) {
> > > +             if (s35390a->pinfunction[i] =3D=3D -1) {
> >=20
> > [Severity: Medium]
> > Is there a data race here since the pinfunction array is accessed lockl=
essly
> > after pinctrl_enable() has made the pinctrl device available?
>=20
> That's a valid concern.
>=20
> Yours,
> Linus Walleij

--=-b4D/z1X2q9gJ4181j8By
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqN71wbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSotgP/0t6GCyBRcvR4JG1E8nA
zLnCL9t73syLikqCQJ0Dnbevg9ZZmxDK8lF7jDtccRgcTtAE1oyZJtClVQdwCb0y
AMjBsZ+QncibPk3h8Yzt7XU4BTjo/2bqMGBVACZ7Ega/5v6cE+HfmU2rK9zHsTX+
/5jGBGHmtplraVO4Dr7G3hz4d49bTlHN7mTEaRhR3qb4656v773J+fmOCLLAGW5F
YbuLfwlWDx77bsTrFaRczU76PWHMcKI8hqztY0P/2twKUq+MIp9SblwyOfrtg9sU
sNlDjP3S2S++78QJ0z7CrN/7kb9NuK5hnQFF/66gIj+AgzsWqy09YUKPKruzn09F
q11dIvGfBTvZur/+zag6lVGcMl0xpO6N2h0DMmXLY2ShLrmr8MGnjoUa8xp1qugX
Yupu4b739T4OQq1PFB+S3jFwKQ4tQkf++lYuteDtz8IzNEDe6/9xRb7uKew1VsMb
aFs1twZKV0LRyjZvFpzWiGLzdzVHitO2aBg3e4kBKZLENS+37WWBCmKGxRVvyqIp
PJeuGrtODe4CadALNwQJDEU8QAbeuMACmfWFRmwsaBlohNwWzHGYmrqnsfI3qKzk
WWOFNgsEaDVvaLafdklcKa7mbnIcIknYxhKYynY44RGB22Aexcw9ZKjmvtMtwz+X
vMw50eiQ54ajl+qW6GP0hm2B
=uZf/
-----END PGP SIGNATURE-----

--=-b4D/z1X2q9gJ4181j8By--
