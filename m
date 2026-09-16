Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33E346D562
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594608; cv=none; b=QvpM+l/qlZV8GAaZ2F2UOjKQnqjGBnuEL6/iLfN60qMf4+U/oT3VOCWJ5Mbl9p+73U+pF65ytaC2NkHkpb2Yqop1RRFvJ6HE+grlT4Dk2By3aLiDO2QTtMpVIXuOGb7267OLVQmRatWaOuWo712LjQjcV8NxCPairkyhKfeaP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594608; c=relaxed/simple;
	bh=VG952ucKyWBOJ+kWu+uDy0Z77W/+l4kXJN0X/n/hRZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1SsJVynFnQbcpVPsvxDj/dDcN0WmNUWew17k11n8vKH3L5GA5ByyK9wk/vB7HcjTT+kr7kkxttk9ZuhDJ/TXzEkS7LJEnTXRlH5m3bl29N6Pg/ks5fjGQc3Yb26Y9HgEQUUplvrgwOBMZcEgCUTzZEtvrKv6CE0+APEvVEjv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Oq5j8jCg; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Oq5j8jCg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=VG95
	2ucKyWBOJ+kWu+uDy0Z77W/+l4kXJN0X/n/hRZs=; b=Oq5j8jCg3iM5ZmfBbUbQ
	H5epnLMIHbbpe63V5u5z8DEncnnRFomkLJNGmmOcV4NvNPrQ++O0r3pCjgGlywyf
	59nTCJR35rmop6K/i0WvKFZiuhmwb66a82NqM/mRQubEEW6XSUl45fsrPBuDcejc
	3D9OqOVfrZh9dNg2jopTSOQjp7OLpXHFv42GkGwBbUpukiF/ZD/zHYx3uSLglE6d
	hOoWS3aVILX56xTckdO3hdMz3NIYDcUTNcm5usRz2NzIzhpBHDSXc+B7y6++wx7a
	OE/XzSaleT2RN1HT2TSRkQ88dpY/w9zbPlZMpKWJYNM0eV8v0xnOTrXGuJhS3NUu
	3w==
Received: (qmail 1716542 invoked from network); 16 Sep 2026 23:36:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2026 23:36:33 +0200
X-UD-Smtp-Session: l3s3148p1@pLQKdqBbNuAujnt4
Date: Wed, 16 Sep 2026 23:36:33 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.csengg@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rtc: rzn1: add R-Car Gen5 support
Message-ID: <aqsL3cudN-On-ii8@shikoro>
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>
 <20260916102520.24288-5-wsa+renesas@sang-engineering.com>
 <CAMuHMdUzvSZUiS9JK2R7doct+NFEFmFy4sZNqerOwER-6wnJ4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ACYovTGWkZB3IFTf"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUzvSZUiS9JK2R7doct+NFEFmFy4sZNqerOwER-6wnJ4Q@mail.gmail.com>

--ACYovTGWkZB3IFTf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> As the DT bindings declare "renesas,r8a78000-rtc" to be compatible with
> "renesas,rcar-gen5-rtc" (which does not set the broken_irqs flag),
> a missing interrupt must not be fatal?

Okay, I'll remove compatibility of r8a78000 with generic Gen5 then.


--ACYovTGWkZB3IFTf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqrC90ACgkQFA3kzBSg
KbYsHA/+Jlh7oC9+kNcFH2EHgwPW/JWkkzNmDRD653+7TyWYcxYLLwrjP6wgOcTs
FVreKAWqbfZINpB5ysJfPhwi3+rFcrIu1RW916nN6PsidlN27mdWwpQffU1DDdr8
riMOUT894VSJNUpCSQ2DTtqwvlhjRiw5nxODvZAdv3DsUB21gdO+51uS9pIpYpUc
dyD/RIZS9KO9UYz/LhefFAQ5DYPBn6a0C7ySR2hMa5dBHHvercpPmcVWtVH+yEuH
x21m5c3nnjP8ZRnY/GM4TOotChSnTj3I+sp2CoMqBe47tvlrk2kmJjJPPaRb4ERK
bygfj918/w3Q2SvFREeYJTAlhlRycC7ZqQBbuCxFtfK6h7unqSNPXAGEUBpNFB7k
RsSkdUZi6SbdsC7difbH2NHI3G3dEN+/qh0JpSkaEYlzlfUoCDuMXor4QvpjGBay
YItZHlRVMomOr1b1jqcUlqBdyD+4X6+lysxmK0Nzp5NiMhNuebNvAKVeTcaRE8ja
SHo38ewBKPFo9oqv37L2dK2lU+tCLSW4L6ed4qrxf0a9snf41BbVJLj8j4Ed66Aw
w4V4zSJ1OFVPGrnC5NB3E/Q9t8/lEta2SFMnx5xSTH9B7pJiWftwUFZb8LRF+C9C
n5Uaui24faRxPTpPvS86gQkHJDrKeaIfoaeSmPS/K73BZCaHdwU=
=i8N6
-----END PGP SIGNATURE-----

--ACYovTGWkZB3IFTf--
