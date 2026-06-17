Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5F37F735
	for <linux-rtc@vger.kernel.org>; Wed, 17 Jun 2026 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694528; cv=none; b=F66htg4iWY8t030L6Dtfxh+Z1rCanNh5qWNxqLkfHA7dD5PcbcTnKyPZr0ghB2+tfjdQLiMH7CAMssCZ4jBJdCIgFhqzuphk8r9dLggQeVd62N8h54CYbaEMAY1hhtAGQPlWlsNuwZM9ULZjutrt3vcojR1TLUg2wiyPELPhPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694528; c=relaxed/simple;
	bh=2eeJvJ00yuhhBXupeaZByMRu2PEkREljI41m93Ip2EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuVVyrA8bO1gtCyiof36fOe2k2TxrX2k+7NkaecIKasasXWpUUNzpSR0jPG39RCjqefnS+KtHtQShEtrbxwgZhGAKvMSzqyawhiqy4B9nLGOtY31ZACOXfBPS30GeWR16FvQoCcLwcBwE4osSPTn5Tz7eEl+knYPCi1DaWn/AWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=UdrB4awJ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UdrB4awJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=wZQs
	+8krBZmwYGnjzofl87rt2yi49qGKHOJDbMffvto=; b=UdrB4awJaJBoakfmH3P3
	inRN8+SQknYcVX1Nx0T77V43nQCl1ins9hpWAP3YSu5Zll96+oWMfTGdsVKet8zM
	iTwPafgMJ45GOGWUPHXixzbboTC91zTY+voTNe6ZdnxKOtg7iOlC52RtPF4aBG7y
	jp45K3ut7mz4LSTm9pJ6hIvumhxYUn6DBm3CywxaNEsm76NMZHZUnwJE4zPBG50D
	9CBOrvbOwk4v+A6pZHD2H/rvf7pW/STrsbWMFtcBQ+68dFAPvAVp2wHn7pI2Q5dP
	iGTktva0p8aKemnVKDVsoDKUqOJjHV0f9PD4CtiiG8K3IfubTLWaWZKfkOTce24D
	IQ==
Received: (qmail 136374 invoked from network); 17 Jun 2026 13:08:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 13:08:44 +0200
X-UD-Smtp-Session: l3s3148p1@ugk5FXFUVp4ujnvI
Date: Wed, 17 Jun 2026 13:08:44 +0200
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
Subject: Re: [PATCH 09/12] rtc: rzn1: Use temporary variable for struct device
Message-ID: <ajKAPJGrea01XVeI@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pRhRGaqgXYIT+eOr"
Content-Disposition: inline
In-Reply-To: <20260615154805.1619693-10-prabhakar.mahadev-lad.rj@bp.renesas.com>


--pRhRGaqgXYIT+eOr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sashiko found issues, not introduced by your patch, but still. I
curated the list and left only those which I think are valid. Do you
have time to look at these issues?

Thank you and happy hacking,

   Wolfram

> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] Asynchronous pm_runtime_put() is used instead of pm_runtime_put_=
sync() before runtime PM is disabled, potentially leaving the device powere=
d on.
> - [High] If the optional 'xtal' clock is missing, readl_poll_timeout() lo=
ops forever with a 0 timeout, risking a boot hang.
> - [High] The driver's `remove` callback prematurely disables hardware int=
errupts and drops the runtime PM reference while the RTC device is still fu=
lly registered.
> --
>=20
> commit b7f73c7d0932a6e78b12419c5912ad3243637b8f
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> rtc: rzn1: Use temporary variable for struct device
>=20
> This patch simplifies the rzn1_rtc_probe function by using a local tempor=
ary
> variable for the struct device pointer. This avoids repeated dereferences=
 of
