Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7D3DE42A
	for <linux-rtc@vger.kernel.org>; Thu, 18 Jun 2026 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778729; cv=none; b=XIRB7oO8iVDyJkSG4Q8s3RG6VoS+Kmwj8PZdq7GNP+bAqDYOEoMdstTgfPofC3+r896poqoNh62V4mb++ugg97EjvOPZ6tuVrPa/K9LXCnjAeeSuGyWusWysEGNHWlLfuHs5TzxuPk7MAd+uqQf4Weqwk6HBxg3vDEUix0dtl/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778729; c=relaxed/simple;
	bh=ICJbwuQFqJH3MjkBX87SVGN26zF29YTm5geT48J+HII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0abivOIpXZnS6us3KAmNgsKyQZsOokmfE5aE7seEeewpZBg/LB1iIsccb/DQQSTenExyez2twDy4od41MfDZlTHzTsJtYnL/3F7V/EXBKpRNYepNrIdimivmAyvqXvXUqzrj2BMDCdBS186PYRQWDs8fGzl4wY1ibtvs3xoIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bHr48bgJ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bHr48bgJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ICJb
	wuQFqJH3MjkBX87SVGN26zF29YTm5geT48J+HII=; b=bHr48bgJgAUMg08cQOIS
	euizn3I1bzIyaHb+5zQZvAN5PkcErCNwqM2VEIpfgrtBQymQjj3qKHwfmcppJ1/3
	699QurZnKh/r4KveKEFda1Spg92XW9APRgM7RxygkJ82evKL0mt8F0CZplspFnnR
	969/+Omw0K/7rcqVlJ1OwGtzGUimcpCbS2qvJvsBAi56kl+3vvv3E1etE/2nm+8s
	Pt3VG6OuZCUm8rWKrkwy84Rhe9+NQL0LFLlC9dls97bfSYhnP7tW/1AAVTu7j+I8
	81rHVAmrUt1uQcGwDmeTm/EfL+yjtdR6L702bLlcXcKCaHcfQ2tTM9/CuMH9os4v
	Ig==
Received: (qmail 525476 invoked from network); 18 Jun 2026 12:31:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Jun 2026 12:31:56 +0200
X-UD-Smtp-Session: l3s3148p1@np93r4RUhrEujnsq
Date: Thu, 18 Jun 2026 12:31:56 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
Subject: Re: [PATCH 05/12] rtc: rzn1: Add system suspend/resume support and
 wakeup capability
Message-ID: <ajPJHKut92mAoo-B@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ajJwqDt2jUfhSD1x@shikoro>
 <CA+V-a8uo9sr3m9F_MQYbHVD5wa3LT3n6MWrVpiNiPDumnVHMYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DD9Lvj8eqqR3LfjR"
Content-Disposition: inline
In-Reply-To: <CA+V-a8uo9sr3m9F_MQYbHVD5wa3LT3n6MWrVpiNiPDumnVHMYQ@mail.gmail.com>


--DD9Lvj8eqqR3LfjR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> For running s2idle cases with rtcwake > 60sec this feature would be
> helpful. What do you think?

I think maintaining such a fragile feature is cumbersome. People might
have different expectations and the maintainers have to handle the delta
then. So, if we cannot to support to a large degree some feature, I
think we should just skip it. Until some user really wants (and tests
and accepts) a half-baked solution.


--DD9Lvj8eqqR3LfjR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmozyRgACgkQFA3kzBSg
KbaTXw/+Pet5isbeIJs7zEbYzaNpdqUKe6KH89BvH9pPeHMN9/t1eqDKoZFwDDyy
/3KUhPtltC23NdIVq9mY/LomqK+ObwCfIex9IG+REvShrZx4wdmqZPFEhtXMrT4d
E0YjwICgx/joHt5vW8GDBy/lgb4Nl7hMQxpJy49plaSUMKPNj2ZnpwzLawXum3Ld
xm87E96WnVKPOs5n5ceaOXAWkgidXy9tiyMtpehU5QFrCjQ8SMCPov9hn1ksDt6L
UdGa9W+INSUC62H0Wjr1naHnQCSyuAwkhvclSUf8p8/CWx7a+pAIeRaR2vHWJCTv
9vXv1KgSw4LpM/mrU4dJ4Cv1kqsARLzFPN8QDtTwQoLQ94F+vYPGZlRh47hNecnb
z4feFEibOktHLwzOV+2+N7mmr5rE83YU8Y7Y5SLOKmnTB40BuvZsIWko6ZrQuSko
Wjn4edQN++sCmHDSwjxi5fJiH37Uk1BbEvXTxIlNz6gfucGtij5Wu+PEuQ0+oRB+
aATyLT7W0w0g4mxeMr/HhSco1Z8LadhdyTBEHHnWHJ0U9O1izFxtGprmgzFXnpCF
khhXjixmCHiYq7WuS5JJMBmSeD5ZnvGbjQhAygfCniUALj98crZKmgOJFjeabZin
9K5Un+Emo5iwGUFfzmktI/JvLnWnLF5jkwGsRjOzoHKrAolw5EQ=
=kcqa
-----END PGP SIGNATURE-----

--DD9Lvj8eqqR3LfjR--
