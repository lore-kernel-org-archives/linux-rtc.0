Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251E367B69
	for <linux-rtc@vger.kernel.org>; Wed, 17 Jun 2026 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694384; cv=none; b=Ne1HTIffhDpc5BOa/6LFHBI83nOvN6rFEwUt+pfToXIimL4dka4TOhj3ng2yNSGrdYZg/baxYnRPLbhN13ls+4TM7oyfzY03noifZ/3U/N/bG1XNQngYGKwo3LAunvvHunFxck9NoXXzMz4qWv7gkVkKtf67mngFBmwWnk61fTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694384; c=relaxed/simple;
	bh=0THx5+qYRNGW+HxuauuYKf8IJDZsm8bKUYF5njwjDjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNA8zjoplLVyMEjUdxuPEFQw4W9Pm/76qPDRyfXNlSua2IuV0sPYjOZ73BA5mNgAkzGu/JAX0pAYQCpVLF6jii2iN7Vyku6gVGnKrwbece/Yo5zI9X1OMM+eLNkOEXcrMMXo4lxQvmkNrdFIWlNGn895CIS5GsO+bYbrOhj8sJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ldZ6BhaR; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ldZ6BhaR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=qksj
	FP+05egnmvGIn5in6IpMSJk0omUlcHLXx1EB7Oc=; b=ldZ6BhaR0u4OI3DbcTu1
	S3ie/lTSLRPDM9NSGaDAJ3j81vog1h38LjKUkFUQPp5EU3zj4YsUJms9VVzG16DQ
	MNxfDyj7Rzz3gDECnsqzT6l0qOHYWZsP2Pd5OqyzbGSYHqTsNmRq6/MOA1xuAFlW
	lGQrQQ9RwvqpGkBdgq4dxo/RMoKB72/dyc1M2sVAmJZgSjCKQOHugUTK1OH62tJV
	6yt+VPXLbZZHAJejQBRQ1VoGCzud64dGIuG417UDACY+YzKGx35WN9l2J2KnuiYq
	lbSZg4Cx2V27J7O/P4xY8pecdPBrwSFlsuuirFkh1EYHRJY8KeS0BYjlBDK8vyCS
	8g==
Received: (qmail 135587 invoked from network); 17 Jun 2026 13:06:19 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 13:06:19 +0200
X-UD-Smtp-Session: l3s3148p1@+zuYDHFUOsUujnvI
Date: Wed, 17 Jun 2026 13:06:19 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 11/12] rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK
 for register access
Message-ID: <ajJ_qwXhJbKB3Xli@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qoqhCdtVLbZfwI1c"
Content-Disposition: inline
In-Reply-To: <20260615154805.1619693-12-prabhakar.mahadev-lad.rj@bp.renesas.com>


--qoqhCdtVLbZfwI1c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sashiko found issues with your patch. I curated the list and left only those
which I see as valid. Please have a look at these issues.

Thank you and happy hacking,

   Wolfram

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Incomplete refactoring: open-coded logic remains for RZN1_RTC_SUB=
U_RTCA0FX
> --
>=20
> commit 2e16f66c80c483d619655d20fbb859a42e9d1b6d
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for register access
>=20
> This commit replaces open-coded shift and mask operations with the bitfie=
ld
> API in the rzn1 RTC driver to improve readability and match the hardware
> manual.
>=20
> > diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> > index c7ef3c81180f4..9f9cf9882fc49 100644
> > --- a/drivers/rtc/rtc-rzn1.c
> > +++ b/drivers/rtc/rtc-rzn1.c
> [ ... ]
> > @@ -306,7 +312,7 @@ static int rzn1_rtc_read_offset(struct device *dev,=
 long *offset)
> >  	val =3D readl(rtc->base + RZN1_RTC_SUBU);
> >  	ppb_per_step =3D val & RZN1_RTC_SUBU_DEV ? 1017 : 3051;
> >  	subtract =3D val & RZN1_RTC_SUBU_DECR;
> > -	val &=3D 0x3F;
> > +	val =3D FIELD_GET(RZN1_RTC_SUBU_RTCA0FX, val);
> > =20
> >  	if (!val)
> >  		*offset =3D 0;
>=20
> [Severity: Low]
> Since the stated goal of this patch is to replace open-coded masks with t=
he
> bitfield API, should the remaining 0x3F masks for this register be update=
d as
> well?
>=20
> In rzn1_rtc_read_offset() just below this change, there is still an expli=
cit
> mask used when calculating the offset:
>=20
> 	*offset =3D -(((~val) & 0x3F) + 1) * ppb_per_step;
>=20
> Additionally, it looks like the write path in rzn1_rtc_set_offset() was m=
issed
> entirely during the refactoring. It continues to use open-coded logic rat=
her
> than FIELD_PREP when constructing the RZN1_RTC_SUBU register:
>=20
> 	subu |=3D RZN1_RTC_SUBU_DECR;
> 	subu |=3D (~(-steps - 1)) & 0x3F;
>=20
> Would it make sense to update these locations so the bitfield access is
> consistent across the driver?
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615154805.16=
19693-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D11

--qoqhCdtVLbZfwI1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoyf6sACgkQFA3kzBSg
KbZi9Q/9GBJ5Di+O1ULPevojmat13Cjt8fiBSizyGqxILP1IBFNY3lZ7dS+ePFpF
5rfwi2rMD/yspislOtOScWAmI2IvGE3KnC+QYPXRfHNyhRmoTlbtT/HdB4sw4Kj9
cB8rP7vIoWETJAMeb7lawqIgy9RjTHnjO6g+EJkIjPhR3jB/fFS4igbFpZVOQFSN
Ch0Lx42yDEB2sVHrgg/k0DaOVLWBD7ccwJC1XLRf8T8HKU0/jZxPvCAGF7dcVeps
vUsxFEvM1xAuvP+keeTMAv+LYBldaF5/L9s0qGk8UsmO/rCZ4GbMr/dkzQSyKhf4
//REnqb1G8848MjE8iVPCW1vhMtnbVoDTWrsofGZfgt5m+PQkG+XHZCSimK3v0O/
icnJjbQIkLZd/+7xg7hC6518hCYW5PIl0Nd255otiVInuiUA/D+IFMh0XXDhKzqM
8wid6YifYD31Ls8qcJ5G4+hkVrA4BGnHgvoenGxY8kWWqgP3Tkcvv/CwXa6nVrAT
YaU2ygegxHI9DBTRBLYLteJhWFNb6kXokc5a6odwCKCV4kuS49GvKzzsQ2m+9o9G
2Bkb71O1Y/Ie6F6riMvvpTSLRuwX0hZkwPRuB2jd3J0B0Q9YbuZHwgTTLPEteqvV
DQjOuZo0FmwflvVteRPsY0HX5uRjvzObr1RV5IQoCvz/jgSDSyw=
=dgdV
-----END PGP SIGNATURE-----

--qoqhCdtVLbZfwI1c--
