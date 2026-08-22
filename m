Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1867C36A36C
	for <linux-rtc@vger.kernel.org>; Sat, 22 Aug 2026 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787426876; cv=none; b=lpxcNkhVH/eNxVnExHL3bcRzEkeJCQPCyLpbHNAzZfqr7Jb64Iv/kLin5ISlBGO5vV8HSZVO2DLrKN1gcVziFYyjAmieafYtWUHxBso9bOHIbaP5IeHvnKNvmg635GBAtdHdwcs8aByKvgJugp16MBS3kt4+79sa1KgpM+dBo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787426876; c=relaxed/simple;
	bh=NCDgIlNU8dGld25uFKFLAlU0K4xTaQqVrOx+t1/cY9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3nTPPK28Sr120DDBI6x/AHFaWwlXBM/Q35odkIfkBUa6q55rhox8gZoq9gDnfUMCxw0ayc4p6+cu6osneDSCUKR31ySaXcgGxs1yT0Y+6YUuszy97fcSCaT2AQVUd8qgTC2Bc2GjUjTQQNQ+TsXnfeRWnJUeK4yisNlkQslbCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=KPgPt9xV; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="KPgPt9xV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=NCDg
	IlNU8dGld25uFKFLAlU0K4xTaQqVrOx+t1/cY9Q=; b=KPgPt9xVRkaK82BrXooQ
	K/GglPKLVOeXW4DvAFamXdBtFdV4/1d+OEB5pzn/UlD+vq0zSz+o42z0Vo6harAz
	FpP7o3SnXhNPorhs4efXhZFTXWQXQKWQtTdOmJoJxwnBM49J9F8IUQfx0Re1K2By
	R54Ah5GHKqmQrmNn4FsFMae6TzVZLJ2CX+a/urFK8OJvhuPSj2oatLRCk24/XGYd
	ZK4cEdTIg7KklsJBYnax26VBPKQ2ptwNyjbj/2MPnxZw2whYm22awRJaKqxihwrC
	yObr4VJnLMq7t6sBABdT33+0ZGonbSsJUCWnmigqMAOTSjPYqekIhUNylBbcfMbr
	4w==
Received: (qmail 1016217 invoked from network); 22 Aug 2026 21:27:51 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Aug 2026 21:27:51 +0200
X-UD-Smtp-Session: l3s3148p1@qlyyv6dZ+oQujnv+
Date: Sat, 22 Aug 2026 21:27:50 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
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
Subject: Re: [PATCH v6 00/17] Add RTC support for Renesas RZ/T2H and RZ/N2H
 SoCs
Message-ID: <aon4NrmlVumUVrrM@ninjato>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HQyQI4l/MOzh8UsR"
Content-Disposition: inline
In-Reply-To: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>


--HQyQI4l/MOzh8UsR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> v5->v6:
> - Dropped the output log from commit message.
> - Added missing sentinel comment
> - Collected Reviewed-by and Tested-by tags from Wolfram

I have no more review comments and re-testing the series was also
successful. It is really good to go from my side.

Thank you for keeping at it and especially for carefully adding the
"change since last version" information. That made the review a lot
easier. Good work!


--HQyQI4l/MOzh8UsR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqJ+DYACgkQFA3kzBSg
KbbZWhAAhyd5aqmJAc857L/fqRQVPGTva/BRnco26gMT/nJ0OtRjCi/uRqYQMHQC
HM2ix/rLd14idRQ01W7W/ECvjnJbemQDIdzyovkejCSdNtEfPTXoE71lhV7hLchE
Uq9BM2cE9HXd4HbJdWUbwEEIH+tseNLeUM8KilSe1bub8dBxOG15HzUe8lDXSzTd
wx3X3QEb7WNqoHj9oc8ipmMV6Kw8prlXYIH8J9KVUbjhytoO6++OY7vYsN+/dBZY
kTPHuUZzomMmxOOCbheFxgbSnKq2ZPncx7ww5pSjJ40cIDKuDif7rEnmMODgrBEs
7/HjM7KonKiMOi2jrsZI2e+3CD5hgeab2R+GkSa2U4oOj5sUlKbd6aqQS6Ajl4DV
oH81ZBB8GugvW+RqGSeHzlffxd2/JLGggDlf1YSdBHWd6n1hZuxT18thwhwkmquZ
NFrUVCtkJpPoN6qYANYEPGJJiJKIc+kcwQG4+gTsRvAbtgz+BgoViwvMTqV6AO4W
dUfyRi2NIKHybX66NamuH6SBYhg12HUoQJXu4TOHc4nAfvpx5AXhQAOcayqJd4VN
s4KlwwfVG92Ke97EW/1k19c9zcZbgC/cgWK7+12J7X4CMg3F7ZMsd4O2w3iIfTXv
o9i4fW2aGm0+w/Sg1ImSsNPAJnAnnXYVLsc6tUuB3mQYAHlGmbk=
=PKEI
-----END PGP SIGNATURE-----

--HQyQI4l/MOzh8UsR--
