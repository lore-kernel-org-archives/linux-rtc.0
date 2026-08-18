Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A933B71C6
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050145; cv=none; b=GlPU9aPCDlhsK3Rx81UPFM7xwtmVU6jXNNo5J2GrfUGXymxhSjdgFS2hSPt/2WcpQL0nStakJQVqQ3/u51FnM12RGgnR3Mby4QYNjBu1TGlG2p9JjYJc7LmqkzebRHY+lSnNQZLFCRjtqd+iRG+bwfdqTZaq3ONS5rFBHnQTgQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050145; c=relaxed/simple;
	bh=PK+cy61m0A69O+xMJxzJUVb0DU/XGxhhf2gcju3goLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAUfIraQwiNqD1ga6WF66I/iSmi4zUCgSyK2PjB+s8TjqQv0PQb//tjl3iqSEETJk+kM+029tK+026b8XOL7GKyEpu5AIueuZAGKO2cvXQwcLSh4EvvE+dNaBveBTQzhLRwkLtI+y9axi3QzTLS8gKsuyC52lpV++lb9cJN4ny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=dNPrwQNV; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="dNPrwQNV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+O58
	3GA5ksqbAZt85yY7ub/rJkSck8Zjm7SqY/UleO0=; b=dNPrwQNVVUq91x55YCJN
	l+muSftGXN2PM2QkP0BiPRhlF7zrITI2Kk/guOAvgCssuukQIRvk0Yy+LWLvoRcf
	XKHNvNKsn5+u2crOJQNCUO4f+lS7CyLESHiqiGxIAjjZGi37k1B1YiDQhyyozc3l
	4jyfQSvwBLRLhoyhz10UAe7PiD1K4nOTLrg0ey+3uh3gO8DnPKAp5kBcrEvTnPqv
	yYoVVQbbmOOkmPpbBrJ/YbeGznT8df8dqo9wy767fIToM+8mYaEpTzD0XlqlYWZc
	RlrvgL3eBRY8sSQ57jLIUQAZONUGuNVqP+YDgyixlihlAG6SUXqqblpp8zsDZjv6
	Nw==
Received: (qmail 3763757 invoked from network); 18 Aug 2026 12:49:01 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2026 12:49:01 +0200
X-UD-Smtp-Session: l3s3148p1@0TrYCFBZEq8ujnuP
Date: Tue, 18 Aug 2026 12:49:00 +0200
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
Subject: Re: [PATCH v3 08/12] rtc: rzn1: Dynamically calculate
 synchronization delay based on clock rate
Message-ID: <aoQ4nMR-NeV3FFz9@ninjato>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gNHJ+Ta7eQurDPlK"
Content-Disposition: inline
In-Reply-To: <20260706175138.12587-9-prabhakar.mahadev-lad.rj@bp.renesas.com>


--gNHJ+Ta7eQurDPlK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> -		/* Wait for the counter to stop: two 32k clock cycles */
> -		usleep_range(61, 100);
> +		/* Wait for the counter to stop: two RTC_PCLK clock cycles */
> +		usleep_range(rtc->sync_time, rtc->sync_time + 100);

Hmm, 100 seems more arbitrary here than in the original code? Maybe 2 *
sync_time like below?

> @@ -444,12 +445,20 @@ static int rzn1_rtc_probe(struct platform_device *p=
dev)
>  			scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;
>  	}
> =20
> +	/*
> +	 * The internal clock counter operates in synchronization with the
> +	 * RTC_PCLK clock. Calculate the duration of two RTC_PCLK clock
> +	 * cycles in microseconds required for operations to complete.
> +	 */

Too wordy, this is enough IMHO:

/* Calculate the duration of two RTC_PCLK clock cycles */

Rest looks good.


--gNHJ+Ta7eQurDPlK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqEOJwACgkQFA3kzBSg
KbataA//Yf+2NLeqnhZfKJmbr5z5abrTuxN1FXS3uVqY/kCQIpPeJ7n3V6xzZkqp
gWKGMmlp29O6nRvWhUJnMpVokdvW3+UBmbQ21wgDh2YXyuAMcjEbuc3hXJPWhuWu
uVhBoY5AMAyEDtrFRxZuRIorDwI/+lcQgLu4z3njvfQD2iwXlIAQ+1rXRtRdp8Wv
jlILModlFe8VxnRKWeuUn2bUDj/D9ftIyOOhV0crHg/NJR1bl/tTpJTfrTsy7Flb
eqR/aRGcz4OmZ51MAc/UyZak8N2S1FnbLG0Gam2+wxx9f8jlqnmawAoRv/l9jixL
MYKSZXmHPNrgzz4s2jAhAbfQ8wHO8GF0XPaEXngRzl066AYvyrplWTKR+a9sb8On
BWUQtcWBVYpWKz7m9ShRbhXIxonD+LCaBDYWIA6xJf4s8w3AxNekOnCL7stppk0W
4aADgDCw51F96wyry72W4XihfdM9yR+Gby9hJVl8eJ+fF7H9j0+BCDKrM9h8ODc/
rSkuMXKTbMVYveRiMzDiaRyphpo/pAkm3sN06GxSm8r1lkhX1P3TgQuzBowodInB
30BbOKWmM3Iuwc+aJw3THw7xL/jSUTKmz4Q/wbUjakNd/LprZwl9EwfVrQuPfQIv
euNCz9p2zux8VqYfQg5hirndIIn+PKsPTflNPKWrkWWOu3xbiWc=
=i3HC
-----END PGP SIGNATURE-----

--gNHJ+Ta7eQurDPlK--
