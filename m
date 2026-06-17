Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48A37F732
	for <linux-rtc@vger.kernel.org>; Wed, 17 Jun 2026 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689119; cv=none; b=CPxi897XV5N5nPLaANZH/WEiDD+mdz2kWq3jdXzsnhFDC9oOk0yr2aZ2co5hV7tHAWd0oe9aviUD5LCtG2fou3+H22aV8GlNyZIWKg5OGwUEfpGFvi5a0mBhvfoJqN71FRx8H4VnixIPuUZQU0s3dW0wXr/fu7Mxf7LP7cUFaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689119; c=relaxed/simple;
	bh=rgm36y2OpGnpfZDyJq45v+u5S54koPvVYpOixi6Jo6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/kT7o/U/XjKLegnjoNKDvMQ2jkYNwIZQE5qb+JtoZkQJ5aL9PIzKdd5LZL8TpEyjAo2P3Kydfq8uJlP7gqHL+Tj5VlFfiWbwz79eKnvV3VHCthMKfUXoUkM8ZiApTzR1IXKuXCOvLGQx4tdmttNQjCA6TxtxVXZ/1xfhXchAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XaPtupS/; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XaPtupS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=rgm3
	6y2OpGnpfZDyJq45v+u5S54koPvVYpOixi6Jo6E=; b=XaPtupS/JnmjRKBJ4YPp
	0DigDPNogMfztF9OWk+MC+NvlOQB/SJWWIdeGMxxyt1n7b0tuu9g9nmSqmlbgmuO
	VErKW7IZ8TQXGF+jI3kqVpN9vSKEWRkTFhGNl6IwHtYXoufSPNq3P1tkCxn5yLju
	w1wtD5mdq7A+OoUg+eHwDM4eyx51jlDosw9198ziES7uqKuspNXH+3vuxdQM6iUL
	XQ7VuoJxe/k6vVCGWZ7KajoslCiBn0x7l6vCxOEtsHCdzK84IsuNPhlWFhuZxG4M
	IAcOp+JdkuaMFRHD4xoIs5UiwY7O0eIQKd8GfjTDlsdqyUS6Eupll80dR67Bbzvc
	AQ==
Received: (qmail 106160 invoked from network); 17 Jun 2026 11:38:36 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 11:38:36 +0200
X-UD-Smtp-Session: l3s3148p1@2HrX0m9UiKQujnvI
Date: Wed, 17 Jun 2026 11:38:35 +0200
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
Subject: Re: [PATCH 01/12] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H and
 RZ/N2H support
Message-ID: <ajJrG51jysbJQujR@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9KewOfIgVqcuK8jH"
Content-Disposition: inline
In-Reply-To: <20260615154805.1619693-2-prabhakar.mahadev-lad.rj@bp.renesas.com>


--9KewOfIgVqcuK8jH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 04:47:54PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add compatible strings for the RTC block found on the Renesas RZ/T2H
> (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>=20
> These SoCs integrate a closely related variant of the RZ/N1 RTC IP.
> Unlike RZ/N1, they do not implement the RTCA0SUBU and RTCA0TCR
> registers. This is not a limitation for Linux support, as these
> registers are not used when the RTC operates in "scmp" clock mode, which
> is required on RZ/T2H and RZ/N2H due to their 195.3 kHz input clock.
>=20
> The RZ/T2H RTC variant also supports a 1Hz output signal on the
> RTCAT1HZ pin, controlled by the RTCA0CTL1[RTCA01HZE] bit. This bit is
> marked as reserved in the RZ/N1 hardware manual.
>=20
> Update the binding schema to require the additional clock inputs used by
> these SoCs.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko is wrong here because

a) TCR is the "Test Register"
b) TCR is not even present on RZ/N1D. Cover-letter misses that, too.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--9KewOfIgVqcuK8jH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoyaxsACgkQFA3kzBSg
Kbb8RA//b1xWUiwEPvJfSOWW96169F2XSyhe0K7AtnjiPwqycXdgnN67t/VyHqiM
ujexSHD/Xm5N/l2xIW7B23X+yXlMov5iZBrH4y1z2jS7DXafrlpyjy8CuINfUfcw
UfH9hBv4lUaudlXBXpHaofVlygOGHnCZQm8UGB6gyBPWCt7pK4hQ2Zq5EK4oMJDh
1yH0sZIMmrJLJwhECbtJFdcgoVxugiY4wdnjvyKZ+ukP/fTNYZJaDnwOf89uNMl3
94lsBSobIFs2x9k60KV1x8UKrcz0nuvbGOLzraplen1OrUmsUjgxtvbK1oe0goKV
nGoSHfIZXXULSvHGdSnMU3xWv0IPifJX+Mn3+QEsT1v4rhKLIyOVXwoQDfJk/BV8
0LaHrfy0v4y4Q94lchcm+SYBBUS6dE+O0GJQ9n1WCaXA4oYY2O0LO3wpaviVwftC
kBCatWPQi0AWe2IXUr/EOBaq4Z42XK+ecctJH4EBAbkRJZNveQ3nJea1TzCkmZ1z
vCYjtQ3vmDd+cfgtwuvzM0x++CTVmUbbY4P3HgQtpWX0k0udZ8EkWiIbFT+K1nm4
zYwGZdbg3hXJFQXM9NijCfv91lRUNnfHIivoC3IxtvXPPiMp4ItgsMHtOCoeWHNh
p2emQw6UibeA5ezXcnTGW8SD/dpmGUmyAshZrQ0yDVzq028LWE0=
=Y5jp
-----END PGP SIGNATURE-----

--9KewOfIgVqcuK8jH--
