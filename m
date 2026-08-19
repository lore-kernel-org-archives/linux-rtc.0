Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291C21256C
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144906; cv=none; b=EsP7acxf4krD6EcJIbyhM7YGVWiIOxzwqJUBb/4ACTmLs0KVPOVus/+Q2qN4Lm/F8m2hztsgb1Ca/7iDyorjz2RkPRJBHWAVjpjAU1T0May1UByutY30aPAuBUDsnvVkHbEDjWuHO7PAwa7dDTWFNy4thA6EinKhfbuMI1lh7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144906; c=relaxed/simple;
	bh=LooAY+tiug92LWFRq/Z2SSzFK+58y0Nao2k1mleT3Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbzQPvBwabS0MDM7fFg78Rg6M9t6x8GvY5QXHlY+HWsi6jxrJFEPdUJjCgKL4f4IAC/NLveVoqXjDA8/9kriA2GZ8j+3dgMNPb/cnNJhx1qwGvSNlOkGzHVoUup9fjXueiQS0CXcHDPtYRD2RXTFtomKUIeBm2J89LN+wM6us2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=dqEa340w; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="dqEa340w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=LooA
	Y+tiug92LWFRq/Z2SSzFK+58y0Nao2k1mleT3Es=; b=dqEa340woZrifUKLGOnx
	IJ0eeF6EzbV25Xe5Lr+ICpXZTnfcuJsi41//p9i3dNVC9RazrM9ffNX7j48hvtp1
	DuSYNtEh0XHVST0tT/jYm5nZ+LU2B3FJqkEm7ELJW80/D9k2m2FXFMzj8/6+3VIi
	lGfE8r6EM0ub6us3FnEDyupNG65an9p16GaJJNN1aKfHWq/U/qbo4qDUgGmkodGx
	9F2CEIEKzUw/ucoSijy+QFToKU/nAAKfPurLdrAV/IzdasI8I2S2rWYKqkDL4c1Q
	qwXC0lPopuDdhK7Gb2VukPD/uPCwqtH//dAmVIX4OMg3wDHTaOcQvqivVQKP3evq
	lQ==
Received: (qmail 4148198 invoked from network); 19 Aug 2026 15:08:22 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2026 15:08:22 +0200
X-UD-Smtp-Session: l3s3148p1@6Y8LGWZZbFFtKXGR
Date: Wed, 19 Aug 2026 15:08:21 +0200
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
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 09/15] rtc: rzn1: Dynamically calculate
 synchronization delay based on clock rate
Message-ID: <aoWqxdIpvTP8zoOX@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F4CNzuRzY1Lt3BIp"
Content-Disposition: inline
In-Reply-To: <20260819103926.2136712-10-prabhakar.mahadev-lad.rj@bp.renesas.com>


--F4CNzuRzY1Lt3BIp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:39:20AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Replace the hardcoded hardware synchronization delays with a calculated
> time window derived from the operating sub-clock frequency.
>=20
> The driver currently hardcodes microsecond ranges assuming a fixed
> sub-clock frequency of 32.768 kHz. Newer SoC variants, such as the
> RZ/T2H, drive this hardware block using a much faster clock rate
> (~195.3 kHz). Hardcoding these wait windows forces faster blocks to
> over-sleep, introducing unnecessary delays during clock initialization
> and register configuration.
>=20
> Calculate the duration of the required clock cycles in microseconds based
> on the runtime clock rate, and store this value in the driver private
> structure to adjust the usleep_range() and readl_poll_timeout() boundaries
> dynamically.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--F4CNzuRzY1Lt3BIp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqFqsUACgkQFA3kzBSg
KbZOhQ/+OY9Bs8UorEFJzw5Frq4e5XZAk7OR/yVPNLRp80JPXpnP2Y5dbFCRG+5j
aGiwliOSbJkxJb1XITplfEUXcYOL6E5buEyUBGiG9jWo2RY7gfq9Lda2sIW/0Pwx
ygEpuGauclElmjGkDCHYO8iVw+K5+Iew68zYJ/5AECmVVVfHroVcgH8LyLnLvNsN
V3Qgbr/WZeKC1LnwEBpvGUPebEQlgvitz08ZF1adhssRInAwT2NtYKjZl1Ltsp8d
EkHlSwEY1NuhF3bltnmClEYIFqd8wA+Ci0ueAAxz1g6+W7nQ5vvg7JAZ36uhCuh5
y8BD2K3V6nTGffqpZI+oP10mb7VQiHpzZ4Jv2CM2HBmgZ+U6JDPpahvXdxytoDbD
tIyj1hBFlYZ37/gaN798El0BOX0b0OPsYCppcQ7i3tHPgdXlCSLfXgoW0sLKLn2S
hc6PBGkk7Ek9+2UZwe4Xl3QEPX/b7+w/6Gk1G/JSzSUPNUhs2regTMsZbRDLgirZ
zWlR2M+dQWw8cMNDEiFKCPvnvShOAZTA3cOazpSY8THY2yIg1LT2dUEru9KuZBE6
nsCoOzNT5fCfictfeW+zqwyvvHAf6n1VSXaZa40NZeyxGZc5LaYwAGenTh4RChTU
deBtPtshL1xp0xw5RoJk8vW4HvyoX3bkKFUWrwWJYLRvGSFaCRk=
=orpP
-----END PGP SIGNATURE-----

--F4CNzuRzY1Lt3BIp--