> pdev->dev throughout the function.
>=20
> > diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> > index bc6af59744e48..25cad9213147d 100644
> > --- a/drivers/rtc/rtc-rzn1.c
> > +++ b/drivers/rtc/rtc-rzn1.c
> [ ... ]
> >  	if (IS_ERR(xtal)) {
> >  		ret =3D PTR_ERR(xtal);
> >  		goto dis_runtime_pm;
> [ ... ]
> > @@ -486,18 +487,18 @@ static int rzn1_rtc_probe(struct platform_device =
*pdev)
> [ ... ]
> >  	device_init_wakeup(dev, true);
> > =20
> >  	ret =3D devm_rtc_register_device(rtc->rtcdev);
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but does registering the RTC
> device using devm_rtc_register_device() create a race condition during
> teardown?
>=20
> In rzn1_rtc_remove(), the driver manually disables interrupts and calls
> pm_runtime_put() before devres has unregistered the RTC device:
>=20
> 	writel(0, rtc->base + RZN1_RTC_CTL1);
> 	pm_runtime_put(&pdev->dev);
>=20
> Could userspace still interact with the RTC during this window via ioctls
> or sysfs, potentially causing synchronous bus faults since the hardware is
> already suspended? Should teardown be bound using
> devm_add_action_or_reset() to guarantee correct reverse execution order?

[wsa] Or maybe not use devm then?

>=20
> >  	if (ret)
> > @@ -506,7 +507,7 @@ static int rzn1_rtc_probe(struct platform_device *p=
dev)
> >  	return 0;
> > =20
> >  dis_runtime_pm:
> > -	pm_runtime_put(&pdev->dev);
> > +	pm_runtime_put(dev);
>=20
> [Severity: High]
> This is a pre-existing issue, but does using pm_runtime_put() here (and in
> rzn1_rtc_remove) leave the device powered on indefinitely?
>=20
> Since devm_pm_runtime_enable(dev) schedules pm_runtime_disable() to
> execute during devres cleanup, calling pm_runtime_put() only queues an
> asynchronous idle check. The immediate return triggers devres cleanup,
> which executes a barrier that explicitly cancels pending async operations.
>=20
> Should this use pm_runtime_put_sync() instead to ensure the device is
> synchronously suspended before teardown?
>=20
> >  	return ret;
> >  }
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615154805.16=
19693-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D9

--pRhRGaqgXYIT+eOr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoygDwACgkQFA3kzBSg
KbZnPA/9Hu9SvBZVOcCSXgElgrkLR7AIqyaiRh+GFuVBMjAyZQVZugRCnvOEloHh
GUvomfxa0Qrro8hAyA2sMUgvXoeQ3M3YBMlnuEE822V4Yic9f0OLQidApFEgbKq3
JVI6NlVGLNu7mKLlnBlAl0U6V+T27rFTFCDxO0cvV9PSyF3zKCH5oBLn/xCTw4aI
pK52cQNP1TPKmhmIjQnRBf6wefc6h37K4dAxDgRu2YOAgv00cAlzZPglZBqgzzbB
q8apbLUZ7ItyIdg+M/ThoIejlEFErLREB1TbLKAG2qFeMdiAiPaa4cK63gu3ZtJf
w0nHR9nXCUc7qmX6LgcFHp3otF7YP0VVEIf3kl+rxb3RdY5DuG4FBOGHaUnW510s
WQZKAATnSzzUes7ade6FZRCCbdUAWCQY00vf6msgYy2in1GEFzeTdklgHWyw69G6
f/KAJqqsvGzh7KJ+ojcQakak36xYHlivxRrS0S6unjmj97V1xcQKhK8sbBY6XViA
8E1uvkbBO0dPEny+Lf/q8g/1PJmltjwT0n+d9IsCz2Yb+R9K4juAu+Aj/BdkSbI2
E6bw8Y80tMb1zaDEHbeyS0ucO8amShvX7b3IZaRJLwdCkJDLRhP3w6VwK5eXy8+d
Fznv5X/c8TOUWIhz2I7LuSemK35wuNzOlWD0lk1Qh5VuRK8ipDw=
=CE1D
-----END PGP SIGNATURE-----

--pRhRGaqgXYIT+eOr--
