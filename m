Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D73C4545
	for <linux-rtc@vger.kernel.org>; Wed, 17 Jun 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690275; cv=none; b=VeVT6RqrLqyfU+1wmlpiVcpHk17QJlKeB/oPZYH+cfd33kJiFYpaD4tLFKXJIHuv9Yc2hQF7L3uiSsTL2lkcne+3d1MwdQnqCvB+/vPZkBIffMVtOBBg+DiH5yYl8oDFHZ68XW27J8JDK+PLXEOdIwAq+ZzsZSBoeAZ2MiWMmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690275; c=relaxed/simple;
	bh=BwE6bYO5GnG+VKz9wWw/hW6X2YhyStMs7xLHXW0sREQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeL0yIq1+Kwby8hzXhp/oQ+d/J1BhBPHaLb4DINAjc5gUq0TNiFhD8yMc1oNyM6kR8dRsDm/IXDE05IM3DtUetEUP3b1KZsOIWUW8db6UePv7btmibhre0dTx/HfpNg1FVBAygMIKfo7xSwViEAIKhHw0wo73uEqR8DXpi7C00Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=JiqwvSm6; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JiqwvSm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=hchz
	Gkv7snKjDyQgvAkU512l331Tlzd4mELj4plHMhk=; b=JiqwvSm6R4sR0lSnQOhb
	/bXHaS/FnIH0D17pR7O4Hdh27UDM/nzslMk62hXVCyl3jb6lzgiWdb9t2y3oAYG0
	wTp725fq8SBmUzbpc222FE/ku6BdO6fi8A0fRBF7jDI2DZLbIQr+mlNnMPcoXTAj
	p2xpBXTLW6gRAt0ZupClxouu/DZVq+zNPHlrbLKDN3+KoEYbK0YjrG32GTR49hfD
	bxPHcnp3tVL0nwVjpNmRsVxYYz3othhG2FWKMQBgyItEvEeQTrvptSAJT06LLHFc
	Zhi6UhNJjXLgWa1Z4nEOqYancLyQ8vTWDgBOaLTE+wBCgYXuFNabPfbc+Gd87EJf
	vg==
Received: (qmail 112364 invoked from network); 17 Jun 2026 11:57:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 11:57:51 +0200
X-UD-Smtp-Session: l3s3148p1@JtO3F3BU5pwujnvI
Date: Wed, 17 Jun 2026 11:57:51 +0200
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
Subject: Re: [PATCH 04/12] rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency to
 ARCH_RENESAS
Message-ID: <ajJvn2YkaspTYx9M@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VPg631Cl9Lczsi1H"
Content-Disposition: inline
In-Reply-To: <20260615154805.1619693-5-prabhakar.mahadev-lad.rj@bp.renesas.com>


--VPg631Cl9Lczsi1H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	depends on ARCH_RZN1 || COMPILE_TEST
> +	depends on ARCH_RENESAS || COMPILE_TEST

Yes, this helps X5H also :)

> -	  If you say yes here you get support for the Renesas RZ/N1 RTC.
> +	  If you say yes here you get support for the RTC found on Renesas RZ/N1,
> +	  RZ/N2H, and RZ/T2H SoCs.

Such lists are easy to get stale IMHO. What about "initially found on
Renesas RZ/N1 SoCs."?


--VPg631Cl9Lczsi1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoyb58ACgkQFA3kzBSg
KbYGfQ/6A5cxO795K1oD0uWEIy8G3MAsikJcFbPjW7MNy9aSPn3MQMjcXm1a2CfS
04FgyVKdFWFrZfIj08OAHlTSYXTHnZ+k/dXp7nIIWYfq4kfAUezj9dqRqu7Kl53i
XvoiJZED3htJaQ4UxhFBq3OY3gWHjCQy7iz0o7RDQUZHjbv3XhWXGGpFQbvxkvin
2CtR+qZEft3G/fnzIXgDKvULnXTN9/Y04khzw26fuOnOC756Yz15oH/rklU308UD
Ep+6N7foK8R/0US/SGihr1VW0bEGNZe9bf7gIpHFu1JzOQqpJ8lSshp7cHClVfTM
9xWY42vaWB/EvNAT2NlZT4QqRcjDt3OvlG9zrpS14LVcka6wXSDBOak2SbXbA1hX
NYyh69pt7tIxFJeu4cDl7tG+QrJPEhvG1HlNr06pc50UWhyL73NhzcwypgYdkmwV
Zv8DkdEqdo+RNM/Y5hEjaICdKCLElhP/n0sPwQ6bhL3XU1Wl47v2bTYwzBrXpaV9
6qhdxGGKP8/aiL5SPuYNW1fJXqWwZKJkuDAK/sJHAlhsyPZFkDoc3OStK+yfxm67
dfhx2jLghYtIejm7I5UHEu1IVnNOMDCIqRQFwQ4N3mjA+DysLx+M4zqzoRAlAKth
c33iIAuLyLNXJMZGNLrBvPvml3bYWQOXYluKroECMRT70hojifU=
=mujp
-----END PGP SIGNATURE-----

--VPg631Cl9Lczsi1H--
