Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5014033DEDF
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786471442; cv=none; b=t0kMedcUZdNx3OPLznE+mFkTGYdqWxxNyuNnKY2kYgChO2lKIT0uOmcesBoBdcGRYyFFgQZDIFSkFOo3z3SWqumUfsySs8FYOBXT0UGK8T5mz9Z6eiBbpy2Sg69FHaCOyYzU5bSIA5d8OL0ciH4xDVX7Ort6GVphoQz6i2HeHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786471442; c=relaxed/simple;
	bh=7DFhAXUVgj9JF2prx27/2JFtAO9oDV+94cL3B8WgpqY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lZOxK+QGhCw7AeCro8pqbne5uNLIfuTX1SVI6dkUTyTWPeNa1wWASXnIuvWpfk1H7IDxk9d39lryWAbf7W3PkLK2Bg5MbB0dF8lcuFKjLZKjf/LR5cTUyWEmijixHcB50EKT3ZKLbFS/8ifxqGwRugCAN57E/7P42OMLYcNjTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=JpZibyMZ; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="JpZibyMZ"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 735BD24002A
	for <linux-rtc@vger.kernel.org>; Tue, 11 Aug 2026 20:03:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1786471437;
	bh=y3+z+tsbACfa+Yw+MQefzdiQfWOqt812EOh0FeS7toU=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=JpZibyMZUvOWfEntQoJVcYSL5lgK1ueoM1aovUNhaVFSOkMcQg5nM5aKkHuVLiI9Q
	 M3J4vR2H/8SthF/DYfTH3XPSThCh/6L9sXFhQG3VWohO1SeovA94XekjDn+HvAMkMX
	 2HClLOa338WrlXGX0Natjzgsw8FGXxGkheGIuKlgKk5cQoj/JazfQlyXOMb5e61gsc
	 xh57U7uPpwztqyiqRkMJNNLR66tTEOD3wEBM+RgoBHEPkgPOPE/Y90D5gav0/Q96fq
	 OtcT4X3ozLg+L1AiOSMFFDJhtsTxEnt8ilXMYRKg6iYcS4dGPkb/YFjOlp/xkJf53y
	 RrccqjK1GAiEw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hKKHw5TNXz9rxX;
	Tue, 11 Aug 2026 20:03:56 +0200 (CEST)
Message-ID: <7548ea70cb73f744dd313722211daa9a5cc49d70.camel@posteo.de>
Subject: Re: [PATCH v3 2/5] rtc: s35390a: Add missing newline to dev_err
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, Alexandre Belloni	
 <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org,
 conor+dt@kernel.org
