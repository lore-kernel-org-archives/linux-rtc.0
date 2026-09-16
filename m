Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5E44C659
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544000; cv=none; b=RwCGlgOSdi4nHZS7iC4o2KbY61zSvYfeSDClr/R7mIEuWGnh8njJSFCtivvK0k0Iw0veiLg7/hcmTtR/iWa917wyCwAMSZyEV+JxpvikThiCLchwKuw7D8Lc5s2H8aK0P8baubA3DzNhlgPcL3VsLEHDHDW5kBvqH2zS/3FbSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544000; c=relaxed/simple;
	bh=rd5sAWS8fPl6tZw0Abc0rw3eZN7dm6UaDYyS9yhj/5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXZgDOa9kwSJJNQia7f1W4YhMnxAIJJ5M1fs1HVjLvVE07woYPnIUQWxC9t7j1AoX0u2uOxw23CdSskFiQ5TF8B8RBISitGx78rSIy4hUGnOIVoAbkIq28rQE7szwhuAhg+603wzJL9cA9KYy7mSmzLHuDd132+cRmRDYihOLBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=F8ZZmtJt; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="F8ZZmtJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=rd5s
	AWS8fPl6tZw0Abc0rw3eZN7dm6UaDYyS9yhj/5Q=; b=F8ZZmtJtRFCDzdjSESr+
	jYd9JsENqBeacg0rEWkqhW35/gl13jCJtpd9GjHvAXJS3Y13uKdTFsUb2J5ipGiY
	UOw6FnodIn7Qcru5asZyJS/d+d49A/pxlvO7kCmck5OgpxqLv/IzuXONKEyaLioH
	30dqu69811cQhALo4ebEH4MZp+ggENUG1wnOOQQaOVXattbcRyUactMcLwoxL9HO
	u1dcz8X4p2Pw7na4A4WN3r6e5c9JYskvBrg+m2zScCWfyLk9+zpFPIjQxIsuR7Qk
	zsYHLpwfTfN3B0yzzAE/iqqXRfjUoDi26b7zTiYaGU3cvW9Bo9R2JXIw1BsovDdy
	Zg==
Received: (qmail 1445549 invoked from network); 16 Sep 2026 09:32:53 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2026 09:32:53 +0200
X-UD-Smtp-Session: l3s3148p1@+HvVrJRbvMcujnt4
Date: Wed, 16 Sep 2026 09:32:52 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Conor Dooley <conor@kernel.org>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: rtc: rzn1: interrupts are not required
Message-ID: <aqpGH_VURXi8y569@ninjato>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
 <20260914211826.73727-11-wsa+renesas@sang-engineering.com>
 <CA+V-a8ssNZ4X+e31V59YdqYmoap-S1W3Vfois9oNisVT3izxag@mail.gmail.com>
 <20260915-cultural-patriarch-9ad164b46cba@spud>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UdnYYk2FsmUgjAld"
Content-Disposition: inline
In-Reply-To: <20260915-cultural-patriarch-9ad164b46cba@spud>

--UdnYYk2FsmUgjAld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Maybe we can add a conditional schema check for SoCs where
> > interrupts{-names} are required.
>=20
> Yeah, I'd prefer this. If all current devices have the interrupt wired,
> there's little value in permitting them to not be populated and thereby
> lose the support for alarms.

Okay, I will refactor like this.

Thank you for your comments, everyone!


--UdnYYk2FsmUgjAld
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqqRh8ACgkQFA3kzBSg
KbZjGg/+OZr+JSK2DNpjhja1RyLpQwEahv2FNl6oxetzONtFdgR/fU44edmzSWSq
tulIOBbBHBSq+XJokJXwZGm5NtTDivYrQ2/+TevL0Ir1MQ5G3IuFDtWnL91DHzpf
NhdLe3kvrRHFLc+czNmB2BOiDQ2wSQFDIcJ4o71b3c/wz8WUMYLV5NkCDY5VjJbE
T42TMBlbVHcrPM3QjcWLY84OjPvIknV1LNXwJ7Nu75nuO/GRF8guFi5ooenPVLZ1
fDlTonimHk8rSOAbp4j/Yq2MziWsqiOF3XT093WRXEdKETa0ZfbYpLG+ioTRfns3
lXFYx7sBwmZedtuAWS01PInbCFkYF8rq05b65Pb8XxULwBFp2nIeqJxY0bfktHaY
NUcSi5IIOycqdR53MVMADhJtezES8zsRzTc9ZY4Tca4KhBrU2Oo0SdoS/RK1tC+W
LBfryKtY9McPw6VmoMEU+w9Qc9R4a3V7IsSM0uLsR4swQXNZFj0UTEE9wXRqBbzi
NwWzDzDgGo6En0gkpYASPBCxIT4VxdtXZsdareplaluCrlHuNmhfgIQH/gLFTCpk
awKQq3JVkaeVXpn/6NBWJEITRurjyKqyIk82xwg42Os+trA90o6fIK5Fzgfpis5m
rkMSYM4YWtpUikIXaqyq3tMNO8kNA+Ygw2siM9JvZwnQXOks+Gw=
=A700
-----END PGP SIGNATURE-----

--UdnYYk2FsmUgjAld--
