Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4F3CF1F2
	for <linux-rtc@vger.kernel.org>; Wed, 17 Jun 2026 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690124; cv=none; b=esSlgBpPu8TeWpRh28mW+GHMuVGg//xVPNs8hfOOGnrJx3xE8aWAz8iHR9DDKtTcBXVo+caD85LtBidi0oiROOyzWc7aQ3wnqDQMufGMoIVevQF6pVBV/k+YOKNQmz4if26bVDOv4/ATie3Gm6gBXF6pX26HwuQZy/cERNNhuV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690124; c=relaxed/simple;
	bh=/xDuO4a3wwE9DMvntr6l9sC3lXJwxvdOJnzzCkiARhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB9SYAMWl9uK3WF8QqdNx+5WZ6JZ9kHUWstB2KlYeGIiVtPamCVQJTWcz/UI01axQcFW270CovP6MNOWhz4oJebok94Pz23oB8tE143OJ3hpKaY7yk8z3FKDhjh03/IDXjXi2+BtpXhsNgbNqIdwvCzQMMlAMxIjPWJYlxgUFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VDTL4vio; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VDTL4vio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=/xDu
	O4a3wwE9DMvntr6l9sC3lXJwxvdOJnzzCkiARhE=; b=VDTL4viopWQS36HZVS9W
	Fl8xANE8qKRHtJcVfLYbVNtGPXDorgid5b16p83Or/WY3TtJL7VvLj0FEWean0pf
	jiFFIDkirjnTFPe5IDf02+p+TLjUZbEE0fHKTGfzk+560PXEIZ5tKHKvMF1MJNOg
	RHELNXsbk4ShZQAxUwN/YLj6PBjL6nu5MV+Hoj2CXS5TDSIX24XmD8GS7yrEBCTG
	QOiDTrTI3F578TfcIk63ZuO7UXz0KjTvFl7gciE6soI8ZT6QDetBKCTpXITPKiKP
	4yOToZDSzHdSSXT5RU3+uSPJHd8RZ9NTZa0RmdeXYgSKLtcL6X4rQpT66iWWjEm2
	EA==
Received: (qmail 111445 invoked from network); 17 Jun 2026 11:55:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 11:55:20 +0200
X-UD-Smtp-Session: l3s3148p1@V2u0DnBUAK0ujnvI
Date: Wed, 17 Jun 2026 11:55:19 +0200
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
Subject: Re: [PATCH 03/12] rtc: rzn1: Fix malformed MODULE_AUTHOR string
Message-ID: <ajJvBzLu0O5lP1fO@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y4M1db+vqfnSrX48"
Content-Disposition: inline
In-Reply-To: <20260615154805.1619693-4-prabhakar.mahadev-lad.rj@bp.renesas.com>


--y4M1db+vqfnSrX48
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 04:47:56PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Fix a malformed MODULE_AUTHOR macro in the rtc-rzn1 driver where a missing
> closing angle bracket on the second author entry creates an invalid forma=
t.
> Correct it to the standard "Name <email>" format.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--y4M1db+vqfnSrX48
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoybwcACgkQFA3kzBSg
KbbJbA/7BvivZjlnNS8uTVnRV/sJPgFBYYHOU2N4Nn/TJ/ldGLyl+Dr3H/0mBepl
PWe+w1aUdbPuskY5g3KGk+DdSX0YPBFIaKz8FKYknSuvyKRXrzzjug0w00HjNlQL
2jKs2GL1+m3KZkqhH6QJ5K/qu68svoQ5UDonkli/qyTBLMAuOujDY7DAAGtoCj8f
bDxsOXLVKntGSjvWVhJIbt35Umtkj5j0z6InTdioMp0FOqaiQsRwqyFjUJ3K/JDj
65JsTlwY9DBl7gz42L9kh1JbmPAFyaGb/4Ku9eScPcVKwfgA1QbezBYM3vMaLOsd
lEzPAOsZSMvwxWdBK33pOjKy3R4/+z87hJHHIk+nr+jjV4xfXabmY6RelGTt2PwB
4uPa/yg8T5n+NXOwWHbDssNW27JSb4F7/RDzBzWiN9aIBW4eo9G5356oqVXM2+L1
NB98SnwVE8w3i3J9g5POZOQnZCTybSUKYxGzxzAhKjypf+t0nwGBgvfITzpQND4M
81Fi8HHRi0cr1LB67YZar/nsmLjduK22TIgpj4nU8atA26F2nJBYj/u2klMtzgP4
Sn4jgxy+OXS29cAOtbrDN95SKv7nH1RFozgcnONSiRxAYx1xI9+v/1q4dH0hEBSR
CdNFHIUqClLy63zss5Uo/BDvgHnZrFJWkOKYPZW9T+kXg3tQBI4=
=CIPP
-----END PGP SIGNATURE-----

--y4M1db+vqfnSrX48--