Date: Tue, 11 Aug 2026 18:03:57 +0000
In-Reply-To: <20260805203037.E9A341F000E9@smtp.kernel.org>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
	 <20260805-rtc_s35390a_int1-v3-2-e836faba3e25@posteo.de>
	 <20260805203037.E9A341F000E9@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=mQINBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93
 qReNLkOWguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVA
 m76Ww+/pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt
 9k5JARhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbm
 fAjaoT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwT
 jRQxBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1
 J+FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN
 6OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
 8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJCX
 CeMe4BO4iaxUQARAQABtCdNYXJrdXMgUHJvYnN0IDxtYXJrdXMucHJvYnN0QHBvc3Rlby5kZT6JAl
 QEEwEIAD4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQSCdBjE9KxY53IwxHM0dh/4561
 D0gUCaIZ9HQIZAQAKCRA0dh/4561D0pKmD/92zsCfbD+SrvBpNWtbit7J9wFBNr9qSFFm2n/65qen
 NNWKDrCzDsjRbALMHSO8nigMWzjofbVjj8Nf7SDcdapRjrMCnidS0DuW3pZBo6W0sZqV/fLx+AzgQ
 7PAr6jtBbUoKW/GCGHLLtb6Hv+zjL17KGVO0DdQeoHEXMa48mJh8rS7VlUzVtpbxsWbb1wRZJTD88
 ALDOLTWGqMbCTFDKFfGcqBLdUT13vx706Q29wrDiogmQhLGYKc6fQzpHhCLNhHTl8ZVLuKVY3wTT+
 f9TzW1BDzFTAe3ZXsKhrzF+ud7vr6ff9p1Zl+Nujz94EDYHi/5Yrtp//+N/ZjDGDmqZOEA86/Gybu
 6XE/v4S85ls0cAe37WTqsMCJjVRMP52r7Y1AuOONJDe3sIsDge++XFhwfGPbZwBnwd4gEVcdrKhnO
 ntuP9TvBMFWeTvtLqlWJUt7n8f/ELCcGoO5acai1iZ59GC81GLl2izObOLNjyv3G6hia/w50Mw9MU
 dAdZQ2MxM6k+x4L5XeysdcR/2AydVLtu2LGFOrKyEe0M9XmlE6OvziWXvVVwomvTN3LaNUmaINhr7
 pHTFwDiZCSWKnwnvD2+jA1trKq1xKUQY1uGW9XgSj98pKyixHWoeEpydr+alSTB43c3m0351/9rYT
 TTi4KSk73wtapPKtaoIR3rOFHLQXbWFya3VzLnByb2JzdEBwb3N0ZW8uZGWJAlEEEwEIADsWIQSCd
 BjE9KxY53IwxHM0dh/4561D0gUCaIO9eAIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCR
 A0dh/4561D0oHZEACEmk5Ng9+OXoVxJJ+c9slBI2lYxyBO84qkWjoJ/0GpwoHk1IpyL+i+kF1Bb7y
 Hx9Tiz8ENYX7xIPTZzS8hXs1ksuo76FQUyD6onA/69xZIrYZ0NSA5HUo62qzzMSZL7od5e12R6OPR
 lR0PIuc4ecOGCEq3BLRPfZSYrL54tiase8HubXsvb6EBQ8jPI8ZUlr96ZqFEwrQZF/3ihyV6LILLk
 geExgwlTzo5Wv3piOXPTITBuzuFhBJqEnT25q2j8OumGQ+ri8oVeAzx24g1kc11pwpR0sowfa5MvZ
 WrrBcaIL7uJfR/ig7FyGnTQ1nS3btf3p0v8A3fc4eUu/K2No3l2huJp3+LHhCmpmeykOhSB63Mj3s
 3Q87LD0HE0HBkTEMwp+sD97ZRpO67H5shzJRanUaDTb/mREfzpJmRT1uuec0X2zItL7a6itgMJvYI
 KG29aJLX3fTzzVzFGPgzVZYEdhu4y53p0qEGrrC1JtKR6DRPE1hb/OdWOkjmJ75+PPLD9U5IuRd6y
 sHJWsEBR1F0wkMPkEofWsvMYJzWXx/rvTWO8N4D6HigTgBXAXNgbc3IHpHlkvKoBJptv6DRVRtIrz
 0G0cfBY0Sm7he4N2IYDWWdGnPBZ3rlLSdj5EiBU2YWgIgtLrb8ZNJ3ZlhYluGnBJDGRqy2jC9s1jY
 66sLA9rQZMHhJTzMyIDwweGlvMzJAcG9zdGVvLmV1PokCbQQTAQgAVxYhBIJ0GMT0rFjncjDEczR2
 H/jnrUPSBQJpa71VGxSAAAAAAAQADm1hbnUyLDIuNSsxLjExLDIsMgIbAwULCQgHAgIiAgYVCgkIC
 wIEFgIDAQIeBwIXgAAKCRA0dh/4561D0gKJD/9uOQKYlsDoQX65Gd0LiMT0C+5vXgr3VI0PHDOwcv
 51fJ3A1vNyPZRFPGrz8+mDEXUQOF/INfnz5Tu1QHwf+iYcWcTGAN/FHgVR6ET6VBNU2hJaKhu+Ggo
 kjYyJTOvyX+3yNRUfSny0GjTjIPuPTErjqmHF+BtjXslpgwqnNMznf3lRIuUjRORupos6p3k1DndE
 5vzUTmXSvMyXyOD2KhBl/kL76k0bHYyAQytZPag12pltrtFbA/r2phDGN2si8PooDT99bSTJjaM45
 MTAAHbHKJfvgfK41bNFD5mMtpWpL195XRtS0Nrxdg3PaYBxN5gtTG0RyZfpYRlkdEhm+jj/8RxuSG
 i/qdhRdbiI7K2IELWeQVHSNDi9JabR/UzlR4NSnhfAjRIVlRM+eFbUl8XwxwVrAkojF5IraH2qRvg
 VCmuFsHUW07FUlrDrzpjXsD73cKppoFGDCdDR0BHJepXbFLS9+AqkT+guRJlnCTg2p+TQtnbwPgKp
 Vj98JixovCl99zRYTsL2bRNU5+q8iET65VMJ1ydyNanvLd5vI/NqDkXhlXLsGmdaDTtu4R21PkToX
 dQNGrZ91M9nlIBKw8Y7c7xZ4098qX2b8JX/CxD+gC1r4C8vuA3GkhFLx+KlkON7LyiJPkrePp6Qky
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-bH8OtN9TdEHa5Hw2HTUT"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-bH8OtN9TdEHa5Hw2HTUT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-08-05 at 20:30 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] Desynchronization between software state and hardware 24-hour mo=
de after initialization causes time corruption.
> - [High] Alarm hour formatting erroneously adds PM bit in 24-hour mode, c=
ausing PM alarms to permanently fail.
> --
>=20
> --- Patch [2]: [PATCH v3 2/5] rtc: s35390a: Add missing newline to dev_er=
r ---
> commit 60df926a63720bd3dbdd3b4991c3149af682d4b0
> Author: Markus Probst <markus.probst@posteo.de>
>=20
> rtc: s35390a: Add missing newline to dev_err
>=20
> This commit fixes a missing newline character in the dev_err call
> within s35390a_probe() when alarm disabling fails.
>=20
> > diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> > index b72eef4fb0997..4cfe7034c5165 100644
> > --- a/drivers/rtc/rtc-s35390a.c
> > +++ b/drivers/rtc/rtc-s35390a.c
> > @@ -494,7 +494,7 @@ static int s35390a_probe(struct i2c_client *client)
> >  		buf =3D 0;
> >  		err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
> >  		if (err < 0) {
> > -			dev_err(dev, "error disabling alarm");
> > +			dev_err(dev, "error disabling alarm\n");
> >  			return err;
> >  		}
> >  	} else {
>=20
> While reviewing this driver, I noticed a couple of pre-existing issues.
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at s35390a_init(),
> is it possible for the software state to become desynchronized from the
> hardware 24-hour mode?
>=20
> drivers/rtc/rtc-s35390a.c:s35390a_init() {
>     ...
>     initialize:
> 	buf =3D S35390A_FLAG_RESET | S35390A_FLAG_24H;
> 	ret =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &buf, 1);
>     ...
> }
>=20
> When this reset is triggered (for instance, via the RTC_VL_CLR ioctl or w=
hen
> a brownout is detected), the hardware is explicitly switched to 24-hour m=
ode
> by setting S35390A_FLAG_24H.
>=20
> However, s35390a->twentyfourhour is not updated to 1.
>=20
> Does this mean subsequent calls to rtc_set_time() will incorrectly use th=
e
> 12-hour formatting rules if twentyfourhour was previously 0, sending inva=
lid
> BCD formats to the chip and corrupting the timekeeping for PM hours?
Yes.
>=20
>=20
> [Severity: High]
> This is a pre-existing issue, but I have a question about how the alarm h=
our
> is formatted when the chip is operating in 24-hour mode:
>=20
> drivers/rtc/rtc-s35390a.c:s35390a_rtc_set_alarm() {
>     ...
> 	buf[S35390A_ALRM_BYTE_HOURS] =3D s35390a_hr2reg(s35390a,
> 			alm->time.tm_hour) | 0x80;
> 	buf[S35390A_ALRM_BYTE_MINS] =3D bin2bcd(alm->time.tm_min) | 0x80;
>=20
> 	if (alm->time.tm_hour >=3D 12)
> 		buf[S35390A_ALRM_BYTE_HOURS] |=3D 0x40;
>     ...
> }
>=20
> If the chip is in 24-hour mode, s35390a_hr2reg() will already return the
> standard 24-hour BCD value (e.g., 0x15 for 15:00).
>=20
> Could the unconditional bitwise-OR with 0x40 (the PM bit) corrupt the ala=
rm
> time value in 24-hour mode, causing PM alarms to permanently fail because=
 the
