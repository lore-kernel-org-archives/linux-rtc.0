Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C08345ED3
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145266; cv=none; b=ryQAz/WF78Ns7zc0KVWOTWFRuIcBuU65XAihXChy01SOlxjtcIEZTJL4WqBSrltLAPlRlXEyPf1WJwL7puBulprJO4XdoTcP7Kua0iWeRuYWOWDspBhmzefIRvTYQPSML3ptKeA+mL1o0kuCBCIZ+ls9YirxRF/z3G4aQvVRP8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145266; c=relaxed/simple;
	bh=7o414s4Zsl1ELqqEmwk8ohhv4+UVrSAhE22lSku8gBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbnLUD1UwtFCnEx9I+ml7QJXSAbPu8lj1WVUoIylJUJ/JiybW0BGNwnuh8w7Y6gGvoy94tCKDqX8NhWa0890Uizx84jXJWeZCYDHGLu6xWEhtfNj4ifCvq+6Uzk3ScnEuBeq3EHrF/Dq+yO1/RhJEUZuE9+k7hlr9MbKNAbhLl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ju8ebyno; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ju8ebyno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=7o41
	4s4Zsl1ELqqEmwk8ohhv4+UVrSAhE22lSku8gBk=; b=ju8ebynofBo4ISE6+F2z
	MVQ52QahgP+yuFL7no5IooUHiKQmOdpIloDA+Kgp8+83g1jJZaG7XL/lg0PwPA4I
	saExYmPNXIDijukaS81PiILZxmrha8FT4tJUOtu3xIJUF2s3J+lut3OmnJ8bkJO9
	80Ab6GLJgQJr4NvPiUTIoLN6PulbBkozC+GkZCX3dBceO1RcYssDIghsEfSjBTUd
	zWvqNZNxkRypK6nDpYOlxyydWuB31ttPIYuNn3jWQ+Ns2H84c3ITkStcJdf805p2
	s+LRmTNDEtgwcPiYkrXihdNsta8cD9Dk2jKpSdqz64U+PL4x2qTpHqqPHJ0ZXJS0
	XQ==
Received: (qmail 4150109 invoked from network); 19 Aug 2026 15:14:21 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2026 15:14:21 +0200
X-UD-Smtp-Session: l3s3148p1@pfdrLmZZe2FtKXGR
Date: Wed, 19 Aug 2026 15:14:20 +0200
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
Subject: Re: [PATCH v4 15/15] rtc: rzn1: Add support for Renesas RZ/T2H and
 RZ/N2H SoCs
Message-ID: <aoWsLHvAjVQjVLWw@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rcLlDZfQxxnx3KNS"
Content-Disposition: inline
In-Reply-To: <20260819103926.2136712-16-prabhakar.mahadev-lad.rj@bp.renesas.com>


--rcLlDZfQxxnx3KNS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:39:26AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add support for the RTC block found on the Renesas RZ/T2H (R9A09G077)
> and RZ/N2H (R9A09G087) SoCs.
>=20
> These SoCs integrate a closely related variant of the RZ/N1 RTC IP, but
> do not implement the RTCA0SUBU register. Use variant-specific match data
> to disable SUBU support for these SoCs.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--rcLlDZfQxxnx3KNS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqFrCwACgkQFA3kzBSg
KbbSHhAAj44J1OmBq4b1QPrGBLIelREHUz7MVyyGmTydR1OYFXfnj+87YCa34CT3
60QL9qUXegiE13Hd4byjshyMu8V8P47v1dB/yr+tT78leBVeYltldA78qcvSF3pt
V3ugIhPdRBnjXxZ7/MxU710bMX8HobN3yKGNpGvp8nlaDxTpWrvlcqYSSAsM/p1z
Opg4Y8OojVtOIH74jqgFvkwSz2Ys0a+hqMDcO42ZhzsWZn5CkEcl7eQoUicFbCPf
7omLYltcKD9fWF2m8rhjWzxYdFC0l3lIerWa5YCHIprAyC5hyapkbMxMcmf6hBFL
9eN2WhCLIGN9L5YvVNr9JqK4uZcAzQlV4SaxUENEukP66V5VDjdSHX9CSML6YktV
J8541mdhTsXP7IARjey6LuheC7PFLOg9VemU3x8DGWIzjsXtKovlpEgUuDI+/JfU
SIrrHIFDQnU18qW97Hf5VSOpByfN0Nxnrhvsglixvr5RbgPllnD5QYQJLrpYA6JF
vun9pnq51JuFwTnTtAuLHCAUuuw3sy9R8UGb1Mt7FQ122307KX+GdwsT7KU4Ke17
XTfC2+gDD9s9u7SyLVWs9NvHqMYcu7Vbzz2gucqfgunvTHflQmbNLhaLteG/XBib
e77HxuK1PyoxpiEmNxlE8ILb35KVBsMhtGkajLQF/2a5+N+yYcI=
=AY/9
-----END PGP SIGNATURE-----

--rcLlDZfQxxnx3KNS--
