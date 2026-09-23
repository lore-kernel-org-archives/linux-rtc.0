Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA934391E74;
	Wed, 23 Sep 2026 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182163; cv=none; b=g7mzJ3qgofpSoVIzXz6k7+YuL5dA2cm5jV8Qu61Nagqk0mrcew/Aes5+lg9+H7IfOLviun6AopNPV+mkI+8qpnCyf5csQqVrCWl1f74bezjRVOwSx72KnKAnosZjO7FF1t3wXKmeIiM+nXRdiRBCM43nkly0yN9yw8q7c7tckAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182163; c=relaxed/simple;
	bh=6D/6Lx4FeaW18dd0db0e2+PErxS3iDoNCWBjzge9c2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZe7grtwg0kMHCMGokgotKS5uQCzIn5TW/G7HK2Ww0Y6VO8TQbKoQlIr4pnbZJuUwu7gZo7jUZ2c7uF3SgHPkdFnAe3J/oKsHTViU59Vm6dVTzRU44+3JGGjF53Pw1cYTXMlDFq6M9VdNp73g2YsdXF7ublipdkWssT+snZjqCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKGxQ1XS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKGxQ1XS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DD81F000FF;
	Wed, 23 Sep 2026 16:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182162;
	bh=6D/6Lx4FeaW18dd0db0e2+PErxS3iDoNCWBjzge9c2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YKGxQ1XS4j7gZoZTtFLH5kga2VvDvNwjXm7rrNXt46YC2lkj6CB1aBWRgFHKCkxOz
	 fcInmSVY2i0+txgxs9delFDiM6vKGw/5gzUuFK3pzVdT64Frb1FuWTCn0+Cd/IIRKO
	 qvB4NU3JxNoTy562fyiYcC1LanTa8y3kLJH5lSL/VmjrBbPgPxoqyAfG7WxHZYzmGs
	 mSbeKmJd947ct09YEcBsLzcEyJeW//pwH2ysdH/wrt3ZH+POfhreL50UF6qlRc7Dxi
	 O6Azp7S97hm2W7972ekP424jbrbYReAAo+9qmT0cqG2VCIZ/RhlCJy1LWyoiGihtyp
	 EF30dVepjZWDQ==
Date: Wed, 23 Sep 2026 17:49:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: rtc: Add property for Raspberry Pi 5
 RTC
Message-ID: <20260923-basically-slider-df357b773907@spud>
References: <20260923131323.1099979-1-sander.speetjens@gmail.com>
 <20260923131323.1099979-2-sander.speetjens@gmail.com>
 <20260923-browbeat-judgingly-b047721f5cb3@spud>
 <6de301bd-0bb6-4704-8c3f-8da09c5f6830@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Az4NTJrw4JBvlQp3"
Content-Disposition: inline
In-Reply-To: <6de301bd-0bb6-4704-8c3f-8da09c5f6830@gmail.com>

--Az4NTJrw4JBvlQp3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 06:46:00PM +0200, Sander Speetjens wrote:
> > Is this actually needed? Shouldn't the type of uint32 come from the same
> > source that the type in rtc.yaml does? Or is this missing in dt-schema?
>=20
> The rtc.yaml does only provide the description not the type, I also expec=
ted
> the type to be there.
>=20

I think this should be dropped and the type added to
property-units.yaml, I don't know where the one in rtc.yaml is getting a
type from.

--Az4NTJrw4JBvlQp3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarQDDgAKCRB4tDGHoIJi
0q4jAP0fxrVwhLTgoZaPeHOSKgAl8IZFnecnfjyEXRCM5zpNRAD/dAch7qPLWnJ3
xJYXTouIBYrbyM4DV+ecAeL4NwMJRg4=
=RW4s
-----END PGP SIGNATURE-----

--Az4NTJrw4JBvlQp3--