> hardware comparator expects a standard 24-hour BCD value?
No. AM/PM bit gets ignored in 24-hour mode.



--=-bH8OtN9TdEHa5Hw2HTUT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmp7ZAcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSpfEP/jRZ+MH9v/Z+yMa5vJHY
79OSrDJDyjGRJpk/g7Iq/fjh3li0EY9J5BBmWZl4wSUItpUN9Z0QVPNxZQNShXPT
03N5QavT701BN6GRe4B+zxDLq/CxkjFAILiJD+l2SIbKDsae+OhpZ43CP93d8mg1
g6AaW9S+FJsMGgm3u+SJOR4YiFHzc3+j2fHSM4tFh7fRs4lNoagd+0E2qdD7d5t3
sy3RcJs4q6VNg91R4dFlnzKa+Pi1FXKNxQ83j4CeaiGinskv11qr7o+Ey3GUcAx1
0tFX6y5jf7UDGPGStQlc1x1u9gPsIHqPRuj+sXS0fvQywU12eADiuTBDmpWT1+0e
TTDAoAKZl0MNufUnKjuvSEydF0tmh4fdQuzZi1HQsnNHFtqZkqs3txrS0l0qnY8F
CVxuy6fXxp/AdQ60VYfl55U5uP9SgO2mHscmaA63p8p+prUJfG4i2AlUXnShWZZ1
nZksB6rcwBwZaY0SI9ND9BiqF724tFl9zbF+ynKGcn3HI+5G3relzKCDzb90EOVV
EeE/LAXGPlqdTDFtivB0jYXn3/KuksF1sQ6kfgYfge6YOQrvbk7pvkhb/6NYMd8o
DULu5wuw6fBOJ87+kjergTfkgUEYt7YpB7ZzEsOVfRs/GZhUCu9EKSc/llQ3Y1po
AB0LLhj4ja7DHN9l4dtmrn/H
=hu7G
-----END PGP SIGNATURE-----

--=-bH8OtN9TdEHa5Hw2HTUT--
