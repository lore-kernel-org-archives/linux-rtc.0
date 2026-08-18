Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AC73E0230
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049457; cv=none; b=GK0C4U6IqdszYOEtSZaZXh6tY/z8nvr+d6FySyGiONLLFnK32tWzbHqCrWW79nLnc4ocxmOA50DTbYUbcki94anfeu7Qop2bNF4TCJ6nPpbgx+4ReXtFO+fILfLkEBgH1ixUKbzVFzJE8zS3qWiOGPlJJeqByn+cwl0X0reI28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049457; c=relaxed/simple;
	bh=T1wDF/p0ES8WtZ8qIUHGWfhnidw1W9o/Qj0U6+dJ48w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HI6IAAwh5tAQqnDit3C4glc5Jn/3SM8xH3K6xtNA+Dsbg4jAYuGH7WUXVsIUJHJyiEQHxIG1suQYG35JSGwY1Eb6/aEgZ8KI83uP9cCQaymeOvM6LASCoX7Nomq4i7Y4R7Nih79O/S3U3NwTFKyJa8pyEFu3/3Tms4FS58sUMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TWq4TZ61; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TWq4TZ61"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=T1wD
	F/p0ES8WtZ8qIUHGWfhnidw1W9o/Qj0U6+dJ48w=; b=TWq4TZ61/1+jPHwQGLwk
	RNRp5pIrjQL00nZ2y2o4610lMzGJiw+D9Qk7b1l1TUDbs7/p9OyGZUHs5Arfqe6D
	MeYAkySUpMk+w5rEPUG85ptROjJPK0i+KwB8EZaT9j9lJM93hY3wGDdaHoFFqmZV
	VpDAE1Yl+9BxUqosvU5wYX0k3ca6ucvrlsob7+qakwDDT8C5GD2KvZ2PatDFgoVj
	0plPMvYTnjL4dFPGiypSz7doExgAG8Z0DXGSOqM81igxqzJRMHX56sIOb8THcW77
	Drnbm2Sq2fvCdE7EhslJcKnvW5coFUKJH01PmTPFVDFwRPOjk5sc067OgghaUYMF
	pg==
Received: (qmail 3760792 invoked from network); 18 Aug 2026 12:37:32 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2026 12:37:32 +0200
X-UD-Smtp-Session: l3s3148p1@hxbQ309ZjIQujnuP
Date: Tue, 18 Aug 2026 12:37:32 +0200
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
Subject: Re: [PATCH v3 07/12] rtc: rzn1: Replace remove callback with
 devm_add_action_or_reset()
Message-ID: <aoQ17OSf5_fGN95X@ninjato>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VExzrXGn0dd0n/c3"
Content-Disposition: inline
In-Reply-To: <20260706175138.12587-8-prabhakar.mahadev-lad.rj@bp.renesas.com>


--VExzrXGn0dd0n/c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 06:51:33PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Simplify the driver teardown by registering a managed cleanup action with
> devm_add_action_or_reset(). This eliminates the explicit probe error path
> and allows the .remove() callback to be dropped.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--VExzrXGn0dd0n/c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqENegACgkQFA3kzBSg
KbYL3xAAnXTTbIMKPiOxjw0K5A/IuoiHNDVE8zRP/VXQyUvXwDldLi9Z7zI0Fupn
z0DYBOHDD0o93n5MSFTPloHy1AswaBTE5AS2+SXXa93Y4UFwzlm01jerxEt7fPI9
Ub6Xdbh9nZMZWeU2D1N6v7oxIR9+ItjKVkRtuDaWwCV/+5+VVditTXHSYzajfCt0
PJYrc4ijnJNk9Zf+ihEh3hEbBr2sgWBhjMdxfeO5TvW55AssxjsmuBGhX36FqxeO
QFngNYdW6VMCLGQyz1C394cqPEjUlaty7dP03hWQQbSzF0HjJRWPd/U6OfpnsctX
CoGXh/vW21px1NtWwxGpwxCs2JiqWJWlkHElfOxhUSRJZ6XqTDax9JYOsEoxImaG
H/E5kn9NKHEhsXmmiNCehqE+mkGbsGa5KUF7IiCpaJT3dhbQ3eZr1h3HFfMIDNZ5
uUHN0K417SYwElidclNTg/dgTFOIBF5n3S7mzKVmsSlohCF7GWVZuFS74UA69sGX
mJtpBsh5KDvHoKSKsRrW4nf0yGGvFDyjuTpq9jebrRS6m6oHMn3EQEoasXAzJuDV
aLGueh8Xccud3bycTPIbzCzov6q7zKEixh6JX0A9IjPpumM9B2uut9uSOZvTOIIG
VISmDhuwyhrA1SzGq72S32gg8QuwX8m7ul7sDYBKVjDi7i6c4Ls=
=zkNk
-----END PGP SIGNATURE-----

--VExzrXGn0dd0n/c3--
