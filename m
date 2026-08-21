Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C44CA26D
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325355; cv=none; b=B5M8d1WvgEijSeF83AIFk4B7MUGPO/jYaO+LlhqXB82FBj6ZldbIBEpQnf4/1VdejxPX7mLv6mP3eCIFeLNlaMqHFVJyYCcY1Lz4PodxgeJ752GGqsxO+ILn0L9eGEn0EZzLr9Q1BCzTYMQJq070bS+Viasjn6wmRz7JxMVyIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325355; c=relaxed/simple;
	bh=21ctLwJPvEhRuTDaPX96Y0NOo74oCljgQKriInCzXGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptghKZAIipAVErScWPcuFQF/MY0lvrWxHLsxM9UVQGsfpK6n05tL0u9K7Gftx6Y8iQKzepFbTh/1YSBoiG8hL/cjdt5z6teRjddAzdgLfOZkpjZ++Xnz8nK0r+eYULp7ORyKVw32iVVaAuTjFh3ys3n67O++N21Iqn5DWVcB5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=EonQMfPp; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="EonQMfPp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=SEjD
	crlpVjC60IzAnkU2XTdoDh6O09yHxWnsPLianKw=; b=EonQMfPpmNW8zm7i5Qxq
	htaVibUaSjeoGvMocQzHE11cdyW2WUujFgybSWgDlXQjyOsVPGm6S2bttz9iVKt4
	9C2i1rkuUYzT6Deo4YjugUsvoSchsK/NSG4Zw8RZ+bN5GPD8skk0Wu0geWIb/F2Y
	EFaOuzb6394gOuCKXVBUnlyCXVTPhzx+CG6H2Ap0oYFP+n11Lo3cuUYSEl19gNaR
	7e2MpQvqk3M3Rb1JzFRQ+TsB7EOIKp6Mwwwln+FkXW4JHqkiFqfYhHAbBjEGtY+T
	Or7B8jhATJ4ZJ9o7zYg1Qx1SNaY43U2JCAR4ygo4VvRZFPInOhzKMQKKwqMLHlQu
	/A==
Received: (qmail 690709 invoked from network); 21 Aug 2026 17:15:51 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Aug 2026 17:15:51 +0200
X-UD-Smtp-Session: l3s3148p1@mD6oHJBZFr0ujnuu
Date: Fri, 21 Aug 2026 17:15:51 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v5 10/17] rtc: rzn1: Replace remove callback with
 devm_add_action_or_reset()
Message-ID: <aohrp9dtVTAg8sVj@ninjato>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821140725.D39CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yWIVHNauTBxAm2Qp"
Content-Disposition: inline
In-Reply-To: <20260821140725.D39CB1F000E9@smtp.kernel.org>


--yWIVHNauTBxAm2Qp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	ret =3D devm_add_action_or_reset(&pdev->dev, rzn1_rtc_disable_hardwar=
e, &pdev->dev);
> > +	if (ret)
> > +		return ret;
> > +
>=20
> [Severity: High]
> Since devres executes teardown actions in LIFO order, will registering the
> hardware disable action here early in rzn1_rtc_probe cause it to run last
> during driver unbind?
>=20
> [ ... ]
>=20
> > @@ -468,14 +480,12 @@ static int rzn1_rtc_probe(struct platform_device =
*pdev)
> >  	ret =3D devm_request_irq(&pdev->dev, irq, rzn1_rtc_alarm_irq, 0, "RZN=
1 RTC Alarm", rtc);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "RTC alarm interrupt not available\n");
> > -		goto dis_runtime_pm;
> > +		return ret;
> >  	}
>=20
> [Severity: High]
> If devm_request_irq is called after the hardware disable action is
> registered, won't the IRQ handlers be freed before the hardware is disabl=
ed
> during teardown?
>=20
> If an RTC alarm or 1-second interrupt is active when the driver unbinds,
> could an interrupt fire in the devres teardown window where the handler is
> gone but the hardware is still active? This might trigger the generic IRQ
> subsystem's spurious interrupt detector, which could permanently disable =
the
> IRQ line.

This needs to be checked, I am afraid. It sounds reasonable.


--yWIVHNauTBxAm2Qp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqIa6cACgkQFA3kzBSg
KbbjbA/9GjGrjSbxpVZA5XNA6QLp8S2MRsDNo0mGJ/jFVWGPHSm18FsMvv2MxBZd
3pkTUoTtLCxbPhA38umc6KDf+iHz48ow++JzAr2CmxBchToXpPDVH3RmVEgWyD/Y
7+OU7dRST6ChqiOPEVf/XcGGM2rtTS/b6dJe6nKDMGvcTtRiFtnPibkjaKlmmFeP
pKORVErq09hL+iCgBknywjB699+BuRVbpxvsUvVYbtbdNCylzCjEgsfEDwTiJ0ZP
V1EoKWhszS41Pl/fPVj4nJyag03s7Lx8jmoaRkWtyWHrnHttMm5ckrFSzD0rnlMw
9m7R3lTG66QDs19E1kd5AWuE6Fn/tV6fsfl/uwiCo+16YUZjLVr3XOLtUVeecwiA
g3n9HolVGEXGprXDEm/g8QlngYSpkPerWpqbjybAFR2iXe561x2imi+17Lzb52yU
mB2ZPWQk/d+WSA65MaIV8ZTaI/e7JCQAv7RQcF1wNKKPyOgxA8WoomxgcAQbDuwR
u115ZnS+jdB/k4B1J3kfdB6Yd6Vxl3UUwWJfZKLAQwitlD988qOWqrxixUnqp6D6
dkM95157g707FGUxB708z4zy6e+TJeKABv67pXsPW/5Ch1Z2Qbrnpc3vlCXbzrGv
agjD2qvhQzav7JE2YOSnfxx2hP4Z2pGfv9zdDzVBT2AaKQYnss0=
=2V3P
-----END PGP SIGNATURE-----

--yWIVHNauTBxAm2Qp--
