Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F364CA29B
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325407; cv=none; b=bXFECC5dardFZ2FB3POsokxTOv3VEB0j6TuUR4ZNF319K9icEHiEHv2ttUqZnk2usXpseQwO1w1SFOt1XcjYS3T9yavF69zur78i5f8gN1/tM+rWJQhpHfSdA/3Mhy8zC1sZ+BSb4u0aFzmOwtCTCe3i8NvH2K19z5R8ZdZLFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325407; c=relaxed/simple;
	bh=o3Lcv7294PYDl4eNoalDF2t1m7dQzMqN3DbY9Se2w9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu39PFC5jehDK36qnK1HC5k58hGseWVT0xTwcm2JYRtZA9as3nCLoSDu+aDhgz02jBh/vtL06rwlKwZAcrz8lgOCTyH69oV1E8KBx2EpCmwDoGGjKjPBKnnd6zDfph6SyqsKzMXxs8YhNFJ+BVdJAWxilBiNoVG9tVCTDuMqFjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=M4gE6aYG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="M4gE6aYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=o3Lc
	v7294PYDl4eNoalDF2t1m7dQzMqN3DbY9Se2w9A=; b=M4gE6aYGEBCyCtzBkEWs
	495czcovPHWppAyyz16rSCxqSCAGREWqL77bBHj92pM9o2ouCi+8a9GdPnOlF9OB
	YR4wB2M0xmXcZ4PjnjkWWBeTYHkAfmKPqVC0vXI+Y+H5HRgzg9eLHfnkTHnvfw2G
	DK+AvDI0P3LtIqKY9xH8vJnK69yY9D7kT9JD02WlNvopAvzCuEzDPXJX1jToD6So
	Wt6/g7W1JxGiUYHaG2vQGfThI/r1Q9W45fl5fBQYtB1Rd3CGR8hEggn2doB03lFL
	SXybuE9Pr3ZQMbRL5MeTwFOtUb+Z72fiiTR8xalYJ6KVhdFmrfRFY2VshgzSAhdM
	jw==
Received: (qmail 690933 invoked from network); 21 Aug 2026 17:16:43 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Aug 2026 17:16:43 +0200
X-UD-Smtp-Session: l3s3148p1@kaHAH5BZBokujnuu
Date: Fri, 21 Aug 2026 17:16:43 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 15/17] rtc: rzn1: Add OF match data to gate SUBU
 register access
Message-ID: <aohr2--OFXSZQfXM@ninjato>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ss9qUP/QcvfJ7SzW"
Content-Disposition: inline
In-Reply-To: <20260821135608.275233-16-prabhakar.mahadev-lad.rj@bp.renesas.com>


--Ss9qUP/QcvfJ7SzW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 02:56:06PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The RZ/N1 RTC driver selects SCMP mode only when an optional xtal clock
> is provided at a valid rate other than 32768 Hz. Without an xtal clock,
> or when it runs at 32768 Hz, the driver uses SUBU mode.
>=20
> However, the RTCA0SUBU register used by SUBU mode is not present on all
> SoCs that integrate a similar variant of the RTC block. Allowing SUBU
> mode on those variants would expose RTC offset operations that access a
> non-existent register.
>=20
> Add OF match data to describe whether the RTC supports the SUBU register.
> Reject probe with -EOPNOTSUPP when SUBU mode would be selected on a
> variant without SUBU support.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--Ss9qUP/QcvfJ7SzW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqIa9oACgkQFA3kzBSg
KbZmohAAlbQrTMY/kAJHtX/JW02vtUjcZJNZmT4KJLd8NQKqO0VNl91s4bne9WAm
d3Riaw5mXpTHamBgq+QCNXiI2ZuzR51MRI+Ex8TBshKntX/lH2Oha+Y8YO8rBy+C
Mtn2CEzw6boOjpbMEeMbtbncKQmJCjI2Pqhws+cOzGFpVi7D30qFYgDvqslgt5tF
EwGarugDGvRLZnmQIOkKSE94TFg7NaMnacH1rDEfpAzW+IxyN9okL+bwNMVNyM9U
P4DA5LBEEJzcdqltiiBarYnmQ/bQNTb9dHQpCy0hBNLZC6yMR8QXSz7LtXTobqnZ
fpUaz8C64U8b5SHtcUG8HM2vSdjhGZwoB6fMKJiqvrVLjHLYnYvQinQzxmK3YJUF
c0mc9i5gl6Fxg4NiSfhp4OT2jr6NG1tugwzOwwfPiYFs3EMMk22M+tADNbOYi3cf
BPlnwkPh3kt/tOBDWA9iA30hPn+gn4GX8A4+BWjnSDIFqz6HnObQvSHNDH1PHHEl
WkZLMzihbttQZCURr+dPXvv6Mgg1pxhsB0XKCPWhQiOaTkFY9Bm10XCcYf048ejl
aqo6sOw8ABj8J8sAaAjA3s0a2hii4NR/2JM5/3MCbwtUiP8tgBWpkqPrE/yxqM+a
Je+wIq4Y610UI7ANmb5d37Fdj25GJ0oqneA28Q+9egkfvmA807s=
=Uwz0
-----END PGP SIGNATURE-----

--Ss9qUP/QcvfJ7SzW--
