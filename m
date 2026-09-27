Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DA83B3C1A
	for <linux-rtc@vger.kernel.org>; Sun, 27 Sep 2026 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790525662; cv=none; b=QqsR+iAz7PejHj4DfhdbudU/8OKBa3sa3AzfpDm3OzEvr9x4WsG0Hi2BtGzisa22gDBCjqtUkJsQz59YjC+F/QYvF9RNSFoICtvJV8DlTe/gyYVSskWPaa3UAKOPGQskcFDr98wtu84gssZyG3uQQv9HIrJPcDsEZ6QgGLBruEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790525662; c=relaxed/simple;
	bh=EJmIRSbA4D/H5ocTDwMMhwDoh4r9pOXceDFPWqnH6Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RswRpIpWJUiVILXF5y3py9y4KjuzURVmkbXbTwAuQG0meSiIhvk2SPGODBRhcBKrsX3yF44frMqlEqyS5NUXV5JaPPi8QQHGJUPac+zzi+3mvVkUa1FiIvJWvaHoD8MuMRLrENR1nmu919rWuQi4Dvm/SGFn13elcZ3x9aIDNk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=j9MJ+A4n; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="j9MJ+A4n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=sXUo
	XPzxvaoW40i4S/CxP5jNmg4aFDgXsOGSZjd+z0Y=; b=j9MJ+A4nDOyRUjO5O34e
	DHRy8B9uVaHI6IItRaiBTIs+WGo3S+am+14Hy/eep7toyvA4Tz6G+gHFEBfszGfr
	pLS584PlzWkkJvwdbICPmU/+T8O5whu1irJo53enJO19Wtmn2Dxnpz88izjpbyyb
	8ZdFULCRfCrs7WlhB0G+k6lU57Nv7Q+8eTnMjn0PA5bnNHolbOejGyoeOSqI2kkk
	fpxJZMMGARDtVxVxzQPgXdmuO7vm8WobSHBbot7kxlCGviim0JzS6vdAz1cU0MdW
	6WUPOtygTrSAEMJIVvFFuuqTSAGcD3kenmxBIXY2fRtmOjSI/FHPpim9zdpQaJS3
	HQ==
Received: (qmail 2691713 invoked from network); 27 Sep 2026 18:14:15 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Sep 2026 18:14:15 +0200
X-UD-Smtp-Session: l3s3148p1@Wd2qPXlcqLkujnuD
Date: Sun, 27 Sep 2026 18:14:13 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: rtc: rzn1: add R-Car X5H support
Message-ID: <arlA1YuH709wjtHm@ninjato>
References: <20260917111349.52250-1-wsa+renesas@sang-engineering.com>
 <20260917111349.52250-4-wsa+renesas@sang-engineering.com>
 <CAMuHMdWy6ksspwvj8jRxf6_OATU5rS5p92KyG4+sEF+ag7S9NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gqq7ZMXFblGtRwML"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWy6ksspwvj8jRxf6_OATU5rS5p92KyG4+sEF+ag7S9NA@mail.gmail.com>

--gqq7ZMXFblGtRwML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +      required:
> > +        - interrupts
> > +        - interrupt-names
> > +
>=20
> Sorry for missing this before: the "resets" property is
> completely missing.

Yes. Prabhakar, looking at the N2H and T2H DTSI files, I assume that
those also have resets for the RTC and only N1D has none?


--gqq7ZMXFblGtRwML
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmq5QNUACgkQFA3kzBSg
KbYqVQ/+JTXX5yQ5EhkWv54M4767sEDS8p28x7peLasQhUa2AvlMJVnGGd3bZq4d
h+PRN4mD9ILXcfMPn7LT9j4zQJGisF7Ngh7R2v7hOb2a8IH353WV0pcKPK8wb7nT
vCEBOZf4fQ/upXyu9al6fLfTMspoOybHsVUELsmYxR51+DdmSHElo88EqzuSaagR
kJEJOPL6yiSm+x9FG2X62pN55JifyV61cTgewrBAbcENnhckmKkjXdkvWjY7Si3Z
nDF6Uwjnw992v5ntU1v2ZY9DUw0KjFbr88mHKxo/667wzR3B+9Mk+ngWA/2vQbHl
z/osohkDZ1IBJdJvizqE084Ze7OcXtX78ZLrkw/Ad0ODdKIeOfQtlQLoiCf4UUm2
RhbOevukaWFIqH8rFu54hseJCypZZRMS0xP76DD1NuKEQahtVbU9HuHs5ksc2L1d
Jg93AqY/3v8Hwtgys86WBLF+Ft7yuogbY9oy3OS4E36AV6xT8aQifhC83F7hFwW3
aeuEPyjynDkmGaM94q1x00D54yJ59XQZrQK5x+2x5Zi/CfQ8nI0ZlulVMkO4SnFr
K/TptfArAJ84WnGWtW9p6uKj/zSywltEJbuRrHo2nrd7Jfp57ZP3/MDoZDLKUonu
mpu/ug6cTPKkxTztF5OZaYRkHsbCbREf7sKCTbEBnjYMkoS2lQc=
=qOvE
-----END PGP SIGNATURE-----

--gqq7ZMXFblGtRwML--
