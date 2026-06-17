Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025037EFE4
	for <linux-rtc@vger.kernel.org>; Wed, 17 Jun 2026 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694638; cv=none; b=ZoEwmpFRNHGunRNifT9IWYeK8yJdgcEPh2hr5AxfRT+3pvFdnZBhsFclyWIQLC5DHM2lO5hEqZYa2X4CH8Qd7bfPptWqQ8tjP0Kjugg4TeYhyeg6i1Zq435Jq4SDOsw3TdX5qSsw/QZBNfib7oeZfOF68MormwJdM8vgyhpLuck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694638; c=relaxed/simple;
	bh=jrnjpfjWAj2gCwYMXgtp+HmbJSErYJxq9mIT1gb3HQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GabHOHGXOEczQFku69e1OyVRZM4usX7wP0CO9jezVqHOTQPIoFLr99P/oYI834TWauka5tNKZKiSJXraJO7kxDCWEZTUU+oO+SDr4ihl5b+fHLQk2m9bGD3FpbhThX0Q4TUa6hDO2oXRrhqC+nxjwKNvJXdVfCSdwql3+xM+LdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=KCnPNYAJ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="KCnPNYAJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=FuAl
	Trj2AiO+4ixzIlxrsr0EN8qN3zNP8tpsHRx8xww=; b=KCnPNYAJ5bJhBofWStP2
	8GQ1leVhShAIemfP9olqqRlNKbBKI2jsqQrKvtGip/ABaa5KNOoyzjND2YwOVGZb
	YhrcbSSOYLMNHL7Gqv16J8MfMd1j2+e7GVN3Q+cDbBOCrxxjmLUEE4GEmy6fjdER
	XE/4DfibCA5FeNL2CCPGXakJ3t2kcwPUPhCGOqJE77nqjiURK9J2TzT+oDiskZcZ
	a2ve2D9oY3LuSQ87LRcGMq60Xauj9oQST8qSUd82/T0DBgN22DOQ6G7a2bm/DQXs
	fjRd9IXPfdIZ+pbgS33BP7JGJXCLcHM5r/CDo7CELZolU53xiKnYfW0RBul/5d2O
	WA==
Received: (qmail 136960 invoked from network); 17 Jun 2026 13:10:35 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 13:10:35 +0200
X-UD-Smtp-Session: l3s3148p1@jh7NG3FUKrAujnvI
Date: Wed, 17 Jun 2026 13:10:34 +0200
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
Subject: Re: [PATCH 12/12] rtc: rzn1: Add support for Renesas RZ/T2H and
 RZ/N2H SoCs
Message-ID: <ajKAqn1F074JJazF@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="It5r3rNYSomVnrZg"
Content-Disposition: inline
In-Reply-To: <20260615154805.1619693-13-prabhakar.mahadev-lad.rj@bp.renesas.com>


--It5r3rNYSomVnrZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 04:48:05PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add a new compatible string "renesas,r9a09g077-rtc" to the OF match table
> to support the RTC IP variant found on the RZ/T2H and RZ/N2H SoCs.
>=20
> These newer SoCs integrate a closely related variant of the RZ/N1 RTC IP.
> The RZ/T2H and RZ/N2H variants lack the RTCA0SUBU and RTCA0TCR  registers,

The RTCA0TCR is also not on RZ/N1.

> those registers are not accessed or used when operating under the
> rzn1_rtc_ops_scmp configurations, making the current infrastructure
> compatible.
>=20
> The RZ/T2H RTC variant also supports a 1 Hz output signal on the
> RTCAT1HZ pin, controlled by the RTCA0CTL1[RTCA01HZE] bit. This bit is
> marked as reserved in the RZ/N1 hardware manual, making RZ/T2H a
> distinct RTC variant despite its overall compatibility with the RZ/N1
> implementation.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

With that fixed:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--It5r3rNYSomVnrZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoygKoACgkQFA3kzBSg
Kbbs8xAAmX10HSwI/vLKRU9rI0perg+e+xnS5czN/LRlwyNmXDwpegfH2kjyclO3
lbdUwwN1WI7LAZtaWIW5Vhq3pJ5xiC3xP7i+pmYdBefXukLEtwjIQjKUnhmsoTWD
8FZj9O8x+4oMbAJ69mAvt3bDU+8OIrcdhfMO/+1TTXhF0wrjPVGUCwvaLfuBnshm
TtLDFWe8Wdq18C+yRe+DwoPODSAyZlXqxMYJFsBekJd4QvXWXy2IyMBUcR/Y+u9k
7asdbBQrEC0V100NgvHFMINGZAaz8PjU6TxKjKmoCWZtlPoCjg0MmqIDPLs7F/4O
ibPcdmkmg4Dat/WsWAc3aR7qZIPUcUQ8LDfXBLAdLmvv1jNLo3KvobDAJAI9XrqJ
y73e/Djo3aX8GEKT2OOc95kfvmBVzJVeh92Ug+DktLEfWfo35Jia0pdtWRAroAxb
IRBJXNRXYlwfXo2nseW4P+qURuyD3lgrc0jEeHFz0mnvWM71F/z60OaAPrI5KNVo
Ne7qYH/ygWzNn/H/kth2K1d30ssiMfdtxeyXffwG5P8/g2LwtbTzJRjphtR/0HLF
c7AIkKy2ji3paOXB0OmbiIT2yIKF424mC7U4J7piM0URhb1aEl1W//MaT5nqRXN4
pv0NPzQnyCZJAzcnf96Z8IrjtW5lkTUt0UyMm4PsOKVY2kUs208=
=pT8T
-----END PGP SIGNATURE-----

--It5r3rNYSomVnrZg--
