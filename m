Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27854C957C
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325018; cv=none; b=bJMiftPuIpIFlRAwKAwM0sXEjS71paGSe9qtMtvAHq1ttnZDsC7EYkMfPrRS/tIMdvP50QhCIirp0+x0CxJ3jeH0/86D29eG0gBWMasvHN3uOTwga96Z6ddY1JA4G7ivxUqo1/R8itjqFQo5CPS+wB9BDE9kCao6/HuMrHnEjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325018; c=relaxed/simple;
	bh=dqRxGkSTo1VRrIDe73RnVqLS9vGMNpCP950CHgyosts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIGWMl6n6Rhl/1kWP/gi/xSKeIqAWNLG+PGF5xZrxsd3SyPqu4TWlgS0ImBF6iZ+kFAlSrFLYZ1u2K76+KSptroPjrhHfyTCZjM+jPONxNm52ZOSPNe4HpJrJOKC/KY7rDs47l2PPss8S7y/vVo7nRg5dDf6bjc9YV11oyRo3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=aoAUH7WB; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="aoAUH7WB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=EUBr
	8qIIL+olxH5I1RSEZWrEOi7bz6A5QbneJ9LGZK4=; b=aoAUH7WBJ+VU1Y6t7lAd
	JNIUm63MKtBJXlFoUrnFl/WYEsOAe8dasVQ07t7hdauYUJ0SrFjADHS2V7EG8jV+
	9WKuf/HA4u5P0M1ecG5uI0XCvaJqQVoXbJxO831/EeLJcRQbsgygSV2551kkZamw
	9B2Fx4y1LnMgULWyKb86y1slKQWxM79uOuDOKvzET4yEFxBjc3p12I3df1/Ug2bs
	pGoEPjajNwSiKB9tvoMzLi7oCBwQgDKA3mXw7L/LKlEqH91PjYW7cbHuKn7517jV
	UlcOvNECHGjb78eqwEZcBin4Ur4l+MGhtPqqLVuaYvkB/eqwxxxaQEHeOLvOdRcC
	Qg==
Received: (qmail 689046 invoked from network); 21 Aug 2026 17:10:14 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Aug 2026 17:10:14 +0200
X-UD-Smtp-Session: l3s3148p1@WgqVCJBZ8M0ujnuu
Date: Fri, 21 Aug 2026 17:10:14 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v5 06/17] rtc: rzn1: Disable alarm interrupt before
 reprogramming alarm registers
Message-ID: <aohqVrJV5hiZoWXd@ninjato>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821141041.57A191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ahu/JitMwqTsonzY"
Content-Disposition: inline
In-Reply-To: <20260821141041.57A191F000E9@smtp.kernel.org>


--ahu/JitMwqTsonzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 02:10:40PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] Concurrent lockless read and write of `rtc->tm_alarm` and a race=
 with delayed IRQ handlers can cause a newly configured alarm to be silentl=
y disabled.
> --
>=20
> --- Patch [6]: [PATCH v5 06/17] rtc: rzn1: Disable alarm interrupt before=
 reprogramming alarm registers ---
> commit 6227942d78d91abfb1648a64bce64f0011716b61
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> rtc: rzn1: Disable alarm interrupt before reprogramming alarm registers
>=20
> This commit updates rzn1_rtc_set_alarm() to disable the alarm interrupt
> before reprogramming the alarm registers. This prevents the interrupt from
> firing while the alarm registers contain a mixture of old and newly writt=
en
> values.
>=20
> > diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> > index 44e8db466cb78..09631a3a51345 100644
> > --- a/drivers/rtc/rtc-rzn1.c
> > +++ b/drivers/rtc/rtc-rzn1.c
> > @@ -280,6 +280,11 @@ static int rzn1_rtc_set_alarm(struct device *dev, =
struct rtc_wkalrm *alrm)
> >  	if (alarm > farest)
> >  		return -ERANGE;
> > =20
> > +	/* Disable alarm interrupts before reprogramming the alarm. */
> > +	ret =3D rzn1_rtc_alarm_irq_enable(dev, 0);
> > +	if (ret)
> > +		return ret;
> > +
> >  	writel(bin2bcd(tm->tm_min), rtc->base + RZN1_RTC_ALM);
> >  	writel(bin2bcd(tm->tm_hour), rtc->base + RZN1_RTC_ALH);
> >  	writel(BIT(tm->tm_wday), rtc->base + RZN1_RTC_ALW);
>=20
> [Severity: High]
> This is a pre-existing issue, but does this fully protect against a race
> with a delayed IRQ handler?

I'll leave it to you but I think this should also be handled
incrementally.


--ahu/JitMwqTsonzY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqIalYACgkQFA3kzBSg
KbbYtRAAmBGBeeUfZjCYLQm2Y/O2Zm3wN4Y9jZLcWjJoBiOiwkJ4IkZG+BdvhT4k
1JG2HaD5oGj4PmKgpIYhTI22cgocQIgeBmsP+V3ETtHOt+eVD8j1oBU+gsFLzYX8
3HRoOV8yPlRCVgm4pvxmFluxHnKcmJUYW2vxRngE1MMLhtnMG7Tvk6i84TFbpaX9
o32KOtCsySA3WSohFhlyDU5AW1bzh+7ZRNswe4uWi4OoBxW4gCna7iCUVJihLb7u
1rucfrTj6Wn+amBSd1gm+R3ASZ8uJN9gc7RGSK/FfQyYeYJBCy6H7M77BIwthn5E
Y23xbcrrFP4gl6JjIsxQ/n6SNltELkMlpfiP4HKiBNJ6+JsC0RkLcX0y6zQUpb7F
LI117lIRoHk3RJ36y9Pcb91Np6nztMn/ltJL49YKCrM9GXQ2OjeQrGvBqYvzQqwj
uSfXPdJ3yvHQlSCnHa+CULC4FCEsC5TEOCwScezzRwlyVErcKj/6g163PG2vuvs3
kURrj6+SZGnVde8pO0GSKKk6RnzOFalCA06jX462LyTcLEUM2hoXkfUrdd1w9s44
I4LyAIuEnf8f99+6cv3GjiU1m1sBtWUeHxQXo4tJUCfdZDIqswUK+C5C8amMf0Ki
irPk4cRg15vk1HhVcvUY+CNgcHaFze0qkA4OjmCE7stfK18/MBg=
=SSbb
-----END PGP SIGNATURE-----

--ahu/JitMwqTsonzY--
