Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDC38F935
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051992; cv=none; b=oLcaVbFGX+Dfj0Sp8n6ZolA0xQ9wtFZQt+qWA75Gf8ZWmjdjQwF7pew63ZAAGOiHzzJZCvWVGq6mJxluJVRCKTIbokMkWqR0iMzR5LtVeuFDLO9OKodq63fo7rf+SLgVpPq0VVzPSu0hVBSKOq3Xtnr7ihkaT6SjVQrXIXaMm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051992; c=relaxed/simple;
	bh=fTNtUZQEiPOT3b4pP9/gkgvLGuwH2uqxHjs4RB4Lkyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shUMsnoHD0lKSShtfza9eI3bTi3obiEfPq9RTMLtIy6i7LUvFJweV8miJCMdHwTXZd4xFqGYfMI2IAPKcAFOVv8t5ynCe/NCF3QjtmQG/1M1rfOdVNch/1UC5FxpVct6W2KI6Fq0kis6IBPvSk+hqFYm5JuwfwJQjbnll0CCqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=StnfLAf9; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="StnfLAf9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=fTNt
	UZQEiPOT3b4pP9/gkgvLGuwH2uqxHjs4RB4Lkyo=; b=StnfLAf9MyBXgh8rk3bv
	6J+dCbW3iJbEV4yFYgAfhiX9YkMAgZ8BpmggGjUdxtXkJVV8JhmrY/663vqZNILX
	D8U/zQgkC3oSYP4b9pCbiYd/23UnissdBmAb+/6sTnBnj+EL/UW57HrnaH4oMDnV
	5qQGz/5vyzcRu/KaSALsRU6U9aBRJU7gPU+cDKWg406S7iYWmpGPc9DKjUE4MuKT
	5Vgx2f1AuU6DoTgjnm0WfgT7fG+y5U8gsMOmm/pH4JtS8s7AaK31rkebKcM8DqIh
	FBSYeGhJ+kisS262HS2IKDHHKQkMwk5zny9gAsTgVJuWVQVJKhzAIo0iquMsTZnL
	iA==
Received: (qmail 3771599 invoked from network); 18 Aug 2026 13:19:46 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2026 13:19:46 +0200
X-UD-Smtp-Session: l3s3148p1@RGrWdlBZaL0ujnuP
Date: Tue, 18 Aug 2026 13:19:46 +0200
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
Subject: Re: [PATCH v3 11/12] rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK
 for register access
Message-ID: <aoQ_0oAR_MGAAA4K@ninjato>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VfuCX6VeJgS88s27"
Content-Disposition: inline
In-Reply-To: <20260706175138.12587-12-prabhakar.mahadev-lad.rj@bp.renesas.com>


--VfuCX6VeJgS88s27
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 06:51:37PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Replace open-coded shift and mask operations with the bitfield API.
>=20
> Note that the weekday field is changed from an explicit 0x0f mask to
> an 8-bit field definition, matching the hardware manual. This does not
> change behaviour, as valid weekday values cannot exceed 7.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Not a super big fan of such changes, but OK

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--VfuCX6VeJgS88s27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqEP80ACgkQFA3kzBSg
Kba36w/+K9qMO/BNax8Y8F60sZ3eHYeHa45rjsSDlyarx26T79qRI95X131sv0rz
TI7ULov+l3pxdZDqu9c9cJ4VC+J3SmOGZaVmhg7ADoCIgSeE3uCqRzQjT28upi7e
JF+/CoiZc30LSJHYNJf3ox+pBHe+IFdHXsnenMbzGb8WnUnQ/DfD/iPqTZUiLO7X
G5udaAwz+cfHz87RHjR/C9mwP+D920UKxEYUPsdDVaQt2izMm5pUG7RMnGLpMufe
pYm7B0bvlO8rocY24Ivs7AkpwLFeWj3wWfTzAzMa1mJdWpEscrbekT+mHVjiids8
8BY+ngNmGBNqkbRaVCsONOK8BncgacqMTBOCLyxz09C1xScZxOeTomC3k3wjC/qW
uzQb3kruElme2Hwb7BVI72RB2r5BPERDiHpJnS50CG6ps66+C5ErALTIJBvlc0oq
nEccroesYcYdlyyKyoHWFy4SvwmSIYuYUhA6WB3WzxivmdKEE0gZ/OLno+9yUL5g
+xgupEdmb0Rro7huf6354837khlql+3fhPjXXaknBjJOVcT4ihq50YVe6YYC9nyh
T9Y6222l/iS3jzCDuMx20ldFT5yK7jl6mpgNwks3WxmPk0GxyicsPEqeQ8Gko0RD
tfIAeFKa/Hs6CICzKQ/jjhoWFJzX+0eSb4ucTuqlHec5lIP5fno=
=NR0k
-----END PGP SIGNATURE-----

--VfuCX6VeJgS88s27--
