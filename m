Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346E2D781B
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145178; cv=none; b=H1CCfb7JozCj8xmyno3luc6a17v3CcGpdZNkvFB12R5JwfcfkyjS29vc6PSyMJNyNip8tda9EKm56tubl3/IbsLsIM6cUFLxZRLsprjJDfs3r3YG6d5DNI6PUGNnPfDu1buW/skmmnAiNGop7Pmxi7GLPgiAElFSnFeqWsL214M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145178; c=relaxed/simple;
	bh=zBO09ja5ojw+0/BB4HZADtBxbp4XR49QZ7n+t+qGU/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfCOBMVMc/2tsE3XI1HTQLWDxLZBnFvR0eIDmzG/BdAukOFhJ3Yx9JBg+P5fq0VIoaOs/7Yasv5kD/AHE161piEhrRhLdNYJs6juptHVNnLKsLQ5SIHEDHKK4e71qnN0JwUUiT5HQQSy56rLIgJWMQ7Bl5toFfmODjYOmq/JY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Vth673st; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Vth673st"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Uoy3
	OiIdEzXy8+bmZF4l6dH7C+zvU2mAql0vSxLh1pw=; b=Vth673st7sFLchf1r/kI
	iJvoPlUVUWqk+2QNGice1L2vFS2eeH96Zk+3150sqlqulvyDHyt9pqIT6xsHA1pM
	Rao7u5B46QW1mE9oG0ZFxlMYmEMYo098lMOiphY/hoXUKTfafaawf3rJjEZmrDrC
	SEVZQFjpwY2/cC23frDR9vaEWii8xeDlTUr8FWzrTE+YYwBe+h1tV7U0QUPPWlQo
	KsTDUXIEzvLfKWt7cmepDsMzMZTzAK5v+Ed3vHCh5SsHl/KOc+ZnS/8kZqpL0kII
	P9f65P9Ha29gApGcdgnbmK3iDo4DBWnkCCnNBk/cAg0Hi1oA1JSeDMnqYslGScYu
	DA==
Received: (qmail 4149665 invoked from network); 19 Aug 2026 15:12:54 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2026 15:12:54 +0200
X-UD-Smtp-Session: l3s3148p1@2cpEKWZZe2BtKXGR
Date: Wed, 19 Aug 2026 15:12:50 +0200
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
Subject: Re: [PATCH v4 13/15] rtc: rzn1: Add OF match data to gate SUBU
 register access
Message-ID: <aoWr0gfN6sQmgUie@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y7rejlSe7J7ljgsj"
Content-Disposition: inline
In-Reply-To: <20260819103926.2136712-14-prabhakar.mahadev-lad.rj@bp.renesas.com>


--y7rejlSe7J7ljgsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	if (!scmp_val && !data->has_subu)
> +		return -EOPNOTSUPP;

I'd think here a helpful comment for the user is justified. Maybe "No
valid XTAL provided and SUBU mode not supported"?

> +static const struct rzn1_rtc_data rzn1_data = {
> +	.has_subu = true,
> +};

'rzn1_data' is maybe too generic? rzn1_rtc_rzn1_data? Yeah, looks a bit
weird but I personally still like it better.


--y7rejlSe7J7ljgsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqFq9IACgkQFA3kzBSg
KbZhww/+MkTEc0GXAV79EUfSKg5XX/h2Vl3oSR2e6ZrzKyz1YhimDE1/Yb0qycSg
kxzTH3TiCeOgT8wCeJk0+5O8PcOqhDa0cNTjMU01N+ivodqtv2ofAfg0XOy+VsQx
cAEBpKcfrmbsQdvfLyfSCjJ2hJ+7EGFsdfp3DVwYxtNDeaE2an8AzA8TLs1g04Hf
OuBTCPtM9O7ntHGn7QbCh1+s1AeL97WC5/hHalhfiQ35m3lMl5vRtJEK2XKioyEa
uwriBMACkAsbhYj3ZoPcwRsSMszBXmmgOh5sFbmg9UNLtXa45p8cGdtcoaUypYGR
QBMaS245vaUqEb4hURgD0nJydexcIQbXCoDwrpMEAtRDP+l8G7IcQHnbwg0wGRI/
9/O9p1Cs06gVG58qEwrTZPpCEcBGJl8QuB0sVtcgqtLtdL9Y+4rwUngiXZwoYBRV
asjM3T6+JOtSwfW7why5QU+uEes8iydyARj67sWWE6BpiHqUd8D1NfMP6LeSEHaT
Haj9EqPz1DXWWw2WJOdi0lYedT1wiMoMqwgS1CgB3hOR/0p0LDzXASgBWg56tg7X
vrftz2ROdcgpfe4ABf1yhxDrDysQIiLcFTC16EnHzXTyz9ETXBwDzyOa3OKnrWQW
yrvp8Yvs0vjyfFa7VqnpGURPD9RXA1Hn9m/TTj3RlfpwXgWtsk8=
=TyNs
-----END PGP SIGNATURE-----

--y7rejlSe7J7ljgsj--
