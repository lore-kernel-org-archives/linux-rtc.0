Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88029D291
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144505; cv=none; b=m9UsUDnqRJXZQCwAZVpqive7wNO73XbWhBR+rZa2Vt8IuIootGE/R44rmCMTWGK4L7OiipwZ8fFGd+i9zufLn+apxrJjYR9SKb6EMBHv6P0SaWns9JZb7sjppLZulwreK9/Ra0x3rK0IDAPmABTRtBKmZLmYvHLUim4A3aPY09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144505; c=relaxed/simple;
	bh=wp8TGbisRW8gW+kdJD0RAvTV+2ZP24fjbMV6UB0mk1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+GJZ3SCofYXZqX6GmRcWJSgmfbu3dD1W9FmMSzVpBmk4Ng42jnLdMgLNarKn0aAHSWbDwt1FUybtf134cDzKd31ZewtMZNc60RRYVRAQ93EPBgVDok/ibAyR9Pe2dpaCKSX1qdP6S3PZ26wJPmbrHeS15Yom2iziCFr7stCjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=fIAdq57+; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="fIAdq57+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=wp8T
	GbisRW8gW+kdJD0RAvTV+2ZP24fjbMV6UB0mk1g=; b=fIAdq57+X4ZBpmxtZzEn
	fDLkyOcc+Zy7BDZDtKwFiI2bOp2j4AmiSMEKywNA9pJwY+gmedx8pe5HHCjndFry
	jT5jKIV6hEyQXCAI2Nmz8i390/yUs4ym9ein5MTqbzvx64o+2yL+2cUrGPdYDd4y
	vMicr/U97JIQ3bwf3ZiddZ6vBPomJJIJ+km22VJNIx1nS02r0T395yt+U8njjXiw
	+vyYZZulQChvv1SU9VD66gAX/inaOGfbDr2JtuULPEJ5emTN9baKzD8/5/YqM+op
	SUwLcGa1BHREKzkW5Gans1/y2/K0F088NpXncV28+panoP12zU/fY8yzNWq9xavA
	RQ==
Received: (qmail 4145528 invoked from network); 19 Aug 2026 15:01:42 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2026 15:01:42 +0200
X-UD-Smtp-Session: l3s3148p1@yYQuAWZZjWJtKXGR
Date: Wed, 19 Aug 2026 15:01:43 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>, conor+dt@kernel.org,
	linux-rtc@vger.kernel.org, robh@kernel.org,
	devicetree@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 03/15] rtc: rzn1: Fix weekday underflow when alarm
 crosses month boundary
Message-ID: <aoWpLvrNGHBPvFY5@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819105356.BD7731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SMyub7+rJAR37Ee9"
Content-Disposition: inline
In-Reply-To: <20260819105356.BD7731F000E9@smtp.kernel.org>


--SMyub7+rJAR37Ee9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> [Severity: High]
> This is a pre-existing issue, but does this time_after() comparison
> allow bypassing the 1-week hardware limit on 32-bit systems?

This is fixed later.

> [Severity: Medium]
> This is a pre-existing issue, but what happens if the RZN1_RTC_ALW regist=
er
> is uninitialized and wday is 0?
>=20
> Calling fls(0) - 1 would evaluate to -1. If the current time is a Saturday
> (tm_now.tm_wday =3D=3D 6), delta_days evaluates to 0, which bypasses
> the if (delta_days) block and leaves tm->tm_wday =3D -1.
>=20
> Since the core function rtc_valid_tm() does not check tm_wday, would this
> propagate a bogus alarm date to the caller?

This looks worth investigating to me. On RZN1, ALW is default 0.


--SMyub7+rJAR37Ee9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqFqTcACgkQFA3kzBSg
Kbag4RAAsMRHDOpMNLJabJXwBAWJUK2mWCnzfDSIETzpqGyx1frm+t8YpZXjOxIT
RRKRx+dk539yoAwSv2Bz50yReL8UKMt2orjSx+UpdDhD4npHRX/llRvyITsT9mUj
p0LwMqTuc3TTXJrWLo0hi5DARDbx5oYlT76urMRIJXNhI4MOt6h/IpC98VD3bZio
X+wn7nfFCB7dalElBZ/lQsdm8WQliyjfi8HpjPzhQmIsv8D5qIzgh2i20XQB2ydR
WkA3yUn3/Li/scou0NJjrgUwsHb+O+BsHU6e0P0BDQOXU/L44V98DOqrcw7BM9bQ
F2jfCMlqxPM9Bu2GjS6k4SWfLjze8uUu1X1zpiqVMZ47w3oCgmVllQsq/+9YfO3z
Uyq5Uq/lf+hgkMIkftkuVM6rWhyEf0Lanl2jB18N5coqiwQLDcblZBjTgDEwb8yx
2EChf0IxabWZjXSFUy2skVCdC/qZ0WzvyAgYZOZZRbNBb619ukQSmR1sR+RKVz66
wPXC4qqAMDAVM/bYJVOdvWyfdwLmQyg3cgE5e1oXhJVDMEsJo8jUXE6xMKk6RWV0
tqgV0qr+yVgEncnCJQWh0L3cHD2ay5LKnWBcitoPRfxmbLatKQqzo0tNDNGRR5RW
PTvL9ChDJdz3yuTORyyH39N3IRNwsbxwiaCyXOXQyipQXC7RMo8=
=xS2V
-----END PGP SIGNATURE-----

--SMyub7+rJAR37Ee9--
