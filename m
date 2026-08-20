Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497883C1978
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254914; cv=none; b=pQa/OTDWSuszhLiFWj8/9X2qaiyEMs1wUUV9zAPHTm41fVmrRrvMBTrDpXSuJMTbiGeYiy8isBK7Gv92RKd2JXKB+lds/AePH+kD3JPaiMlRFZ2kNay2IcPuI45P5FyV3+Vpelk2iat2tCCE+tA7PPZbOAMCXgq0uEPzjIuS5+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254914; c=relaxed/simple;
	bh=ftKGfBE9ZMctmHLFNNPRC6G2BWKocSNsOdxh853W4yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgtDMGBMRBCc9P19cuUMqMqLdRov5JMCIve9bsH5N4aWITeZRU4oflgAsmUScc6oS+LG2h7bkmKlII+4M7oUaczOnqTQK3KnH2Kjmiaxl8E5FjKteOyBgxCoOjQD6yAf0NhBfhjTLZoVpLeFyPbOTWqGUat82f7Uh/YgtopruQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QylkPCei; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QylkPCei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ftKG
	fBE9ZMctmHLFNNPRC6G2BWKocSNsOdxh853W4yo=; b=QylkPCeiYvOmgBySuP7E
	p9XjTWxq+1DQHrmhzk7j9eAgWphRiPYGflC22kxBPIR42/HNGxBlx1mtw4/MDqyc
	kKVjCB/gBayIXDiXkgEnTdMGsNWxCOjOpProYMXTQd14xpKfuhDZj15+0l0iapH7
	QIxMIe+ibhogj08k/KoqCxEeeHarfvG7Qat3jhluzeJeu/MykHLWbdpaq1Lua6Fn
	QLGM/RNc34V1Stftciz6sNovnoO4PO+JYvHiTS7T/w4wzgbyxyJ/Ce6sMYoYAAQ9
	nzSEPftHRjpIjm3dkJRDXK8cfIXPW8bOcD3w67VbFwvJhzqkjKSKQ3nJiuhWPIj1
	ZA==
Received: (qmail 409437 invoked from network); 20 Aug 2026 21:41:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Aug 2026 21:41:50 +0200
X-UD-Smtp-Session: l3s3148p1@BXgGtn9ZcLIujnuE
Date: Thu, 20 Aug 2026 21:41:49 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, conor+dt@kernel.org,
	linux-rtc@vger.kernel.org, robh@kernel.org,
	devicetree@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 03/15] rtc: rzn1: Fix weekday underflow when alarm
 crosses month boundary
Message-ID: <aodYfdRMyX4dcMCl@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819105356.BD7731F000E9@smtp.kernel.org>
 <aoWpLvrNGHBPvFY5@shikoro>
 <CA+V-a8v23+zevx_xRS-GeHG2yk2k-M2UkPxoC76t-0JewRk9Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RkBCC7n8O8U3Pqfk"
Content-Disposition: inline
In-Reply-To: <CA+V-a8v23+zevx_xRS-GeHG2yk2k-M2UkPxoC76t-0JewRk9Dw@mail.gmail.com>


--RkBCC7n8O8U3Pqfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> On T2H/N2H too.
>=20
> I'll create a below patch for it:

Looks proper from a glimpse, but it is quite late already. Should look
at it with a fresh brain tomorrow.


--RkBCC7n8O8U3Pqfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqHWH0ACgkQFA3kzBSg
KbaDWxAAnG2dO97IfVFLBVJ4JVop3r694eC4bAqdkohtEjweFN8XKK5c8tALz6QO
+YoNy+mfgq4fW9CGeJYDjJZsKYOwSv1T/P+Z4SyxTMLtoZWyAUKqvJ51jFgfMnN3
XB/+LV5qAouILf8Px+6AGjoQ5geGcGOG+JOPNckAo+i/K7aJgbZtbcVJtWYvCR5g
DCjPAX5GVdZV7NMjDaOlCrBQU2dEXL50zj/yC2Bt5t13236kl8H77UWjGh5b1fAn
CoXhFX7up5BMr8IEHGW97yzsgiGsDCcjzDvoi1khsVXXaHdoS3caYdoRlCgxjrqI
SrZLUlBXs/dSF1fpU+vzAP1Jt01mIuzZa0UqmqKoE1BFkHeoZxaMS0+LQPfHErvS
gBSNm9uAhGozC+V5S8lH4X6TYGfie7/Ouxqon7BO4VOrK+yZ2fpiR1VKcurG3X9S
W/88qeNkdOEWX57lOEl+ffQHc0+YyPGSzBkgdVEGk2kUhJe3p4CfESUDwec6/JcP
pShjfq3VrlRyMkSR/GH49kPSoq4kp3r6760CvpYjaWTX0HRzCJbXirZ8ogyuQNVs
OEXNaRLfZKo9FcMITmT/SHSETrZH/40Zh4h+KgV9CrXLmYxWiJ/H3e3WyMIxwHK7
TIsTukmZ05Zc+qcMPtvQ2gUaYIrgpDRojGW0b6q0DCWu+y75Ujc=
=2E0I
-----END PGP SIGNATURE-----

--RkBCC7n8O8U3Pqfk--
