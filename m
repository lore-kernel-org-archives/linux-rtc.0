Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0721356761
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145357; cv=none; b=t5h31Ka2Ih6Mo2jzG2hUqc/QyoMRzX7CH24FopFZNfl3DUBlgKiIVpahBW5YQdaWlVGedqnYLzXC5DCH23HlTSFHkBKwXWgWhZHAmjQ56cScd7Hd1ZuVb9y8pyUkbHeQdSqimG/6gju40EkUf7OMlXksqzKd+yFY57FXsj2SOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145357; c=relaxed/simple;
	bh=qucgUuO73zR3boZqMIQx7OkvbyaS9W7Gr9SqQ9EnCJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVsHUBAF/VEFZRLuqOp44jgGf4pTIo4PQ1B9V5+r6WfjA4/r+tPCBPBHpvfedm/LDj6OH/gzVsfW3TvDk7eDtyMy+ZsON/Ma6do+Iyq6jImmXn/EvhFNS7bhBFRqidI5OGwoewwtxoJLgBn3MTEvzlGYLCgY3kMkPYIZdhE/Ass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OhSodnPa; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OhSodnPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=qucg
	UuO73zR3boZqMIQx7OkvbyaS9W7Gr9SqQ9EnCJA=; b=OhSodnPaq2BooRYwSeRB
	vYKaF84itHBsfX4K2Ky/Sj3HA8qnxpVYUHBh8ENNPyuzwOmM+tUg079DeP+qgPEk
	7YeJSXCTu3HDZeFK7PYnrdp8B1hK79mHZR8RVsimSRnovbser90oCQt94MJt5MqO
	Z0UepgHuGxe7UDitsTAx5TSjJtVA36PEs7+BCOu1Xn2BtaVjYvrBzBR+TBwnPFdO
	aeuXq6cHIFIyE3Tpaa6W1u/3oJLX17rW2DUPgPe5PZbiLu/+2XKI5uiAccbPbg/x
	qriH8gDsr33n1AgTg6aMM0Ozio+RI1cTFvSdz2Za2UTLATNW5fKqtngtt2BXVcjv
	ew==
Received: (qmail 4150694 invoked from network); 19 Aug 2026 15:15:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2026 15:15:49 +0200
X-UD-Smtp-Session: l3s3148p1@hC6SM2ZZwgVtKXGR
Date: Wed, 19 Aug 2026 15:15:46 +0200
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
Subject: Re: [PATCH v4 00/15] Add RTC support for Renesas RZ/T2H and RZ/N2H
 SoCs
Message-ID: <aoWsgnsw5gC6TCj5@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UTfPJjRsmDMyP0vk"
Content-Disposition: inline
In-Reply-To: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>


--UTfPJjRsmDMyP0vk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> v3->v4:

Thanks for the quick update. I have done the review now, but still need
to test it on my N1D board. I can do this maybe this evening, but surely
tomorrow somewhen.


--UTfPJjRsmDMyP0vk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqFrIIACgkQFA3kzBSg
KbYgeQ//dM6icDPuT24f9XL7tmzttwB1K5abNRCZT8c5ACliy9vfCoiti3RrpJB8
oDBT9Xd+ZQwDTLNXCjMttWKJefs3jBmzpENra4Ef+g0Y4bSWj9jg+20A+QIkNLUp
sxMgIZwj87r3WY2ChNj7tss2T6KlzYQlLvWtda61qgj/rZ9g39Mzf0mb97g55K0h
hCdb2NZOpLR1HTsoyEtUvcHhMdsNdgrVdpnuEUnG0xRth5LE8FBd217Kg9ygEfDt
cDLIir4NecrOwmsrEc7zYaJFRr49Hv/KATSFRak47EJks2pHTHjsS/8bLK8Y9dPl
AgpxLr6m+2/jiNvZ/8KXrbbNO4qoLzQfYPtvGo7/hiEb/hDV4W2Uq/mJ3XMV1cCC
bZ0n2Z0gb8poAl2vEAWls7Cx/vdha+76w69xBynDAcnW4njNe6U1uxndg7ccT4w3
6baAN/1hQr1jF5p9vSig9YeNzrw7D1wCWGtO1vSS+dZTNX91z+gTv/U2RL5ALyHQ
iDfOyBfsoeWuoOZVVdPElGhxTaiVQ3r1PAEIF++ugWj9oHCmKIPtkqaIc/CDVO/F
8/0wuRPlrydYNmmsIb9FewbfaxZ6upvV3H7cNsSbNZylko/qsCyvXZFATAC8lJWe
8tquVAOdJTsGfE4GnkUhw/Tw7TazUds+g7q2XLijxt+gFsNESqU=
=4P92
-----END PGP SIGNATURE-----

--UTfPJjRsmDMyP0vk--
