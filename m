Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30FE309F00
	for <linux-rtc@vger.kernel.org>; Wed, 17 Jun 2026 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693391; cv=none; b=bHZNDHMH+VOACW72ffjBmyryCPYOfXWGcw1kNxNNtIJxcnr/0bzYczjMRqWigrugkxuxLhwC8NoeBH3Z8im9+2X6BAX/VfCB0YXQnphF0QoOnPIsbgDeo5VLWbq4hu9IQlXwPZXx5/1dMv1wMNeXl8baYaBwZTldnpoJVWkKxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693391; c=relaxed/simple;
	bh=Nn8wg+Z7wUOkFoafAMDetdLdfHYSTwcl3VKFqFeYQVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkKaqri24G5dPMAANRkyPPATmdAgwKGaEK+/0SZgbdwIO8otsofUR143Z6ZQB88pZwoRDzoB3rc40t5sA8iC/cGqJI3ZzxrD3kUtt+jKwtwtePKEBwJal2QIJ3ZrOrGW9XN6/xmh1y0Ult3z6X5KbaI7y5lJwB+CFnEfHSmZbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mRauZSft; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mRauZSft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Nn8w
	g+Z7wUOkFoafAMDetdLdfHYSTwcl3VKFqFeYQVU=; b=mRauZSft36VdjuVkqN+u
	in674LwuXVeCuqVINMgKusKwc/ToKD9V0WqTpr1HSZ2cVbMZi9S4cL2boMgn80OY
	V4GYq/PBk3msrtAiOQzMa1EuELzwUYrP1ufK6+M1ecsoKIN9ynKJrbkPKDVxdezG
	xSrc4p7nR/uIjCWHcoRBMdz4hKFxbvdnn6ctUpVX3Pv4Zn9X2qU/1AUldogyZ26T
	0L6hNH70omm9PL159CEMsQqMko/Tg3cg2lsOoxIpNnBj2WvIhJW9q75JSyOezVHi
	9+mNKafLtWbkMH3QNmy6RoC9lzmRpUxM+S/Qs0VhWUAkH/zVs5SX34lGzaJgksas
	Og==
Received: (qmail 129810 invoked from network); 17 Jun 2026 12:49:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 12:49:44 +0200
X-UD-Smtp-Session: l3s3148p1@aS9K0XBUep0ujnvI
Date: Wed, 17 Jun 2026 12:49:44 +0200
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
Subject: Re: [PATCH 07/12] rtc: rzn1: fix alarm range check truncation on
 32-bit systems
Message-ID: <ajJ7yHNW9FnASuTW@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2C4IQubKzRsAj3ev"
Content-Disposition: inline
In-Reply-To: <20260615154805.1619693-8-prabhakar.mahadev-lad.rj@bp.renesas.com>


--2C4IQubKzRsAj3ev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 04:48:00PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> alarm and farest were declared as unsigned long, but
> rtc_tm_to_time64() returns time64_t (s64). On 32-bit systems where
> unsigned long is 32 bits, the assignment silently truncates the upper
> 32 bits of the timestamp.
>=20
> Fix by declaring alarm and farest as time64_t and replacing
> time_after() with a direct signed comparison, which is correct for
> time64_t values that will never realistically overflow.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

I need to postpone testing this to the evening. Setting alarm behaves
strange here for alarms beyond the one-week-ahead-limit. No error, but
bogus values. Seems to be irrelevant to your patch, though. Does it work
for you?


--2C4IQubKzRsAj3ev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoye8QACgkQFA3kzBSg
KbariBAAsh85CuzWt8H1+maznXMXpaoF/5nizSXqhd90y0Mh3tsMOJrw6eoH8iFu
Zy305N03nRDJPHNBXX/KzTfNnCbZaTVtrXq8K4sC6AaU69D3xAFaPAd5+4OG2nU7
Y1fQPTx5+GLP05CoBQcvbro82f2Bq7KjB2eEVJi0tZd53AgQ5W3q0eC5+soh5UWm
/N/Xpcd0DDTKzaINlQKiqTDSuxvvqKQf+YQKvoELLPAOLblE6POm9XR/Cyx0uQzx
XGVE8DK+MaxMh4M442CjHeW7iIB4wWXEdZpGSTKijjOsyfqZeMYSCxShPo/Cdx+p
CZtNOEDZL+0bqalhsDp3atWjK5N5/r66yNczdL1kOrLKVCdNcQXbTM5gcqhlt+eD
fDseLSjM149WRev0dGjBd0Hll7XkTiE+6uu13nBG7khwRt6nUKCZvJpwpaIb8cCv
BDnqhEI+kLs7zMKsGLhQsvYYRS1wgLIybHduFV6mzvmfKjR63Sj7ezehEDzmfiHS
WSa1iBOJ9qTJREUAug41C28BdxA3Kmvgpqu8PcOaDQtbILOQdo//E0750+04yUlE
RN5XN/MHGrWkmifey/PanUt2vr/PiqEOaSLLnFg9hmpaQeMI5Vtwgs6dr6qPZ4JC
6/DSdk6GvcT58r39TFVQBdMcI98urPlSzCr71aPlXgVpnFHeWU4=
=nvKZ
-----END PGP SIGNATURE-----

--2C4IQubKzRsAj3ev--
