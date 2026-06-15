Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B69404BD9;
	Mon, 15 Jun 2026 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540548; cv=none; b=sMvLsZOukuhkCtgrOUuZXjD022qd6jAhiLeTvAlJHjva/6mmOPfzVpp8fermnU6iauWPT0JQ0imiCPtWYlVjK4e/31dkHbViWmHMrJDIahhs1ZOXSHx9whSfe7yKceHUuMaJ7nvpYNwbO5k6iCC/KuSHEaEpMDB0CC9ERlGNn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540548; c=relaxed/simple;
	bh=ZL99LIkSmfCuu2ZPcaPH43OJHW+fgcXUoWcaJytU6y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvkUGkIy4nfoNnzZqPWETA7XXEMZZrQfpMoZ/zsy0Abc5YH3Fg3uboZJH26HJjAml3qeTMmdRkS3DqMY083zXyA920C/CJ72d9VyWIzNnfRkTjtHp05AZhSEIuaZzfa46tpVT7dQJ0T8IR0VC0P/bGkgVFZGsMZaK724znPLRdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smx5OMjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smx5OMjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DE41F000E9;
	Mon, 15 Jun 2026 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540547;
	bh=ZL99LIkSmfCuu2ZPcaPH43OJHW+fgcXUoWcaJytU6y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Smx5OMjZYpEIXxjYpvupg/WYt/YuK3qXBkdpJDJ8HOrVBc9Aiiq/aknFUfdJ9q9by
	 roANGQD/Uc1VUVsE35cpUvQ8W5FH3ufsGwq+JPleg6GbqP5C2VsYUnR6SeqNGYqmY/
	 /VcHO5sAAthnPRN/c90CrWcOO77ODXZwqFMsbh/HBHvHT1YOGchpqTDzN7IAYIVI0u
	 pjcDgYJSxE05t8cqPDJ2hyPNFDq4h+84FZRGlpcVe3M1jEM6YVLfSw817mYwFENnop
	 O0Yci4RTGVYIQkwhDR7mbe9MwMiGdZviSiCbFhDId+arANhiZ9PB1AgZRhobIJxtFg
	 lbi0ZvaLZ8MAA==
Date: Mon, 15 Jun 2026 17:22:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 01/12] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H and
 RZ/N2H support
Message-ID: <20260615-yesterday-saddled-d41792aea31a@spud>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SpV7twdmNb/juJoq"
Content-Disposition: inline
In-Reply-To: <20260615154805.1619693-2-prabhakar.mahadev-lad.rj@bp.renesas.com>


--SpV7twdmNb/juJoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--SpV7twdmNb/juJoq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajAmvgAKCRB4tDGHoIJi
0hUDAP9iJBjB3lNC743jBeXutSciKO8Ww0dip07NxF4msIEveQEA9LBI8d/jH1tq
R52znrXWad9X3ihXtuTBEY4ELo/MMAM=
=0sPM
-----END PGP SIGNATURE-----

--SpV7twdmNb/juJoq--
